// Description:
//  Holiday Detector - Sample Hubot Script Written in JS
//
// Dependencies:
//   None
//
// Configuration:
//   None
//
// Commands:
//   hal is it the weekend?  - returns whether it is the weekend or not

module.exports = function(robot) {
    robot.hear(/is it the weekend\s?\?/i, function(msg){
        var today = new Date();
        msg.send(today.getDay() === 0 || today.getDay() === 6 ? "Yep! :awyeah:" : "No. Get back to work... :disappointed:");
    });
}
