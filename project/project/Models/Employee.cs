using System;
using System.Collections.Generic;

namespace project.Models
{
    public partial class Employee
    {
        public Employee()
        {
            Invoices = new HashSet<Invoice>();
        }

        public int EmployeeId { get; set; }
        public string EmployeeName { get; set; } = null!;
        public string ContactInfo { get; set; } = null!;

        public virtual ICollection<Invoice> Invoices { get; set; }
    }
}
