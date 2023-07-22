using System;
using System.Collections.Generic;

namespace PRN221Project.Models
{
    public partial class Supplier
    {
        public Supplier()
        {
            Inventories = new HashSet<Inventory>();
            Products = new HashSet<Product>();
        }

        public int SupplierId { get; set; }
        public string? SupplierName { get; set; }
        public string? SupplierAddress { get; set; }
        public string? SupplierPhone { get; set; }
        public bool? IsActive { get; set; }
        public DateTime? CreatedDate { get; set; }
        public DateTime? ModifiedDate { get; set; }

        public virtual ICollection<Inventory> Inventories { get; set; }
        public virtual ICollection<Product> Products { get; set; }
    }
}
