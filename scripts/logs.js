// Description:
//  Log Uploader - Uploads Hubot's Logs to Slack for Review
//
// Dependencies:
//   None
//
// Configuration:
//   Update filePath, displayName and mySlackUsername variables below. 
//
// Commands:
//   hal logs - upload a copy of the pre-defined log file

var filePath = '\/home\/jonfairbanks\/Logs\/hubot.log'; // Special characters need to be escaped! (Ex: \/var\/log\/syslog)
var displayName = 'Halbert Logs';
var mySlackUsername = 'jonfairbanks';

var fs = require('fs');
var WebClient = require('@slack/client').WebClient;
var token = process.env.HUBOT_SLACK_TOKEN;
var streamOpts = null;

var web = new WebClient(token);

module.exports = function(robot) {
    robot.respond(/logs/i, function(msg){
        if(msg.message.user.is_admin != true) {
            msg.send('You don\'t have permission to do that. :closed_lock_with_key:');
        }else {
            var streamOpts = {
                file: fs.createReadStream(filePath),
                channels: msg.message.room,
                title: displayName
            };
            
            web.files.upload(displayName, streamOpts, function(err, res) {
                if (err) {
                    msg.send('```' + err + '```');
                } else {
                    //console.log(res); // Uncomment to see API response
                }
            });
        }
    });
}