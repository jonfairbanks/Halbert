# Description:
#   Always Listening...
#   
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Author:
#   jonfairbanks

module.exports = (robot) ->
  robot.hear /Larry|larry|Curb|curb/i, (msg) ->
    robot.adapter.client.web.reactions.add('curb', {channel: msg.message.room, timestamp: msg.message.id})
    
  robot.hear /(?:^|\W)skype(?:$|\W)/i, (msg) ->
    robot.adapter.client.web.reactions.add('-1', {channel: msg.message.room, timestamp: msg.message.id})
