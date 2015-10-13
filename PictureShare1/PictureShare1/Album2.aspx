<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Album2.aspx.cs" MasterPageFile="~/Site.Master" Inherits="PictureShare1.AlbumTel" %>

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
            Co>
        </telerik:RadFileExplorer>
        <br />
        <br />
    </div>
</asp:Content>
