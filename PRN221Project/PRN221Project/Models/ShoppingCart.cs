using System;
using System.Collections.Generic;

namespace PRN221Project.Models
{
    public partial class ShoppingCart
    {
        public int CartId { get; set; }
        public int? CustomerId { get; set; }
        public int? ProductId { get; set; }
        public int? Quantity { get; set; }
        public bool? IsActive { get; set; }
        public DateTime? CreatedDate { get; set; }
        public DateTime? ModifiedDate { get; set; }

        public virtual Customer? Customer { get; set; }
        public virtual Inventory? Product { get; set; }
    }
}
