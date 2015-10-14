using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;
using System.ServiceModel.Web;

namespace PictureShare1
{
    [ServiceBehavior(AddressFilterMode = AddressFilterMode.Any)]
    public class AlbumService : IAlbumService
    {
        #region IAlbumServiceMembers

        public string GetAlbumName(string pin)
        {
            Album album = new Album();
            return album.GetAlbumName(pin);
        }

        public bool AlbumExists(string pin)
        {
            Album album = new Album();
            return album.AlbumExists(pin);
        }

        public string CreateAlbum(string albumName, string userName)
        {
            Album album = new Album();
            string pin = album.CreateNewAlbum(albumName,userName);
            return pin;
        }

        public Album.AlbumObject[] GetPinNameList(string userName)
        {
//            Album.AlbumList[] a = new Album.AlbumList[2];
//            Album.AlbumList a1 = new Album.AlbumList();
//            a1.AlbumName = "aName1";
//            a1.Pin = "aPin1";
//            Album.AlbumList a2 = new Album.AlbumList();
//            a2.AlbumName = "aName1";
//            a2.Pin = "aPin1";
//            a[0] = a1;
//            a[1] = a2;
////            new {Album.AlbumList = new [] {
////    new {name = "command" , index = "X", optional = "0"}, 
////    new {name = "command" , index = "X", optional = "0"}
////}}
            Album album = new Album();
            return album.GetPinNameListByUser("1a6ce3d7-1288-4501-8ebf-794141c520d8");
        }
        #endregion


    }
}
