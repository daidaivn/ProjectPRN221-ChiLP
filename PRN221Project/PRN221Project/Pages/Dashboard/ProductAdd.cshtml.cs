using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using PRN221Project.Models;
using System.Collections.Generic;
using System.Linq;

namespace PRN221Project.Pages.Dashboard
{
    public class ProductAddModel : PageModel
    {
        private readonly Project221Context _context;

        public ProductAddModel(Project221Context context)
        {
            _context = context;
        }

        [BindProperty]
        public Product Product { get; set; }

        public SelectList Categories { get; set; }
        public SelectList Suppliers { get; set; }

        public async Task<IActionResult> OnGet()
        {
            Categories = new SelectList(await _context.ProductCategories.ToListAsync(), "CategoryId", "CategoryName");
            Suppliers = new SelectList(await _context.Suppliers.ToListAsync(), "SupplierId", "SupplierName");

            return Page();
        }

        public async Task<IActionResult> OnPost()
        {
            if (!ModelState.IsValid)
            {
                Categories = new SelectList(await _context.ProductCategories.ToListAsync(), "CategoryId", "CategoryName");
                Suppliers = new SelectList(await _context.Suppliers.ToListAsync(), "SupplierId", "SupplierName");
                return Page();
            }

            _context.Products.Add(Product);
            await _context.SaveChangesAsync();

            return RedirectToPage("/Dashboard/Product");
        }
    }
}
