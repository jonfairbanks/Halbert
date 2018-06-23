// Description:
//  Log chats to file for later review.
//
// Dependencies:
//   None
//
// Configuration:
//   Update logsFolder below!

var logsFolder = '\/usr\/src\/hubot\/Logs\/';

var fs = require('fs');
var moment = require('moment-timezone');
var WebClient = require('@slack/client').WebClient;
var token = process.env.HUBOT_SLACK_TOKEN;
var streamOpts = null;

var web = new WebClient(token);

module.exports = function(robot) {
    robot.hear(/(.*)/i, function(msg){
        var messageText = msg.message.rawMessage.text;
        try{
            var userName = (msg.message.rawMessage.user.name) ? msg.message.rawMessage.user.name : "Unknown";
        }catch(err){
            console.log('Error Saving Message to Chat Log: ' + JSON.stringify(msg.message.rawMessage));
            var userName = "Unknown";
        }
        var userID = msg.message.rawMessage.user.id;
        var channelName = msg.message.rawMessage.channel.name;
        var channelID = msg.message.rawMessage.channel.id;
        var ts = moment.tz(msg.message.rawMessage.user.tz).format('h:mm:ssa z');

        var data = ('[' + channelID + '](' + userName + ' in #' + channelName + ' @ ' + ts + ') \n' + messageText + '\n\n');
        var savePath = logsFolder + channelName + '.log';

        fs.appendFile(savePath, data, function (err, msg) {
            if (err) {
                console.log('Error Saving Message to Chat Log: ' + JSON.stringify(msg.message.rawMessage));
                throw err;
            }
        });
    });

    robot.respond(/chatlog/i, function(msg){
        if(msg.message.user.is_admin != true) {
            msg.send('You don\'t have permission to do that. :closed_lock_with_key:');
        }else {
            var filePath = logsFolder + msg.message.rawMessage.channel.name + '.log';
            var streamOpts = {
                file: fs.createReadStream(filePath),
                channels: msg.message.room,
                title: 'Chat Log for #' + msg.message.rawMessage.channel.name
            };

            web.files.upload('Chat Log', streamOpts, function(err, res) {
                if (err) {
                    msg.send('```' + err + '```');
                } else {
                    //console.log(res); // Uncomment to see API response
                }
            });
        }
    });
}