using System;
using System.Collections.Generic;
using System.Web.UI;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
using CrudProject.BLL;
using CrudProject.Models;
using WebApplication2.pages.Reports;
using System.IO;

namespace WebApplication2
{
    public partial class ReportViewer : Page
    {
        private ProductService _productService = new ProductService();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ExportReportToPDF();
            }
        }

        private void ExportReportToPDF()
        {
            // Crear una instancia del ReportDocument
            ReportDocument report = new ReportDocument();

            // Cargar el archivo .rpt (ajusta la ruta según tu estructura)
            string reportPath = Server.MapPath("~/pages/ReportViewer/CrystalReport1.rpt");
            report.Load(reportPath);

            // Obtener la lista de productos desde la capa de negocio
            List<Product> products = _productService.GetProducts();

            // Crear un DataSet y llenarlo con los datos obtenidos
            ProductDataSet ds = new ProductDataSet();
            foreach (var product in products)
            {
                ProductDataSet.productsRow row = ds.products.NewproductsRow();
                row.id = product.Id.ToString();
                row.name = product.Name;
                row.stock = product.Stock.ToString();
                row.price = product.Price.ToString();
                row.isActive = product.IsActive.ToString();
                ds.products.AddproductsRow(row);
            }

            // Asignar el DataSet al reporte
            report.SetDataSource(ds);

            // Exportar el reporte a un stream en formato PDF
            Stream pdfStream = report.ExportToStream(ExportFormatType.PortableDocFormat);
            pdfStream.Seek(0, SeekOrigin.Begin);


            //            Stream pdfStream = report.ExportToStream(ExportFormatType.WordForWindows);
            //              pdfStream.Seek(0, SeekOrigin.Begin);


            // Configurar la respuesta HTTP para enviar el PDF
            Response.Clear();
            Response.Buffer = true;
            Response.ContentType = "application/pdf";
            // "inline" para visualizar en el navegador o "attachment" para forzar la descarga
            Response.AddHeader("Content-Disposition", "inline; filename=ReporteProductos.pdf");
            Response.BinaryWrite(ReadStreamFully(pdfStream));
            Response.End();
        }

        // Método auxiliar para leer el stream completamente y convertirlo a byte[]
        private byte[] ReadStreamFully(Stream input)
        {
            using (MemoryStream ms = new MemoryStream())
            {
                input.CopyTo(ms);
                return ms.ToArray();
            }
        }
    }
}
