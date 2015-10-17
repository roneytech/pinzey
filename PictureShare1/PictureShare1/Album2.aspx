<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Album2.aspx.cs" MasterPageFile="~/Site.Master" Inherits="PictureShare1.AlbumTel" Title="Pinzey Picture Sharing"%>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
       <script type="text/javascript" src="https://www.dropbox.com/static/api/2/dropins.js" id="dropboxjs" data-app-key="8aqznpahstk8pkd"></script>

        <script type="text/javascript">
            function extendedFileExplorer_onGridContextItemClicked(oGridMenu, args) {
                //var menuItemText = args.get_item().get_text();
                var menuItemValue = args.get_item().get_value();
                if (menuItemValue == "Download1") {
                    extendedFileExplorer_sendItemsPathsToServer();
                }
                if (menuItemValue == "Download2") {
                    var oExplorer = $find("<%= RadFileExplorerAlbum.ClientID %>");
                    var fileList = oExplorer.get_selectedItems();
                    saveToDropbox(makeDropboxFileListFromSelectedItems(fileList));
                }
            }

            function onClientContextMenuItemClicked(sender, args) {
                var menuItem = args.get_menuItem();
                var treeNode = args.get_node();

                if (menuItem.get_value() == "Download1") {
                    extendedFileExplorer_sendItemsPathsToServer();
                }

                if (menuItem.get_value() == "Download2") {
                    var oExplorer = $find("<%= RadFileExplorerAlbum.ClientID %>");
                    var fileList = oExplorer.get_fileList().get_items();
                    saveToDropbox(makeDropboxFileListFromFileList(fileList));
                }
            }

            function makeDropboxFileListFromFileList(fileArray) {
                var baseUrl = window.location.href.replace("#", "");
                var itemPaths = new Array();
                for (var i = 0; i < fileArray.length; i++) {
                    var url = baseUrl + fileArray[i].Path;
                    itemPaths.push({ 'url': url, 'filename': fileArray[i].Name });
                }
                return itemPaths;
            }

            function makeDropboxFileListFromSelectedItems(selectedItemArray)
            {
                var baseUrl = window.location.href.replace("#", "");
                var itemPaths = new Array();
                for (var i = 0; i < selectedItemArray.length; i++) {
                    var url = baseUrl + selectedItemArray[i].get_path();
                    itemPaths.push({ 'url': url, 'filename': selectedItemArray[i].get_name() });
                }
                return itemPaths;
            }

            function saveToDropbox(arrayOfFiles)
            {
                var options = {
                    files: arrayOfFiles,

                    // Success is called once all files have been successfully added to the user's
                    // Dropbox, although they may not have synced to the user's devices yet.
                    success: function () {
                        // Indicate to the user that the files have been saved.
                        alert("Success! Files saved to your Dropbox.");
                    },

                    // Progress is called periodically to update the application on the progress
                    // of the user's downloads. The value passed to this callback is a float
                    // between 0 and 1. The progress callback is guaranteed to be called at least
                    // once with the value 1.
                    progress: function (progress) { },

                    // Cancel is called if the user presses the Cancel button or closes the Saver.
                    cancel: function () { },

                    // Error is called in the event of an unexpected response from the server
                    // hosting the files, such as not being able to find a file. This callback is
                    // also called if there is an error on Dropbox or if the user is over quota.
                    error: function (errorMessage) { }
                };
                Dropbox.save(options);
            }

            function extendedFileExplorer_sendItemsPathsToServer() {
                var oExplorer = $find("<%= RadFileExplorerAlbum.ClientID %>"); // Find the RadFileExplorer ; 
                var selectedItems = oExplorer.get_selectedItems(); // Retrieve the selected items ;
                var selectedItemsPaths = extendedFileExplorer_combinePathsInAString(selectedItems); // Get the paths as a string in specific format ;

                var hiddenField = $get("<%= HiddenFieldDownload.ClientID %>"); // Find the hiddenField 
                hiddenField.value = selectedItemsPaths;
                __doPostBack("<%= ButtonDownload.UniqueID %>", ""); // Call the 'btnDownload_Click' function on the server ;
            }

            function extendedFileExplorer_combinePathsInAString(arrayOfSelectedItems) {
                var itemPaths = new Array();
                for (var i = 0; i < arrayOfSelectedItems.length; i++) {
                    // Pass all the selected paths ; 
                    itemPaths.push(arrayOfSelectedItems[i].get_path());
                }

                // Return a string that contains the paths ; 
                return itemPaths.join("|");
            }

            function OnClientFolderChange(sender, args) {
                var pinLabel = $get("<%= LabelAlbumPin.ClientID %>");
                var radFile = $find("<%= RadFileExplorerAlbum.ClientID %>");
                var radText = $find("<%= RadTextBoxAlbumName.ClientID %>");
                var nameValue = args.get_item().get_name();
                var currentDirectory = radFile.get_currentDirectory();
                var pinValue = currentDirectory.split('/').pop();
                pinLabel.innerHTML = pinValue;
                radText.set_value(nameValue);
                //SetAlbumNameByPinFromRest(pinValue);
            }

<%--            function SetAlbumNameByUserIdFromRest(userId) {
                $.ajax({
                    type: "GET",
                    url: "/AlbumService.svc/GetPinNameList/" + userId,
                    dataType: "json",
                    success: function (resp) {
                        for (var i = 0; i < resp.GetPinNameListResult.length; i++) {
                            if (resp.GetPinNameListResult[i].Pin == searchPin) {
                                var nameLabel = $get("<%= LabelAlbumName.ClientID %>");
                                nameLabel.innerHTML = resp.GetPinNameListResult[i].AlbumName;
                            }
                        }

                    }
                })
            }--%>

<%--            function SetAlbumNameByPinFromRest(searchPin) {
                    $.ajax({
                        type: "GET",
                        url: "/AlbumService.svc/GetAlbumName/" + searchPin,
                        dataType: "json",
                        success: function (resp) {
                            var nameLabel = $get("<%= LabelAlbumName.ClientID %>");
                            nameLabel.innerHTML = resp.GetAlbumNameResult;
                        }
                    })
            }--%>

            function OnExplorerFileOpen(oExplorer, args) {
                if (!args.get_item().isDirectory()) {
                    setTimeout(function () {
                        var oWindowManager = oExplorer.get_windowManager();
                        var previewWindow = oWindowManager.getActiveWindow(); // Gets the current active widow.
                        previewWindow.setSize(800, 700);
                        previewWindow.center();
                    }, 100);   // Some timeout is required in order to allow the window to become active
                }
            }

            function OnClientDelete(oExplorer, args) {
                var item = args.get_item();

                if (item.isDirectory()) {
                    args.set_cancel(true);
                    alert("Sorry, deletion of directories is not allowed at this time. This prevents users from accidentally deleting everyone's photos.");
                }
            }
</script>
        </script>
    </telerik:RadCodeBlock>
    
    <div>
        <h1>Pin:
            <asp:Label ID="LabelAlbumPin" runat="server" /></h1>        
        <br />
        <h1>Name:
        <%--<asp:Label ID="LabelAlbumName" runat="server" /> <br />--%>
            <telerik:RadTextBox ID="RadTextBoxAlbumName" runat="server" ShowButton="false" ></telerik:RadTextBox>
            <asp:Button ID="ButtonChangeAlbumName" runat="server" Text="Change Name" OnClick="ButtonChangeAlbumName_Click"></asp:Button>
        </h1>
        <asp:HiddenField ID="HiddenFieldDownload" runat="server" />
        <asp:Button ID="ButtonDownload" runat="server" Style="display: none" />
        <telerik:RadFileExplorer ID="RadFileExplorerAlbum"
            runat="server"
            VisibleControls="FileList, Grid, Toolbar, ListView, TreeView, ContextMenus"
            Configuration-AllowMultipleSelection="true"
            Configuration-MaxUploadFileSize="500000000"
            ExplorerMode="Thumbnails"
            OnClientFolderChange="OnClientFolderChange"
            OnClientDelete="OnClientDelete"
            ToolTip="Right click on a file or folder to download it. Downloads will be zipped up into a single file."
            OnClientFileOpen="OnExplorerFileOpen">
        </telerik:RadFileExplorer>
        <br />
        <br />
    </div>
</asp:Content>

