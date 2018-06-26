# Description:
#   Random test scripts. Can likely be deleted.
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

module.exports = (robot) ->
   robot.respond /isthereanydeal (.*)/i, (res) ->
     query = res.match[1].split(' ').join('+')
     url = 'https://isthereanydeal.com/search/?q=' + query +
     res.send "#{url}"

   robot.respond /where u at/i, (res) ->
     res.send "fairbanks.io :parrot:"