using System;
using System.Collections.Generic;

namespace project.Models
{
    public partial class Product
    {
        public Product()
        {
            Carts = new HashSet<Cart>();
            InvoiceDetails = new HashSet<InvoiceDetail>();
        }

        public int ProductId { get; set; }
        public string ProductName { get; set; } = null!;
        public string? Description { get; set; }
        public int? CategoryId { get; set; }
        public int? BrandId { get; set; }
        public int? SupplierId { get; set; }
        public decimal? Price { get; set; }
        public decimal? Cost { get; set; }
        public int? StockQuantity { get; set; }
        public bool IsActive { get; set; }
        public string? Image { get; set; }

        public virtual Brand? Brand { get; set; }
        public virtual Category? Category { get; set; }
        public virtual Supplier? Supplier { get; set; }
        public virtual ICollection<Cart> Carts { get; set; }
        public virtual ICollection<InvoiceDetail> InvoiceDetails { get; set; }
    }
}
