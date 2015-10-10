using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;
using System.ServiceModel.Web;

namespace PictureShare1
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the interface name "IAlbumService" in both code and config file together.
    [ServiceContract]
    public interface IAlbumService
    {
        [OperationContract]
        [WebInvoke(Method = "GET",
            ResponseFormat = WebMessageFormat.Json,
            BodyStyle = WebMessageBodyStyle.Wrapped,
            UriTemplate = "AlbumExists/{pin}")]
        bool AlbumExists(string pin);

        [OperationContract]
        [WebInvoke(Method = "GET",
            ResponseFormat = WebMessageFormat.Json,
            BodyStyle = WebMessageBodyStyle.Wrapped,
            UriTemplate = "GetAlbumName/{pin}")]
        string GetAlbumName(string pin);

        [OperationContract]
        [WebInvoke(Method = "GET",
            ResponseFormat = WebMessageFormat.Json,
            BodyStyle = WebMessageBodyStyle.Wrapped,
            UriTemplate = "CreateAlbum/{userName}/{albumName}")]
        string CreateAlbum(string albumName, string userName);
    }
    
}
