# Description:
#   When you get some bad news sometimes you got to let it out.
#   
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#
#
# Author:
#   jonfairbanks

sheits = [
  "https://www.youtube.com/watch?v=l1dnqKGuezo",
  "https://i.imgur.com/MO3d7A5.gif",
  "https://i.imgur.com/NgIqbgy.gifv",
  "https://i.imgur.com/8qnpIO6.gifv",
  "https://i.imgur.com/W1Mrt4j.gifv",
  "https://i.imgur.com/ZA8y1Li.gifv",
  "https://i.imgur.com/2y2lohe.gif",
  "https://i.imgur.com/mLOXTGA.gif",
  "https://i.imgur.com/J2t4fkQ.gifv",
  "https://i.imgur.com/BtbaJiK.gifv"
]

module.exports = (robot) ->
  robot.hear /Sh(e+)(i+)(t+)|sh(e+)(i+)(t+)/i, (msg) ->
    msg.send msg.random sheits
