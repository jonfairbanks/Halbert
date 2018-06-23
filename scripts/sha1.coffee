# Description:
#  Just a bunch o' stuff...
#
# Commands:
#  hubot test - run this test script
#
# Author:
#  jonfairbanks

secretKey = 'ThisIsMyTestKey123'
CryptoJS = require("crypto-js");

module.exports = (robot) ->   
    robot.respond /encode (.*)/i, (msg) ->
        ciphertext = CryptoJS.SHA1(msg.match[1]).toString();
        console.log(ciphertext)
        msg.send '```' + ciphertext + '```'