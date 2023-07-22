using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using PRN221Project.Models;

namespace PRN221Project.Pages
{
    public class PrivacyModel : PageModel
    {
        private readonly Project221Context _context;

        public PrivacyModel(Project221Context context)
        {
            _context = context;
        }

        public List<Product> Products { get; set; }

        public void OnGet()
        {
            // Truy vấn danh sách sản phẩm từ bảng "Product"
            Products = _context.Products.ToList();
        }
    }
}