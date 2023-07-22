using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using PRN221Project.Models;

namespace PRN221Project.Pages.Dashboard
{
    public class SupplierDeleteModel : PageModel
    {
        private readonly Project221Context _context;

        public SupplierDeleteModel(Project221Context context)
        {
            _context = context;
        }

        [BindProperty]
        public Supplier Supplier { get; set; }

        public async Task<IActionResult> OnGetAsync(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            Supplier = await _context.Suppliers.FindAsync(id);

            if (Supplier == null)
            {
                return NotFound();
            }

            return Page();
        }

        public async Task<IActionResult> OnPostAsync()
        {
            try
            {
                Supplier = await _context.Suppliers.FindAsync(Supplier.SupplierId);

                if (Supplier != null)
                {
                    _context.Suppliers.Remove(Supplier);
                    await _context.SaveChangesAsync();
                }
                else
                {
                    return NotFound();
                }
            }
            catch (DbUpdateException)
            {
                // Log the exception or handle it as needed
                return RedirectToPage("Error");
            }

            return RedirectToPage("SupplierList");
        }
    }
}
