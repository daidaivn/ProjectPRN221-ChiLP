using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using project.Models;
using Microsoft.EntityFrameworkCore;
using System.Linq;

namespace project.Pages
{
    public class IndexModel : PageModel
    {
        private readonly ElegantStylesContext _context;

        public IndexModel(ElegantStylesContext context)
        {
            _context = context;
        }

        public List<Product> Products { get; set; }
        public List<Category> Categories { get; set; }

        public async Task OnGetAsync()
        {
            Products = await _context.Products.ToListAsync();
            Categories = await _context.Categories.ToListAsync();
        }
    }
}