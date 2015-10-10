<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TestWebForm.aspx.cs" MasterPageFile="~/Site.Master" Inherits="PictureShare1.TestWebForm" %>

<%@ Register Assembly="IZ.WebFileManager" Namespace="IZ.WebFileManager" TagPrefix="iz" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div>
        test form 1
                <iz:FileManager ID="FileManager1" runat="server" Height="400" Width="600" AllowUpload="true">
                    <RootDirectories>
                        <iz:RootDirectory DirectoryPath="~/Uploads" Text="Upload" />
                    </RootDirectories>
                </iz:FileManager>
    </div>


</asp:Content>
