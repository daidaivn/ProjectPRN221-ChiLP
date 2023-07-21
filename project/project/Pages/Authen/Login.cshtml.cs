using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using System.Threading.Tasks;
using project.Models;
using Microsoft.AspNetCore.Http;

namespace project.Pages.Authen
{
    public class LoginModel : PageModel
    {
        private readonly ElegantStylesContext _context;
        private readonly IConfiguration Configuration;

        public LoginModel(ElegantStylesContext context, IConfiguration configuration)
        {
            _context = context;
            Configuration = configuration;
        }

        [BindProperty]
        public string Username { get; set; }

        [BindProperty]
        public string Password { get; set; }

        public bool LoginFailed { get; set; }

        public async Task<IActionResult> OnPostAsync()
        {
            // Kiểm tra thông tin đăng nhập trong cơ sở dữ liệu
            var user = await _context.Users.FirstOrDefaultAsync(u => u.Username == Username && u.Password == Password);

            if (user != null)
            {
                // Xác thực thành công, lưu trạng thái đăng nhập vào session
                HttpContext.Session.SetString("IsLoggedIn", "true");
                HttpContext.Session.SetString("Username", Username);

                // Kiểm tra vai trò của người dùng và chuyển hướng tùy thuộc vào vai trò
                if (user.Role == "admin")
                {
                    HttpContext.Session.SetString("UserRole", "admin");
                }
                else if (user.Role == "customer")
                {
                    HttpContext.Session.SetString("UserRole", "customer");
                }
                return RedirectToPage("/Index");
            }
            else
            {
                // Xử lý khi đăng nhập không thành công (hiển thị thông báo lỗi, v.v.)
                // Đây là ví dụ đơn giản, bạn có thể thêm mã xử lý phù hợp với yêu cầu của dự án.
                LoginFailed = true;
            }

            return Page();
        }
    }


}
