<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="WebApplication2.Dashboard" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="wtext" runat="server">
    <!-- Enlace a Bootstrap desde CDN -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />

    <div class="container mt-4">
        <h2 class="mb-4">Dashboard</h2>
        
        <!-- GridView -->
 <asp:GridView ID="gvDashboard" runat="server"
    CssClass="table table-striped table-hover"
    AutoGenerateColumns="False" DataKeyNames="id"
    OnRowEditing="gvDashboard_RowEditing"
    OnRowUpdating="gvDashboard_RowUpdating"
    OnRowCancelingEdit="gvDashboard_RowCancelingEdit"
    OnRowDeleting="gvDashboard_RowDeleting">
    <Columns>
        <asp:BoundField DataField="id" HeaderText="ID" ReadOnly="True" />
        <asp:TemplateField HeaderText="Nombre">
            <ItemTemplate>
                <%# Eval("name") %>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="txtNombre" runat="server" Text='<%# Bind("name") %>'></asp:TextBox>
            </EditItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Stock">
            <ItemTemplate>
                <%# Eval("stock") %>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="txtStock" runat="server" Text='<%# Bind("stock") %>'></asp:TextBox>
            </EditItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Precio">
            <ItemTemplate>
                <%# Eval("price", "{0:C}") %>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="txtPrecio" runat="server" Text='<%# Bind("price") %>'></asp:TextBox>
            </EditItemTemplate>
        </asp:TemplateField>
        <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" />
    </Columns>
</asp:GridView>


        <!-- Botón para agregar un nuevo registro -->
        <asp:Button ID="btnAddNew" runat="server" Text="Agregar Producto" CssClass="btn btn-primary mt-3" OnClick="btnAddNew_Click" />
    </div>
<!-- Modal para agregar producto utilizando Bootstrap -->
<asp:Panel ID="pnlAddProduct" runat="server" CssClass="modal fade" Role="dialog">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Agregar Nuevo Producto</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Cerrar">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <!-- Grupo de controles para Nombre -->
                <div class="form-group">
                    <asp:Label ID="lblNombre" runat="server" Text="Nombre:" CssClass="control-label"></asp:Label>
                    <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
                <!-- Grupo de controles para Precio -->
                <div class="form-group">
                    <asp:Label ID="lblPrecio" runat="server" Text="Precio:" CssClass="control-label"></asp:Label>
                    <asp:TextBox ID="txtPrecio" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
<!-- grupo de controles de btnguardar -->
                <div class="form-group">
                    <asp:Label ID="lblStock" runat="server" Text="Stock:" CssClass="control-label"></asp:Label>
                    <asp:TextBox ID="txtStock" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
            </div>
            <div class="modal-footer">
                <asp:Button ID="btnSaveProduct" runat="server" Text="Guardar" CssClass="btn btn-success" OnClick="btnSaveProduct_Click" />
                <asp:Button ID="btnCancel" runat="server" Text="Cancelar" CssClass="btn btn-secondary" OnClick="btnCancel_Click" />
            </div>
        </div>a
    </div>
</asp:Panel>



    <!-- Scripts de jQuery y Bootstrap -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Script para mostrar el modal si pnlAddProduct.Visible es true -->
    <script>
        $(document).ready(function () {
        <% if (pnlAddProduct.Visible) { %>
        $('#<%= pnlAddProduct.ClientID %>').modal('show');
        <% } %>
    });
    </script>
</asp:Content>
