using System.Collections.Generic;
using System.Configuration;
using System.Data;
using CrudProject.Models;
using MySql.Data.MySqlClient;

namespace CrudProject.DAL
{
    public class ProductRepository
    {
        private readonly string _connectionString = ConfigurationManager.ConnectionStrings["MySqlConnection"].ConnectionString;

        public List<Product> GetProducts()
        {
            var products = new List<Product>();

            using (MySqlConnection connection = new MySqlConnection(_connectionString))
            {
                connection.Open();
                using (MySqlCommand cmd = new MySqlCommand("sp_GetProducts", connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    using (MySqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            products.Add(new Product
                            {
                                Id = reader.GetInt32("id"),
                                Name = reader.GetString("name"),
                                Price = reader.GetDecimal("price"),
                                Stock = reader.GetInt32("stock"),
                                IsActive = reader.GetBoolean("isActive")
                            });
                        }
                    }
                }
            }

            return products;
        }

        public void InsertProduct(Product product)
        {
            using (MySqlConnection connection = new MySqlConnection(_connectionString))
            {
                connection.Open();
                using (MySqlCommand cmd = new MySqlCommand("sp_InsertProduct", connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("p_name", product.Name);
                    cmd.Parameters.AddWithValue("p_price", product.Price);
                    cmd.Parameters.AddWithValue("p_stock", product.Stock);
                    cmd.ExecuteNonQuery();
                }
            }
        }

        public void UpdateProduct(Product product)
        {
            using (MySqlConnection connection = new MySqlConnection(_connectionString))
            {
                connection.Open();
                using (MySqlCommand cmd = new MySqlCommand("sp_UpdateProduct", connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("p_id", product.Id);
                    cmd.Parameters.AddWithValue("p_name", product.Name);
                    cmd.Parameters.AddWithValue("p_price", product.Price);
                    cmd.Parameters.AddWithValue("p_stock", product.Stock);
                    cmd.ExecuteNonQuery();
                }
            }
        }

        public void DeleteProduct(int id)
        {
            using (MySqlConnection connection = new MySqlConnection(_connectionString))
            {
                connection.Open();
                using (MySqlCommand cmd = new MySqlCommand("sp_DeleteProduct", connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("p_id", id);
                    cmd.ExecuteNonQuery();
                }
            }
        }
    }
}
