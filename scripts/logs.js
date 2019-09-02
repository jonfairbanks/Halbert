// Description:
//  Log Uploader - Uploads Hubot's Logs to Slack for Review
//
// Dependencies:
//   None
//
// Configuration:
//   Pass a valid environment variable for:
//   - HUBOT_LOG_FILE_PATH -- Where is the file you want to upload to Slack?
//   - HUBOT_LOG_TITLE -- What should the log be titled once uploaded?
//
// Commands:
//
//

const filePath = process.env.HUBOT_LOG_FILE_PATH || '/home/jonfairbanks/Logs/hubot.log'; // Special characters need to be escaped! (Ex: \/var\/log\/syslog)

const fs = require('fs');
const { WebClient } = require('@slack/web-api');

const token = process.env.HUBOT_SLACK_TOKEN;
let streamOpts = null;

const web = new WebClient(token);

module.exports = function (robot) {
  robot.respond(/logs/i, (msg) => {
    if (msg.message.user.slack.is_admin !== true) {
      msg.send('You don\'t have permission to do that. :closed_lock_with_key:');
    } else {
      streamOpts = {
        file: fs.createReadStream(filePath),
        channels: msg.message.room,
        title: process.env.HUBOT_LOG_TITLE || 'Hubot Logs',
      };

      web.files.upload(streamOpts, (err, res) => { // eslint-disable-line no-unused-vars
        if (err) {
          msg.send(`\`\`\`${err}\`\`\``);
        } else {
          // console.log(res); // Uncomment to see API response
        }
      });
    }
  });
};