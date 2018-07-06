class GameServer {
  constructor(){
    const flashio = require('flashio');
    const _ = require('underscore');

    const { Logger } = require('./Logger/Logger');
    const { MongoClass } = require('./Database/Mongo');
    const { PacketParser } = require('./Connection/Packets/PacketParser');
    const { Delegator } = require('./Connection/Delegator');

    const { Map } = require('./Classes/Map');

    const { MapManager } = require('./Game/Map/MapManager');

    let logger = new Logger("GAMESERVER");
    let packetParser = new PacketParser();
    let delegator = new Delegator();
    let db = new MongoClass();
    let server = flashio.createServer(8080)

    logger.log('Server started!');

    //Initialize maps
    //TODO: Loop to load all maps from DB and move to separate function!

    MapManager.initMap({id: 1, gates: [{id: 1, x: 18000, y: 12000, toMapId: 2}], base: 1});
    MapManager.initMap({id: 2, gates: [], base: false});

    logger.log('Maps intialized!');

    server.on('connect', (data) => {
      logger.log("NEW CONNECTION FROM : " + data.socket.remoteAddress);
    });

    server.on('data', (object) => {
      logger.log(object.socket.remoteAddress + ": " + object.message);
      let parsed = packetParser.parse(object.message);
      delegator.delegate(object.socket, parsed);
    });

    server.on('end', (socket) => {
      if(MapManager.removeFromMap(socket)){
        logger.log("DC userId: " + socket.darkorbit.hero.id);
      }
      else {
        logger.log("DC FROM POLICY");
      }
    });
  }
}

module.exports = { GameServer };
