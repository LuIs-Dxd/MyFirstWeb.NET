using MySql.Data.MySqlClient;
using System;
using System.Configuration;
using System.Data;
using System.Web.UI.WebControls;

namespace WebApplication2
{
    public partial class Dashboard : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["MySqlConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid(); // Cargar datos en el GridView
            }
        }

        private void BindGrid()
        {
            try
            {
                using (MySqlConnection conn = new MySqlConnection(cs))
                {
                    conn.Open();
                    string query = "SELECT id, name, price, stock FROM products WHERE isActive = 1";
                    MySqlDataAdapter da = new MySqlDataAdapter(query, conn);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvDashboard.DataSource = dt;
                    gvDashboard.DataBind();
                }
            }
            catch (Exception ex)
            {
                Response.Write($"<script>alert('Error al cargar la tabla: {ex.Message}');</script>");
            }
        }


        protected void btnAddNew_Click(object sender, EventArgs e)
        {
            pnlAddProduct.Visible = true;
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            pnlAddProduct.Visible = false;
        }


        protected void btnSaveProduct_Click(object sender, EventArgs e)
        {
            string nombre = txtNombre.Text;
            decimal precio;
            int stock;

            if (string.IsNullOrEmpty(nombre) || !decimal.TryParse(txtPrecio.Text, out precio) || !int.TryParse(txtStock.Text, out stock))
            {
                Response.Write("<script>alert('Datos invalidos');</script>");
                return;
            }

            using (MySqlConnection conn = new MySqlConnection(cs))
            {
                conn.Open();
                string query = "INSERT INTO products (name, price, stock, isActive) VALUES (@name, @price, @stock, 1)";
                MySqlCommand cmd = new MySqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@name", nombre);
                cmd.Parameters.AddWithValue("@price", precio);
                cmd.Parameters.AddWithValue("@stock", stock);
                cmd.ExecuteNonQuery();
            }

            BindGrid();
            pnlAddProduct.Visible = false;
        }

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

        protected void gvDashboard_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int id = Convert.ToInt32(gvDashboard.DataKeys[e.RowIndex].Value);
            GridViewRow row = gvDashboard.Rows[e.RowIndex];

            // Recuperar los controles por sus IDs usando FindControl
            TextBox txtNombre = (TextBox)row.FindControl("txtNombre");
            TextBox txtStock = (TextBox)row.FindControl("txtStock");
            TextBox txtPrecio = (TextBox)row.FindControl("txtPrecio");

            if (txtNombre == null || txtStock == null || txtPrecio == null)
            {
                Response.Write("<script>alert('Error al recuperar los controles de edición.');</script>");
                return;
            }

            string nombre = txtNombre.Text;
            string stockTexto = txtStock.Text.Trim();
            string precioTexto = txtPrecio.Text.Trim();

            decimal precio;
            int stock;

            if (!decimal.TryParse(precioTexto, out precio))
            {
                Response.Write("<script>alert('Error: Precio debe ser un número válido.');</script>");
                return;
            }

            if (!int.TryParse(stockTexto, out stock))
            {
                Response.Write("<script>alert('Error: Stock debe ser un número entero válido.');</script>");
                return;
            }

            try
            {
                using (MySqlConnection con = new MySqlConnection(cs))
                {
                    string query = "UPDATE products SET name=@name, price=@price, stock=@stock WHERE id=@id";
                    using (MySqlCommand cmd = new MySqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@name", nombre);
                        cmd.Parameters.AddWithValue("@price", precio);
                        cmd.Parameters.AddWithValue("@stock", stock);
                        cmd.Parameters.AddWithValue("@id", id);
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
                gvDashboard.EditIndex = -1;
                BindGrid();
            }
            catch (Exception ex)
            {
                Response.Write($"<script>alert('Error al actualizar el producto: {ex.Message}');</script>");
            }
        }




        //cambiar esto
        protected void gvDashboard_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(gvDashboard.DataKeys[e.RowIndex].Value);

            try
            {
                using (MySqlConnection con = new MySqlConnection(cs))
                {
                    string query = "DELETE FROM products WHERE id=@id";
                    using (MySqlCommand cmd = new MySqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@id", id);
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
                BindGrid();
            }
            catch (Exception ex)
            {
                Response.Write($"<script>alert('Error al eliminar el producto: {ex.Message}');</script>");
            }
        }
    }
}