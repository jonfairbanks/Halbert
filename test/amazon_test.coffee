const co     = require('co');
const expect = require('chai').expect;
const Helper = require('hubot-test-helper');

const helper = new Helper('../scripts/amazon.coffee');

describe('amazon', function() {
  beforeEach(function() {
    this.room = helper.createRoom();
  });
  afterEach(function() {
    this.room.destroy();
  });

  context('user requests Amazon link', function() {
    beforeEach(function() {
      return co(function*() {
        yield this.room.user.say('goldfinger', '@hubot amazon me golf balls');
      }.bind(this));
    });

    it('should give link to user', function() {
      expect(this.room.messages).to.eql([
        ['goldfinger', '@hubot amazon me golf balls'],
        ['hubot', {
            "text": "<https://smile.amazon.com/s?k=Golf Balls|Find Golf Balls on Amazon>",
            "unfurl_links": false
        }]
      ]);
    });
  });
});