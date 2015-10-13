<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AccountSettings.aspx.cs" Inherits="PictureShare1.AccountSettings" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Default album pin setup</h2>
    <br />
    <asp:RadioButtonList ID="RadioButtonListPinStyle" runat="server">
        <asp:ListItem>One pin for the whole album (Easiest)</asp:ListItem>
        <asp:ListItem>Unique pin for each user (Requires Setup)</asp:ListItem>
    </asp:RadioButtonList>
</asp:Content>
