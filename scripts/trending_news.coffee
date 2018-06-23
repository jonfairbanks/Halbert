# Description:
#  Get trending news topics from f5oclock.com
#
# Commands:
#  hubot trending (news) - share the latest trending news items (default 3)
#
# Author:
#  jonfairbanks

f5_baseurl = 'http://www.f5oclock.com'
reddit_baseurl = 'https://reddit.com'
post_limit = 3
upvote_threshold = 100
final = []

# Helper Functions
compare = (a, b) ->
  if a.upvoteCount < b.upvoteCount
    return 1
  if a.upvoteCount > b.upvoteCount
    return -1
  0
  
trimArray = (data) ->
  length = data.length - 1
  i = 0
  while i <= length
    if data[i].upvoteCount >= upvote_threshold
        final.push data[i]
    i++
  return

# Main Code
module.exports = (robot) ->
  robot.respond /trending( news)?$/i, (res) ->
    res.send "*Trending on /r/politics in the past 60 minutes:*"
    robot.http("#{f5_baseurl}/getPosts").get() (err, response, body) ->
        throw err if err
        json = JSON.parse body
        sorted = json.sort(compare)
        trimArray sorted
        res.send "Final: ```" + JSON.stringify(final, null, ' ') + "```"
        if final.length == 0 || final.length == "undefined"
            res.send 'There are currently no trending news items.'
        else
            i = 0
            #while i < "#{post_limit}"
                #res.send "#{reddit_baseurl}" + final[i].commentLink
                #i++
                
            for row in final
                res.send "#{reddit_baseurl}" + final[i].commentLink
                i++