# Description:
#  Save quick notes in Hal's Redis brain :)
#
# Commands:
#  hubot save X as Y - Save a quick note into Hal's brain
#  hubot load X - Load a previous note from Hal's brain
#  hubot delete X - Delete a previous note from Hal's brain
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
            msg.send "Sorry, I got nothin'. :thinky:"
        
    robot.respond /remove (.*)/i, (msg) ->
        query = msg.match[1]
        upper = query.toUpperCase()
        robot.brain.set(upper, null)
        msg.send 'Ok, I deleted the `' + msg.match[1] + '` entry. :no_entry:'