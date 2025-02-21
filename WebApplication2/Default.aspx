<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebApplication2._Default" %>

<asp:Content ID="SidebarContent" ContentPlaceHolderID="sidebarContent" runat="server">
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


<asp:Content ID="FooterContent" ContentPlaceHolderID="footerContent" runat="server">
    <footer>© 2025 Inventory System. All Rights Reserved.</footer>
</asp:Content>
