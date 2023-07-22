using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using PRN221Project.Models;

namespace PRN221Project.Pages.Dashboard
{
    public class ProfitSummaryModel : PageModel
    {
        private readonly Project221Context _context;

        public ProfitSummaryModel(Project221Context context)
        {
            _context = context;
        }

        // Các thuộc tính để lưu trữ kết quả truy vấn
        public decimal TotalProfit { get; set; }
        public decimal TotalExpense { get; set; }
        public decimal NetProfit { get; set; }

        // Thuộc tính để lưu trữ giá trị ngày được chọn từ điều khiển lọc
        [BindProperty(SupportsGet = true)]
        public DateTime? SelectedDate { get; set; }

        // Thuộc tính để lưu trữ danh sách báo cáo hàng tháng
        public List<MonthlyReport> MonthlyReports { get; set; }

        public async Task OnGetAsync()
        {
            // Truy vấn dữ liệu từ bảng Profit để tính tổng số tiền lãi
            TotalProfit = await _context.Profits
                .Where(p => p.IsActive == true) // Chỉ tính toán tiền lãi từ các mục có trạng thái hoạt động
                .SumAsync(p => p.Amount ?? 0);

            // Truy vấn dữ liệu từ bảng Order để tính tổng số tiền chi (tổng giá trị các đơn hàng)
            TotalExpense = await _context.Orders
                .Where(o => o.IsActive == true) // Chỉ tính toán số đơn hàng có trạng thái hoạt động
                .SumAsync(o => o.TotalAmount ?? 0);

            // Tính toán tổng lợi nhuận
            NetProfit = TotalProfit - TotalExpense;

            if (SelectedDate.HasValue)
            {
                DateTime selectedDate = SelectedDate.Value.Date; // Lấy ngày được chọn từ ngày/tháng/năm

                // Truy vấn dữ liệu từ bảng Order để tính tổng số tiền doanh thu và lãi suất hàng tháng
                MonthlyReports = await _context.Orders
                    .Where(o => o.IsActive == true && o.OrderDate.HasValue && TruncateTime(o.OrderDate.Value) == selectedDate)
                    .GroupBy(o => new { Month = o.OrderDate.Value.Month, Year = o.OrderDate.Value.Year })
                    .Select(g => new MonthlyReport
                    {
                        Date = new DateTime(g.Key.Year, g.Key.Month, 1),
                        TotalRevenue = g.Sum(o => o.TotalAmount ?? 0),
                        TotalProfit = g.Sum(o => o.Profits.Sum(p => p.Amount ?? 0))
                    })
                    .ToListAsync();
            }
        }

        // Hàm TruncateTime để cắt bỏ phần thời gian trong ngày và chỉ lấy ngày/tháng/năm
        private DateTime TruncateTime(DateTime dateTime)
        {
            return dateTime.Date;
        }
    }

    public class MonthlyReport
    {
        public DateTime Date { get; set; } // Ngày báo cáo hàng tháng
        public decimal TotalRevenue { get; set; } // Tổng doanh thu trong tháng
        public decimal TotalProfit { get; set; } // Tổng lợi nhuận trong tháng
    }
}
