<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReportViewer.aspx.cs" Inherits="WebApplication2.ReportViewer" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.4000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<asp:Literal ID="ltDataSet" runat="server" />

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Reporte de Productos</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:GridView ID="gvData" runat="server" AutoGenerateColumns="true"></asp:GridView>
            <CR:CrystalReportViewer
                ID="CrystalReportViewer1"
                runat="server"
                AutoDataBind="true"
                Width="100%"
                Height="600px"
                PrintMode="ActiveX" />

        </div>
    </form>
</body>
</html>
