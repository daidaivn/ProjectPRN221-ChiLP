using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;

namespace project.Pages.Authen
{
    [AllowAnonymous]
    public class LogoutModel : PageModel
    {
        private readonly IHttpContextAccessor _httpContextAccessor;

        public LogoutModel(IHttpContextAccessor httpContextAccessor)
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
            return LocalRedirect(returnUrl ?? "/");
        }
    }
}
