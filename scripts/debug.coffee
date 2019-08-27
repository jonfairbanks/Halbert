# Description:
#  Just a bunch o' stuff...
#
# Commands:
#  hubot test - run this test script
#
# Author:
#  jonfairbanks

module.exports = (robot) ->
  robot.respond /(.*) make me a sandwich/i, (msg) ->
    query = msg.match[1].toUpperCase()
    if query == 'SUDO'
      msg.reply ':sandwich:'
      robot.adapter.client.web.reactions.add('sandwich', {channel: msg.message.room, timestamp: msg.message.id}) # Post an emoji on the last receieved message     ------     BROKEN!!!
    else
      msg.send 'You don\'t have permission to do that. :closed_lock_with_key:'

  robot.respond /debug/, (msg) ->
    console.log Object(msg.message)
    msg.send '```' + JSON.stringify(msg.message, null, ' ') + '```'