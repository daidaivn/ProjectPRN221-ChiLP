using System;
using System.Collections.Generic;

namespace PRN221Project.Models
{
    public partial class Product
    {
        public int ProductId { get; set; }
        public string? ProductName { get; set; }
        public int? CategoryId { get; set; }
        public int? SupplierId { get; set; }
        public int? Quantity { get; set; }
        public decimal? UnitPrice { get; set; }
        public bool? IsActive { get; set; }
        public DateTime? CreatedDate { get; set; }
        public DateTime? ModifiedDate { get; set; }
        public string? Image { get; set; }

        public virtual ProductCategory? Category { get; set; }
        public virtual Supplier? Supplier { get; set; }
    }
}
