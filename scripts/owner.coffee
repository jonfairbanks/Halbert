# Description:
#  Display Hal Ownership and Source Code Details
#
# Commands:
#  hubot owner - shows @hal's owner
#  hubot source code - shows @hal's source code
#
# Configuration:
#  Update your ownership and soruce code details below.
#
# Author:
#  jonfairbanks
#

module.exports = (robot) ->
    robot.respond /owner/i, (res) ->
        res.send '@jonfairbanks'

    robot.respond /source code/i, (res) ->
        res.send 'My Source Code: ```Service File: https://github.com/jonfairbanks/Hubot-as-a-Service\nHalbert Code: https://github.com/jonfairbanks/Halbert\nHalbert Docker: https://hub.docker.com/r/jonfairbanks/halbert```'