// Description:
//  Log chats to file for later review.
//
// Dependencies:
//   None
//
// Configuration:
//   Update logsFolder below!

let logsFolder = '\/home\/jonfairbanks\/Logs\/slack\/';

let fs = require('fs');
let moment = require('moment-timezone');
let WebClient = require('@slack/client').WebClient;
let token = process.env.HUBOT_SLACK_TOKEN;
let streamOpts = null;

let web = new WebClient(token);

module.exports = function(robot) {
    robot.hear(/(.*)/i, function(msg){
        let ts = moment.tz("America/Los_Angeles").format('h:mm:ssa z');
        let messageText = msg.message.rawMessage.text;
        let userName = "Unknown";
        try{
            userName = (msg.message.rawMessage.user.real_name) ? msg.message.rawMessage.user.real_name : "unknown";
        }catch(err){
            console.log('Error Saving Message to Chat Log: ' + err);
        }
        let userID = msg.message.rawMessage.user.id;
        let channelID = msg.message.rawMessage.channel;
        
        web.channels.info({ channel: channelID })
        .then(msg => {
            if(msg.channel.name.length > 1)
                var channelName = msg.channel.name
                if(channelName) {
                    let data = ('[' + channelID + '](' + userName + ' in #' + channelName + ' @ ' + ts + ') \n' + messageText + '\n\n');
                    let savePath = logsFolder + channelName + '.log';
                    fs.appendFile(savePath, data, function (err, msg) {
                        if (err) {
                            console.log('Error Saving Message to Chat Log: \n');
                            throw err;
                        }
                    });
                }
        })
        .catch(e => { channelName = userName + "-unknown" })
    });

    robot.respond(/chatlog/i, function(msg){
        if(msg.message.user.slack.is_admin != true) {
            msg.send('You don\'t have permission to do that. :closed_lock_with_key:');
        }else {
            console.log(msg.message.rawMessage.channel)
            let channelID = msg.message.rawMessage.channel;
            web.channels.info({ channel: channelID })
            .then(msg => {
                if(msg.channel.name.length > 1) {
                    var channelName = msg.channel.name
                    let filePath = logsFolder + channelName + '.log';
                    let streamOpts = {
                        file: fs.createReadStream(filePath),
                        channels: msg.message.rawMessage.channel,
                        title: 'Chat Log for #' + channelName
                    };
        
                    web.files.upload('Chat Log', streamOpts, function(err, res) {
                        if (err) {
                            msg.send('```' + err + '```');
                        } else {
                            //console.log(res); // Uncomment to see API response
                        }
                    });
                }
            })
            .catch(e => { channelName = userName + "-unknown" })
        }
    });
}
