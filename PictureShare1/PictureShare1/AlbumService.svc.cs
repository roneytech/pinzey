using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;

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
        #endregion


    }
}
