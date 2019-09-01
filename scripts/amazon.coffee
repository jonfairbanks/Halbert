# Description:
#  Amazon Link Helper
#
# Commands:
#  hubot amazon me X - Search for an item on Amazon
#
# Author:
#  jonfairbanks

amazonBase = 'https://smile.amazon.com/s?k='

toTitleCase = (str) ->
  str.replace /\w\S*/g, (txt) ->
    txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase()

module.exports = (robot) ->          
    robot.respond /amazon me (.*)/i, (msg) ->
        term = toTitleCase(msg.match[1])
        link = amazonBase + term
        text = '<' + link + '|Find ' + term + ' on Amazon>'
        finalMsg = {text: text, unfurl_links: false}
        msg.send finalMsg