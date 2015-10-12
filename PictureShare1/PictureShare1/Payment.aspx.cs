using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Stripe;

namespace PictureShare1
{
    public partial class Payment : System.Web.UI.Page
    {


        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ButtonSubmit_Click(object sender, EventArgs e)
        {
            LabelTokenId.Text = getStripeToken(TextBoxCardNumber.Text,
                TextBoxExpirationYear.Text,
                TextBoxExpirationMonth.Text,
                TextBoxCvc.Text);
            if (chargeCard(LabelTokenId.Text, (int.Parse(DropDownListOption.SelectedValue)*100)))
            {
                LabelChargeDetails.Text = "Charge sucessful!";
            }
        }

        protected string getStripeToken(string cardNumber, string expirationYear, string expirationMonth, string cvc)
        {
            var myToken = new StripeTokenCreateOptions();

            // if you need this...
            myToken.Card = new StripeCreditCardOptions()
            {
                // set these properties if passing full card details (do not
                // set these properties if you set TokenId)
                Number = cardNumber,
                ExpirationYear = expirationYear,
                ExpirationMonth = expirationMonth,
                //AddressCountry = "US",                // optional
                //AddressLine1 = "24 Beef Flank St",    // optional
                //AddressLine2 = "Apt 24",              // optional
                //AddressCity = "Biggie Smalls",        // optional
                //AddressState = "NC",                  // optional
                //AddressZip = "27617",                 // optional
                //Name = "Joe Meatballs",               // optional
                Cvc = cvc
            };

            var tokenService = new StripeTokenService();
            StripeToken stripeToken = tokenService.Create(myToken);
            return stripeToken.Id;
        }

        protected bool chargeCard(string tokenId, int amount)
        {
            var pinzeyCharge = new StripeChargeCreateOptions();

            // always set these properties
            pinzeyCharge.Amount = amount;
            pinzeyCharge.Currency = "usd";

            // set this if you want to
            pinzeyCharge.Description = "Charge it like it's hot";

            // setting up the card
            pinzeyCharge.Source = new StripeSourceOptions()
            {
                // set this property if using a token
                TokenId = tokenId
            };


            // set this if you have your own application fees (you must have your application configured first within Stripe)
            //myCharge.ApplicationFee = 25;

            // (not required) set this to false if you don't want to capture the charge yet - requires you call capture later
            //myCharge.Capture = true;

            var chargeService = new StripeChargeService();
            StripeCharge stripeCharge = chargeService.Create(pinzeyCharge);
            return stripeCharge.Paid;
        }



    }
}