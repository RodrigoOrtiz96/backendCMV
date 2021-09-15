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
    public class ClienteController : ControllerBase
    {

        private readonly IConfiguration _configuration;
        public ClienteController(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        //Metodo GET para obtener la lista de los clientes
        [HttpGet]
        
        public JsonResult Get()
        {
            string query = @"EXEC selecClientes";

            DataTable table = new DataTable();
            string sqlDataSource = _configuration.GetConnectionString("Conexion");
            SqlDataReader myReader;
            using (SqlConnection miCon=new SqlConnection(sqlDataSource))
            {
                miCon.Open();
                using (SqlCommand miComando=new SqlCommand(query, miCon))
                {
                    myReader = miComando.ExecuteReader();
                    table.Load(myReader);
                    myReader.Close();
                    miCon.Close();
                }
            }

            return new JsonResult(table);
        }

        //Metodo PUT para modificar un cliente
        [HttpPut]

        public JsonResult Put(Cliente client)
        {
            string query = @"EXEC actualizarCliente @idCliente, @nombre, @apellidoPaterno, @apellidoMaterno, @rfc, @curp";

            DataTable table = new DataTable();
            string sqlDataSource = _configuration.GetConnectionString("Conexion");
            SqlDataReader myReader;
            using (SqlConnection miCon = new SqlConnection(sqlDataSource))
            {
                miCon.Open();
                using (SqlCommand miComando = new SqlCommand(query, miCon))
                {
                    miComando.Parameters.AddWithValue("@idCliente", client.idCliente);
                    miComando.Parameters.AddWithValue("@nombre", client.nombre);
                    miComando.Parameters.AddWithValue("@apellidoPaterno", client.apellidoPaterno);
                    miComando.Parameters.AddWithValue("@apellidoMaterno", client.apellidoMaterno);
                    miComando.Parameters.AddWithValue("@rfc", client.rfc);
                    miComando.Parameters.AddWithValue("@curp", client.curp);
                    myReader = miComando.ExecuteReader();
                    table.Load(myReader);
                    myReader.Close();
                    miCon.Close();
                }
            }

            return new JsonResult("Cliente modificado");
        }

        //Metodo DELETE para eliminar un cliente
        [HttpDelete("{id}")]

        public JsonResult Delete(int id)
        {
            string query = @"EXEC eliminarCliente @idCliente";

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

            return new JsonResult("Cliente eliminado");
        }

        //Metodo POST para dar de alta un nuevo cliente
        [HttpPost]

        public JsonResult Post(Cliente client)
        {
            string query = @"EXEC altaCliente @nombre, @apellidoPaterno, @apellidoMaterno, @rfc, @curp";

            DataTable table = new DataTable();
            string sqlDataSource = _configuration.GetConnectionString("Conexion");
            SqlDataReader myReader;
            using (SqlConnection miCon = new SqlConnection(sqlDataSource))
            {
                miCon.Open();
                using (SqlCommand miComando = new SqlCommand(query, miCon))
                {
                    miComando.Parameters.AddWithValue("@nombre", client.nombre);
                    miComando.Parameters.AddWithValue("@apellidoPaterno", client.apellidoPaterno);
                    miComando.Parameters.AddWithValue("@apellidoMaterno", client.apellidoMaterno);
                    miComando.Parameters.AddWithValue("@rfc", client.rfc);
                    miComando.Parameters.AddWithValue("@curp", client.curp);
                    myReader = miComando.ExecuteReader();
                    table.Load(myReader);
                    myReader.Close();
                    miCon.Close();
                }
            }

            return new JsonResult("Nuevo cliente agregado");
        }


    }
}
