<%@ Page Title="Pinzey Picture Sharing" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="PictureShare1._Default" %>

<%--<%@ Register Src="~/Account/OpenAuthProviders.ascx" TagPrefix="uc" TagName="OpenAuthProviders" %>--%>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
<div class="home">

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
            <h2>View album</h2>
            <div id="existing_album">
                <asp:Panel ID="Panel1" runat="server" defaultbutton="ButtonLoadAlbum">
                <asp:TextBox ID="TextBoxPin" runat="server" placeholder="Pin" ToolTip="Click here and enter your pin!"></asp:TextBox>
                <asp:Button ID="ButtonLoadAlbum" Text="Go" runat="server" OnClick="ButtonLoadAlbum_Click" />
                <p class="error">
                    <asp:Label ID="LabelErrorMessage" runat="server" Text="" ForeColor="Red"></asp:Label>
                </p>
                </asp:Panel>
            </div>
        </div><!-- End .left -->
        <div class="right">
            <h2>Create a New Album</h2>
            <%--<p>
                In just two easy steps you can create an album that your whole family can upload photos to. 
                They will not need to set up an account!
            </p>--%>
            <%--            <p>
                <a class="btn btn-default" href="CreateAlbum.aspx">Create New Album &raquo;</a>
            </p>--%>
            <asp:Panel ID="Panel2" runat="server" defaultbutton="ButtonCreateAlbum">
            <div id="new_album">
                <asp:TextBox ID="TextBoxAlbumName" runat="server" placeholder="Album Name" ToolTip="Click here and enter a name for your new album. You will be given a pin to share with your friends and family."></asp:TextBox>
                <asp:Button ID="ButtonCreateAlbum" runat="server" Text="Go" OnClick="ButtonCreateAlbum_Click" />
            </div>
            </asp:Panel>
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
        </div><!-- End .right -->
    </div><!-- End #top -->

    <div id="about">
        <div class="body-content">
            <h2>Share files with your loved ones, no signup to contribute.</h2>
            <p>Let friends and family upload files all in one location, without the hastle of multiple signups. Only one account holder necessary.</p>
        </div>
    </div>

    <div id="pricing">
        <div class="body-content">
            <h2>File sharing on the cheap-cheap</h2>
            <ul class="pricing_table">
                <li>
                    <div class="white">
                        <h4>Free</h4>
                        <p>Simple sharing</p>
                        <hr />
                        <h5>Files:</h5>
                        <p>.JPG, .PNG</p>
                    </div>
                    <a href="/payment">Yes Please</a>
                </li>
                <li>
                    <div class="white">
                        <h4>$2 per month</h4>
                        <p>More Storage</p>
                        <hr />
                        <h5>Files:</h5>
                        <p>.JPG, .PNG, .MP4, .PDF, .DOC, .PSD, .AI</p>
                    </div>
                    <a href="/payment">Yes Please</a>
                </li>
                <li>
                    <div class="white">
                        <h4>$4 per month</h4>
                        <p>Unlimited Storage</p>
                        <hr />
                        <h5>Files:</h5>
                        <p>.JPG, .PNG, .MP4, .PDF, .DOC, .PSD, .AI</p>
                    </div>
                    <a href="/payment">Yes Please</a>
                </li>
            </ul>
        </div>
    </div>

</div>
</asp:Content>