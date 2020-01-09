# Halbert
[![Docker Automated](https://img.shields.io/docker/automated/jonfairbanks/halbert.svg)](https://hub.docker.com/r/jonfairbanks/halbert/)
[![Docker Build](https://img.shields.io/docker/build/jonfairbanks/halbert.svg)](https://hub.docker.com/r/jonfairbanks/halbert/)
[![Docker Pulls](https://img.shields.io/docker/pulls/jonfairbanks/halbert.svg)](https://hub.docker.com/r/jonfairbanks/halbert/)
![GitHub top language](https://img.shields.io/github/languages/top/jonfairbanks/halbert.svg)
![GitHub last commit](https://img.shields.io/github/last-commit/jonfairbanks/halbert.svg)
![License](https://img.shields.io/github/license/jonfairbanks/halbert.svg?style=flat)

A production ready Slackbot written with Hubot
<br>


### Prerequisites
A Slackbot token pre-configured for your team is required. [Checkout the Slack docs for more information](https://api.slack.com/slack-apps).


### Start the Container Headless
If you do not want to connect to the container and just want to run it, use daemon mode with **-d**:

```
(sudo) docker run -d \
-e HUBOT_SLACK_TOKEN=<token> \
-v /logs:/app/logs \
--name halbert jonfairbanks/halbert
```

The `logs/` volume mount can be moved as you see fit, but is required if you want [hubot-chatlog](https://www.npmjs.com/package/hubot-chatlog) files to persist container updates, reboots, etc.

### Pre-installed hubot packages
- [hubot-diagnostics](https://www.npmjs.com/package/hubot-diagnostics)
- [hubot-help](https://www.npmjs.com/package/hubot-help)
- [hubot-maps](https://www.npmjs.com/package/hubot-maps)
- [hubot-redis-brain](https://www.npmjs.com/package/hubot-redis-brain)
- [hubot-uptime](https://www.npmjs.com/package/hubot-uptime)
- [hubot-chatlog](https://www.npmjs.com/package/hubot-chatlog)
- [hubot-xkcd](https://www.npmjs.com/package/hubot-xkcd)
- [hubot-base64](https://www.npmjs.com/package/hubot-base64)
- [hubot-sha1](https://www.npmjs.com/package/hubot-sha1)
- Other experimental scripts can be found in the **scripts/** directory.


### Start and Connect to the Container for Debugging
1) To download, launch and connect to the container: 
`(sudo) docker run -it --name halbert jonfairbanks/halbert '/bin/bash'`
2) Finally, launch the bot within the container: 
`HUBOT_SLACK_TOKEN=<token> ./bin/hubot`


### Viewing Log Output
The output of hubot startup and any console.log() within your scripts is directed to container logs and can be viewed within Docker.

`(sudo) docker logs <container name>`

Unless specifically disabled, halbert also maintains a chatlog for each channel it is invited to. These logs are stored in the path specified on container launch and can also be viewed within Slack using the `chatlog` command.


### Helpful Docker Commands for Removing/Updating Halbert
- To stop the container: `(sudo) docker stop halbert`
- To remove the container: `(sudo) docker rm halbert`
- To list containers: `(sudo) docker ps -a`
- To list images: `(sudo) docker images`
- To remove the old image: `(sudo) docker rmi jonfairbanks/halbert`


### Environment Variables
Additional ENV variables can be passed when starting Docker with the **-e** flag and then accessed within scripts as process.env.ENV_VARIABLE_NAME

`-e ENV_VARIABLE_NAME='My Variable'`


### Exposing Directories
Directories within the Docker container can be exposed to the local machine with the **-v** flag with parameter syntax of <docker path>:<local machine path>.

#### Expose Logs Directory
`-v /app/logs:/hubot/logs`

#### Expose Scripts Directory
`-v /app/scripts:/hubot/scripts`

_Note: exposing the entire /app directory may cause a startup failure_

### Exposing Ports
Docker ports can be exposed to extend functionality, such as with webhooks, using the **-p** flag.

`-p 8080:8080 (<External Port>:<Internal Docker Port>)`

### Adding new packages to Hubot
`docker exec -it halbert npm install hubot-packagename --save`
`docker restart halbert`

Be sure to replace 'hubot-packagename' with the desired package you wish to install.
_When NPM packages are installed with the name that begins with hubot-*, they will be automatically added to the external-scripts.json file._

### Resources
- [Hubot Documentation](https://hubot.github.com/docs/)
- [Slack Developer Kit for Hubot](https://slack.dev/hubot-slack/)
- [Slack API Test](https://api.slack.com/methods/api.test)
- [Testing Hubot Scripts](https://hubot.github.com/docs/scripting/#testing-hubot-scripts)