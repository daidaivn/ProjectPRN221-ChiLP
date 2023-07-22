using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace PRN221Project.Pages.All
{
    public class CartDeleteModel : PageModel
    {

        public async Task<IActionResult> OnGet(int proId)
        {
            var cookie = Request.Cookies["myCard"];
            if (cookie != null)
            {
                Console.WriteLine("This is delete onGet proId : " + proId);

                //delete product with id
                DeleteProductCookie(proId);

                //return shopping cart

            }
            return RedirectToPage("/All/Cart");
        }

        public void DeleteProductCookie(int proid)
        {
            CookieOptions options = new CookieOptions();

            //get cookie 
            var cookie = Request.Cookies["myCard"];
            if (cookie != null)
            {
                //create new list
                var listProductCart = new List<(int proId, int proQuantity)>();

                //create empty string
                string newCookie = "";

                //create list split cookie value by ' AND '
                string[] items = splitString(cookie, "AND");

                foreach (string item in items)
                {
                    //create list split by ' - '
                    string[] pair = splitString(item, "-");
                    try
                    {
                        //add product id and quantity to list
                        listProductCart.Add((int.Parse(pair[0]), int.Parse(pair[1])));
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine("error: " + ex);
                    }
                }


                //check if ID exist in list
                bool checkDuplicate = false;
                foreach (var item in listProductCart)
                {
                    if (item.proId == proid)
                    {
                        checkDuplicate = true;
                        break;
                    }
                }


                if (checkDuplicate == true)
                {
                    for (int i = 0; i < listProductCart.Count; i++)
                    {
                        //if Id exist in List
                        if (listProductCart[i].Item1 == proid)
                        {
                            //remove from list
                            listProductCart.Remove(listProductCart[i]);

                            break;
                        }

                    }

                    //if list not empty
                    if (listProductCart.Count > 0)
                    {
                        foreach (var item in listProductCart)
                        {
                            //append new string cookie value
                            newCookie += "AND" + item.proId + "-" + item.proQuantity;
                        }


                        //if string begin with ' AND '
                        if (newCookie.Substring(0, 3).Equals("AND"))
                        {
                            //remove ' AND ' from begining string
                            newCookie = newCookie.Substring(3, newCookie.Length - 3);

                        }
                    }

                    //if list is empty
                    else
                    {
                        newCookie = null;
                    }


                    //options.Expires = DateTime.Now.AddSeconds(0);

                    //if new string value is null
                    if (newCookie == null)
                    {
                        // Expire cookie
                        options.Expires = DateTime.Now.AddSeconds(0);
                        Response.Cookies.Append("myCard", "", options);
                    }

                    //if new string not null
                    else
                    {
                        //append new string to cookie
                        options.Expires = DateTime.Now.AddSeconds(1000);
                        Response.Cookies.Append("myCard", newCookie, options);
                    }
                    Console.WriteLine("new cookie after update: " + newCookie);

                }

            }


        }
        public string[] splitString(string value, string charac)
        {
            string[] result = value.Split(charac);

            return result;
        }
    }
}
