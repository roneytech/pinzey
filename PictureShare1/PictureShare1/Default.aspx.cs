using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Owin;
using PictureShare1.Models;

namespace PictureShare1
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.Identity.IsAuthenticated)
            {
                LabelLoginError.Text = "";
                TextBoxAlbumName.Enabled = true;
                ButtonCreateAlbum.Enabled = true;
            }
            else
            {
                LabelLoginError.Text = "Please login or create an account first.";
                TextBoxAlbumName.Enabled = false;
                ButtonCreateAlbum.Enabled = false;
            }

            //Login stuff
            RegisterHyperLink.NavigateUrl = "Register";
            // Enable this once you have account confirmation enabled for password reset functionality
            //ForgotPasswordHyperLink.NavigateUrl = "Forgot";
            //OpenAuthLogin.ReturnUrl = Request.QueryString["ReturnUrl"];
            //var returnUrl = HttpUtility.UrlEncode(Request.QueryString["ReturnUrl"]);
            //if (!String.IsNullOrEmpty(returnUrl))
            //{
            //    RegisterHyperLink.NavigateUrl += "?ReturnUrl=" + returnUrl;
            //}
        }

        protected void ButtonLoadAlbum_Click(object sender, EventArgs e)
        {
            LabelErrorMessage.Text = GoToAlbum(TextBoxPin.Text);
        }

        protected void ButtonCreateAlbum_Click(object sender, EventArgs e)
        {
            if (User.Identity.IsAuthenticated)
            {
                Album album = new Album();
                string pin = album.CreateNewAlbum(TextBoxAlbumName.Text, User.Identity.GetUserId());
                ButtonGoToAlbum.PostBackUrl = "Album2.aspx?pin=" + pin;
                LabelPin.Visible = true;
                LabelPin.Text = "Your new pin is: " + pin;
                ButtonGoToAlbum.Visible = true;
            }
            else
            {
                LabelLoginError.Text = "Please login or create an account to create albums.";
            }
        }

        private string GoToAlbum(string pin)
        {
            Album album = new Album();
            if (album.AlbumExists(pin))
            {
                Response.Redirect("Album2.aspx?pin=" + TextBoxPin.Text);
            }
            return "Album not found.";
        }

        protected void LogIn(object sender, EventArgs e)
        {
            if (IsValid)
            {
                // Validate the user password
                var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
                var signinManager = Context.GetOwinContext().GetUserManager<ApplicationSignInManager>();

                // This doen't count login failures towards account lockout
                // To enable password failures to trigger lockout, change to shouldLockout: true
                var result = signinManager.PasswordSignIn(Email.Text, Password.Text, RememberMe.Checked, shouldLockout: false);

                switch (result)
                {
                    case SignInStatus.Success:
                        IdentityHelper.RedirectToReturnUrl(Request.QueryString["ReturnUrl"], Response);
                        //IdentityHelper.RedirectToReturnUrl("~/Album.aspx", Response);
                        break;
                    case SignInStatus.LockedOut:
                        Response.Redirect("/Account/Lockout");
                        break;
                    case SignInStatus.RequiresVerification:
                        Response.Redirect(String.Format("/Account/TwoFactorAuthenticationSignIn?ReturnUrl={0}&RememberMe={1}",
                                                        Request.QueryString["ReturnUrl"],
                                                        RememberMe.Checked),
                                          true);
                        break;
                    case SignInStatus.Failure:
                    default:
                        FailureText.Text = "Invalid login attempt";
                        ErrorMessage.Visible = true;
                        break;
                }
            }
        }
    }
}