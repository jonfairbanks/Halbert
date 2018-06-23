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
            robot.adapter.client.web.reactions.add('sandwich', {channel: msg.message.room, timestamp: msg.message.id}) # Post an emoji on the last receieved message
        else
            msg.send 'You don\'t have permission to do that. :closed_lock_with_key:'
            
    robot.respond /debug/, (msg) ->  
        console.log Object(msg.message)
        
    robot.respond /echo (.*)/, (msg) ->  
        console.log(msg.match[1])
        msg.send msg.match[1]
        
    robot.respond /link/i, (res) ->
        msgResponse =
            "as_user": true,
            "text": "Would you like to play a game?",
            "attachments": [
                {
                    "fallback": "Required plain-text summary of the attachment.",
                    "color": "#36a64f",
                    "pretext": "Optional text that appears above the attachment block",
                    "author_name": "Bobby Tables",
                    "author_link": "http://flickr.com/bobby/",
                    "author_icon": "https://cdn4.iconfinder.com/data/icons/dragon/256/User.png",
                    "title": "Slack API Documentation",
                    "title_link": "https://api.slack.com/",
                    "text": "Optional text that appears within the attachment",
                    "fields": [
                        {
                            "title": "Priority",
                            "value": "High",
                            "short": false
                        }
                    ],
                    "image_url": "https://camo.githubusercontent.com/f8ea5eab7494f955e90f60abc1d13f2ce2c2e540/68747470733a2f2f662e636c6f75642e6769746875622e636f6d2f6173736574732f323037383234352f3235393331332f35653833313336322d386362612d313165322d383435332d6536626439353663383961342e706e67",
                    "thumb_url": "http://example.com/path/to/thumb.png",
                    "footer": "Slack API",
                    "footer_icon": "https://platform.slack-edge.com/img/default_application_icon.png",
                    "ts": 123456789
                }
          ]
        robot.adapter.client.web.chat.postMessage(res.message.room, null, msgResponse)