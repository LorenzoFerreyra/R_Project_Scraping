require(TweetScraperR)




getTweetsHistoricalHashtag(
    hashtag = "milei",
    timeout = 10,
    n_tweets = 100,
    since = "2018-10-26",
    until = "2018-10-30",
    xuser = Sys.getenv("USER_XT"),
    xpass = Sys.getenv("PASS"),
    dir = getwd(),
    save = TRUE
)