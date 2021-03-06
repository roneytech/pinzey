﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using IZ.WebFileManager;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.AspNet.Identity.EntityFramework;
using PictureShare1.Models;
using Telerik.Web.UI;
using Telerik.Web.UI.Widgets;
//using System.Web.Security;

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
            RadMenuItem item = new RadMenuItem("Download to my computer");
            item.PostBack = false;
            item.Value = "Download1";
            RadFileExplorerAlbum.GridContextMenu.Items.Add(item);
            RadFileExplorerAlbum.GridContextMenu.OnClientItemClicked = "extendedFileExplorer_onGridContextItemClicked";
            
            // Add a custom download item to the tree view context menu.
            RadMenuItem item2 = new RadMenuItem("Download to my computer");
            item2.PostBack = false;
            item2.Value = "Download1";
            RadFileExplorerAlbum.TreeView.ContextMenus[0].Items.Add(item2);
            RadFileExplorerAlbum.TreeView.OnClientContextMenuItemClicked = "onClientContextMenuItemClicked";
            //ButtonDownload.Click += new EventHandler(ButtonDownload_Click);

            // Add a custom download item to the grid context menu.
            RadMenuItem item3 = new RadMenuItem("Download to my Dropbox account");
            item3.PostBack = false;
            item3.Value = "Download2";
            RadFileExplorerAlbum.GridContextMenu.Items.Add(item3);
            RadFileExplorerAlbum.GridContextMenu.OnClientItemClicked = "extendedFileExplorer_onGridContextItemClicked";

            // Add a custom download item to the tree view context menu.
            RadMenuItem item4 = new RadMenuItem("Download to my Dropbox account");
            item4.PostBack = false;
            item4.Value = "Download2";
            RadFileExplorerAlbum.TreeView.ContextMenus[0].Items.Add(item4);
            RadFileExplorerAlbum.TreeView.OnClientContextMenuItemClicked = "onClientContextMenuItemClicked";

            ButtonDownload.Click += new EventHandler(ButtonDownload_Click);

            RadFileExplorerAlbum.Configuration.ContentProviderTypeName = typeof(CustomContentProvider).AssemblyQualifiedName;
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
                    string userId = User.Identity.GetUserId();
                    userFolder += userId + "/";

                    if (!String.IsNullOrEmpty(albumPin))
                    {
                        string albumUserId = album.GetAlbumUserId(albumPin);
                        if (albumUserId == userId)
                        {
                            //This album pin belongs to the current users
                            //RadFileExplorerAlbum.InitialPath = Page.ResolveUrl(userFolder);
                            RadFileExplorerAlbum.Configuration.MaxUploadFileSize = GetUploadLimit(userId);
                            RadFileExplorerAlbum.Configuration.ViewPaths = getFolderArray(Request.MapPath(userFolder));
                            RadFileExplorerAlbum.Configuration.UploadPaths = new string[] { userFolder };
                            RadFileExplorerAlbum.Configuration.DeletePaths = new string[] { userFolder };
                        }
                        else
                            // The user is logged in but its not their album.
                            ViewAnotherUsersAlbum(albumPin);
                        LabelAlbumPin.Text = albumPin;
                        RadTextBoxAlbumName.Text = album.GetAlbumName(albumPin);
                    }
                    else
                    { 
                        // Load users root folder.
                        RadFileExplorerAlbum.Configuration.MaxUploadFileSize = GetUploadLimit(userId);
                        RadFileExplorerAlbum.Configuration.ViewPaths = getFolderArray(Request.MapPath(userFolder));
                        RadFileExplorerAlbum.Configuration.UploadPaths = new string[] { userFolder };
                        RadFileExplorerAlbum.Configuration.DeletePaths = new string[] { userFolder };
                    }
                }
                else
                {
                    if (!String.IsNullOrEmpty(albumPin))
                    {
                        // The user is not logged in therefor its another users pin.
                        ViewAnotherUsersAlbum(albumPin);
                        LabelAlbumPin.Text = albumPin;
                        RadTextBoxAlbumName.Text = album.GetAlbumName(albumPin);
                    }
                    else
                    {
                        // The user is not logged in and no pin is given. Redirect.
                        Response.Redirect("~/Default.aspx");
                    }
                }                
            }
        }

        private void ViewAnotherUsersAlbum(string albumPin)
        {
            Album album = new Album();
            string albumUserId = album.GetAlbumUserId(albumPin);
            string albumUserFolder = rootDir + albumUserId + "/";
            RadFileExplorerAlbum.Configuration.MaxUploadFileSize = GetUploadLimit(albumUserId);
            RadFileExplorerAlbum.Configuration.SearchPatterns = new string[] { "*.jpg", "*.jpeg", "*.gif", "*.png" };
            RadFileExplorerAlbum.Configuration.ViewPaths = new string[] { albumUserFolder + albumPin };
            RadFileExplorerAlbum.Configuration.UploadPaths = new string[] { albumUserFolder + albumPin };
            RadFileExplorerAlbum.Configuration.DeletePaths = new string[] { albumUserFolder + albumPin };
            RadFileExplorerAlbum.InitialPath = Page.ResolveUrl(albumUserFolder + albumPin);
        }

        protected void RadFileExplorerAlbum_ExplorerPopulated(object sender, Telerik.Web.UI.RadFileExplorerPopulatedEventArgs e)
        {
            if (e.ControlName == "tree")
            {
                albumPin = Request.QueryString["pin"];
                if (!String.IsNullOrEmpty(albumPin))
                {
                    Album album = new Album();
                    albumName = album.GetAlbumName(albumPin);
                    RadTreeNode node = RadFileExplorerAlbum.TreeView.FindNodeByText(albumName);
                    if (node != null)
                    {
                        node.Selected = true;
                        node.Focus();
                        node.Expanded = true;
                        RadFileExplorerAlbum.InitialPath = node.FullPath;     
                    }
                }
            }
        }

        protected void ButtonChangeAlbumName_Click(object sender, EventArgs e)
        {
            Album album = new Album();
            var pin = RadFileExplorerAlbum.CurrentFolder.Substring(RadFileExplorerAlbum.CurrentFolder.LastIndexOf('/') + 1);
            album.ChangeAlbumName(RadTextBoxAlbumName.Text, pin);
            RadFileExplorerAlbum.TreeView.Nodes.Clear();
        }

        protected void ButtonDownload_Click(object sender, EventArgs e)
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

        public class CustomContentProvider : FileSystemContentProvider
        {

            public CustomContentProvider(HttpContext context, string[] searchPatterns, string[] viewPaths, string[] uploadPaths, string[] deletePaths, string selectedUrl, string selectedItemTag)
                : base(context, searchPatterns, viewPaths, uploadPaths, deletePaths, selectedUrl, selectedItemTag)
            {
            }

            public int GetNthIndex(string s, char t, int n)
            {
                int count = 0;
                for (int i = 0; i < s.Length; i++)
                {
                    if (s[i] == t)
                    {
                        count++;
                        if (count == n)
                        {
                            return i;
                        }
                    }
                }
                return -1;
            }

            // Show directories as album name instead of pin.
            public override DirectoryItem ResolveRootDirectoryAsTree(string path)
            {
                Album album = new Album();
                try
                {
                    DirectoryItem orgDir = base.ResolveRootDirectoryAsTree(path);

                    string pin = "";
                    int firstSlash = GetNthIndex(path, '/', 3);
                    int secondSlash = GetNthIndex(path, '/', 4);
                    if (secondSlash > firstSlash)
                    {
                        pin = path.Substring(firstSlash, (secondSlash - firstSlash)) + " : ";
                    }
                    else
                    {
                        pin = orgDir.Name + " : ";
                    }
                    
                    
                    orgDir.Name = pin + album.GetAlbumName(orgDir.Name);
                    return orgDir;
                    

                }
                catch (UnauthorizedAccessException)
                {
                    //Eat access exceptions.
                    //return new DirectoryItem();
                    return null;
                }
            }

        }


        protected int GetUploadLimit(string userId)
        {
            var context = HttpContext.Current.GetOwinContext().Get<ApplicationDbContext>();
            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            if(manager.IsInRole(userId, "Level2"))
            { 
                return 500000000;
            }
            else if (manager.IsInRole(userId, "Level1"))
            {
                return 5000000;
            }
            else 
            {
                return 1000000;
            }
        }
    }
}