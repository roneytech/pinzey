﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Album2.aspx.cs" MasterPageFile="~/Site.Master" Inherits="PictureShare1.AlbumTel" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div>
        <h1> Pin: <asp:Label ID="LabelAlbumPin" runat="server" /></h1>
        <h1> Name: <asp:Label ID="LabelAlbumName" runat="server" /></h1>
        <asp:LoginView ID="LoginView1" runat="server">
            <LoggedInTemplate>
                <telerik:RadFileExplorer ID="RadFileExplorerUser"
                    runat="server"
                    VisibleControls="FileList, Grid, Toolbar, ListView, TreeView"
                    Configuration-AllowMultipleSelection="true"
                    Configuration-MaxUploadFileSize="500000000">
                </telerik:RadFileExplorer>
            </LoggedInTemplate>
            <AnonymousTemplate>
                <telerik:RadFileExplorer ID="RadFileExplorerAnon" runat="server"
                    VisibleControls="FileList, Grid, Toolbar, ListView, TreeView"
                    Configuration-AllowMultipleSelection="true"
                    Configuration-MaxUploadFileSize="500000000">
                </telerik:RadFileExplorer>
            </AnonymousTemplate>
        </asp:LoginView>
        <br />
        <br />

    </div>
</asp:Content>
