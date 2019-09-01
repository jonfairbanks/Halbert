const co     = require('co');
const chaiHttp = require('chai-http');
const expect = require('chai').expect;
const Helper = require('hubot-test-helper');

const helper = new Helper('../scripts/amazon.coffee');
expect.use(chaiHttp);

describe('Amazon helper', function() {
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
      expect.request(app)
      .put('/user/me')
      .send({ password: '123', confirmPassword: '123' })
      .end(function (err, res) {
        expect(err).to.be.null;
        expect(res).to.have.status(200);
      });
    });
  });
});