class PacketParser {
  parse(packetData){
    packetData = packetData.toString().replace('\0', '').replace(/\n/g, '');
    let separators = ['|', '%', '@'];
    let tokens = packetData.split(new RegExp('[' + separators.join('') + ']', 'g'));
    this.packetHeader = tokens[0];
    tokens.shift()
    this.packetParams = tokens;

    return {'header': this.packetHeader, 'params': this.packetParams};
  }
}

module.exports = { PacketParser };
