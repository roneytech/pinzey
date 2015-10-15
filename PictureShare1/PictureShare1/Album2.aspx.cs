using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using IZ.WebFileManager;
using Microsoft.AspNet.Identity;
using Telerik.Web.UI;
using Telerik.Web.UI.Widgets;

namespace PictureShare1
{
    public partial class AlbumTel : System.Web.UI.Page
    {
        protected string userFolder;
        protected string albumPin;
        protected string albumName;
        private const string rootDir = "~/Uploads/";

        protected void Page_Init(object sender, EventArgs e)
        {
            // Add a custom download item to the grid context menu.
            RadMenuItem item = new RadMenuItem("Download");
            item.PostBack = false;
            item.Value = "Download";
            RadFileExplorerAlbum.GridContextMenu.Items.Add(item);
            RadFileExplorerAlbum.GridContextMenu.OnClientItemClicked = "extendedFileExplorer_onGridContextItemClicked";
            
            // Add a custom download item to the tree view context menu.
            RadMenuItem item2 = new RadMenuItem("Download");
            item2.PostBack = false;
            item2.Value = "Download";
            RadFileExplorerAlbum.TreeView.ContextMenus[0].Items.Add(item2);
            RadFileExplorerAlbum.TreeView.OnClientContextMenuItemClicked = "onClientContextMenuItemClicked";
            ButtonDownload.Click += new EventHandler(ButtonDownload_Click);

            //RadFileExplorerAlbum.Configuration.ContentProviderTypeName = typeof(CustomContentProvider).AssemblyQualifiedName;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            Album album = new Album();
            userFolder = rootDir;
            albumPin = Request.QueryString["pin"];         

            if (!IsPostBack)
            {
                LabelAlbumPin.Text = albumPin;
                if (User.Identity.IsAuthenticated)
                {
                    userFolder += User.Identity.GetUserId() + "/";
                    RadFileExplorerAlbum.Configuration.ViewPaths = getFolderArray(Request.MapPath(userFolder));
                    RadFileExplorerAlbum.Configuration.UploadPaths = new string[] { userFolder };
                    RadFileExplorerAlbum.Configuration.DeletePaths = new string[] { userFolder };
                    if (!String.IsNullOrEmpty(albumPin))
                    {                
                        RadFileExplorerAlbum.InitialPath = Page.ResolveUrl(userFolder + albumPin);
                        LabelAlbumName.Text = album.GetAlbumName(albumPin);
                    }
                }
                else
                {
                    if (!String.IsNullOrEmpty(albumPin))
                    {
                        userFolder += album.GetAlbumUserId(albumPin) + "/";
                        RadFileExplorerAlbum.Configuration.SearchPatterns = new string[] { "*.jpg", "*.jpeg", "*.gif", "*.png" };
                        RadFileExplorerAlbum.Configuration.ViewPaths = new string[] { userFolder + albumPin };
                        RadFileExplorerAlbum.Configuration.UploadPaths = new string[] { userFolder + albumPin };
                        RadFileExplorerAlbum.Configuration.DeletePaths = new string[] { userFolder + albumPin };
                        RadFileExplorerAlbum.InitialPath = Page.ResolveUrl(userFolder + albumPin);
                        LabelAlbumName.Text = album.GetAlbumName(albumPin);
                    }
                    else
                    {
                        Response.Redirect("~/Default.aspx");
                    }
                }                
            }
        }

        void ButtonDownload_Click(object sender, EventArgs e)
        {
            string[] paths = HiddenFieldDownload.Value.Split('|');
            if (paths.Length > 0 && !String.IsNullOrEmpty(paths[0]))
            {
                byte[] downloadFile = null;
                string downloadFileName = String.Empty;
                if (paths.Length == 1 && ((File.GetAttributes(Request.MapPath(paths[0])) & FileAttributes.Directory) != FileAttributes.Directory))
                {
                    //Single path
                    string path = Request.MapPath(paths[0]);
                    downloadFile = File.ReadAllBytes(path);
                    downloadFileName = new FileInfo(path).Name;
                }
                else
                {
                    //Multiple paths
                    List<FileInfo> fileInfos = new List<FileInfo>();
                    List<DirectoryInfo> emptyDirectoryInfos = new List<DirectoryInfo>();

                    foreach (string relativePath in paths)
                    {
                        string path = Request.MapPath(relativePath);
                        FileAttributes attr = File.GetAttributes(path);
                        if ((attr & FileAttributes.Directory) == FileAttributes.Directory)
                        {
                            DirectoryInfo di = new DirectoryInfo(path);
                            //All the files recursively within a directory
                            FileInfo[] pathFileInfos = di.GetFiles("*", SearchOption.AllDirectories);
                            if (pathFileInfos.Length > 0)
                            {
                                fileInfos.AddRange(pathFileInfos);
                            }
                            else
                            {
                                emptyDirectoryInfos.Add(di);
                            }
                            //All the folders recursively within a directory
                            DirectoryInfo[] pathDirectoryInfos = di.GetDirectories("*", SearchOption.AllDirectories);
                            foreach (DirectoryInfo pathDirectoryInfo in pathDirectoryInfos)
                            {
                                if (pathDirectoryInfo.GetFiles().Length == 0)
                                {
                                    emptyDirectoryInfos.Add(pathDirectoryInfo);
                                }
                            }
                        }
                        else
                        {
                            fileInfos.Add(new FileInfo(path));
                        }
                    }

                    //Needed for constructing the directory hierarchy by the DotNetZip requirements
                    string currentFolder = Request.MapPath(RadFileExplorerAlbum.CurrentFolder);
                    string zipFileName = Path.Combine(Path.GetTempPath(), String.Format("{0}.zip", new Guid()));

                    using (Ionic.Zip.ZipFile zip = new Ionic.Zip.ZipFile(zipFileName))
                    {
                        foreach (FileInfo fileInfo in fileInfos)
                        {
                            zip.AddFile(fileInfo.FullName, !fileInfo.Directory.FullName.Equals(currentFolder, StringComparison.InvariantCultureIgnoreCase) ? fileInfo.Directory.FullName.Substring(currentFolder.Length + 1) : String.Empty);
                        }
                        foreach (DirectoryInfo directoryInfo in emptyDirectoryInfos)
                        {
                            zip.AddDirectoryByName(
        directoryInfo.FullName.Substring(currentFolder.Length + 1));
                        }

                        zip.TempFileFolder = Path.GetTempPath();
                        zip.Save();
                    }

                    downloadFile = File.ReadAllBytes(zipFileName);
                    File.Delete(zipFileName);
                    downloadFileName = "Combined.zip";
                }

                Response.Clear();
                Response.AppendHeader("Content-Disposition", String.Format("attachment; filename=\"{0}\"", downloadFileName));
                Response.ContentType = String.Format("application/{0}", downloadFileName);
                Response.BinaryWrite(downloadFile);
                Response.End();
            }
        }

        string [] getFolderArray(string rootFolder)
        {
            string[] subdirectoryEntries = Directory.GetDirectories(rootFolder);
            string[] reletiveDirectoryPaths = new string[subdirectoryEntries.Length];
            //foreach (string relativePath in subdirectoryEntries)
            //{
            //    relativePath = relativePath.Replace(Request.ServerVariables["APPL_PHYSICAL_PATH"], String.Empty);
            //}
            string path;
            for (int i = 0; i < subdirectoryEntries.Length; i++)
            {
                path = "~/";
                path += subdirectoryEntries[i].Replace(Request.ServerVariables["APPL_PHYSICAL_PATH"], String.Empty);
                path = path.Replace(@"\", "/");
                reletiveDirectoryPaths[i] = path;
            }
            return reletiveDirectoryPaths;
        }

        //public class CustomContentProvider : FileSystemContentProvider
        //{

        //    public CustomContentProvider(HttpContext context, string[] searchPatterns, string[] viewPaths, string[] uploadPaths, string[] deletePaths, string selectedUrl, string selectedItemTag)
        //        : base(context, searchPatterns, viewPaths, uploadPaths, deletePaths, selectedUrl, selectedItemTag)
        //    {
        //    }

        //    public override DirectoryItem ResolveRootDirectoryAsTree(string path)
        //    {
        //        try
        //        {
        //            DirectoryItem orgDir = base.ResolveRootDirectoryAsTree(path);

        //            if (orgDir != null && orgDir.Name.Length == 36)
        //                orgDir.Name = "My Account";
        //            return orgDir;

        //        }
        //        catch (UnauthorizedAccessException uae)
        //        {
        //            //Eat access exceptions.
        //            //return new DirectoryItem();
        //            return null;
        //        }             
        //    }

        //}

    }
}