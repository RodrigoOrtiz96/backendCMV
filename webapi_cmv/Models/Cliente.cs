using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace webapi_cmv.Models
{
    public class Cliente
    {
        public int idCliente { get; set; }
        public string nombre { get; set; }
        public string apellidoPaterno { get; set; }
        public string apellidoMaterno { get; set; }
        public string rfc { get; set; }
        public string curp { get; set; }
        public DateTime fechaAlta { get; set; }

    }
}
