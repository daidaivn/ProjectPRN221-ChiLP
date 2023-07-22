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
    public class SupplierListPageModel : PageModel
    {
        private readonly Project221Context _context;

        public SupplierListPageModel(Project221Context context)
        {
            _context = context;
        }

        // Thuộc tính cho phân trang
        public PaginatedList<Supplier> Suppliers { get; set; }
        public int PageSize { get; set; } = 3; // Kích thước trang mặc định là 10

        // Thuộc tính để lưu trữ từ khóa tìm kiếm
        [BindProperty(SupportsGet = true)]
        public string SearchString { get; set; }

        public async Task OnGetAsync(int? pageIndex)
        {
            // Truy vấn dữ liệu từ bảng Suppliers
            IQueryable<Supplier> suppliersQuery = _context.Suppliers;

            // Thêm phần tìm kiếm theo tên nhà cung cấp nếu có từ khóa tìm kiếm
            if (!string.IsNullOrEmpty(SearchString))
            {
                suppliersQuery = suppliersQuery.Where(s => s.SupplierName.Contains(SearchString));
            }

            // Thực hiện phân trang
            Suppliers = await PaginatedList<Supplier>.CreateAsync(suppliersQuery, pageIndex ?? 1, PageSize);
        }
    }
}
