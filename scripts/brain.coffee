# Description:
#  Just a bunch o' stuff...
#
# Commands:
#  hubot test - run this test script
#
# Author:
#  jonfairbanks

module.exports = (robot) ->   
    robot.respond /save (.*) as (.*)/i, (msg) ->
        robot.brain.set(msg.match[2].toUpperCase(), null)
        robot.brain.set(msg.match[2].toUpperCase(), msg.match[1])
        robot.adapter.client.web.reactions.add('floppy_disk', {channel: msg.message.room, timestamp: msg.message.id})
        
    robot.respond /load (.*)/i, (msg) -> 
        data = robot.brain.get(msg.match[1].toUpperCase())
        if data != null
            msg.send data
        else
            msg.send "Sorry, I got nothin'. :think-hard:"
        
    robot.respond /remove (.*)/i, (msg) ->
        query = msg.match[1]
        upper = query.toUpperCase()
        robot.brain.set(upper, null)
        msg.send 'Ok, I deleted the `' + msg.match[1] + '` entry. :no_entry:' 
        
    robot.respond /brain/i, (msg) -> 
        msg.send "```" + JSON.stringify(robot.brain.data, null, ' ') + "```"