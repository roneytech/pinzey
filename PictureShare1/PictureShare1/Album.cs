using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;

namespace PictureShare1
{
    public class Album
    {
        public class AlbumObject
        {
            public string Pin { get; set; }
            public string AlbumName { get; set; }
            public string UserId { get; set; }
        }

        public string CreateNewAlbum(string albumName, string userId)
        {
            string pin = CreateNewAlbumDAL(albumName,userId);
            CreateFolder(userId);
            CreateFolder(userId + "/" + pin);
            return pin;
        }

        public bool AlbumExists(string pin)
        {
            return !String.IsNullOrEmpty(GetAlbumNameDAL(pin));
        }

        public string GetAlbumName(string pin)
        {
            return GetAlbumNameDAL(pin);
        }

        public string GetAlbumUserId(string pin)
        {
            return GetAlbumUserDAL(pin);
        }

        public AlbumObject[] GetPinNameListByUser(string userId)
        {
            using (SqlConnection conn = new SqlConnection())
            {
                List<AlbumObject> aList = new List<AlbumObject>();
                conn.ConnectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
                conn.Open();
                SqlCommand cmd = new SqlCommand("SELECT * FROM Album WHERE UserId = @0", conn);
                cmd.Parameters.Add(new SqlParameter("0", userId));

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        AlbumObject a = new AlbumObject();
                        a.Pin = reader["AlbumPin"].ToString();
                        a.AlbumName = reader["AlbumName"].ToString();
                        a.UserId = reader["UserId"].ToString();
                        aList.Add(a);
                    }
                }                
                return aList.ToArray();
            }
        }

        protected string CreateNewAlbumDAL(string albumName, string userId)
        {
            using (SqlConnection conn = new SqlConnection())
            {
                string NewAlbumPin = string.Empty;
                conn.ConnectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
                conn.Open();
                SqlCommand cmd = new SqlCommand("GetNewAlbum", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@albumName", albumName));
                cmd.Parameters.Add(new SqlParameter("@userId", userId));

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    reader.Read();
                    NewAlbumPin = reader["AlbumPin"].ToString();
                }
                return NewAlbumPin;
            }

        }

        protected string GetAlbumNameDAL(string pin)
        {
            if (!String.IsNullOrEmpty(pin))
            {

                using (SqlConnection conn = new SqlConnection())
                {
                    string AlbumName = string.Empty;
                    conn.ConnectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("SELECT * FROM Album WHERE AlbumPin = @0", conn);
                    cmd.Parameters.Add(new SqlParameter("0", pin));


                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        reader.Read();
                        if (reader.HasRows)
                        {
                            AlbumName = reader["AlbumName"].ToString();
                        }
                    }
                    return AlbumName;
                }
            }
            else
                throw new Exception();
        }

        protected string GetAlbumUserDAL(string pin)
        {
            using (SqlConnection conn = new SqlConnection())
            {
                string UserId = string.Empty;
                conn.ConnectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
                conn.Open();
                SqlCommand cmd = new SqlCommand("SELECT * FROM Album WHERE AlbumPin = @0", conn);
                cmd.Parameters.Add(new SqlParameter("@0", pin));


                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    reader.Read();
                    if (reader.HasRows)
                    {
                        UserId = reader["UserId"].ToString();
                    }
                }
                return UserId;
            }
        }

        protected void CreateFolder(string folderName)
        {
            string path = HttpContext.Current.Server.MapPath("~/Uploads/");
            path = path += folderName;
            if (!Directory.Exists(path))
            {
                Directory.CreateDirectory(path);
            }
        }

        public void ChangeAlbumName(string newAlbumName, string pin)
        {
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
                conn.Open();
                SqlCommand cmd = new SqlCommand("UPDATE Album SET AlbumName = @0 WHERE AlbumPin = @1", conn);
                cmd.Parameters.Add(new SqlParameter("0", newAlbumName));
                cmd.Parameters.Add(new SqlParameter("1", pin));
                cmd.ExecuteNonQuery();
            }
        }


    }


}