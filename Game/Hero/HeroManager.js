const { PacketMaker } = require('../../Connection/Packets/PacketMaker');
const { MapManager } = require('../Map/MapManager');

let HeroManager = {
  packetADelegator: function(socket, params){
      let header = params.shift();
      switch(header){
        case "SET":
          HeroManager.settings(socket, params);
          break;
        default:
          console.log(header);
          break;
      }
  },

  packetSDelegator: function(socket, params){
      let header = params.shift();
      switch(header){
        case "CFG":
          HeroManager.changeConfig(socket, params[0]);
          break;
        default:
          console.log(header);
          break;
      }
  },

  login: function(socket, params){
    socket.darkorbit = {};
    socket.darkorbit.hero = {};
    socket.darkorbit.hero.id = params[0];
    socket.darkorbit.hero.sid = params[1];
    socket.darkorbit.hero.title = "";

    socket.darkorbit.hero.hp = 256000;
    socket.darkorbit.hero.maxHp = 256000;
    socket.darkorbit.hero.invisible = 0;

    socket.darkorbit.hero.position = {mapId: 0, x: 0, y: 0};

    socket.darkorbit.hero.selectedLaser = 1;
    socket.darkorbit.hero.selectedRocket = 1;
    socket.darkorbit.hero.currentConfig = 1;
    socket.darkorbit.hero.canChangeConfig = true;
    socket.darkorbit.hero.isUnderAttack = false;

    socket.darkorbit.settings = [];
    socket.darkorbit.ammo = [];
    socket.darkorbit.rockets = [];
    socket.darkorbit.drones = [];
    socket.darkorbit.confings = [{shield: 100000, maxShield: 500000, speed: 500, minDamage: 10000, maxDamage: 20000}, {shield: 1000, maxShield: 10000, speed: 800, minDamage: 20000, maxDamage: 50000}];

    HeroManager.settings(socket, [1,1,1,1,1,1,1,1,1,1,1,0,0,1,1,1,1,1,1,1,1,1,1,1,1]);
    HeroManager.init(socket, null);
    HeroManager.updateAmmo(socket, [10000,10000,10000,10000,10000]);
    HeroManager.updateRockets(socket, [10000,10000,10000,10000,10000,10000]);
    HeroManager.updateDrones(socket, [0,8]);
    HeroManager.updateTitle(socket, "title_1");
    MapManager.updateMapAtLogin(socket, [1, 10000, 10000]);

  },

  ping: function(socket){
    console.log(socket.darkorbit);
  },

  settings: function(socket, params, fromLogin){
    if (socket.darkorbit.settings != params){
      //TODO: Save new settings to DB!

      socket.darkorbit.settings = params;
    }

    let packetMaker = new PacketMaker('A');
    packetMaker.addParam('SET');
    for(let i=0;i<params.length;i++){
      packetMaker.addParam(params[i]);
    }

    socket.send(packetMaker.makeGamePacket());
  },

  init: function(socket, params){
    let map = 1;
    if(params){
      map = params.newMap;
    }

    let configForArray = socket.darkorbit.hero.currentConfig-1;


    //TODO: In the future use params (data of user from DB)
    let packetMaker = new PacketMaker('I');
    packetMaker.addParam(1); //userId
    packetMaker.addParam('Nommo'); //userName
    packetMaker.addParam(10); //shipId
    packetMaker.addParam(socket.darkorbit.confings[configForArray].speed); //speed
    packetMaker.addParam(socket.darkorbit.confings[configForArray].shield); //shield
    packetMaker.addParam(socket.darkorbit.confings[configForArray].maxShield); //maxShield
    packetMaker.addParam(socket.darkorbit.hero.hp); //hp
    packetMaker.addParam(socket.darkorbit.hero.maxHp); //maxHp
    packetMaker.addParam(2000); //cargo
    packetMaker.addParam(2000); //maxCargo
    packetMaker.addParam(10000); //xPos
    packetMaker.addParam(10000); //yPos
    packetMaker.addParam(map); //mapId
    packetMaker.addParam(1); //company
    packetMaker.addParam(1); //clanId
    packetMaker.addParam(32000); //maxLaserAmmo
    packetMaker.addParam(16000); //maxRocketAmmo
    packetMaker.addParam(15); //unknwn
    packetMaker.addParam(666); //unkwn
    packetMaker.addParam(100000000); //expieriance
    packetMaker.addParam(100000); //honor
    packetMaker.addParam(20); //level
    packetMaker.addParam(10000); //credits
    packetMaker.addParam(1000); //uridium
    packetMaker.addParam(10000); //jackpot
    packetMaker.addParam(21); //rank
    packetMaker.addParam('ADM'); //clanTag
    packetMaker.addParam(4); //galaxygatesDone
    packetMaker.addParam(socket.darkorbit.hero.invisible); //invisible

    socket.send(packetMaker.makeGamePacket());
  },

  updateAmmo: function(socket, params){
    if (socket.darkorbit.ammo != params){
      //TODO: Save new ammo status to DB!

      socket.darkorbit.ammo = params;
    }

    let packetMaker = new PacketMaker('B');
    for(let i=0;i<params.length;i++){
      packetMaker.addParam(params[i]);
    }

    socket.send(packetMaker.makeGamePacket());
  },

  updateRockets: function(socket, params){
    if (socket.darkorbit.rockets != params){
      //TODO: Save new rocket status to DB!

      socket.darkorbit.rockets = params;
    }

    let packetMaker = new PacketMaker('3');
    for(let i=0;i<params.length;i++){
      packetMaker.addParam(params[i]);
    }

    socket.send(packetMaker.makeGamePacket());
  },

  updateDrones: function(socket, params){
    if(socket.darkorbit.drones != params){
      socket.darkorbit.drones = params;
    }

    let packetStringParam = params[0] + '/' + params[1];

    let packetMaker = new PacketMaker('n');
    packetMaker.addParam('e');
    packetMaker.addParam(socket.darkorbit.hero.id);
    packetMaker.addParam(packetStringParam);

    socket.send(packetMaker.makeGamePacket());
  },

  updateTitle: function(socket, param){
    if(socket.darkorbit.hero.title != param){
      //TODO: Save new title to DB!

      socket.darkorbit.hero.title = param;
    }

    let packetMaker = new PacketMaker('n');
    packetMaker.addParam('t');
    packetMaker.addParam(socket.darkorbit.hero.id);
    packetMaker.addParam(socket.darkorbit.hero.title);

    socket.send(packetMaker.makeGamePacket());
  },

  updateCargoStatus: function(socket, params){

  },

  selectLaser: function(socket, params){
    let newLaser = parseInt(params[0]);
    if (newLaser <= 0 || newLaser > 6){
      return;
    }
    socket.darkorbit.hero.selectedLaser = newLaser;
  },

  selectRocket: function(socket, params){
    let newRocket = parseInt(params[0]);
    if (newRocket <= 0 || newRocket > 3){
      return;
    }
    socket.darkorbit.hero.selectedRocket = newRocket;
  },

  changeConfig: function(socket, newConfig){
    newConfig = parseInt(newConfig);
    if((newConfig != 1 && newConfig != 2) || socket.darkorbit.hero.currentConfig == newConfig){
      let packetMaker = new PacketMaker('A');
      packetMaker.addParam('STD');
      packetMaker.addParam('You cannot change to that config!');
      socket.send(packetMaker.makeGamePacket());
      return;
    }

    if(!socket.darkorbit.hero.canChangeConfig){
      let packetMaker = new PacketMaker('A');
      packetMaker.addParam('STD');
      packetMaker.addParam('Warning: Configuration can only be changed every 5 seconds.');
      socket.send(packetMaker.makeGamePacket());
    }
    else {
      //TODO: Change values of Shield, MaxShield, Speed, MinDamage, MaxDamage
      let packetMaker = new PacketMaker('S');
      packetMaker.addParam('CFG');
      packetMaker.addParam(newConfig);
      socket.send(packetMaker.makeGamePacket());

      let newConfigForArray = newConfig - 1;

      packetMaker = new PacketMaker('A');
      packetMaker.addParam('v');
      packetMaker.addParam(socket.darkorbit.confings[newConfigForArray].speed);
      socket.send(packetMaker.makeGamePacket());

      packetMaker = new PacketMaker('A');
      packetMaker.addParam('SHD');
      packetMaker.addParam(socket.darkorbit.confings[newConfigForArray].shield);
      packetMaker.addParam(socket.darkorbit.confings[newConfigForArray].maxShield);
      socket.send(packetMaker.makeGamePacket());

      socket.darkorbit.hero.currentConfig = newConfig;
      socket.darkorbit.hero.canChangeConfig = false;

      setTimeout(() => {
        socket.darkorbit.hero.canChangeConfig = true;
      }, 5000);
    }
  }

};

module.exports = { HeroManager };
