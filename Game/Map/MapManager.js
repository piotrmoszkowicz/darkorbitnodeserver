const _ = require('underscore');

const { PacketMaker } = require('../../Connection/Packets/PacketMaker');
const { Map } = require('../../Classes/Map');

let MapManager = {
  mapList: [],
  initMap: function(mapObject){
    this.mapList.push(new Map(mapObject));
  },

  sendGates: function(socket, mapId){
    let map = _.findWhere(this.mapList, {mapId: mapId});
    for(let i=0;i<map.gates.length;i++){
      let packetMaker = new PacketMaker('p');
      packetMaker.addParam(map.gates[i].id); //gateId
      packetMaker.addParam(1); //gateType (visual)
      packetMaker.addParam(map.gates[i].toMapId); //newMapId (possibly newGateId, idk :<)
      packetMaker.addParam(map.gates[i].x); //gateX
      packetMaker.addParam(map.gates[i].y); //gateT
      socket.send(packetMaker.makeGamePacket());
    }
  },

  sendBases: function(socket, mapId){
    let map = _.findWhere(this.mapList, {mapId: mapId});
    if(map.base){
      let packetMaker = new PacketMaker('s');
      if (map.base === 1){
        //MMO
        packetMaker.addParam(0); //stationId
        packetMaker.addParam(1); //nothing XD
        packetMaker.addParam('redStation'); //stationName
        packetMaker.addParam(1); //companyId
        packetMaker.addParam(0); //keepEmpty
        packetMaker.addParam(1000); //stationX
        packetMaker.addParam(1000); //stationY
      }
      else if (map.base === 2){
        //EIC
        packetMaker.addParam(0); //stationId
        packetMaker.addParam(1); //nothing XD
        packetMaker.addParam('blueStation'); //stationName
        packetMaker.addParam(2); //companyId
        packetMaker.addParam(0); //keepEmpty
        packetMaker.addParam(20500); //stationX
        packetMaker.addParam(1000); //stationY
      }
      else if (map.base === 3){
        //VRU
        packetMaker.addParam(0); //stationId
        packetMaker.addParam(1); //nothing XD
        packetMaker.addParam('greenStation'); //stationName
        packetMaker.addParam(3); //companyId
        packetMaker.addParam(0); //keepEmpty
        packetMaker.addParam(20500); //stationX
        packetMaker.addParam(12500); //stationY
      }
      else {
        return;
      }

      socket.send(packetMaker.makeGamePacket());
    }
  },

  getCloseGate: function(curX, curY, mapId){
    let map = _.findWhere(this.mapList, {mapId: mapId});
    if(map.gates.length === 0){
      return false;
    }

    let result = false;

    for(let i=0;i<map.gates.length;i++){
      let isCloseX = false;
      let isCloseY = false;
      if (curX >= map.gates[i].x - 200 && curX <= map.gates[i].x + 200){
        isCloseX = true;
      }
      if (curY >= map.gates[i].y - 200 && curY <= map.gates[i].y + 200){
        isCloseY = true;
      }
      if(isCloseX && isCloseY){
        result = map.gates[i];
      }
    }

    return result;
  },

  jump: function(socket){
    let curX = socket.darkorbit.hero.position.x;
    let curY = socket.darkorbit.hero.position.y;
    let curMapId = socket.darkorbit.hero.position.mapId;

    //TODO: Make this function while on battleMaps
    /*if(socket.darkorbit.hero.isUnderAttack){
      let packetMaker = new PacketMaker('A');
      packetMaker.addParam('STD');
      packetMaker.addParam('You can\'t jump while beeing under attack!');

      socket.send(packetMaker.makeGamePacket());
      return;
    }*/

    let closeGate = MapManager.getCloseGate(curX, curY, curMapId);
    if(!closeGate){
      let packetMaker = new PacketMaker('A');
      packetMaker.addParam('STD');
      packetMaker.addParam('You are not close enough to the gate! Move your shit fast!');

      socket.send(packetMaker.makeGamePacket());
      return;
    }

    //0|U|curMapId|portalId
    //TODO: Juming process...

  },

  move: function(socket, params){
    //TODO: Moving process
  },

  updateMap: function(socket, newMapId){
    let packetMaker = new PacketMaker('i');
    packetMaker.addParam(newMapId);
    socket.send(packetMaker.makeGamePacket());

    let map = _.findWhere(this.mapList, {mapId: newMapId});
    map.addUser(socket.darkorbit.hero.id);

    this.sendGates(socket, newMapId);
    this.sendBases(socket, newMapId);
  },

  updateMapAtLogin: function(socket, params){
    let positionObject = {mapId: params[0], x: params[1], y: params[2]};
    socket.darkorbit.hero.position = positionObject;

    let map = _.findWhere(this.mapList, {mapId: positionObject.mapId});
    map.addUser(socket.darkorbit.hero.id);

    let packetMaker = new PacketMaker('m');
    packetMaker.addParam(socket.darkorbit.hero.position.mapId);
    packetMaker.addParam(socket.darkorbit.hero.position.x);
    packetMaker.addParam(socket.darkorbit.hero.position.y);
    socket.send(packetMaker.makeGamePacket());

    this.sendGates(socket, socket.darkorbit.hero.position.mapId);
    this.sendBases(socket, socket.darkorbit.hero.position.mapId);
  },

  removeFromMap: function(socket){
    if (typeof socket.darkorbit === "object"){
      let map = _.findWhere(this.mapList, {mapId: socket.darkorbit.hero.position.mapId});
      if (!map){
        return false;
      }
      map.delUser(socket.darkorbit.hero.id);
      return true;
    }
    return false
  }
};

module.exports = { MapManager };
