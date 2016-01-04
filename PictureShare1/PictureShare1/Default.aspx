<%@ Page Title="Pinzey Picture Sharing" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="PictureShare1._Default" %>

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

            <div class="icon-PinzeyCTA2">
                <div class="path1"></div><div class="path2"></div><div class="path3"></div><div class="path4"></div><div class="path5"></div><div class="path6"></div><div class="path7"></div><div class="path8"></div><div class="path9"></div><div class="path10"></div><div class="path11"></div><div class="path12"></div><div class="path13"></div><div class="path14"></div><div class="path15"></div><div class="path16"></div><div class="path17"></div><div class="path18"></div><div class="path19"></div><div class="path20"></div><div class="path21"></div><div class="path22"></div><div class="path23"></div><div class="path24"></div><div class="path25"></div><div class="path26"></div><div class="path27"></div><div class="path28"></div><div class="path29"></div><div class="path30"></div><div class="path31"></div><div class="path32"></div><div class="path33"></div><div class="path34"></div><div class="path35"></div><div class="path36"></div><div class="path37"></div><div class="path38"></div><div class="path39"></div><div class="path40"></div><div class="path41"></div><div class="path42"></div><div class="path43"></div><div class="path44"></div><div class="path45"></div><div class="path46"></div><div class="path47"></div><div class="path48"></div><div class="path49"></div><div class="path50"></div><div class="path51"></div><div class="path52"></div><div class="path53"></div><div class="path54"></div><div class="path55"></div><div class="path56"></div><div class="path57"></div><div class="path58"></div><div class="path59"></div><div class="path60"></div><div class="path61"></div><div class="path62"></div><div class="path63"></div><div class="path64"></div><div class="path65"></div><div class="path66"></div><div class="path67"></div><div class="path68"></div><div class="path69"></div><div class="path70"></div><div class="path71"></div><div class="path72"></div><div class="path73"></div><div class="path74"></div><div class="path75"></div><div class="path76"></div><div class="path77"></div><div class="path78"></div><div class="path79"></div><div class="path80"></div><div class="path81"></div><div class="path82"></div><div class="path83"></div><div class="path84"></div><div class="path85"></div><div class="path86"></div><div class="path87"></div><div class="path88"></div><div class="path89"></div><div class="path90"></div><div class="path91"></div><div class="path92"></div><div class="path93"></div><div class="path94"></div><div class="path95"></div><div class="path96"></div><div class="path97"></div><div class="path98"></div><div class="path99"></div><div class="path100"></div><div class="path101"></div><div class="path102"></div><div class="path103"></div><div class="path104"></div><div class="path105"></div><div class="path106"></div><div class="path107"></div><div class="path108"></div><div class="path109"></div><div class="path110"></div><div class="path111"></div><div class="path112"></div><div class="path113"></div><div class="path114"></div><div class="path115"></div><div class="path116"></div><div class="path117"></div><div class="path118"></div><div class="path119"></div><div class="path120"></div><div class="path121"></div><div class="path122"></div><div class="path123"></div><div class="path124"></div><div class="path125"></div><div class="path126"></div><div class="path127"></div><div class="path128"></div><div class="path129"></div><div class="path130"></div><div class="path131"></div><div class="path132"></div><div class="path133"></div><div class="path134"></div><div class="path135"></div><div class="path136"></div><div class="path137"></div><div class="path138"></div><div class="path139"></div><div class="path140"></div><div class="path141"></div>
            </div>

            <p>Does this sound familiar? You go on a trip with friends or family and everyone takes pictures. You get home and realize it’s so hard to share them. Not everyone uses an online photo service and the ones that do all use something different. How are you going to get all those great pictures?</p>

            <div class="icon-PinzeyCTA1">
                <div class="path1"></div><div class="path2"></div><div class="path3"></div><div class="path4"></div><div class="path5"></div><div class="path6"></div><div class="path7"></div><div class="path8"></div><div class="path9"></div><div class="path10"></div><div class="path11"></div><div class="path12"></div><div class="path13"></div><div class="path14"></div><div class="path15"></div><div class="path16"></div><div class="path17"></div><div class="path18"></div><div class="path19"></div><div class="path20"></div><div class="path21"></div><div class="path22"></div><div class="path23"></div><div class="path24"></div><div class="path25"></div><div class="path26"></div><div class="path27"></div><div class="path28"></div><div class="path29"></div><div class="path30"></div><div class="path31"></div><div class="path32"></div><div class="path33"></div><div class="path34"></div><div class="path35"></div><div class="path36"></div><div class="path37"></div><div class="path38"></div><div class="path39"></div><div class="path40"></div><div class="path41"></div><div class="path42"></div><div class="path43"></div><div class="path44"></div><div class="path45"></div><div class="path46"></div><div class="path47"></div><div class="path48"></div><div class="path49"></div><div class="path50"></div><div class="path51"></div><div class="path52"></div><div class="path53"></div><div class="path54"></div><div class="path55"></div><div class="path56"></div><div class="path57"></div><div class="path58"></div><div class="path59"></div><div class="path60"></div><div class="path61"></div><div class="path62"></div><div class="path63"></div><div class="path64"></div><div class="path65"></div><div class="path66"></div><div class="path67"></div><div class="path68"></div><div class="path69"></div><div class="path70"></div><div class="path71"></div><div class="path72"></div><div class="path73"></div><div class="path74"></div><div class="path75"></div><div class="path76"></div><div class="path77"></div>
            </div>

            <p>There is an answer and it is Pinzey! Pinzey is the place where everyone, regardless of what tools they already own, can exchange photos. There is no need to make your friends and family sign up to something new, and no need for them to stop using the tools they already love.</p>
            <p>We built this site for our family and friends but we made it open for everyone to use. If you find it useful please consider a paid account to help us pay for storage and bandwidth.</p>
            <a href="/Account/Register" class="buttonStyle2">Come try it out!</a>
        </div>
    </div>

</div>
</asp:Content>