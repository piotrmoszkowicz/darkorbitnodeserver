class Logger {
  constructor(parent){
    this.moment = require('moment');
    this.parent = parent;

    this.moment.locale('pl');
  }

  log(message){
    let date = this.moment().format('D/M/YYYY H:mm:ss');
    let strMsg = '[' + date + '][' + this.parent + ']'
    if (typeof message === 'object'){
      console.log(strMsg, message);
    }
    else {
      console.log(strMsg + message);
    }
  }
}

module.exports = { Logger }
