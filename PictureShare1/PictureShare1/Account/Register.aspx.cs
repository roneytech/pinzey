﻿using System;
using System.Linq;
using System.Web;
using System.Web.UI;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Owin;
using PictureShare1.Models;
using Microsoft.AspNet.Identity.EntityFramework;

namespace PictureShare1.Account
{
    public partial class Register : Page
    {
        protected void CreateUser_Click(object sender, EventArgs e)
        {
            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            var signInManager = Context.GetOwinContext().Get<ApplicationSignInManager>();
            var user = new ApplicationUser() { UserName = Email.Text, Email = Email.Text };
            IdentityResult result = manager.Create(user, Password.Text);
            if (result.Succeeded)
            {
                // For more information on how to enable account confirmation and password reset please visit http://go.microsoft.com/fwlink/?LinkID=320771
                string code = manager.GenerateEmailConfirmationToken(user.Id);
                string callbackUrl = IdentityHelper.GetUserConfirmationRedirectUrl(code, user.Id, Request);
                manager.SendEmail(user.Id, "Confirm your account", "Please confirm your account by clicking <a href=\"" + callbackUrl + "\">here</a>.");
                signInManager.SignIn( user, isPersistent: false, rememberBrowser: false);
                loginForm.Visible = false;
                EmailSentForm.Visible = true;

                // For Beta add all users to full account.
                updateUsersRole(user.Id, "level2");
            }
            else 
            {
                ErrorMessage.Text = result.Errors.FirstOrDefault();
            }
        }

        protected void updateUsersRole(string userId, string roleName)
        {
            var context = HttpContext.Current.GetOwinContext().Get<ApplicationDbContext>();
            var roleManager = new RoleManager<IdentityRole>(new RoleStore<IdentityRole>(context));

            if (!roleManager.RoleExists(roleName))
            {
                var roleresult = roleManager.Create(new IdentityRole(roleName));
            }
            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            var result = manager.AddToRole(userId, roleName);
        }
    }
}