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
                //LabelLoginError.Text = "";
                TextBoxAlbumName.Enabled = true;
                ButtonCreateAlbum.Enabled = true;
            }
            else
            {
                //LabelLoginError.Text = "Please login or create an account first.";
                TextBoxAlbumName.Enabled = false;
                ButtonCreateAlbum.Enabled = false;
            }
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
                //LabelLoginError.Text = "Please login or create an account to create albums.";
            }
        }

        private string GoToAlbum(string pin)
        {
            Album album = new Album();
            if (album.AlbumExists(pin))
            {
                Response.Redirect("Album2.aspx?pin=" + TextBoxPin.Text);
            }
            return "Album not found";
        }

    }
}