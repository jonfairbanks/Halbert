# Description:
#   Greet Slack users
#   Version 1.0 - Initial Release
#   
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#	None
#
# Author:
#   jonfairbanks

enterReplies = ['Hi', 'Yo yo yo.', 'What\'s up?', 'Hello friend.', 'Sup', 'Eyyyy']
leaveReplies = ['He gone.', 'Target lost', 'Later!', 'Peace Out', 'GTFO']

module.exports = (robot) ->
  robot.enter (res) ->
    res.send res.random enterReplies
  robot.leave (res) ->
    res.send res.random leaveReplies
