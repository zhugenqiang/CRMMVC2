using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel.DataAnnotations;

namespace CRM.Model
{
    public class LoginUser
    {
        [Required(ErrorMessage = "必填")]
        public string usr_name { get; set; }
        [Required(ErrorMessage = "必填")]
        public string usr_pwd { get; set; }
        [Required(ErrorMessage = "必填")]
        public string valicode { get; set; }
    }
}
