using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using webapi_cmv.Models;

namespace webapi_cmv.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CuentasController : ControllerBase
    {

        private readonly IConfiguration _configuration;
        public CuentasController(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        //Metodo GET para obtener la relacion de los clientes y sus cuentas
        [HttpGet("{id}")]

        public JsonResult Get(int id)
        {
            string query = @"EXEC consultarCuenta @idCliente";

            DataTable table = new DataTable();
            string sqlDataSource = _configuration.GetConnectionString("Conexion");
            SqlDataReader myReader;
            using (SqlConnection miCon = new SqlConnection(sqlDataSource))
            {
                miCon.Open();
                using (SqlCommand miComando = new SqlCommand(query, miCon))
                {
                    miComando.Parameters.AddWithValue("@idCliente", id);
                    myReader = miComando.ExecuteReader();
                    table.Load(myReader);
                    myReader.Close();
                    miCon.Close();
                }
            }

            return new JsonResult(table);
        }

        //Metodo POST para dar relacionar clientes con cuentas
        [HttpPost]

        public JsonResult Post(Cliente_Cuenta cuenta)
        {
            string query = @"EXEC asociarCuenta @idCliente, @idCuenta, @saldoActual";

            DataTable table = new DataTable();
            string sqlDataSource = _configuration.GetConnectionString("Conexion");
            SqlDataReader myReader;
            using (SqlConnection miCon = new SqlConnection(sqlDataSource))
            {
                miCon.Open();
                using (SqlCommand miComando = new SqlCommand(query, miCon))
                {
                    miComando.Parameters.AddWithValue("@idCliente", cuenta.idCliente);
                    miComando.Parameters.AddWithValue("@idCuenta", cuenta.idCuenta);
                    miComando.Parameters.AddWithValue("@saldoActual", cuenta.saldoActual);
                    myReader = miComando.ExecuteReader();
                    table.Load(myReader);
                    myReader.Close();
                    miCon.Close();
                }
            }

            return new JsonResult("Cuenta asociada correctamente");
        }

    }
}
