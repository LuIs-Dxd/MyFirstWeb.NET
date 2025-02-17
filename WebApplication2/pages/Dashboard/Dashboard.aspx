
<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs"  Inherits="WebApplication2.Dashboard" %>

<asp:Content ID="sidebarPlaceholder" ContentPlaceHolderID="sidebarContent" runat="server">
    <li class="nav-item">
        <a class="nav-link text-white" href="Dashboard.aspx"><i class="bi bi-house-door"></i> Dashboard</a>
    </li>
    <li class="nav-item">
        <a class="nav-link text-white" href="#"><i class="bi bi-box-seam"></i> Inventory</a>
    </li>
    <li class="nav-item">
        <a class="nav-link text-white" href="#"><i class="bi bi-clipboard-data"></i> Reports</a>
    </li>
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="wtext" runat="server">
    <!-- Enlace a Bootstrap desde CDN -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
    <link href="../../Content/DashboardStyle.css" rel="stylesheet" />



    <!-- Agregar producto button -->
    <div class="container mt-2">

        <div class="row align-items-center mb-0">
            <!-- Columna izquierda: Título -->
            <div class="col-md-4">
                <h2 class="mb-0">Dashboard</h2>
            </div>

            <!-- Columna central: Input de búsqueda -->
            <div class="col-md-4">
                <div class="input-group">
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search" />
                    <div class="input-group-append">
                        <asp:Button ID="btnSearch" runat="server" CssClass="btn btn-outline-success" Text="Buscar" OnClick="btnSearch_Click" />
                    </div>
                </div>
            </div>

            <!-- Columna derecha: Botón Agregar/imprimir Producto -->
            <div class="col-md-4 text-right">
                <button id="btnPrint" runat="server" class="btn btn-outline-secondary mr-2" onserverclick="btnPrint_Click">
                   Imprimir <i class="bi bi-printer"></i>
   
                </button>
                <asp:Button ID="btnAddNew" runat="server" Text="Agregar Producto" CssClass="btn btn-outline-primary" OnClick="btnAddNew_Click" />
            </div>

        </div>
    </div>

 <asp:GridView ID="gvDashboard" runat="server"
    CssClass="table table-striped table-hover"
    AutoGenerateColumns="False" 
    emptydatatext="No data available." 
    BorderStyle="Ridge"
    DataKeyNames="id"
    AllowSorting="true"
    AllowPaging="true"
    PageSize="12"
    OnPageIndexChanging="gvDashboard_PageIndexChanging"
    OnRowEditing="gvDashboard_RowEditing"
    OnRowUpdating="gvDashboard_RowUpdating"
    OnRowCancelingEdit="gvDashboard_RowCancelingEdit"
    OnRowDeleting="gvDashboard_RowDeleting"
    OnSorting="gvDashboard_Sorting">
    <Columns>
        <asp:BoundField DataField="id" HeaderText="ID" ReadOnly="True" SortExpression="id" />
        <asp:TemplateField HeaderText="Nombre" SortExpression="name">
            <ItemTemplate>
                <%# Eval("Name") %>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="txtNombre" runat="server" Text='<%# Bind("Name") %>'></asp:TextBox>
            </EditItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Stock" SortExpression="stock">
            <ItemTemplate>
                <%# Eval("Stock") %>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="txtStock" runat="server" Text='<%# Bind("Stock") %>'></asp:TextBox>
            </EditItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Precio" SortExpression="price">
            <ItemTemplate>
                <%# Eval("Price", "{0:C}") %>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="txtPrecio" runat="server" Text='<%# Bind("Price") %>'></asp:TextBox>
            </EditItemTemplate>
        </asp:TemplateField>
        <asp:CommandField ShowEditButton="true" ShowDeleteButton="true" />
    </Columns>
</asp:GridView>

<%--
    <nav aria-label="Page navigation">
        <ul class="pagination justify-content-center">
            <li class="page-item">
                <a class="page-link" href="#" aria-label="Previous">
                    <span aria-hidden="true">&laquo;</span>
                    <span class="sr-only">Previous</span>
                </a>
            </li>
            <li class="page-item"><a class="page-link" href="#">1</a></li>
            <li class="page-item"><a class="page-link" href="#">2</a></li>
            <li class="page-item"><a class="page-link" href="#">3</a></li>
            <li class="page-item">
                <a class="page-link" href="#" aria-label="Next">
                    <span aria-hidden="true">&raquo;</span>
                    <span class="sr-only">Next</span>
                </a>
            </li>
        </ul>
    </nav>
        --%>

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
                    <asp:Button ID="btnCancel" runat="server" Text="Cancelar" CssClass="btn btn-secondary"
    OnClientClick="$('#pnlAddProduct').modal('hide'); return false;" />

                </div>
            </div>
        </div>
    </asp:Panel>



    <!-- Scripts de jQuery y Bootstrap -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Bootstrap  -->

    <asp:PlaceHolder runat="server">
        <%: Scripts.Render("~/Scripts/bootstrap.js") %>
    </asp:PlaceHolder>

</asp:Content>