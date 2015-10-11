<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="PictureShare1._Default" %>

<%--<%@ Register Src="~/Account/OpenAuthProviders.ascx" TagPrefix="uc" TagName="OpenAuthProviders" %>--%>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="mask" role="dialog"></div>
    <div class="modal" role="alert">
      <button class="close" role="button">X</button>
      <div id="tabs">
          <div id="tabs-1">
            <h4>Login</h4>
                <asp:PlaceHolder runat="server" ID="ErrorMessage" Visible="false">
                    <p class="text-danger">
                        <asp:Literal runat="server" ID="FailureText" />
                    </p>
                </asp:PlaceHolder>
                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="Email" CssClass="col-md-2 control-label">Email</asp:Label>
                    <div class="col-md-10">
                        <asp:TextBox runat="server" ID="Email" CssClass="form-control" TextMode="Email" ValidationGroup="Login" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="Email"
                            CssClass="text-danger" ErrorMessage="The email field is required." ValidationGroup="Login" />
                    </div>
                </div>
                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="Password" CssClass="col-md-2 control-label">Password</asp:Label>
                    <div class="col-md-10">
                        <asp:TextBox runat="server" ID="Password" TextMode="Password" CssClass="form-control" ValidationGroup="Login" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="Password" CssClass="text-danger" ErrorMessage="The password field is required." ValidationGroup="Login" />
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-md-offset-2 col-md-10">
                        <div class="checkbox">
                            <asp:CheckBox runat="server" ID="RememberMe" ValidationGroup="Login" />
                            <asp:Label runat="server" AssociatedControlID="RememberMe">Remember me?</asp:Label>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-md-offset-2 col-md-10">
                        <asp:Button runat="server" OnClick="LogIn" Text="Log in" CssClass="btn btn-default" ValidationGroup="Login" />
                    </div>
                </div>
                <p>
                    <asp:HyperLink runat="server" ID="RegisterHyperLink" ViewStateMode="Disabled">Register as a new user</asp:HyperLink>
                </p>
                <asp:HyperLink runat="server" ID="ForgotPasswordHyperLink" ViewStateMode="Disabled">Forgot your password?</asp:HyperLink>
                    
                <%--<uc:openauthproviders runat="server" id="OpenAuthLogin" />--%>
                <a href="#" class="forgot">Forgot your password?</a>
          </div>
          <div id="tabs-2">
            <h4>Sign Up</h4>
          </div>
          <ul>
            <li><a href="#tabs-1">Login</a></li>
            <li><a href="#tabs-2">Sign Up</a></li>
          </ul>
        </div>
    </div>

    <div id="top">
        <div class="left">
            <h2>Access Existing Album</h2>
            <div id="existing_album">
                <asp:TextBox ID="TextBoxPin" runat="server" placeholder="Album Code"></asp:TextBox>
                <asp:Button ID="ButtonLoadAlbum" Text="Go" runat="server" OnClick="ButtonLoadAlbum_Click" />
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
                <h3>
                    <asp:Label ID="LabelPin" runat="server" Text="Your pin is:" Visible="false"></asp:Label></h3>
                <p>
                    <asp:Button ID="ButtonGoToAlbum" Text="View your new album" runat="server" PostBackUrl="~/Album.aspx" Visible="false" />
                </p>
                <p>
                    <asp:Label ID="LabelLoginError" runat="server" Text=""></asp:Label>
                </p>
            </div>
        </div>
    </div>
</asp:Content>
