<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Payment.aspx.cs" Inherits="PictureShare1.Payment" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="payment">
        <br />
        <br />
        <p>
        <asp:DropDownList ID="DropDownListOption" runat="server">
            <asp:ListItem Text="$2/Month for 12 Months = $24.00" Value="24"></asp:ListItem>
        </asp:DropDownList>
        <asp:TextBox ID="TextBoxCardNumber" Text="4242424242424242" runat="server"></asp:TextBox>
        <asp:TextBox ID="TextBoxExpirationYear" Text="2022" runat="server"></asp:TextBox>
        <asp:TextBox ID="TextBoxExpirationMonth" Text="12" runat="server"></asp:TextBox>
        <asp:TextBox ID="TextBoxCvc" Text="123" runat="server"></asp:TextBox>
        <asp:Button ID="ButtonSubmit" Text="Submit Credit Card Details" runat="server" OnClick="ButtonSubmit_Click" />
        <br />
        <asp:Label ID="LabelTokenId" runat="server"></asp:Label>
        <br />
        <asp:Label ID="LabelChargeDetails" runat="server"></asp:Label>
        </p>
    </div>
    </asp:Content>

<%--<form action="" method="POST">
  <script
    src="https://checkout.stripe.com/checkout.js" class="stripe-button"
    data-key="pk_test_I2o0VLS5HAMQfGWsvGONATE9"
    data-amount="2000"
    data-name="Demo Site"
    data-description="2 widgets ($20.00)"
    data-image="/128x128.png"
    data-locale="auto">
  </script>
</form>--%>


