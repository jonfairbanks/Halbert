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
#   hal radar <state> - returns current radar for the requested state (US, CA, IA, NE, SD supported at this time)

# There has to be a better way to get these
images = {
    US: "https://icons.wxug.com/data/weather-maps/radar/united-states/united-states-current-radar-animation.gif",
    CA: "https://icons.wxug.com/data/weather-maps/radar/united-states/bakersfield-california-region-current-radar-animation.gif",
    IA: "https://icons.wxug.com/data/weather-maps/radar/united-states/des-moines-iowa-region-current-radar-animation.gif",
    NE: "https://icons.wxug.com/data/weather-maps/radar/united-states/north-platte-nebraska-region-current-radar-animation.gif",
    SD: "https://icons.wxug.com/data/weather-maps/radar/united-states/pierre-south-dakota-region-current-radar-animation.gif"
}

module.exports = (robot) ->             
    robot.respond /radar\b\s?(.*)\b/i, (msg) ->
        if(msg.match[1])
            type = msg.match[1].toUpperCase()
        else
            type = 'US'
            
        if(type == "US" || type == "CA" || type == "IA" || type == "NE" || type == "SD")
            finalMsg = images[type]
        else
            finalMsg = "Sorry but I am not aware of a radar source for them. If you know of one, please let me know in #hal-feedback."

        msg.send finalMsg