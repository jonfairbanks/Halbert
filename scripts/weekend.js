// Description:
//  Weekend Detector - Sample Hubot Script Written in JS
//
// Dependencies:
//   None
//
// Configuration:
//   None
//
// Commands:
//   hubot is it the weekend? - should we get excited yet?
//

module.exports = function (robot) {
  robot.hear(/is it the weekend\s?\?/i, (msg) => {
    const today = new Date();
    msg.send(today.getDay() === 0 || today.getDay() === 6 ? 'Yep! :awyeah:' : 'No. Get back to work... :disappointed:');
  });
};
