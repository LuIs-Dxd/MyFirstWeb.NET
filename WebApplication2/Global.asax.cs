using System;
using System.Web.Routing;

namespace WebApplication2
{
    public class Global : System.Web.HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            RegisterRoutes(RouteTable.Routes);
        }

        void RegisterRoutes(RouteCollection routes)
        {
            routes.MapPageRoute("DashboardRoute", "dashboard", "~/pages/dashboard/Dashboard.aspx");
        }
    }
}
