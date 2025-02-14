using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;
using CrudProject.BLL;       // Asegúrate de tener la referencia al proyecto BLL
using CrudProject.Models;    // Para la clase Product
using System.Linq;

namespace WebApplication2
{
    public partial class Dashboard : Page
    {
        // Puedes instanciar el servicio aquí.
        // En escenarios más avanzados podrías implementar un patrón de inyección de dependencias con Unity o Ninject.
        private ProductService _productService = new ProductService();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid(); // Cargar datos en el GridView

            }
        }

        private void BindGrid(string searchText = "")
        {
            try
            {
                List<Product> products = _productService.GetProducts();

                // Filtrar si hay texto de búsqueda
                if (!string.IsNullOrEmpty(searchText))
                {
                    products = products.Where(p => p.Name.ToLower().Contains(searchText)).ToList();
                }

                gvDashboard.DataSource = products;
                gvDashboard.DataBind();
            }
            catch (Exception ex)
            {
                Response.Write($"<script>alert('Error al cargar la tabla: {ex.Message}');</script>");
            }
        }


        protected void gvDashboard_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvDashboard.PageIndex = e.NewPageIndex;
            BindGrid();     
        }

        
        protected int GetMaxID()
        {
            List<Product> products = _productService.GetProducts();
            if (products != null && products.Count > 0)
            {
                return products.Select(p => p.Id).Max();
            }
            return 0;
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string searchText = txtSearch.Text.Trim().ToLower();
            BindGrid(searchText);
        }

        protected void btnAddNew_Click(object sender, EventArgs e)
        {
            pnlAddProduct.Visible = true;
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            pnlAddProduct.Visible = false;
        }

        // Insertar un nuevo producto usando la BLL
        protected void btnSaveProduct_Click(object sender, EventArgs e)
        {                       
            string name = txtNombre.Text;
            decimal price;
            int stock;

            if (string.IsNullOrEmpty(name) ||
                !decimal.TryParse(txtPrecio.Text, out price) ||
                !int.TryParse(txtStock.Text, out stock))
            {
                Response.Write("<script>alert('Datos inválidos');</script>");
                return;
            }

            try
            {
                // Crear el nuevo producto
                Product newProduct = new Product
                {
                    Name = name,
                    Price = price,
                    Stock = stock,
                    IsActive = true  
                };

                // Llama al método de la BLL para insertar el producto
                _productService.AddProduct(newProduct);

                // Llamar a BindGrid después de que el producto se haya insertado con éxito
                BindGrid();
                Response.Redirect(Request.Url.ToString(), true);
                // Cerrar el modal después de guardar
                pnlAddProduct.Visible = false;
            }
            catch (Exception ex)
            {
                Response.Write($"<script>alert('Error al insertar el producto: {ex.Message}');</script>");
                return;
            }
        }

        // Actualizar un producto (evento del GridView)
        protected void gvDashboard_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int id = Convert.ToInt32(gvDashboard.DataKeys[e.RowIndex].Value);
            GridViewRow row = gvDashboard.Rows[e.RowIndex];

            // Obtén los controles de edición del GridView
            TextBox txtNombreEdit = (TextBox)row.FindControl("txtNombre");
            TextBox txtPrecioEdit = (TextBox)row.FindControl("txtPrecio");
            TextBox txtStockEdit = (TextBox)row.FindControl("txtStock");

            if (txtNombreEdit == null || txtPrecioEdit == null || txtStockEdit == null)
            {
                Response.Write("<script>alert('Error al recuperar controles de edición.');</script>");
                return;
            }

            string name = txtNombreEdit.Text;
            decimal price;
            int stock;

            if (!decimal.TryParse(txtPrecioEdit.Text, out price) ||
                !int.TryParse(txtStockEdit.Text, out stock))
            {
                Response.Write("<script>alert('Datos inválidos');</script>");
                return;
            }

            try
            {
                Product productToUpdate = new Product
                {
                    Id = id,
                    Name = name,
                    Price = price,
                    Stock = stock
                };

                // Llama al método de la BLL para actualizar el producto
                _productService.UpdateProduct(productToUpdate);
            }
            catch (Exception ex)
            {
                Response.Write($"<script>alert('Error al actualizar el producto: {ex.Message}');</script>");
                return;
            }

            gvDashboard.EditIndex = -1;
            BindGrid();
        }

        // Eliminar un producto (evento del GridView)
        protected void gvDashboard_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(gvDashboard.DataKeys[e.RowIndex].Value);

            try
            {
                // Llama al método de la BLL para eliminar el producto
                _productService.DeleteProduct(id);
            }
            catch (Exception ex)
            {
                Response.Write($"<script>alert('Error al eliminar el producto: {ex.Message}');</script>");
                return;
            }

            BindGrid();
        }
        protected void gvDashboard_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            // Verificamos que sea una fila de datos (no los encabezados, pie de página, etc.)
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Obtener el ID del producto de la fila
                int productId = Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "id"));
                int maxId = GetMaxID();  // Llamamos al método para obtener el ID máximo

                // Si el ID de la fila es igual al ID máximo, agregamos el badge "Nuevo"
                if (productId == maxId)
                {
                    // Encuentra la celda correspondiente (en este caso, la celda de "Estado")
                    e.Row.Cells[4].Text = "<span class='badge badge-pill badge-primary'>Nuevo</span>";  // La celda 4 es la columna "Estado"
                }
            }
        }
        protected void gvDashboard_Sorting(object sender, GridViewSortEventArgs e)
        {
            // Obtén la lista de productos desde tu servicio.
            List<Product> products = _productService.GetProducts();
            if (products != null && products.Count > 0)
            {
                // Determina la dirección de ordenamiento (ASC o DESC)
                string sortDirection = GetSortDirection(e.SortExpression);

                // Ordena la lista según el SortExpression
                switch (e.SortExpression)
                {
                    case "id":
                        products = sortDirection == "ASC"
                            ? products.OrderBy(p => p.Id).ToList()
                            : products.OrderByDescending(p => p.Id).ToList();
                        break;
                    case "name":
                        products = sortDirection == "ASC"
                            ? products.OrderBy(p => p.Name).ToList()
                            : products.OrderByDescending(p => p.Name).ToList();
                        break;
                    case "stock":
                        products = sortDirection == "ASC"
                            ? products.OrderBy(p => p.Stock).ToList()
                            : products.OrderByDescending(p => p.Stock).ToList();
                        break;
                    case "price":
                        products = sortDirection == "ASC"
                            ? products.OrderBy(p => p.Price).ToList()
                            : products.OrderByDescending(p => p.Price).ToList();
                        break;
                    default:
                        break;
                }

                // Vuelve a enlazar la lista ordenada al GridView.
                gvDashboard.DataSource = products;
                gvDashboard.DataBind();
            }
        }


        private string GetSortDirection(string column)
        {
            // Por defecto, la dirección es ASC.
            string sortDirection = "ASC";

            // Recupera la última columna ordenada del ViewState.
            string sortExpression = ViewState["SortExpression"] as string;

            if (sortExpression != null)
            {
                // Si se vuelve a ordenar por la misma columna, alterna la dirección.
                if (sortExpression == column)
                {
                    string lastDirection = ViewState["SortDirection"] as string;
                    if ((lastDirection != null) && (lastDirection == "ASC"))
                    {
                        sortDirection = "DESC";
                    }
                }
            }

            // Guarda la columna actual y la dirección en el ViewState.
            ViewState["SortDirection"] = sortDirection;
            ViewState["SortExpression"] = column;

            return sortDirection;
        }



        // Otros eventos (por ejemplo, RowEditing y RowCancelingEdit) se implementan de manera similar
        protected void gvDashboard_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvDashboard.EditIndex = e.NewEditIndex;
            BindGrid();
        }

        protected void gvDashboard_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvDashboard.EditIndex = -1;
            BindGrid();
        }
    }
}
