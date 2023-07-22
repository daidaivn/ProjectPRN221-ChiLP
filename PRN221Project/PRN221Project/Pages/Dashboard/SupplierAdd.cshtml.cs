using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using PRN221Project.Models;

namespace PRN221Project.Pages.Dashboard
{
    public class SupplierAddModel : PageModel
    {
        private readonly Project221Context _context;

        public SupplierAddModel(Project221Context context)
        {
            _context = context;
        }

        [BindProperty]
        public Supplier Supplier { get; set; }

        public IActionResult OnGet()
        {
            return Page();
        }

        public async Task<IActionResult> OnPostAsync()
        {
            if (!ModelState.IsValid)
            {
                return Page();
            }

            Supplier.IsActive = true;
            Supplier.CreatedDate = DateTime.Now;
            Supplier.ModifiedDate = DateTime.Now;

            _context.Suppliers.Add(Supplier);
            await _context.SaveChangesAsync();

            return RedirectToPage("SupplierList");
        }
    }
}
