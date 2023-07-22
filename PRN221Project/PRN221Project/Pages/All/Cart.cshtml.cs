using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using PRN221Project.Models;
using System.Text.Json;

namespace PRN221Project.Pages.All
{
    public class CartModel : PageModel
    {
        private readonly Project221Context _dbContext;

        public List<(Product, int proQuantity)>? ProductListCart { get; set; }


        public CartModel(Project221Context _db)
        {
            _dbContext = _db;
        }



        public void OnGet()
        {
            //get cookie
            var cookie = Request.Cookies["myCard"];

            //create new list 
            ProductListCart = new List<(Product, int proQuantity)>();


            //if cookie not null
            if (cookie != null)
            {
                //clear all list cart
                ProductListCart.Clear();


                //read cookie
                foreach (var item in ReadCookie())
                {
                    //Add product and quantity to list
                    ProductListCart.Add((_dbContext.Products.Find(item.proId), item.proQuantity));
                }



            }
        }


        public async Task<IActionResult> OnPost(int proid, int proQuantity)
        {
            //Update product in Shopping Cart
            UpdateCookie(proid, proQuantity);

            //return shopping cart
            return RedirectToPage("ShoppingCart");

        }




        public void UpdateCookie(int proid, int proQuantity)
        {
            CookieOptions options = new CookieOptions();

            //get cookie
            var cookie = Request.Cookies["myCard"];
            if (cookie != null)
            {
                //create new list 
                var listProductCart = new List<(int proId, int proQuantity)>();
                string newCookie = "";

                //create list split by ' AND '
                string[] items = splitString(cookie, "AND");
                foreach (string item in items)
                {
                    //create list split by ' - '
                    string[] pair = splitString(item, "-");
                    try
                    {
                        //add to list with Key and Value
                        listProductCart.Add((int.Parse(pair[0]), int.Parse(pair[1])));
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine("error: " + ex);
                    }
                }

                //check Id exist in list
                bool checkDuplicate = false;
                foreach (var item in listProductCart)
                {
                    //if exist return true
                    if (item.proId == proid)
                    {
                        checkDuplicate = true;
                        break;
                    }
                }

                //if is true
                if (checkDuplicate == true)
                {
                    for (int i = 0; i < listProductCart.Count; i++)
                    {
                        //find Id in list
                        if (listProductCart[i].Item1 == proid)
                        {
                            //update product in list
                            listProductCart[i] = (listProductCart[i].Item1, proQuantity);
                            break;
                        }

                    }

                    foreach (var item in listProductCart)
                    {
                        //append new string value
                        newCookie += "AND" + item.proId + "-" + item.proQuantity;
                    }

                    //if string begin with ' AND '
                    if (newCookie.Substring(0, 3).Equals("AND"))
                    {
                        //remove AND from begin string value
                        newCookie = newCookie.Substring(3, newCookie.Length - 3);

                    }

                    //Delete cookie
                    options.Expires = DateTime.Now.AddSeconds(0);

                    //Add new cookie
                    options.Expires = DateTime.Now.AddSeconds(1000);
                    Response.Cookies.Append("myCard", newCookie, options);

                    Console.WriteLine("new cookie after update: " + newCookie);

                }

            }


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
