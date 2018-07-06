class ChatServer {
  constructor(){
    const flashio = require('flashio');

    const server = flashio.createServer(9338);

    const { Logger } = require('./Logger/Logger');
    const { PacketParser } = require('./Connection/Packets/PacketParser');

    let logger = new Logger("CHATSERVER");

    logger.log('Server started!');

    server.on('connect', (data) => {
      //logger.log(data);
    });

    server.on('data', (data) => {
      //logger.log(data);
    });

    server.on('end', (data) => {
      //logger.log("DC");
    });
  }
}

module.exports = { ChatServer };
