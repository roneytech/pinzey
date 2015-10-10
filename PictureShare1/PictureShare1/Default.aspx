<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="PictureShare1._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div id="top">
        <div class="left">
            <h2>Access Existing Album</h2>
                <div id="existing_album">
                        <asp:TextBox ID="TextBoxPin" runat="server" placeholder="Album Code"></asp:TextBox><asp:Button ID="ButtonLoadAlbum" Text="Go" runat="server" OnClick="ButtonLoadAlbum_Click" />
                    <p class="error">
                        <asp:Label ID="LabelErrorMessage" runat="server" Text="" ForeColor="Red"></asp:Label>
                    </p>
                </div>
        </div>
        <div class="right">
            <h2>Create a New Album</h2>
            <%--<p>
                In just two easy steps you can create an album that your whole family can upload photos to. 
                They will not need to set up an account!
            </p>--%>
<%--            <p>
                <a class="btn btn-default" href="CreateAlbum.aspx">Create New Album &raquo;</a>
            </p>--%>
            <div id="new_album">
                <asp:TextBox ID="TextBoxAlbumName" runat="server" placeholder="Album Name"></asp:TextBox>
                <asp:Button ID="ButtonCreateAlbum" runat="server" Text="Go" OnClick="ButtonCreateAlbum_Click" />
            </div>
            <div class="error">
                    <h3><asp:Label ID="LabelPin" runat="server" Text="Your pin is:" Visible="false"></asp:Label></h3>
                    <p>
                        <asp:Button ID="ButtonGoToAlbum" Text="View your new album" runat="server" PostBackUrl="~/Album.aspx" Visible="false"/>
                    </p>
                    <p>
                        <asp:Label ID="LabelLoginError" runat="server" Text=""></asp:Label>
                    </p>
            </div>
        </div>
    </div>

</asp:Content>
