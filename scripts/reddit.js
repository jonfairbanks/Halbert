// Description:
//  Gets a list of Top Reddit posts using snoowrap
//
// Dependencies:
//   A Reddit client ID, secret and refresh token
//
// Configuration:
//   Update X, Y and Z
//
// Commands:
//    hal reddit (*) - Get a list of top Reddit posts
'use strict';

var defaultPostLimit = 5; // If you go over 15, the message may become too long
var reddit_base = 'https://www.reddit.com';
var errorMessage = 'It looks like there was an error. :explode: Check the logs.';

var snoowrap = require('snoowrap');
var r = new snoowrap({
    userAgent: 'Reddit via Slack',
    clientId: 'QSzK7-MEGhVnVg',
    clientSecret: '9L5-jmBSjIlqK1A4GO_JRFGKW-I',
    refreshToken: '15920890-6rJ0y_1-shIdMXfkj4NkYZtXU-w'
});

var compare = function(a, b) {
    if (a.upvotes < b.upvotes) {
        return 1;
    }
    if (a.upvotes > b.upvotes) {
        return -1;
    }
    return 0;
};

var numberWithCommas = (x) => {
  var parts = x.toString().split(".");
  parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
  return parts.join(".");
}

function toTitleCase(str)
{
    return str.replace(/\w\S*/g, function(txt){return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();});
}

module.exports = function(robot) {  
    robot.respond(/reddit\b\s?(.*)\b/i, function(msg){      
        if(msg.match[1]){
            var subreddit = msg.match[1];
        }else{
            var subreddit = '';
        }
        
        r.getHot(subreddit).then(output => {
            var temp = {}, i = 1;
            for (let row of Array.from(output)) {
                temp[i] = {
                    title: row.title,
                    subreddit: row.subreddit.display_name,
                    upvotes: row.ups,
                    comments: row.num_comments,
                    permalink: reddit_base + row.permalink
                };
                i++;
            }
            
            // Sort the Array by Upvotes
            var arr = Object.keys(temp).map(function (key) { return temp[key]; });
            var posts = arr.sort(compare);
            //console.log(JSON.stringify(posts, null, ' '));
            
            var resp = '', i = 1;

            while(i <= defaultPostLimit){
                resp = resp + '>' + [i] + '. <' + posts[i].permalink + '|' + posts[i].title + '> (+' + numberWithCommas(posts[i].upvotes) + ' upvotes)'
                if(i != defaultPostLimit) {
                    resp = resp + '\n\n';
                }
                i++;
            }
            
            if(subreddit == ''){
                var finalMessage = '*Today\'s Hot:reddit:Reddit Posts:*\n' + resp;
            }else{
                var link = reddit_base + '/r/' + msg.match[1];
                var finalMessage = '*Today\'s Hot:reddit:Reddit Posts on <' + link + '|/r/' + msg.match[1] + '>:*\n' + resp;
            }
            
            var message = {text: finalMessage, unfurl_links: false};
            msg.send(message);
        });
    });
    
    robot.hear(/\/r\/([^\s/]+)/i, function(msg){
        if(msg.match[1]) {
            var subreddit = msg.match[1];
            var link = reddit_base + '/r/' + subreddit;
            var text = '<' + link + '| /r/' + subreddit + ' on Reddit> :reddit:';
            var finalMsg = {text: text, unfurl_links: false};
            msg.send(finalMsg);   
        }
    });
    
    robot.hear(/\st\/([^\s/]+)/i, function(msg){
        if(msg.match[1]) {
            var subreddit = msg.match[1];
            var link = reddit_base + '/r/' + subreddit;
            var text = '<' + link + '| /r/' + subreddit + ' on Reddit> :reddit:';
            var finalMsg = {text: text, unfurl_links: false};
            msg.send(finalMsg);   
        }
    });
}




