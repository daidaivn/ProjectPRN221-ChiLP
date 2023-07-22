using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Authorization;

namespace PRN221Project.Pages.All
{
    [AllowAnonymous]
    public class LogoutModelModel : PageModel
    {
        private readonly IHttpContextAccessor _httpContextAccessor;

        public LogoutModelModel(IHttpContextAccessor httpContextAccessor)
        {
            _httpContextAccessor = httpContextAccessor;
        }

        public IActionResult OnPost(string returnUrl = null)
        {
            // Xóa thông tin đăng nhập khỏi session
            _httpContextAccessor.HttpContext.Session.Clear();

            // Xóa thông tin đăng nhập khỏi cookie
            HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);

            // Chuyển hướng đến trang chủ
            return LocalRedirect("/Index");
        }
    }
}
