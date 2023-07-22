using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using PRN221Project.Models;

namespace PRN221Project.Pages.Dashboard
{
    public class CustomerModel : PageModel
    {
        private readonly Project221Context _context;

        public CustomerModel(Project221Context context)
        {
            _context = context;
        }

        //public List<Customer> Customers { get; set; }
        
        //public void OnGet()
        //{
        //    // Truy vấn danh sách khách hàng từ bảng "Customers"
        //    Customers = _context.Customers.ToList();
        //}
    }
}
