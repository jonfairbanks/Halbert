// Description:
//  Gets a list of Top Reddit posts using snoowrap
//
// Dependencies:
//   A Reddit client ID, secret and refresh token
//
// Configuration:
//   Pass a valid environment variable for:
//   - HUBOT_REDDIT_CLIENT_ID
//   - HUBOT_REDDIT_CLIENT_SECRET
//   - HUBOT_REDDIT_REFRESH_TOKEN
//
//   Optional env variables:
//   - HUBOT_REDDIT_POST_LIMIT: How many posts should Reddit display?
//   - HUBOT_REDDIT_BASE_URL: Base URL for Reddit
//
// Commands:
//    hubot reddit X - Get a list of top Reddit posts
//


const defaultPostLimit = process.env.HUBOT_REDDIT_POST_LIMIT || 5; // If you go over 15, the message may become too long
const reddit_base = process.env.HUBOT_REDDIT_BASE_URL || 'https://www.reddit.com';
const errorMessage = 'It looks like there was an error. :explode: Check the logs.';

const snoowrap = require('snoowrap');

const r = new snoowrap({
  userAgent: process.env.HUBOT_REDDIT_USER_AGENT || 'Reddit via Slack',
  clientId: process.env.HUBOT_REDDIT_CLIENT_ID || null,
  clientSecret: process.env.HUBOT_REDDIT_CLIENT_SECRET || null,
  refreshToken: process.env.HUBOT_REDDIT_REFRESH_TOKEN || null,
});

const compare = function (a, b) {
  if (a.upvotes < b.upvotes) {
    return 1;
  }
  if (a.upvotes > b.upvotes) {
    return -1;
  }
  return 0;
};

const numberWithCommas = (x) => {
  const parts = x.toString().split('.');
  parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ',');
  return parts.join('.');
};

function toTitleCase(str) {
  return str.replace(/\w\S*/g, (txt) => txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase());
}

module.exports = function (robot) {
  robot.respond(/reddit\b\s?(.*)\b/i, (msg) => {
    if (msg.match[1]) {
      var subreddit = msg.match[1];
    } else {
      var subreddit = '';
    }

    r.getHot(subreddit).then((output) => {
      const temp = {}; var
        i = 1;
      for (const row of Array.from(output)) {
        temp[i] = {
          title: row.title,
          subreddit: row.subreddit.display_name,
          upvotes: row.ups,
          comments: row.num_comments,
          permalink: reddit_base + row.permalink,
        };
        i++;
      }

      // Sort the Array by Upvotes
      const arr = Object.keys(temp).map((key) => temp[key]);
      const posts = arr.sort(compare);
      // console.log(JSON.stringify(posts, null, ' '));

      let resp = ''; var
        i = 1;

      while (i <= defaultPostLimit) {
        resp = `${resp}>${[i]}. <${posts[i].permalink}|${posts[i].title}> (+${numberWithCommas(posts[i].upvotes)} upvotes)`;
        if (i != defaultPostLimit) {
          resp = `${resp}\n\n`;
        }
        i++;
      }

      if (subreddit == '') {
        var finalMessage = `*Today's Hot:reddit:Reddit Posts:*\n${resp}`;
      } else {
        const link = `${reddit_base}/r/${msg.match[1]}`;
        var finalMessage = `*Today's Hot:reddit:Reddit Posts on <${link}|/r/${msg.match[1]}>:*\n${resp}`;
      }

      const message = { text: finalMessage, unfurl_links: false };
      msg.send(message);
    });
  });

  robot.hear(/\/r\/([^\s/]+)/i, (msg) => {
    if (msg.match[1]) {
      const subreddit = msg.match[1];
      const link = `${reddit_base}/r/${subreddit}`;
      const text = `<${link}| /r/${subreddit} on Reddit> :reddit:`;
      const finalMsg = { text, unfurl_links: false };
      msg.send(finalMsg);
    }
  });
};
