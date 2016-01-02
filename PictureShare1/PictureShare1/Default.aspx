﻿<%@ Page Title="Pinzey Picture Sharing" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="PictureShare1._Default" %>

<%--<%@ Register Src="~/Account/OpenAuthProviders.ascx" TagPrefix="uc" TagName="OpenAuthProviders" %>--%>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
<div class="home">
    <div id="top">
        <div class="left">
            <h2>View album</h2>
            <div id="existing_album">
                <asp:Panel ID="Panel1" runat="server" defaultbutton="ButtonLoadAlbum">
                <asp:TextBox ID="TextBoxPin" runat="server" placeholder="Enter your pin here" ToolTip="Click here and enter your pin!"></asp:TextBox>
                <asp:Button ID="ButtonLoadAlbum" Text="Go" runat="server" OnClick="ButtonLoadAlbum_Click" />
                <p class="error">
                    <br />
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
            <asp:Panel ID="Panel2" runat="server" DefaultButton="ButtonCreateAlbum">
                <div id="new_album">
                    <asp:TextBox ID="TextBoxAlbumName" runat="server" placeholder="Enter a new album name" ToolTip="Click here and enter a name for your new album. You will be given a pin to share with your friends and family."></asp:TextBox>
                    <asp:Button ID="ButtonCreateAlbum" runat="server" Text="Go" OnClick="ButtonCreateAlbum_Click" />
                </div>

                <div class="error">
                    <h3 class="yourpin">
                        <asp:Label ID="LabelPin" runat="server" Text="Your pin is:" Visible="false"></asp:Label></h3>
                    <p>                        
                        <asp:Button ID="ButtonGoToAlbum" Text="View your new album" runat="server" PostBackUrl="~/Album.aspx" Visible="false" />
                    </p>
            </asp:Panel>
            <asp:LoginView ID="LoginView1" runat="server">
                <AnonymousTemplate>
                    <p>
                        <%--<asp:Label ID="LabelLoginError" runat="server" Text=""></asp:Label>--%>
                        Please <a href="Account/Login.aspx">login</a> or <a href="Account/Register.aspx">create an account</a> first
                    </p>
                </AnonymousTemplate>
            </asp:LoginView>
            </div>

        </div>
        <!-- End .right -->
    </div><!-- End #top -->

    <div id="about">
        <a href="#about" class="icon-arrow-down"></a>
        <div class="body-content">
            <h2>Share files with your loved ones, no signup to contribute.</h2>
            <p>Let friends and family upload files all in one location, without the hastle of multiple signups. Only one account holder necessary.</p>

            <ul class="half">
                <li>
                    <div class="collaboration">
                      <div class="circle">
                        <div class="triangle"></div>
                        <div class="triangle"></div>
                        <div class="triangle"></div>
                        <div class="triangle"></div>
                        <div class="triangle"></div>
                        <div class="triangle"></div>
                      </div>
                      <div class="circle">
                        <div class="triangle"></div>
                        <div class="triangle"></div>
                        <div class="triangle"></div>
                        <div class="triangle"></div>
                        <div class="triangle"></div>
                        <div class="triangle"></div>
                      </div>
                      <div class="circle">
                        <div class="triangle"></div>
                        <div class="triangle"></div>
                        <div class="triangle"></div>
                        <div class="triangle"></div>
                        <div class="triangle"></div>
                        <div class="triangle"></div>
                      </div>
                    </div>
                    <h3>Group Collaboration</h3>
                    <p>Invite everyone to view and contribute files with the use of just one PIN.</p>
                </li>
                <li>
                    <div class="share">
                      <div class="hexagon">
                        <div class="part"></div>
                        <div class="part"></div>
                        <div class="part"></div>
                        <div class="part"></div>
                        <div class="part"></div>
                        <div class="part"></div>
                      </div>
                      <div class="hexagon">
                        <div class="part"></div>
                        <div class="part"></div>
                        <div class="part"></div>
                        <div class="part"></div>
                        <div class="part"></div>
                        <div class="part"></div>
                      </div>
                      <div class="hexagon">
                        <div class="part"></div>
                        <div class="part"></div>
                        <div class="part"></div>
                        <div class="part"></div>
                        <div class="part"></div>
                        <div class="part"></div>
                      </div>
                      <div class="hexagon">
                        <div class="part"></div>
                        <div class="part"></div>
                        <div class="part"></div>
                        <div class="part"></div>
                        <div class="part"></div>
                        <div class="part"></div>
                      </div>
                      <div class="hexagon">
                        <div class="part"></div>
                        <div class="part"></div>
                        <div class="part"></div>
                        <div class="part"></div>
                        <div class="part"></div>
                        <div class="part"></div>
                      </div>
                      <div class="hexagon">
                        <div class="part"></div>
                        <div class="part"></div>
                        <div class="part"></div>
                        <div class="part"></div>
                        <div class="part"></div>
                        <div class="part"></div>
                      </div>
                      <div class="hexagon">
                        <div class="part"></div>
                        <div class="part"></div>
                        <div class="part"></div>
                        <div class="part"></div>
                        <div class="part"></div>
                        <div class="part"></div>
                      </div>
                    </div>
                    <h3>Sync with existing accounts</h3>
                    <p>Sync files with your DropBox and Google accounts, publish to Facebook and more!</p>
                </li>
            </ul>
        </div>
    </div>

    <div id="pricing">
        <div class="body-content">
            <h2>File sharing you can afford</h2>
            <ul class="pricing_table">
                <li>
                    <div class="white">
                        <a href="/Account/register.aspx"><h4>Free</h4>
                        <p>Simple sharing</p>
                        <hr />
                        <h5>Files:</h5>
                        <p>.JPG, .PNG</p></a>
                    </div>
                    <a href="/Account/register.aspx" class="button">Yes Please</a>
                </li>
                <li>
                    <div class="white">
                        <a href="/payment"><h4>$2 per month</h4>
                        <p>More Storage</p>
                        <hr />
                        <h5>Files:</h5>
                        <p>.JPG, .PNG, .MP4, .PDF, .DOC, .PSD, .AI</p></a>
                    </div>
                    <a href="/payment" class="button">Yes Please</a>
                </li>
                <li>
                    <div class="white">
                        <a href="/payment"><h4>$4 per month</h4>
                        <p>Unlimited Storage</p>
                        <hr />
                        <h5>Files:</h5>
                        <p>.JPG, .PNG, .MP4, .PDF, .DOC, .PSD, .AI</p></a>
                    </div>
                    <a href="/payment" class="button">Yes Please</a>
                </li>
            </ul>
            <img href="http://pinzey.com/images/PinzeyCTA2.png" alt="Pinzey Group File Sharing" title="Pinzey Group File Sharing" class="left_img" /><p>Does this sound familiar? You go on a trip with friends or family and everyone takes pictures. You get home and realize it’s so hard to share them. Not everyone uses an online photo service and the ones that do all use something different. How are you going to get all those great pictures?</p>
            <img href="http://pinzey.com/images/PinzeyCTA1.png" alt="Pinzey Group File Sharing" title="Pinzey Group File Sharing" class="right_img" /><p>There is an answer and it is Pinzey! Pinzey is the place where everyone, regardless of what tools they already own, can exchange photos. There is no need to make your friends and family sign up to something new, and no need for them to stop using the tools they already love.</p>
            <p>We built this site for our family and friends but we made it open for everyone to use. If you find it useful please consider a paid account to help us pay for storage and bandwidth.</p>
            <a href="/Account/Register" class="buttonStyle2">Come try it out!</a>
        </div>
    </div>

</div>
</asp:Content>