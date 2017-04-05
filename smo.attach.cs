using System;
using System.Collections.Specialized;
using System.IO;
using System.Data.SqlClient;
using Microsoft.SqlServer.Management.Smo;

namespace MBDTests
{
    partial class DBCreator
    {
        public string DatabaseName { get{ return mDatabaseName; } }
        string mDatabaseName;
        string mDatabaseFileName;
        Server mServer;
        public void Create(string dbName, string templatePath, string testPath, string masterConnectionString)
        {
            mDatabaseName = dbName;
            var mTemplateDatabaseFilePath = templatePath;

            /// Generate path to local copy of database.
            mDatabaseFileName = Path.Combine(testPath, dbName + Path.GetExtension(mTemplateDatabaseFilePath));

            var mSqlConnection = new SqlConnection(masterConnectionString);
            mServer = new Server(new Microsoft.SqlServer.Management.Common.ServerConnection(mSqlConnection));

            Delete();

            File.Copy(mTemplateDatabaseFilePath, mDatabaseFileName, true);

            File.SetAttributes(mDatabaseFileName, File.GetAttributes(mDatabaseFileName) & ~FileAttributes.ReadOnly);

            var lDatabaseFileNames = new StringCollection();
            lDatabaseFileNames.Add(mDatabaseFileName);

            try
            {
                mServer.AttachDatabase(mDatabaseName, lDatabaseFileNames, AttachOptions.None);
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                return;
            }
        }

        public void Delete()
        {
            if (mServer.Databases.Contains(mDatabaseName))
            {
                /// Disconnect all users from the database.
                mServer.KillAllProcesses(mDatabaseName);

                /// Detach and delete database.
                mServer.KillDatabase(mDatabaseName);
            }

            /// Delete the database file if it still exists.
            if (File.Exists(mDatabaseFileName))
            {
                File.Delete(mDatabaseFileName);
            }
        }
    }
}
