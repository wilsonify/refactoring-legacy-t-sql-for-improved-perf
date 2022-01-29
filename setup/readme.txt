

1. download data
2. extract zip with 7Zip
3. update environment variables as needed
3. docker-compose up to start the database
4. init container to attach mdf

The extract will have the database MDF, NDFs, LDF, and a Readme.txt file.
Don’t extract the files directly into your SQL Server’s database directories – instead,
extract them somewhere else first, and then move or copy them into the SQL Server’s database directories.
You’re going to screw up the database over time, and you’re going to want to start again
– keep the original copy so you don’t have to download it again.

Then, attach the database.
It’s in Microsoft SQL Server 2008 format (2005 for the older torrents),
so you can attach it to any 2008 or newer instance.

It doesn’t use any Enterprise Edition features like partitioning or compression,
so you can attach it to Developer, Standard, or Enterprise Edition.

If your SSMS crashes or throws permissions errors,
you likely tried extracting the archive directly into the database directory,
and you’ve got permissions problems on the data/log files.

What’s Inside the StackOverflow Database:

I want you to get started quickly while still keeping the database size small, so:

    All tables have a clustered index on Id, an identity field
    No other indexes are included (nonclustered or full text)
    The log file is small, and you should grow it out if you plan to build indexes or modify data
    It only includes StackOverflow.com data, not data for other Stack sites

To get started, here’s a few helpful links:
 [This Meta. SE post explains the database schema.] (http://meta.stackexchange.com/questions/2677/database-schema-documentation-for-the-public-data-dump-and-sede)

If you want to learn how to tune queries, Data.StackExchange.com is a fun source for queries written by other people.
For questions about the data, check the data-dump tag on Meta.StackExchange.com.

output from sqlcmd -? for reference:
    [ -U login id ]
    [ -P password ]
    [ -S server ]
    [ -H hostname ]
    [ -Q "cmdline query" and exit ]
    [ -E trusted connection ]
    [ -N Encrypt Connection ]
    [ -C Trust Server Certificate ]
    [ -d use database name ]
    [ -l login timeout ]
    [ -t query timeout ]
    [ -h headers ]
    [ -s colseparator ]
    [ -w screen width ]
    [ -a packetsize ]
    [ -e echo input ]
    [ -I Enable Quoted Identifiers ]
    [ -c cmdend ]
    [ -q "cmdline query" ]
    [ -m errorlevel ]
    [ -V severitylevel ]
    [ -W remove trailing spaces ]
    [ -u unicode output ]
    [ -r[ 0|1 ] msgs to stderr ]
    [ -i inputfile ]
    [ -o outputfile ]
    [ -k[ 1|2 ] remove[ replace ] control characters ]
    [ -y variable length type display width ]
    [ -Y fixed length type display width ]
    [ -p[ 1 ] print statistics[ colon format ] ]
    [ -R use client regional setting ]
    [ -K application intent ]
    [ -M multisubnet failover ]
    [ -b On error batch abort ]
    [ -D Dsn flag, indicate -S is Dsn ]
    [ -X[ 1 ] disable commands, startup script, environment variables [ and exit ] ]
    [ -x disable variable substitution ]
    [ -g enable column encryption ]
    [ -G use Azure Active Directory for authentication ]
    [ -? show syntax summary ]



