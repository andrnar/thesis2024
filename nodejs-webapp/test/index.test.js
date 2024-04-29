const chai = require('chai');
const chaiHttp = require('chai-http');

const app = require('../index');

chai.use(chaiHttp);

const expect = chai.expect;

describe('Simple Node.js Web App', () => {
  it('should return 200 OK when accessing the homepage', (done) => {
    chai.request(app)
      .get('/')
      .end((err, res) => {
        expect(res).to.have.status(200);
        done();
      });
  });
});
