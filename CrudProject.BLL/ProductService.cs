using System.Collections.Generic;
using CrudProject.Models;
using CrudProject.DAL;

namespace CrudProject.BLL
{
    public class ProductService
    {
        private readonly ProductRepository _productRepository;

        public ProductService()
        {
            _productRepository = new ProductRepository();
        }
        public void AddProduct(Product product)
        {
            _productRepository.InsertProduct(product);
        }
        public List<Product> GetProducts()
        {
            return _productRepository.GetProducts();
        }

        public void InsertProduct(Product product)
        {
            _productRepository.InsertProduct(product);
        }

        public void UpdateProduct(Product product)
        {
            _productRepository.UpdateProduct(product);
        }

        public void DeleteProduct(int id)
        {
            _productRepository.DeleteProduct(id);
        }
    }
}
