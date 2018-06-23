# Description:
#  Cryptocurrency Price Checker - Bitcoin
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hal btc historical - returns last year's price for BTC from Coinbase

module.exports = (robot) ->
    robot.respond /btc historical/i, (msg) ->
        d = new Date();
        date = (d.getFullYear()-1) + "-" + ("0"+(d.getMonth()+1)).slice(-2) + "-" + ("0" + d.getDate()).slice(-2);
        url = "https://api.coinbase.com/v2/prices/BTC-USD/spot?date=" + date

        msg.http(url).headers(Accept: "application/json").get() (err, res, body) ->
            unless res.statusCode is 200
                msg.send "The Coinbase API did not return a proper response! :coinbase-enfuego:"
                return
            json = JSON.parse body
            msg.send "*Last Year's Bitcoin Price:* $" + json.data.amount + " " + json.data.currency
