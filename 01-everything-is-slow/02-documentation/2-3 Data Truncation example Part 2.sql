/* Listing 2-3: Data Truncation example Part 2 */
DECLARE @sometable TABLE (somecol varchar(40));
DECLARE @othertable TABLE (othercol Varchar(100));

INSERT INTO @othertable(othercol)
VALUES ('blah')
		, ('foo')
		, ('short')
		, ('uhhuh')
		, ('nuhuh Im going to be over 40 characters ha');

INSERT INTO @sometable (somecol)
SELECT othercol
FROM @othertable;

SELECT *
FROM @sometable;

/* Listing 2-5: Implicit Conversion example Part 1 */
DECLARE @sometable TABLE (int01 INT);
DECLARE @othertable TABLE (varchar01 varchar(8));

INSERT INTO @sometable (int01)
VALUES (1)
		, (10)
		, (23)
		, (47)
		, (56);

INSERT INTO @othertable(varchar01)
VALUES ('23')
		, ('a89')
		, ('56o')
		, ('e1')
		, ('47');

SELECT ot.varchar01
FROM @othertable ot
WHERE EXISTS (SELECT 1
			FROM @sometable st
			WHERE st.int01 = ot.varchar01);

/* Listing 2-7: Implicit Conversion example Part 2 */
DECLARE @sometable TABLE (int01 INT);
DECLARE @othertable TABLE (varchar01 varchar(8));

INSERT INTO @sometable (int01)
VALUES (1)
		, (10)
		, (23)
		, (47)
		, (56);


INSERT INTO @othertable(varchar01)
VALUES ('23')
		, ('89')
		, ('56')
		, ('1')
		, ('47');

SELECT ot.varchar01
FROM @othertable ot
WHERE EXISTS (SELECT 1
			FROM @sometable st
			WHERE st.int01 = ot.varchar01);

/* Listing 2-8: percentage posts calculation from Listing 2-1 */
CASE
	WHEN fo.numPosts = 0
THEN 0
	ELSE CAST(
			(
			  SELECT MAX(ud.numPostsAnswered)
				FROM @usersDay ud
				WHERE ud.dayOfMonth = fo.dayOfMonth
			) / fo.numPosts AS DECIMAL(8, 7))
		 END

/* Listing 2-10: Code to determine number of posts entered per month */
SELECT COUNT(1) as NumPosts
, DATEPART(year,creationdate)
, DATEPART(m, creationdate)
FROM dbo.Posts
WHERE posttypeid = 1
GROUP BY DATEPART(year,creationdate),DATEPART(m,creationdate)
ORDER BY DATEPART(year,creationdate),DATEPART(m,creationdate);

/* Listing 2-11: Sample call for sp_codeCallsCascade */
EXECUTE sp_codeCallsCascade @codeName='DailySummaryReportPerMonth', @rootSchema = 'dbo';

/* Listing 2-12: Native SQL Server Function in the WHERE clause from Listing 2-1 */
SET @postID = COALESCE((SELECT MIN(id)
				FROM dbo.posts
				WHERE  DATEADD(m, DATEDIFF(m, 0, creationDate),0) = @monthYear
					AND posttypeID = 1)
				,0);

/* Listing 2-13: Mocked up test example of native SQL Server function in the WHERE clause */
DECLARE @monthYear datetime = '20120801'
	, @postID int;

SET @postID = COALESCE((SELECT MIN(id)
				FROM dbo.posts
				WHERE  DATEADD(m, DATEDIFF(m, 0, creationDate),0) = @monthYear
					AND posttypeID = 1)
			,0);
SET @postID = COALESCE((SELECT MIN(id)
				FROM dbo.posts
				WHERE  DATEADD(m, DATEDIFF(m, 0, creationDate),0) = @monthYear
					AND posttypeID = 1
					AND id > @postID),0);
