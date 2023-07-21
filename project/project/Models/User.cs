using System;
using System.Collections.Generic;

namespace project.Models
{
    public partial class User
    {
        public User()
        {
            Carts = new HashSet<Cart>();
            Invoices = new HashSet<Invoice>();
        }

        public int UserId { get; set; }
        public string Username { get; set; } = null!;
        public string Password { get; set; } = null!;
        public string Role { get; set; } = null!;

        public virtual ICollection<Cart> Carts { get; set; }
        public virtual ICollection<Invoice> Invoices { get; set; }
    }
}
