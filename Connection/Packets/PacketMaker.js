exports.PacketMaker = class {

  constructor(header){
    this.packetHeader = header;
    this.packetParams = [];
  }

  addParam(param){
    this.packetParams.push(param);
  }

  makeGamePacket(){
    let packet = "0|";
    packet += this.packetHeader;

    for(let i=0;i<this.packetParams.length;i++){
      packet += "|";
      packet += this.packetParams[i];
    }

    //packet += "\0";

    return packet;
  }
};
