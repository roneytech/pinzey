using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
//using System.Web.Security;
using IZ.WebFileManager;
using Microsoft.AspNet.Identity;
using Telerik.Web.UI;


namespace PictureShare1
{
    public partial class AlbumTel : System.Web.UI.Page
    {
        protected string userFolder;
        protected string albumPin;
        protected string albumName;
        private const string rootDir = "~/Uploads/";

        protected void Page_Load(object sender, EventArgs e)
        {
            Album album = new Album();
            userFolder = rootDir;
            albumPin = Request.QueryString["pin"];
            LabelAlbumPin.Text = albumPin;
            LabelAlbumName.Text = album.GetAlbumName(albumPin);

            if (!IsPostBack)
            {
                if (User.Identity.IsAuthenticated)
                {
                    userFolder += User.Identity.GetUserId() + "/";
                    RadFileExplorer RadFileExplorerUser = (RadFileExplorer)LoginView1.FindControl("RadFileExplorerUser");
                    RadFileExplorerUser.Configuration.ViewPaths = new string[] { userFolder };
                    RadFileExplorerUser.Configuration.UploadPaths = new string[] { userFolder };
                    RadFileExplorerUser.Configuration.DeletePaths = new string[] { userFolder };
                    if (!String.IsNullOrEmpty(albumPin))
                    {                
                        RadFileExplorerUser.InitialPath = Page.ResolveUrl(userFolder + albumPin);
                    }
                }
                else
                {
                    userFolder += album.GetAlbumUserId(Request.QueryString["pin"]) + "/";
                    RadFileExplorer RadFileExplorerAnon = (RadFileExplorer)LoginView1.FindControl("RadFileExplorerAnon");
                    RadFileExplorerAnon.Configuration.SearchPatterns = new string[] { "*.jpg", "*.jpeg", "*.gif", "*.png" };
                    RadFileExplorerAnon.Configuration.ViewPaths = new string[] { userFolder + albumPin };
                    RadFileExplorerAnon.Configuration.UploadPaths = new string[] { userFolder + albumPin };
                    RadFileExplorerAnon.Configuration.DeletePaths = new string[] { userFolder + albumPin };
                    RadFileExplorerAnon.InitialPath = Page.ResolveUrl(userFolder + albumPin);
                }
            }
        }
    }
}