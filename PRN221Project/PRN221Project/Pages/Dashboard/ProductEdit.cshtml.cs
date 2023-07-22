using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using PRN221Project.Models;

namespace PRN221Project.Pages.Dashboard
{
    public class ProductEditModel : PageModel
    {
        private readonly Project221Context _context;

        public ProductEditModel(Project221Context context)
        {
            _context = context;
        }

        [BindProperty]
        public Product Product { get; set; }

        public SelectList Categories { get; set; }
        public SelectList Suppliers { get; set; }

        public IActionResult OnGet(int id)
        {
            Product = _context.Products
                .Include(p => p.Category)
                .Include(p => p.Supplier)
                .FirstOrDefault(p => p.ProductId == id);

            if (Product == null)
            {
                return NotFound();
            }

            Categories = new SelectList(_context.ProductCategories, "CategoryId", "CategoryName");
            Suppliers = new SelectList(_context.Suppliers, "SupplierId", "SupplierName");

            return Page();
        }

        public IActionResult OnPost()
        {
            if (!ModelState.IsValid)
            {
                Categories = new SelectList(_context.ProductCategories, "CategoryId", "CategoryName");
                Suppliers = new SelectList(_context.Suppliers, "SupplierId", "SupplierName");
                return Page();
            }

            _context.Attach(Product).State = EntityState.Modified;
            _context.SaveChanges();

            TempData["SaveSuccess"] = "Product information has been updated successfully."; // Lưu thông báo thành công trong TempData

            return RedirectToPage("/Dashboard/Product");
        }
    }
}
