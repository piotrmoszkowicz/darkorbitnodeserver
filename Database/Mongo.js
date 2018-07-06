class MongoClass {
  constructor(){
    const { Logger } = require('../Logger/Logger');

    this.mongoClient = require('mongodb').MongoClient;
    this.logger = new Logger("MONGODB");

    const url = 'mongodb://localhost:27017/darkorbit';
    let _this = this;

    this.mongoClient.connect(url, function(err, db) {
      if (err){
        _this.logger.log('Error during connection to database!');
        _this.logger.log(err);
        process.exit(1);
      }
      else {
        _this.logger.log("Connected successfully to database!");
        _this.db = db;
      }
    });
  }
}

module.exports = { MongoClass };
