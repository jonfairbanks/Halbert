// Description:
//  Clean up some unwanted items in the chat. 
//
// Dependencies:
//   None
//
// Configuration:
//   Update logsFolder below!

var fs = require('fs');
var moment = require('moment-timezone');
var WebClient = require('@slack/client').WebClient;
var token = process.env.HUBOT_SLACK_TOKEN;
var streamOpts = null;

var web = new WebClient(token);

module.exports = function(robot) {    
    robot.hear(/asdf/i, function(msg){
        console.log(JSON.stringify(msg.message, null, ' '));
        var reqOpts = {
            ts: msg.message.id, 
            channel: msg.message.rawMessage.channel.id,
            as_user: true
        };
        console.log(reqOpts);
        web.chat.delete(JSON.stringify(reqOpts), function(error, res) {
            if (error) {
                msg.send('```' + error + '```');          
            } else {
                //console.log(res); // Uncomment to see API response
            }
        });
    });
}