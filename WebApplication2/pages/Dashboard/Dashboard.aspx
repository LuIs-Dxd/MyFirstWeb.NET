﻿<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="WebApplication2.Dashboard" %>

<asp:Content ID="sidebarPlaceholder" ContentPlaceHolderID="sidebarContent" runat="server">
        <li class="nav-item">
        <asp:HyperLink runat="server" CssClass="nav-link active" NavigateUrl="~/pages/Dashboard/Dashboard.aspx">
            <i class="bi bi-speedometer2"></i> Dashboard
        </asp:HyperLink>
    </li>
    <li class="nav-item">
        <asp:HyperLink runat="server" CssClass="nav-link text-white" NavigateUrl="#">
            <i class="bi bi-bar-chart"></i> Reports
        </asp:HyperLink>
    </li>
    <li class="nav-item">
        <asp:HyperLink runat="server" CssClass="nav-link text-white" NavigateUrl="#">
            <i class="bi bi-gear"></i> Settings
        </asp:HyperLink>
    </li>
        <li class="nav-item">
        <asp:HyperLink runat="server" CssClass="nav-link text-white" NavigateUrl="#">
            <i class="bi bi-gear"></i> Changelog
        </asp:HyperLink>
    </li>
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="wtext" runat="server">
    <!-- Enlace a Bootstrap desde CDN -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" />

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
    <!-- GridView Dashboard -->
    <asp:GridView ID="gvDashboard" runat="server" colspan="4" OnDataBound="gvDashboard_DataBound"
        CssClass="table table-striped table-hover minimalist-grid"
        AutoGenerateColumns="False"
        EmptyDataText="No hay datos que coincidan con la busqueda"
        DataKeyNames="id"
        AllowSorting="true"
        AllowPaging="true"
        PageSize="10"
        PagerStyle-Visible="false"
        OnPageIndexChanging="gvDashboard_PageIndexChanging"
        OnRowEditing="gvDashboard_RowEditing"
        OnRowUpdating="gvDashboard_RowUpdating"
        OnRowCancelingEdit="gvDashboard_RowCancelingEdit"
        OnRowDeleting="gvDashboard_RowDeleting"
        OnSorting="gvDashboard_Sorting"
        PagerStyle-BorderStyle="None"
        PagerStyle-HorizontalAlign="Center"
        PagerSettings-Mode="NumericFirstLast"
        PagerSettings-Position="Bottom"
        PagerSettings-FirstPageText="&laquo;"
        PagerSettings-LastPageText="&raquo;"
        PagerSettings-PageButtonCount="25">
        <PagerSettings Mode="NumericFirstLast"
            FirstPageText="&laquo;"
            LastPageText="&raquo;"
            PageButtonCount="25" />
        <Columns>
            <asp:BoundField DataField="id" HeaderText="ID" ReadOnly="True" SortExpression="id" />
            <asp:TemplateField HeaderText="Nombre" SortExpression="name">
                <ItemTemplate>
                    <%# Eval("Name") %>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox
                        ID="txtNombre"
                        runat="server"
                        CssClass="form-control"
                        onkeyup="this.value = this.value.toUpperCase();"
                        Style="text-transform: uppercase;"
                        Text='<%# Bind("Name") %>'>
                    </asp:TextBox>
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
            <asp:CommandField ShowEditButton="false" ShowDeleteButton="false" />
            <asp:TemplateField HeaderText="Acciones">
                <ItemTemplate>
                    <!-- Botón para editar -->
                    <asp:LinkButton ID="btnEdit" runat="server" CommandName="Edit" Text="Editar" CssClass="btn btn-outline-info" />
                    &nbsp;|&nbsp;
       
                    <!-- Botón para eliminar: pasa el ID y el nombre -->
                    <asp:LinkButton ID="btnDelete" runat="server" Text="Eliminar"
                        OnClientClick='<%# "confirmDelete(" + Eval("id") + ", \"" + Eval("Name") + "\"); return false;" %>'
                        CssClass="btn btn-outline-danger" />
                </ItemTemplate>
                <EditItemTemplate>
                    <!-- Botones de actualización y cancelación en modo edición -->
                    <asp:LinkButton ID="btnUpdate" runat="server" CommandName="Update" Text="Actualizar" CssClass="btn btn-warning" />
                    &nbsp;|&nbsp;
       
                    <asp:LinkButton ID="btnCancelEdit" runat="server" CommandName="Cancel" Text="Cancelar" CssClass="btn btn-outline-primary" />
                </EditItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <!-- contador de productos -->
    <asp:Label ID="lblTotalDinero" runat="server" CssClass="badge badge-light p-2 float-end"></asp:Label>
    <asp:Label ID="lblTotalProductos" runat="server" CssClass="badge badge-light p-2 float-end" Style="margin-right: 10px;"></asp:Label>

    <asp:HiddenField ID="hdnProductId" runat="server" />

<nav aria-label="Page navigation">
    <ul class="pagination pagination-minimal justify-content-center">
        <!-- Botón "Anterior" -->
        <li class="page-item">
            <a class="page-link" href="#" onclick="changePage('<%= gvDashboard.PageIndex - 1 %>'); return false;">Anterior</a>
        </li>
        
        <!-- Repeater para generar las páginas -->
        <asp:Repeater ID="rptPages" runat="server">
            <ItemTemplate>
                <li class="page-item <%# Convert.ToInt32(Eval("PageIndex")) == gvDashboard.PageIndex ? "active" : "" %>">
                    <a class="page-link" href="#" onclick="changePage('<%# Eval("PageIndex") %>'); return false;">
                        <%# Eval("PageDisplay") %>
                    </a>
                </li>
            </ItemTemplate>
        </asp:Repeater>
        
        <!-- Botón "Siguiente" -->
        <li class="page-item">
            <a class="page-link" href="#" onclick="changePage('<%= gvDashboard.PageIndex + 1 %>'); return false;">Siguiente</a>
        </li>
    </ul>
</nav>


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
                    <button type="button" class="close" data-dismiss="modal"     aria-label="Cerrar" >
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
                    <asp:Button ID="btnCancel" runat="server" Text="Cancelar" CssClass="btn btn-secondary" data-dismiss="modal" 

                        OnClientClick="$('#pnlAddProduct').modal('hide'); return false;" />
                </div>
            </div>
        </div>
    </asp:Panel>


    <!-- Confirmation panel -->
    <asp:Panel ID="pnlConfirmation" runat="server" CssClass="modal fade" Role="dialog">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">¿Estás seguro?</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Cerrar">
                        <span aria-hidden="true"></span>
                    </button>
                </div>
                <div class="modal-body">
                    <p id="pConfirmationMessage">¿Deseas eliminar este producto?</p>
                </div>
                <div class="modal-footer">
                    <!-- Botón para confirmar la eliminación -->
                    <asp:Button ID="btnConfirmDeletion" runat="server" Text="Sí, eliminar"
                        CssClass="btn btn-danger" OnClick="btnConfirmDeletion_Click" />
                    <!-- Botón para cancelar -->
                    <asp:Button ID="btnCancelDeletion" runat="server" Text="Cancelar"
                        CssClass="btn btn-secondary"
                        OnClientClick="$('#<%= pnlConfirmation.ClientID %>').modal('hide'); return false;" />
                </div>
            </div>
        </div>
    </asp:Panel>



    <!-- Scripts de jQuery y Bootstrap -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>


    <!-- Bootstrap  -->

    <asp:PlaceHolder runat="server">
        <%: Scripts.Render("~/Scripts/bootstrap.js") %>
    </asp:PlaceHolder>
    <!--  Modal de confirmacion -->
    <script type="text/javascript">
        function confirmDelete(productId, productName) {
            // Asigna el ID del producto al HiddenField
            document.getElementById('<%= hdnProductId.ClientID %>').value = productId;
            // Actualiza el mensaje de confirmación con el nombre del producto
            document.getElementById('pConfirmationMessage').innerText = "¿Deseas eliminar el producto '" + productName + "'?";
            // Abre el modal de confirmación
            $('#<%= pnlConfirmation.ClientID %>').modal('show');
        }
    </script>
    <script>
        $(document).ready(function () {
            // Vincula el evento keyup al TextBox, utilizando su ClientID
            $('#<%= txtNombre.ClientID %>').on('keyup', function () {
                // Convierte el valor a mayúsculas y lo asigna al input
                $(this).val($(this).val().toUpperCase());
            });
        });
    </script>

<%--    <script type="text/javascript">
        function changePage(pageIndex) {
            // Asigna el nuevo índice en un HiddenField o usa __doPostBack para enviar el valor al servidor.
            // Por ejemplo, si usas un HiddenField:
            document.getElementById('<%= hdnPageIndex.ClientID %>').value = pageIndex;
            __doPostBack('ChangePage', '');
        }
</script>--%>

</asp:Content>
