using Microsoft.AspNetCore.SignalR;
using System.Threading.Tasks;
using project.Models;
using Microsoft.EntityFrameworkCore;

namespace project.Hubs
{
    public class ProductHub : Hub
    {
        private readonly ElegantStylesContext _context;

        public ProductHub(ElegantStylesContext context)
        {
            _context = context;
        }

        public async Task GetProductData()
        {
            // Lấy thông tin bảng "Product" từ cơ sở dữ liệu
            var products = _context.Products.ToList();

            // Gửi dữ liệu bảng "Product" về client sử dụng SignalR
            await Clients.Caller.SendAsync("ReceiveProductData", products);
        }

        public async Task GetCategories()
        {
            var categories = await _context.Categories.ToListAsync();
            await Clients.Caller.SendAsync("ReceiveCategories", categories);
        }
        public async Task DeleteProduct(int productId)
        {
            var product = await _context.Products.FindAsync(productId);
            if (product != null)
            {
                _context.Products.Remove(product);
                await _context.SaveChangesAsync();

                // Gửi thông báo tới tất cả các client đã kết nối rằng có một sản phẩm đã bị xóa.
                await Clients.All.SendAsync("ProductDeleted", productId);
            }
        }
        public async Task ToggleProductStatus(int productId)
        {
            // Tìm sản phẩm dựa vào productId
            var product = await _context.Products.FindAsync(productId);
            if (product != null)
            {
                // Chuyển đổi trạng thái isActive của sản phẩm
                product.IsActive = !product.IsActive;
                await _context.SaveChangesAsync();

                // Gửi thông báo tới các client rằng trạng thái isActive đã thay đổi
                await Clients.All.SendAsync("ProductStatusToggled", productId, product.IsActive);
            }
        }
        public async Task CreateProduct(string productName, decimal productPrice, decimal productCost, int productStockQuantity, bool isActive, int categoryId)
        {
            // Tạo một sản phẩm mới
            var newProduct = new Product
            {
                ProductName = productName,
                Price = productPrice,
                Cost = productCost,
                StockQuantity = productStockQuantity,
                IsActive = isActive,
                CategoryId = categoryId // Thêm categoryId vào sản phẩm mới
            };

            // Thêm sản phẩm mới vào cơ sở dữ liệu
            _context.Products.Add(newProduct);
            await _context.SaveChangesAsync();

            // Gửi thông báo đến các client rằng đã có sản phẩm mới được tạo
            await Clients.All.SendAsync("ProductCreated", newProduct);
        }

    }
}
