using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace webapi_cmv.Models
{
    public class Cliente_Cuenta
    {
        public int idClienteCuenta { get; set; }
        public int idCliente { get; set; }
        public int idCuenta { get; set; }
        public decimal saldoActual { get; set; }
        public DateTime fechaContratacion { get; set; }
        public DateTime fechaUltimoMovimiento { get; set; }

    }
}
