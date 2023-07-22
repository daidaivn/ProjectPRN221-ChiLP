using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using PRN221Project.Models;

namespace PRN221Project.Pages
{
    public class IndexModel : PageModel
    {
        private readonly Project221Context _context;
        private readonly IConfiguration Configuration;
        public IndexModel(Project221Context context, IConfiguration configuration)
        {
            _context = context;
            Configuration = configuration;
        }
        public PaginatedList<Product> Products { get; set; }
        public List<ProductCategory> Categories { get; set; }
        public List<SelectListItem> CategoryOptions { get; set; }

        // Các thuộc tính để lưu trạng thái của các tham số tìm kiếm và lọc
        public string CurrentFilter { get; set; }
        [BindProperty(SupportsGet = true)]

        public int? SelectedCategoryId { get; set; }


        // Danh sách sản phẩm hiển thị trên trang

        // Danh sách các danh mục sản phẩm để hiển thị trong dropdown

        // Danh sách các tùy chọn danh mục trong dropdown

        public async Task OnGetAsync(string currentFilter, string searchString, int? pageIndex, int? categoryId)
        {
            // Gán giá trị mặc định cho pageIndex nếu không có giá trị
            pageIndex ??= 1;

            // Lưu trạng thái của các tham số vào thuộc tính của model
            CurrentFilter = searchString;
            SelectedCategoryId = categoryId;

            // Khởi tạo truy vấn IQueryable
            IQueryable<Product> productsIQ = from p in _context.Products select p;

            // Lọc theo từ khóa tìm kiếm (searchString) và danh mục (categoryId)
            if (!String.IsNullOrEmpty(searchString))
            {
                productsIQ = productsIQ.Where(p => p.ProductName.Contains(searchString));
            }

            if (SelectedCategoryId.HasValue)
            {
                productsIQ = productsIQ.Where(p => p.CategoryId == SelectedCategoryId);
            }

            // Lọc các sản phẩm có StockQuantity > 0
            productsIQ = productsIQ.Where(p => p.Quantity > 0);

            // Đếm số lượng sản phẩm sau khi lọc
            var count = await productsIQ.CountAsync();

            // Lấy số trang trên toàn bộ dữ liệu sau khi lọc
            var pageSize = Configuration.GetValue("PageSize", 3);
            var totalPages = (int)Math.Ceiling(count / (double)pageSize);

            // Đảm bảo pageIndex không vượt quá số trang tối đa
            pageIndex = Math.Max(1, Math.Min(pageIndex.Value, totalPages));

            // Lấy danh sách sản phẩm trang hiện tại
            Products = await PaginatedList<Product>.CreateAsync(
                productsIQ.AsNoTracking(), pageIndex.Value, pageSize);

            Categories = await _context.ProductCategories.ToListAsync();

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