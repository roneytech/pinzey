using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(PictureShare1.Startup))]
namespace PictureShare1
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
