using System;
using System.Web.Routing;
using System.Web.Optimization;

namespace WebApplication2
{
    public class Global : System.Web.HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            RegisterRoutes(RouteTable.Routes);
            RegisterBundles(BundleTable.Bundles); // ← Agregado
        }

        void RegisterRoutes(RouteCollection routes)
        {
            routes.MapPageRoute("DashboardRoute", "dashboard", "~/pages/dashboard/Dashboard.aspx");
        }

        void RegisterBundles(BundleCollection bundles)
        {
            BundleTable.EnableOptimizations = true;
        }
    }
}
