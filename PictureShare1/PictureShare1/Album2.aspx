<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Album2.aspx.cs" MasterPageFile="~/Site.Master" Inherits="PictureShare1.AlbumTel" Title="Pinzey Picture Sharing" %>

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

            function makeDropboxFileListFromSelectedItems(selectedItemArray) {
                var baseUrl = window.location.href.replace("#", "");
                var itemPaths = new Array();
                for (var i = 0; i < selectedItemArray.length; i++) {
                    var url = baseUrl + selectedItemArray[i].get_path();
                    itemPaths.push({ 'url': url, 'filename': selectedItemArray[i].get_name() });
                }
                return itemPaths;
            }

            function saveToDropbox(arrayOfFiles) {
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

            // Set pin label depending on folder selected.
            function OnClientFolderChange(sender, args) {
                var pinLabel = $get("<%= LabelAlbumPin.ClientID %>");
                var radFile = $find("<%= RadFileExplorerAlbum.ClientID %>");
                var radText = $find("<%= RadTextBoxAlbumName.ClientID %>");
                var nameValue = args.get_item().get_name();
                var currentDirectory = args.get_item().get_path();
                var folderCount = currentDirectory.split('/').length - 1;
                if (folderCount < 4) {
                    pinLabel.innerHTML = nameValue.substr(0, nameValue.indexOf(' '));
                    radText.set_value(nameValue.substr(nameValue.indexOf(': '), nameValue.length - nameValue.indexOf(': ')));
                }
                else {
                    var directories = currentDirectory.split('/');
                    directories.pop();
                    var pinValue = directories.pop();
                    pinLabel.innerHTML = pinValue;
                    SetAlbumNameByPinFromRest(pinValue);

                }
                //pinLabel.innerHTML = nameValue.substr(0, nameValue.indexOf(' '));

                //SetAlbumNameByPinFromRest(pinValue);
            }

            function OnFileExplorerLoad() {
                setInitialAlbumPinText();
                addToolTip();
            }

            function setInitialAlbumPinText() {
                var pinLabel = $get("<%= LabelAlbumPin.ClientID %>");
                var radFile = $find("<%= RadFileExplorerAlbum.ClientID %>");
                var radText = $find("<%= RadTextBoxAlbumName.ClientID %>");
                var radTree = radFile.get_tree();
                var node = radTree.get_nodes().getNode(0);
                var nodeText = node.get_text();
                pinLabel.innerHTML = nodeText.substr(0, nodeText.indexOf(' '));
                radText.set_value(nodeText.substr(nodeText.indexOf(': '), nodeText.length - nodeText.indexOf(': ')));
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

            function SetAlbumNameByPinFromRest(searchPin) {
                    $.ajax({
                        type: "GET",
                        url: "/AlbumService.svc/GetAlbumName/" + searchPin,
                        dataType: "json",
                        success: function (resp) {
                            var radText = $get("<%= RadTextBoxAlbumName.ClientID %>");
                            radText.set_value(resp.GetAlbumNameResult);
                            //nameLabel.innerHTML = resp.GetAlbumNameResult;
                        }
                    })
            }

            function OnExplorerFileOpen(oExplorer, args) {
                if (!args.get_item().isDirectory()) {

                    addImagesToImageGalary();
                    selectGallaryItem(args.get_item().get_name());
                    args.set_cancel(true);
                    
                    var oWnd = $find("<%= RadWindow1.ClientID %>");
                    oWnd.show();
                }
            }

            function OnClientDelete(oExplorer, args) {
                var item = args.get_item();

                if (item.isDirectory()) {
                    args.set_cancel(true);
                    alert("Sorry, deletion of directories is not allowed at this time. This prevents users from accidentally deleting everyone's photos.");
                }
            }


            function selectGallaryItem(itemToOpen) {
                var oImage = $find("<%= RadImageGallery2.ClientID %>");
                var itemsArray = oImage.get_items();
                var titles = [];
                var paths = [];
                var count = itemsArray.get_count();
                var gallaryItem;
                for (var i = 0; i < count; i++) {
                    var imageUrl = itemsArray.getItem(i).get_imageUrl();
                    imageUrl = imageUrl.split('%20').join(' ')
                    if (imageUrl.indexOf(itemToOpen) > -1) {
                        gallaryItem = itemsArray.getItem(i);
                    }

                }
                
                oImage.selectItem(gallaryItem);
            }

            function addImagesToImageGalary(itemToSelect)
            {
                // Get the image gallary and clear its items.
                var oImage = $find("<%= RadImageGallery2.ClientID %>");
                oImage.get_items().clear();

                // Get list of items.
                var oExplorer = $find("<%= RadFileExplorerAlbum.ClientID %>");
                var fileList = oExplorer.get_fileList().get_items();
                for (var i = 0; i < fileList.length; i++) {
                    var filePath = fileList[i].Path;
                    if (/\.(jpe?g|png|gif|bmp)$/i.test(filePath)) {
                        var item = new Telerik.Web.UI.ImageGalleryItem({
                            //title: "Image title",
                            //description: "Image description",
                            //thumbnailUrl: fileList[i].Path,
                            imageUrl: fileList[i].Path
                        });                    
                        oImage.get_items().add(item);
                    }
                }
            }

            function addToolTip() {
                var oExplorer = $find("<%= RadFileExplorerAlbum.ClientID %>");
                var toolBar = oExplorer.get_toolbar();
                var uploadButton = toolBar.findItemByText("Upload");
                uploadButton.onmouseover = null;
                var element = uploadButton.get_element();
                var toolTipManager = $find("<%= RadToolTipManager1.ClientID %>");
                tooltip = toolTipManager.createToolTip(element);
                tooltip.set_text("Click here to upload your files!");
                tooltip.set_showEvent(Telerik.Web.UI.ToolTipShowEvent.OnMouseOver);
                tooltip.set_animation(Telerik.Web.UI.ToolTipAnimation.FlyIn);
                tooltip.set_animationDuration(2000);
                tooltip.set_position(Telerik.Web.UI.ToolTipPosition.TopRight);

                setTimeout(function () {
                    radToolTip.show();
                }, 20);
                tooltip.show();
            }
        </script>
    </telerik:RadCodeBlock>

    <div class="main_left"></div>
    <div class="main_right"></div>

    <div class="albums_container">
        
        <telerik:RadToolTipManager ID="RadToolTipManager1" runat="server"></telerik:RadToolTipManager>
        <telerik:RadToolTip ID="RadToolTip1" runat="server" Text="TEST" Animation="FlyIn" Visible="true"></telerik:RadToolTip>
        <div class="orange">
            <h3 class="album_titles">Pin:
                <asp:Label ID="LabelAlbumPin" runat="server" /></h3>
            <h3 class="album_titles">Name
            <%--<asp:Label ID="LabelAlbumName" runat="server" /> <br />  --%>
                <telerik:RadTextBox ID="RadTextBoxAlbumName" runat="server" ShowButton="false"></telerik:RadTextBox>
                <asp:Button ID="ButtonChangeAlbumName" runat="server" Text="Change Name" OnClick="ButtonChangeAlbumName_Click"></asp:Button>            
            </h3>
        </div>
        <asp:HiddenField ID="HiddenFieldDownload" runat="server" />
        <asp:Button ID="ButtonDownload" runat="server" Style="display: none" />
        <telerik:RadFileExplorer ID="RadFileExplorerAlbum"
            runat="server"
            Width="100%"
            TreePaneWidth ="25%"
            VisibleControls="FileList, Grid, Toolbar, ListView, TreeView, ContextMenus"
            Configuration-AllowMultipleSelection="true"
            Configuration-MaxUploadFileSize="500000000"
            ExplorerMode="Thumbnails"
            OnClientFolderChange="OnClientFolderChange"
            OnClientDelete="OnClientDelete"
            ToolTip="Right click on a file or folder to download it. Downloads will be zipped up into a single file."
            OnClientFileOpen="OnExplorerFileOpen"
            OnExplorerPopulated="RadFileExplorerAlbum_ExplorerPopulated"
            OnClientLoad="OnFileExplorerLoad">
        </telerik:RadFileExplorer>
        
        <telerik:RadWindow runat="server" ID="RadWindow1"
            Behaviors="Close,Move" ShowContentDuringLoad="true"
            VisibleStatusbar="false" AutoSize="false" Height="650px" Width="640px"
            Modal="true">
            <ContentTemplate>
                <telerik:RadImageGallery runat="server" ID="RadImageGallery2" DisplayAreaMode="Image"
                    Width="600px" Height="600" Visible="true" >
                     <ThumbnailsAreaSettings Mode="ImageSliderPreview" />
                     <ClientSettings AllowKeyboardNavigation="true"/>
                </telerik:RadImageGallery>
            </ContentTemplate>
        </telerik:RadWindow>
        <a runat="server" href="~/Payment" class="more_space">Get more space!</a>
    </div>

    <div class="tips">
        <h4>Tips</h4>
        <ol>
            <li>Find the upload button and start uploading your files.</li>
            <li>Create a different folder inside your album for each person so pictures don't get mixed together.</li>
            <li>Right click on files or folders to see more options.</li>
        </ol>
    </div>

</asp:Content>

