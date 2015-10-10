<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Album.aspx.cs" MasterPageFile="~/Site.Master" Inherits="PictureShare1.AlbumWeb" %>

<%@ Register Assembly="IZ.WebFileManager" Namespace="IZ.WebFileManager" TagPrefix="iz" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div>
        <asp:LoginView ID="LoginView1" runat="server">
            <LoggedInTemplate>
                <br />
                <br />
                Click the Browse button to select files to upload
                <asp:FileUpload ID="FileUploadUser" runat="server" AllowMultiple="True" />
                <br />
                <asp:Button ID="ButtonUploadUser" runat="server" Text="Upload Files" OnClick="Button1_Click" />
                <br />
                <asp:Label ID="LabelFilesUser" runat="server"></asp:Label>\
                <br />
                <br />
                <iz:FileManager ID="FileManagerUser" runat="server" Height="400" Width="600" AllowUpload="true">
                    <RootDirectories>
                        <iz:RootDirectory DirectoryPath="~/Uploads" Text="Upload" />
                    </RootDirectories>
                </iz:FileManager>
            </LoggedInTemplate>
            <AnonymousTemplate>
                <asp:FileUpload ID="FileUpload1" runat="server" AllowMultiple="True" />
                <br />
                <asp:Button ID="ButtonUpload" runat="server" Text="Upload Files" OnClick="Button1_Click" />
                <br />
                <asp:Label ID="LabelFiles" runat="server"></asp:Label>\
                <br />
                <br />
                <iz:FileManager ID="FileManagerAnon" runat="server" Height="400" Width="600" AllowUpload="true">
                    <RootDirectories>
                        <iz:RootDirectory DirectoryPath="~/Uploads" Text="Upload" />
                    </RootDirectories>
                </iz:FileManager>
            </AnonymousTemplate>

        </asp:LoginView>
    </div>
</asp:Content>
