// Description:
//  Responds to the user with the current time.
//
// Dependencies:
//   Moment-Timezone pre-installed: npm install npm-timezone --save
//
// Configuration:
//   Update defaultTZ below to reflect your timezone:
//
// Commands:
//    hal what time is it - Displays the current time

var defaultTZ = 'America/Los_Angeles';

var moment = require('moment-timezone');

module.exports = function(robot) {  
    robot.respond(/time\s?(.*)/i, function(msg){
        if(msg.match[1]){
            var reqTZ = msg.match[1];
            var h = moment.tz(reqTZ).format('h');
            var m = moment.tz(reqTZ).format('mm');
            
            var icon = ':clock' + h;
            if(m >= 30){
                icon = icon + '30:';
            }else{
                icon = icon + ':';
            }
            
            msg.send('The time in ' + reqTZ + ' is currently ' + moment.tz(reqTZ).format('h:mma z') + '. ' + icon);
        }else{
            var h = moment.tz(msg.message.rawMessage.user.tz).format('h');
            var m = moment.tz(msg.message.rawMessage.user.tz).format('mm');
            
            var icon = ':clock' + h;
            if(m >= 30){
                icon = icon + '30:';
            }else{
                icon = icon + ':';
            }
            
            msg.send('Local time is currently ' + moment.tz(msg.message.rawMessage.user.tz).format('h:mma (z)') + '. ' + icon);
        }
    });
}