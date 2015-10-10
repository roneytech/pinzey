<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="PictureShare1._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="row">
        <div class="col-md-4">
            <h2>I have a pin</h2>
            <p>
                Pin
                <asp:TextBox ID="TextBoxPin" runat="server"></asp:TextBox>
            </p>
            <p>
                <asp:Button ID="ButtonLoadAlbum" Text="Go to my album" runat="server" OnClick="ButtonLoadAlbum_Click" />
            </p>
            <p>
                <asp:Label ID="LabelErrorMessage" runat="server" Text="" ForeColor="Red"></asp:Label>
            </p>
        </div>
        <div class="col-md-4">
            <h2>Create a new album</h2>
            <p>
                In just two easy steps you can create an album that your whole family can upload photos to. 
                They will not need to set up an account!
            </p>
<%--            <p>
                <a class="btn btn-default" href="CreateAlbum.aspx">Create New Album &raquo;</a>
            </p>--%>
            <p>Enter New Album Name</p>
            <asp:TextBox ID="TextBoxAlbumName" runat="server"></asp:TextBox>
            <asp:Button ID="ButtonCreateAlbum" runat="server" Text="Create" OnClick="ButtonCreateAlbum_Click" />
            <div class="row">
                <div class="col-md-4">
                    <h3>
                    <asp:Label ID="LabelPin" runat="server" Text="Your pin is:" Visible="false"></asp:Label></h3>
                    <p>
                        <asp:Button ID="ButtonGoToAlbum" Text="View your new album" runat="server" PostBackUrl="~/Album.aspx" Visible="false"/>

                    </p>
                    <p>
                        <asp:Label ID="LabelLoginError" runat="server" Text="" ForeColor="Red"></asp:Label>
                    </p>
                </div>
            </div>
        </div>
        <%--        <div class="col-md-4">
            <h2>Web Hosting</h2>
            <p>
                You can easily find a web hosting company that offers the right mix of features and price for your applications.
            </p>
            <p>
                <a class="btn btn-default" href="http://go.microsoft.com/fwlink/?LinkId=301950">Learn more &raquo;</a>
            </p>
        </div>--%>
    </div>
    <div class="jumbotron">
        <h1>PINZ<u>e</u>Y</h1>
        <p class="lead">The easiest way to share pictures with your family and friends!</p>
        <p><a href="http://www.pinzey.com/about" class="btn btn-primary btn-lg">Learn more &raquo;</a></p>
    </div>


</asp:Content>
