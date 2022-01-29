/* Listing 2-2: Data truncation example Part 1 */

DECLARE @sometable TABLE (somecol varchar(40));
DECLARE @othertable TABLE (othercol Varchar(50));

INSERT INTO @othertable(othercol)
VALUES ('blah')
		, ('foo')
		, ('short')
		, ('uhhuh');

INSERT INTO @sometable (somecol)
SELECT othercol
FROM @othertable;

SELECT *
FROM @sometable;