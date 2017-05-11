var casper = require('casper').create();
var system = require('system');

// Enviroment variables
var ckEmail = system.env.ck_email;
var ckPass = system.env.ck_password;
var ifEventName = system.env.if_event_name || 'credit_karma';
var ifKey = system.env.if_key;

casper.start('https://www.creditkarma.ca/login/', function(){
  this.echo('Started')
});

casper.waitForSelector('form#login', function() {
  this.echo('Filling form')

  this.fill('form#login', {
    'emailAddress' : ckEmail,
    'password' : ckPass,
  }, true);

});

casper.waitForSelector('.ca-dashboard-root', function(){
  this.echo('Dashboard found')
  var REPORT = casper.evaluate(function() { return REPORT; });
  //require('utils').dump(REPORT);

  this.echo('Credit Score: '+REPORT.creditScore.score, 'INFO');

  // Post to IFTTT
  if(ifEventName && ifKey){
    this.open('https://maker.ifttt.com/trigger/'+ifEventName+'/with/key/'+ifKey, {
      method: 'post',
      headers: {
        'Content-Type': 'application/json; charset=utf-8'
      },
      data: {
        'value1': REPORT.creditScore.score,
        'value2': REPORT.creditScore.scoreRating,
        'value3': REPORT.creditScore.datePulled,
      }
    }).then(function() {
        this.echo('IFTTT\'d it.');
    });
  }

});

casper.run();