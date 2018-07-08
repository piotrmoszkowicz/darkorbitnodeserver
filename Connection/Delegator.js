class Delegator {
  constructor(){
    this.delegationArray = [];

    this.userDelegations();
    this.mapDelegations();
  }

  userDelegations(){
    const { HeroManager } = require('../Game/Hero/HeroManager');

    this.delegationArray.push(this.returnDelegationObject('LOGIN', HeroManager.login, true));
    this.delegationArray.push(this.returnDelegationObject('PNG', HeroManager.ping, false));
    this.delegationArray.push(this.returnDelegationObject('A', HeroManager.packetADelegator, true));
    this.delegationArray.push(this.returnDelegationObject('S', HeroManager.packetSDelegator, true));
    this.delegationArray.push(this.returnDelegationObject('u', HeroManager.selectLaser, true));
    this.delegationArray.push(this.returnDelegationObject('d', HeroManager.selectRocket, true));
  }

  mapDelegations(){
    const { MapManager } = require('../Game/Map/MapManager');

    this.delegationArray.push(this.returnDelegationObject('1', MapManager.move, true));
    this.delegationArray.push(this.returnDelegationObject('j', MapManager.jump, true));
  }

  returnDelegationObject(header, handler, needArgs){
    return {'header': header, 'handler': handler, 'needArgs': needArgs};
  }

  delegate(socket, packetObject){
    for(let i=0;i<this.delegationArray.length;i++){
      if(packetObject.header === this.delegationArray[i].header){
        if (this.delegationArray[i].needArgs){
          this.delegationArray[i].handler(socket, packetObject.params);
        }
        else {
          this.delegationArray[i].handler(socket);
        }
      }
    }
  }
}

module.exports = { Delegator };
