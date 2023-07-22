using PRN221Project.Models;

namespace PRN221Project.Pages
{
    public class ShoppingCart
    {
        public List<CartItem> Items { get; } = new List<CartItem>();

        public void AddToCart(Product product)
        {
            // Check if the product is already in the cart
            var existingItem = Items.Find(item => item.Product.ProductId == product.ProductId);

            if (existingItem != null)
            {
                existingItem.Quantity++;
            }
            else
            {
                Items.Add(new CartItem { Product = product, Quantity = 1 });
            }
        }
    }

    public class CartItem
    {
        public Product Product { get; set; }
        public int Quantity { get; set; }
    }
}
