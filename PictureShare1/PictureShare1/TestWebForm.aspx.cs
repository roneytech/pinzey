using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PictureShare1
{
    public partial class TestWebForm : System.Web.UI.Page
    {
        protected string albumFolder;
        protected void Page_Load(object sender, EventArgs e)
        {
            albumFolder = Request.QueryString["pin"];
            FileManager1.RootDirectories[0].DirectoryPath = "~/Uploads/" + albumFolder;
            FileManager1.RootDirectories[0].Text = albumFolder;
        }
    }
}