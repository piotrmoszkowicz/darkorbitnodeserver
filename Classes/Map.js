const _ = require('underscore');

exports.Map = class {
  constructor(mapObject){
    this.mapId = mapObject.id;
    this.gates = mapObject.gates;
    this.base = mapObject.base;
    this.users = [];
  }

  addUser(userId){
    this.users.push(userId);
  }

  delUser(userId){
    this.users = _.without(userId, this.users);
  }

};
