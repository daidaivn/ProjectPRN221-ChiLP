using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.SignalR;
using PRN221Project.Models;
using PRN221Project.Hubs;

namespace PRN221Project.Pages.All
{
    public class CarBuyProductModel : PageModel
    {
        private readonly Project221Context _dbContext;
        public List<(Product, int proQuantity)>? ProductListCart { get; set; }
        private readonly IHubContext<ChatHub> _hubContext;

        public CarBuyProductModel(Project221Context _db, IHubContext<ChatHub> SignalRServer)
        {
            _dbContext = _db;
            _hubContext = SignalRServer;
        }

        public async Task<IActionResult> OnGet()
        {
            var cookie = Request.Cookies["myCard"];
            ProductListCart = new List<(Product, int proQuantity)>();
            if (cookie != null)
            {
                ProductListCart.Clear();

                // Đọc cookie và cập nhật số lượng hàng tồn kho
                foreach (var item in ReadCookie())
                {
                    Product p = _dbContext.Products.Find(item.proId);
                    if (p != null)
                    {
                        // Giảm số lượng hàng tồn kho
                        p.Quantity -= item.proQuantity;

                        // Cập nhật thông tin sản phẩm trong cơ sở dữ liệu
                        _dbContext.Update(p);
                    }

                    // Add sản phẩm và số lượng vào danh sách
                    ProductListCart.Add((p, item.proQuantity));
                }

                // Lưu các thay đổi vào cơ sở dữ liệu
                _dbContext.SaveChanges();

                // Set success message
                TempData["PaymentSuccess"] = "Payment successful!";

                // Xóa toàn bộ cookie
                CookieOptions options = new CookieOptions();
                options.Expires = DateTime.Now.AddSeconds(0);
                Response.Cookies.Append("myCard", "null", options);
            }

            await _hubContext.Clients.All.SendAsync("cmf5edit");
            return RedirectToPage("/All/Cart");
        }


        public List<(int proId, int proQuantity)> ReadCookie()
        {
            //create list
            var myProcductCart = new List<(int proId, int proQuantity)>();

            //get cookie
            var cookie = Request.Cookies["myCard"];
            if (cookie != null)
            {
                //create list split by ' AND '
                string[] items = splitString(cookie, "AND");

                foreach (string item in items)
                {
                    //create list split by ' - ' 
                    string[] pair = splitString(item, "-");

                    try
                    {
                        //add to list with Key and Value
                        myProcductCart.Add((int.Parse(pair[0]), int.Parse(pair[1])));
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine("error: " + ex);
                    }
                }
            }

            return myProcductCart;
        }

        public string[] splitString(string value, string charac)
        {
            string[] result = value.Split(charac);
            return result;
        }
    }
}
