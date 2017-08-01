# Description:
#   When you get some bad news sometimes you got to let it out.
#   Version 2.0 - Fixed Image Sources
#   
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#
# Author:
#   jonfairbanks

sheits = [
  "http://i.imgur.com/nv9hR03.gifv",
  "https://www.youtube.com/watch?v=l1dnqKGuezo",
  "http://www.reactiongifs.com/r/2013/11/The-Wire-SHIT-Clay-Davis.gif",
  "http://img.pandawhale.com/post-29949-Clay-Davis-SHIT-gif-Imgur-eTgm.gif",
  "http://img.pandawhale.com/89754-SHEEIT-gif-Clay-Davis-The-Wire-R90q.gif",
  "http://img.pandawhale.com/84964-Clay-Davis-SHEEIT-meme-demotiv-ejWX.jpeg"
]

module.exports = (robot) ->
  robot.hear /Sh(e+)(i+)(t+)|sh(e+)(i+)(t+)/i, (msg) ->
    msg.send msg.random sheits
