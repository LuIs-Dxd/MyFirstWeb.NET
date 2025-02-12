<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Inventory.aspx.cs" Inherits="WebApplication2.Pages.Inventory.Inventory" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <title>Inventory Management</title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ContentPlaceHolder ID="navbarl" runat="server">

            <asp:Content ID="Content1" ContentPlaceHolderID="navbarl" runat="server">
                <h1>Inventory Management</h1>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False">
                    <Columns>
                        <asp:BoundField DataField="ProductID" HeaderText="ID" />
                        <asp:BoundField DataField="ProductName" HeaderText="Name" />
                        <asp:BoundField DataField="Quantity" HeaderText="Quantity" />
                        <asp:BoundField DataField="Price" HeaderText="Price" DataFormatString="{0:C}" />
                    </Columns>
                </asp:GridView>
            </asp:Content>

        </asp:ContentPlaceHolder>
    </form>
</body>
</html>
