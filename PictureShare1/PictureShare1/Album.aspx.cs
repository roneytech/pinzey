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


namespace PictureShare1
{
    public partial class AlbumWeb : System.Web.UI.Page
    {
        protected string albumFolder;
        private const string rootDir = "~/Uploads/";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.Identity.IsAuthenticated)
            {
                string userId = User.Identity.GetUserId();
                string userName = User.Identity.Name;
                FileManager FileManagerUser = (FileManager)LoginView1.FindControl("FileManagerUser");
                FileManagerUser.RootDirectories[0].DirectoryPath = rootDir + userId;
                FileManagerUser.RootDirectories[0].Text = userName;
            }
            else
            {
                albumFolder = Request.QueryString["pin"];
                FileManager fileManager = (FileManager)LoginView1.FindControl("FileManagerAnon");
                fileManager.RootDirectories[0].DirectoryPath = "~/Uploads/" + albumFolder;
                fileManager.RootDirectories[0].Text = albumFolder;
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            FileUpload FileUpload1 = (FileUpload)LoginView1.FindControl("FileUpload1");
            Label LabelFiles = (Label)LoginView1.FindControl("LabelFiles");

            foreach (HttpPostedFile postedFile in FileUpload1.PostedFiles)
            {
                string fileName = Path.GetFileName(postedFile.FileName);
                postedFile.SaveAs(Server.MapPath("~/Uploads/") + albumFolder + "/" + fileName);
            }
            LabelFiles.Text = string.Format("{0} files have been uploaded successfully.", FileUpload1.PostedFiles.Count);
        }
    }
}