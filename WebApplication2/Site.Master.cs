using System;
using System.Web.UI;

namespace WebApplication2
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Obtén el nombre del archivo de la página actual
            string currentPage = System.IO.Path.GetFileName(Request.PhysicalPath);

            // Si la página actual es "Dashboard.aspx" (o la que consideres principal), mostramos el toast; de lo contrario, lo ocultamos.
            if (currentPage.Equals("Default.aspx", StringComparison.OrdinalIgnoreCase))
            {
                phToast.Visible = true;
            }
            else
            {
                phToast.Visible = false;
            }
        }
    }
}