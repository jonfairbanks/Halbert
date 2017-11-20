# Description:
#  Get a quote from NBC's The Office
#
# Commands:
#  hubot I need an Office quote - share a random quote from The Office
#
# Author:
#  jonfairbanks

quote_source = 'https://raw.githubusercontent.com/jonfairbanks/the-office-quotes/master/src/quotes/all.json'

sendMsg = (res, body) ->
  # ** Get/Parse the Quote Data **
  data = JSON.parse body
  #console.log(JSON.stringify(data)) # Enable for Debugging

  # ** Find and Build a Random Quote **
  length = data.length
  rand = Math.floor(Math.random() * length)
  msg = ">" + data[rand].quote + " - _" + data[rand].name + "_"

  # ** Send It! **
  res.send msg

module.exports = (robot) ->
  robot.respond /i need an office quote?$/i, (res) ->
    robot.http("#{quote_source}").get() (err, response, body) ->
      if err
        res.send "There was an error: ```" + err + "```"
      sendMsg res, body
