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
        public List<Product> TopProducts { get; set; }
        // Các thuộc tính để lưu trạng thái của các tham số tìm kiếm và lọc
        public string CurrentFilter { get; set; }
        [BindProperty(SupportsGet = true)]

        public int? SelectedCategoryId { get; set; }

        public int TotalProductInCart { get; set; }
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

            TopProducts = _context.Products.OrderByDescending(p => p.Quantity).Take(5).ToList();
        }

        public IActionResult OnPostAddToCart(int proId, int proQuantity, int? pageIndex)
        {
            if (proId > 0 && proQuantity > 0)
            {
                appenCookie(proId, proQuantity);
                return RedirectToPage("Index", new { pageIndex });
            }

            return RedirectToPage("Error");
        }

        public void appenCookie(int id, int quantity)
        {

            CookieOptions options = new CookieOptions();

            //get cookie 
            var cookie = Request.Cookies["myCard"];


            //if cookie is null
            if (cookie == null)

            {   //set Key
                string key = "myCard";

                //set value
                string value = id.ToString() + "-" + quantity.ToString();

                //set time expire
                options.Expires = DateTime.Now.AddSeconds(1000);

                //apend cookie
                Response.Cookies.Append(key, value, options);
            }

            //if not null
            else
            {
                //create list to store id and quantity
                var mylist = new List<(int proId, int proQuantity)>();

                //empty string to append new cookie
                string newCookie = "";

                //list to split by ' AND '
                string[] items = cookie.Split("AND");


                foreach (string item in items)
                {
                    //list to split by ' - '
                    string[] pair = item.Split("-");
                    try
                    {
                        //add to list with Key and Value
                        mylist.Add((int.Parse(pair[0]), int.Parse(pair[1])));
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine("error " + ex);
                    }
                }


                //check duplicate id
                bool checkDuplicate = false;

                foreach (var item in mylist)
                {
                    //if id already exist in list
                    if (item.proId == id)
                    {
                        //return true
                        checkDuplicate = true;
                        break;
                    }
                }


                if (checkDuplicate)
                {
                    for (int i = 0; i < mylist.Count; i++)
                    {
                        //if id exist in list
                        if (mylist[i].Item1 == id)
                        {
                            //update product in list
                            mylist[i] = (mylist[i].Item1, mylist[i].Item2 + quantity);
                            break;
                        }

                    }

                    foreach (var item in mylist)
                    {
                        //append new cookie
                        newCookie += "AND" + item.proId + "-" + item.proQuantity;
                    }

                    if (newCookie.Substring(0, 3).Equals("AND"))
                    {
                        //substring if string begin with 'AND'
                        newCookie = newCookie.Substring(3, newCookie.Length - 3);

                    }

                    //delete current cookie
                    // Response.Cookies.Delete(cookie);

                    //add new cookie with new string
                    options.Expires = DateTime.Now.AddSeconds(1000);
                    Response.Cookies.Append("myCard", newCookie, options);


                }

                //if ID not exist in cookie
                else
                {
                    //append next to string
                    cookie += "AND" + id.ToString() + "-" + quantity.ToString();
                    options.Expires = DateTime.Now.AddSeconds(1000);
                    Response.Cookies.Append("myCard", cookie, options);
                }



            }


        }

    }
}