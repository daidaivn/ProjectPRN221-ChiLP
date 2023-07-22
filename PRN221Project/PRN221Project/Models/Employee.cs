using System;
using System.Collections.Generic;

namespace PRN221Project.Models
{
    public partial class Employee
    {
        public Employee()
        {
            Users = new HashSet<User>();
        }

        public int EmployeeId { get; set; }
        public string? EmployeeName { get; set; }
        public string? Position { get; set; }
        public bool? IsActive { get; set; }
        public DateTime? CreatedDate { get; set; }
        public DateTime? ModifiedDate { get; set; }

        public virtual ICollection<User> Users { get; set; }
    }
}
