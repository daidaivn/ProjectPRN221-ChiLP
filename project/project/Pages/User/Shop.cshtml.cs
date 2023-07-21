using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using project.Models;
using Microsoft.EntityFrameworkCore;
using System.Linq;
using Microsoft.AspNetCore.SignalR;
using project.Hubs;
using X.PagedList;
using Microsoft.Extensions.Configuration;
using Microsoft.AspNetCore.Mvc.Rendering;

namespace project.Pages.User
{
    public class ShopModel : PageModel
    {
        private readonly ElegantStylesContext _context;
        private readonly IConfiguration Configuration;

        public ShopModel(ElegantStylesContext context, IConfiguration configuration)
        {
            _context = context;
            Configuration = configuration;
        }

        public PaginatedList<Product> bestSaleProducts { get; set; }
        public List<Category> Categories { get; set; }
        public List<SelectListItem> CategoryOptions { get; set; }
        public string CurrentFiler { get; set; }
        [BindProperty(SupportsGet = true)]
        public int? SelectedCategoryId { get; set; }

        public async Task OnGetAsync(string currentFilter, string searchString, int? pageIndex, int? categoryId)
        {
            // Gán giá trị mặc định cho pageIndex nếu không có giá trị
            pageIndex ??= 1;

            // Lưu trạng thái của các tham số vào thuộc tính của model
            CurrentFiler = searchString;
            SelectedCategoryId = categoryId;

            // Khởi tạo truy vấn IQueryable
            IQueryable<Product> productsIQ = from p in _context.Products select p;

            // Lọc theo từ khóa tìm kiếm (searchString) và danh mục (categoryId)
            if (!String.IsNullOrEmpty(searchString))
            {
                productsIQ = productsIQ.Where(p => p.ProductName.Contains(searchString));
            }

            if (categoryId.HasValue)
            {
                productsIQ = productsIQ.Where(p => p.CategoryId == categoryId);
            }

            // Lọc các sản phẩm có StockQuantity > 0
            productsIQ = productsIQ.Where(p => p.StockQuantity > 0);

            // Đếm số lượng sản phẩm sau khi lọc
            var count = await productsIQ.CountAsync();

            // Lấy số trang trên toàn bộ dữ liệu sau khi lọc
            var pageSize = Configuration.GetValue("PageSize", 3);
            var totalPages = (int)Math.Ceiling(count / (double)pageSize);

            // Đảm bảo pageIndex không vượt quá số trang tối đa
            pageIndex = Math.Max(1, Math.Min(pageIndex.Value, totalPages));

            // Lấy danh sách sản phẩm trang hiện tại
            bestSaleProducts = await PaginatedList<Product>.CreateAsync(
                productsIQ.AsNoTracking(), pageIndex.Value, pageSize);

            Categories = await _context.Categories.ToListAsync();

            // Tạo danh sách các tùy chọn danh mục
            CategoryOptions = Categories.Select(c => new SelectListItem
            {
                Value = c.CategoryId.ToString(),
                Text = c.CategoryName,
                Selected = c.CategoryId == SelectedCategoryId
            }).ToList();
        }

    }


}
