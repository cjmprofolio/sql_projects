--What are the most commented-upon videos? Or the most liked?

SELECT "Title",
	"Comments"
FROM PUBLIC."videos-stats"
WHERE "Comments" IS NOT NULL
ORDER BY "Comments" DESC
LIMIT 1

SELECT "Title",
	"Likes"
FROM PUBLIC."videos-stats"
WHERE "Likes" IS NOT NULL
ORDER BY "Likes" DESC
LIMIT 1


--How many total views does each category have? How many likes?

SELECT "Keyword",
	SUM("Views") AS "total_views"
FROM PUBLIC."videos-stats"
GROUP BY "Keyword"
ORDER BY "total_views" DESC

SELECT "Keyword",
	SUM("Likes") AS "total_Likes"
FROM PUBLIC."videos-stats"
GROUP BY "Keyword"
ORDER BY "total_Likes" DESC

--What are the most-liked comments?

SELECT "Comment",
	"Likes"
FROM PUBLIC."comments"
ORDER BY "Likes" DESC
LIMIT 1

--What is the ratio of views/likes per video? Per each category?

SELECT "Title",
	("Views" / "Likes") AS "rate"
FROM PUBLIC."videos-stats"
WHERE "Likes" <> 0

SELECT "Keyword",
		(SUM("Views") / SUM("Likes")) AS "total_rate"
FROM PUBLIC."videos-stats" WHERE "Likes" <> 0
GROUP BY "Keyword"
ORDER BY "Keyword"


--But what will really expand your understanding of SQL is answering more elaborate questions:

--What is the average sentiment score in each keyword category?

SELECT "videos-stats"."Keyword",
	AVG("Sentiment")
FROM PUBLIC."comments"
LEFT JOIN PUBLIC."videos-stats" ON "comments"."VideoID" = "videos-stats"."VideoID"
GROUP BY "videos-stats"."Keyword"


--How many times do company names (i.e., Apple or Samsung) appear in each keyword category?
-- take 'Twitter' as an example

SELECT "Keyword",
	COUNT("Title")
FROM PUBLIC."videos-stats"
WHERE "Title" like '%Twitter%'
GROUP BY "Keyword"