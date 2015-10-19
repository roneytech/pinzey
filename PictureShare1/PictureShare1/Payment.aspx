<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Payment.aspx.cs" Inherits="PictureShare1.Payment" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="payment">
        <h3>Payment Details</h3>
        <div class="white_container">
            <div class="form-group select-label">
                <asp:Label runat="server" AssociatedControlID="DropDownListOption">Select Your Plan</asp:Label>
                <span class="select"><asp:DropDownList ID="DropDownListOption" runat="server">
                    <asp:ListItem Text="$2/Month for 12 Months = $24.00" Value="Level1"></asp:ListItem>
                    <asp:ListItem Text="$4/Month for 12 Months = $48.00" Value="Level2"></asp:ListItem>
                </asp:DropDownList></span>
            </div>
            <div class="form-group cardnumber-label">
                <asp:Label runat="server" AssociatedControlID="TextBoxCardNumber">Credit Card Number</asp:Label>
                <asp:TextBox ID="TextBoxCardNumber" Text="4242424242424242" runat="server" placeholder="Credit Card Number"></asp:TextBox>
            </div>
            <div class="form-group exp-label first">
                <asp:Label runat="server" AssociatedControlID="TextBoxExpirationYear">Exp Year</asp:Label>
                <asp:TextBox ID="TextBoxExpirationYear" Text="2022" runat="server" placeholder="Exp Year"></asp:TextBox>
            </div>
            <div class="form-group exp-label">
                <asp:Label runat="server" AssociatedControlID="TextBoxExpirationMonth">Exp Month</asp:Label>
                <asp:TextBox ID="TextBoxExpirationMonth" Text="12" runat="server" placeholder="Exp Month"></asp:TextBox>
            </div>
            <div class="form-group exp-label">
                <asp:Label runat="server" AssociatedControlID="TextBoxCvc">CVS</asp:Label>
                <asp:TextBox ID="TextBoxCvc" Text="123" runat="server" placeholder="CVS"></asp:TextBox>
            </div>
        </div>
        <asp:Button ID="ButtonSubmit" Text="Submit Credit Card Details" runat="server" OnClick="ButtonSubmit_Click" /><br />
            <asp:Label ID="LabelTokenId" runat="server"></asp:Label><br />
            <asp:Label ID="LabelChargeDetails" runat="server"></asp:Label>
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


