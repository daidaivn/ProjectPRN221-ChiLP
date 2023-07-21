using System;
using System.Collections.Generic;

namespace project.Models
{
    public partial class InvoiceDetail
    {
        public int DetailId { get; set; }
        public int? InvoiceId { get; set; }
        public int? ProductId { get; set; }
        public int? Quantity { get; set; }
        public decimal? UnitPrice { get; set; }

        public virtual Invoice? Invoice { get; set; }
        public virtual Product? Product { get; set; }
    }
}
