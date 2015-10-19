using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Stripe;
using System.Web.Security;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using PictureShare1.Models;
//using Owin;
using Microsoft.AspNet.Identity.EntityFramework;


namespace PictureShare1
{
    public partial class Payment : System.Web.UI.Page
    {
        const int level1Price = 2400;
        const int level2Price = 4800;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ButtonSubmit_Click(object sender, EventArgs e)
        {
            LabelTokenId.Text = getStripeToken(TextBoxCardNumber.Text,
                TextBoxExpirationYear.Text,
                TextBoxExpirationMonth.Text,
                TextBoxCvc.Text);
            int paymentAmount = 0;
            switch (DropDownListOption.SelectedValue)
            {
                case "Level1":
                    paymentAmount = level1Price;
                    break;
                case "Level2":
                    paymentAmount = level2Price;
                    break;
                default:
                    paymentAmount = 0;
                    break;
            }

            if (paymentAmount > 0)
            {
                if (chargeCard(LabelTokenId.Text, paymentAmount))
                {
                    LabelChargeDetails.Text = "Charge sucessful!";
                    updateUsersRole(DropDownListOption.SelectedValue);

                }
            }
        }

        protected void updateUsersRole(string roleName)
        {
            var context = HttpContext.Current.GetOwinContext().Get<ApplicationDbContext>();
            var roleManager = new RoleManager<IdentityRole>(new RoleStore<IdentityRole>(context));

            if (!roleManager.RoleExists(roleName))
            {
                var roleresult = roleManager.Create(new IdentityRole(roleName));
            }
            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            var result = manager.AddToRole(User.Identity.GetUserId(), roleName);
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