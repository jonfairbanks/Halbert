# Description:
#  Get trending news topics from f5oclock.com
#
# Commands:
#  hubot trending (news) - Get trending news articles from /r/politics in the last 60 minutes (default 3)
#
# Author:
#  jonfairbanks

f5_baseurl = 'http://www.f5oclock.com'
reddit_baseurl = 'https://reddit.com'
post_limit = 3

sendMsg = (res, body) ->
  data = JSON.parse body
  data = data.sort(compare)
  # console.log(JSON.stringify(data))
  i = 0
  while i < "#{post_limit}"
    res.send "#{reddit_baseurl}" + data[i].commentLink
    i++

compare = (a, b) ->
  if a.upvoteCount < b.upvoteCount
    return 1
  if a.upvoteCount > b.upvoteCount
    return -1
  0

module.exports = (robot) ->
  robot.respond /trending( news)?$/i, (res) ->
    res.send "*Trending on /r/politics in the past 60 minutes:*"
    robot.http("#{f5_baseurl}/getPosts").get() (err, response, body) ->
      if err
        res.send "There was an error: ```" + err + "```"
      setTimeout ->
        sendMsg res, body
      , 300
