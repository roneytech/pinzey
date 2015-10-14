<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Album2.aspx.cs" MasterPageFile="~/Site.Master" Inherits="PictureShare1.AlbumTel" Title="Pinzey Picture Sharing"%>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            function extendedFileExplorer_onGridContextItemClicked(oGridMenu, args) {
                var menuItemText = args.get_item().get_text();
                if (menuItemText == "Download") {
                    extendedFileExplorer_sendItemsPathsToServer();
                }
            }

            function onClientContextMenuItemClicked(sender, args) {
                var menuItem = args.get_menuItem();
                var treeNode = args.get_node();

                if (menuItem.get_value() == "Download") {
                    extendedFileExplorer_sendItemsPathsToServer();
                }
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
                var pinValue = args.get_item().get_name();
                pinLabel.innerHTML = pinValue;
                SetAlbumNameByPinFromRest(pinValue);
            }

            function SetAlbumNameByUserIdFromRest(userId) {
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
            }

            function SetAlbumNameByPinFromRest(searchPin) {
                    $.ajax({
                        type: "GET",
                        url: "/AlbumService.svc/GetAlbumName/" + searchPin,
                        dataType: "json",
                        success: function (resp) {
                            var nameLabel = $get("<%= LabelAlbumName.ClientID %>");
                            nameLabel.innerHTML = resp.GetAlbumNameResult;
                        }
                    })
            }
        </script>
    </telerik:RadCodeBlock>

    <div>
        <h1>Pin:
            <asp:Label ID="LabelAlbumPin" runat="server" /></h1>
        <br />
        <h1>Name:
            <asp:Label ID="LabelAlbumName" runat="server" /></h1>
        <asp:HiddenField ID="HiddenFieldDownload" runat="server" />
        <asp:Button ID="ButtonDownload" runat="server" Style="display: none" />
        <telerik:RadFileExplorer ID="RadFileExplorerAlbum"
            runat="server"
            VisibleControls="FileList, Grid, Toolbar, ListView, TreeView, ContextMenus"
            Configuration-AllowMultipleSelection="true"
            Configuration-MaxUploadFileSize="500000000"
            ExplorerMode="Thumbnails"
            OnClientFolderChange="OnClientFolderChange"
            ToolTip="Right click on a file or folder to download it. Downloads will be zipped up into a single file.">
        </telerik:RadFileExplorer>
        <br />
        <br />
    </div>
</asp:Content>
