# Description:
#  Cryptocurrency Price Checker
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hal <symbol> price - returns current price and hourly percentage change for your coin from CoinMarketCap

webcap = require('webcap');
request = require('request');
fs = require('fs');
html2canvas = require('html2canvas');

module.exports = (robot) ->
    round = (value, exp) ->
      if typeof exp == 'undefined' or +exp == 0
        return Math.round(value)
      value = +value
      exp = +exp
      if isNaN(value) or !(typeof exp == 'number' and exp % 1 == 0)
        return NaN
      # Shift
      value = value.toString().split('e')
      value = Math.round(+(value[0] + 'e' + (if value[1] then +value[1] + exp else exp)))
      # Shift back
      value = value.toString().split('e')
      +(value[0] + 'e' + (if value[1] then +value[1] - exp else -exp))

    robot.respond /(.*) price/i, (msg) ->
        #msg.send "```" + JSON.stringify(msg.message, null, " ") + "```" # Enable to debug the incoming message
        query = msg.match[1]
        symbol = query.toUpperCase()
        url = "https://api.coinmarketcap.com/v1/ticker/?limit=150"
        msg.http(url).headers(Accept: "application/json").get() (err, res, body) ->
            unless res.statusCode is 200
                msg.send "The CoinMarketCap API did not return a proper response! :rage5:"
                return
            res = JSON.parse body

            coin = {}
            for row in res
              coin[row.symbol] = {
                name: row.name,
                price_usd: round(row.price_usd, 2),
                change_1hr: row.percent_change_1h,
                change_24hr: row.percent_change_24h
              }

            if coin[symbol] == undefined
              msg.send "There was a problem. :explode: Did you use the symbol? Is it in CoinMarketCap's Top 150?"
            else
              msg.send "*" + coin[symbol].name + " ("+ symbol + ")*" +
              "\nPrice (USD): $" + coin[symbol].price_usd +
              "\n1hr Change: " + coin[symbol].change_1hr + "%" +
              "\n24hr Change: " + coin[symbol].change_24hr + "%"

    robot.respond /(.*) chart/i, (msg) ->
      if(webcap == undefined)
        msg.send("We were unable to load the chart at this time.")
      else
        msg.send("Let me check...")
        query = msg.match[1]
        channel = msg.message.rawMessage.channel
        symbol = query.toUpperCase()
        file = "temp/" + symbol + ".png"
        chart_url = "http://www.cryptocurrencychart.com/coin/" + symbol
        api_url = "https://slack.com/api/files.upload"
        token = process.env.HUBOT_SLACK_TOKEN

        webcap chart_url, file, options, (err) ->
          try
           options =
              method: 'POST'
              url: api_url
              headers:
                'cache-control': 'no-cache'
                'content-type': 'multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW'
              formData:
                token: token
                file:
                  value: fs.createReadStream(file)
                  options:
                    filename: symbol + "_" + Date.now() + ".png"
                    contentType: null
                channels: channel
                title: symbol + ' Chart'
            request options, (error, response, body) ->
              if error
                throw new Error(error)
          catch error
            console.log(error)
            msg.send("Error: Unable to attach the chart image. Please check the logs. :explode:")
