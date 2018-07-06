function pushMapToQueue(map_id)
{
   if(!loadedMaps[map_id])
   {
      var _loc2_ = false;
      var _loc1_ = 0;
      while(_loc1_ < mapsQueue.length)
      {
         if(mapsQueue[_loc1_] == map_id)
         {
            _loc2_ = true;
            return undefined;
         }
         _loc1_ = _loc1_ + 1;
      }
      mapsQueue.push(map_id);
   }
}
function pushMapsToQueue(map_list)
{
   if(map_list == undefined)
   {
      return undefined;
   }
   var _loc1_ = 0;
   while(_loc1_ < map_list.length)
   {
      pushMapToQueue(map_list[_loc1_]);
      _loc1_ = _loc1_ + 1;
   }
}
function waiting()
{
   this.onEnterFrame = function()
   {
      if(_root.sid != "" && _root.userID > 0 && _root.mapID > 0)
      {
      }
      _root.updateServerList();
      delete this.onEnterFrame;
   };
}
function updateServerList()
{
   if(_root.server_ip.length > 1)
   {
      getGameserverAddress();
      updateMapQueue();
      return undefined;
   }
   var gsConfigXml = new XML();
   gsConfigXml.ignoreWhite = true;
   var _loc9_ = random(9999999);
   gsConfigXml.load(_root.dynamicHost + "gameserver.es?fID=" + _loc9_);
   gsConfigXml.onLoad = function(success)
   {
      node = 0;
      while(node < gsConfigXml.childNodes.length)
      {
         if(gsConfigXml.childNodes[node].nodeName == "config")
         {
            definedRoot = gsConfigXml.childNodes[node];
            var _loc5_ = 0;
            while(_loc5_ < definedRoot.childNodes.length)
            {
               tmpNode = definedRoot.childNodes[_loc5_].nodeName;
               tmpChildren = definedRoot.childNodes[_loc5_].childNodes;
               if(tmpNode == "routing")
               {
                  var _loc3_ = 0;
                  while(_loc3_ < tmpChildren.length)
                  {
                     var _loc2_ = {};
                     var _loc4_ = tmpChildren[_loc3_].attributes.SVname;
                     _loc2_.SVname = _loc4_;
                     _loc2_.MAParray = [];
                     _loc2_.MAParray = tmpChildren[_loc3_].attributes.MAPrange.split(",");
                     var _loc7_ = _loc2_.MAParray;
                     var _loc6_ = _loc2_.MAParray.length;
                     k = 0;
                     while(k < _loc6_)
                     {
                        _root.server_ip[_loc7_[k]] = _loc4_;
                        k++;
                     }
                     ServertoMap.push(_loc2_);
                     _loc3_ = _loc3_ + 1;
                  }
                  _root.g_gsDataLoaded = true;
               }
               else if(tmpNode == "chat")
               {
                  if(tmpChildren[0].nodeName == "Dchat")
                  {
                     tmpChild = tmpChildren[0];
                     g_chatChannelSuffix = tmpChild.attributes.suffix;
                     _root.projectId = tmpChild.attributes.instance;
                     g_chatChannelBase = tmpChild.attributes.base;
                     _root.g_chatServerName = String(tmpChild.attributes.SVname);
                  }
                  if(tmpChildren[1].nodeName == "global")
                  {
                     globalChildren = tmpChildren[1].childNodes;
                     if(globalChildren[0].nodeName == "host")
                     {
                        _root.chatWebDomain = String(globalChildren[0].firstChild);
                     }
                     if(globalChildren[1].nodeName == "languages")
                     {
                        var _loc8_ = String(globalChildren[1].firstChild);
                        _root.activeChatLang = _loc8_.split(",");
                     }
                     setChatEnvironment();
                  }
               }
               _loc5_ = _loc5_ + 1;
            }
         }
         node++;
      }
      if(_root.g_gsDataLoaded == true)
      {
         getGameserverAddress();
         updateMapQueue();
      }
   };
}
function getGameserverAddress()
{
   if(_root.useLocalGS)
   {
      _root.g_gs_host_ip = _root.localGSHost;
   }
   else
   {
      _root.g_gs_host_ip = _root.server_ip[_root.mapID];
   }
   waitAndStartGame();
}
function updateMapQueue()
{
   if(_root.mapLoadInProgress < 0)
   {
      processMapQueue();
   }
}
function processMapQueue()
{
   if(mapsQueue.length > 0)
   {
      i = 0;
      while(i < mapsQueue.length)
      {
         _root.mapLoadInProgress = mapsQueue.shift();
         if(_root.mapLoadInProgress != undefined)
         {
            loadMap();
            break;
         }
         i++;
      }
   }
}
function loadMap()
{
   var _loc2_ = new Object();
   _loc2_.onLoadComplete = function(target_mc, httpStatus)
   {
      _root.loadedMaps[_root.mapLoadInProgress] = true;
      if(_root.mapLoadInProgress == _root.mapID)
      {
         _root.updateBg();
         _root.loadedBg = true;
         _root.waitAndStartGame();
         _root.pushMapsToQueue(_root.neighbors[_root.mapID]);
      }
      _root.mapLoadInProgress = -1;
      _root.updateMapQueue();
      _root.mcMaploader.txtPct.text = "/";
      _root.mcMaploader._visible = false;
   };
   _loc2_.onLoadInit = function(target_mc)
   {
   };
   _loc2_.onLoadProgress = function(target, loadedBytes, totalBytes)
   {
      var _loc2_ = Math.floor(loadedBytes * 100 / (totalBytes + 0.1));
      _root.mcMaploader.txtPct.text = _loc2_ + "%";
   };
   _loc2_.onLoadError = function(target_mc, errorCode, httpStatus)
   {
   };
   var _loc3_ = new MovieClipLoader();
   _loc3_.addListener(_loc2_);
   _root.progressMovie = "map" + _root.mapLoadInProgress;
   var _loc4_ = _root.createEmptyMovieClip(_root.progressMovie,_root.getNextHighestDepth());
   _loc4_._x = 1000;
   _root.mcMaploader.txtPct.text = "--";
   _root.mcMaploader._visible = true;
   _loc3_.loadClip(_root.staticHost + "swf_global/" + _root.mapLoadInProgress + ".swf",_loc4_);
   _root.checktask = false;
}
function SCAconn()
{
   _root.SCAflag = 1;
}
function doReconnect()
{
   ConnectionID = setInterval(streamConnect,7000);
}
function streamConnect()
{
   var _loc2_ = g_port[random(7)];
   if(_root.useLocalGS)
   {
      if(_root.mapID == 16)
      {
         _loc2_ = 5631;
      }
      else
      {
         _loc2_ = 5001;
      }
   }
   else
   {
      _loc2_ = g_port[random(7)];
   }
   return stream.connect(g_gs_host_ip,_loc2_);
}
function SendtoStream(sendstring)
{
   _root.addOutCmdToGroupDebugUi(sendstring);
   stream.send(sendstring + "\n");
   _root.pingAlive = 0;
}
function pingIt()
{
   if(_root.pingAlive == 1)
   {
      var _loc2_ = "PNG";
      SendtoStream(_loc2_);
   }
   _root.pingAlive = 1;
}
function initGame()
{
   _root.g_CurClientUser = _root.userID;
   g_USER = new Array(g_CurClientUser);
   g_OpponentDATA = new Array();
}
function doConnect(selobj)
{
   _root.failedConnections = _root.failedConnections + 1;
   if(!streamConnect())
   {
      _root.failedConnections = _root.failedConnections + 1;
      g_Connected = false;
   }
   if(_root.failedConnections > 10)
   {
      var _loc2_ = selobj.z;
      clearInterval(_loc2_);
      displayStatus(resource.window_refresh);
      getURL(_root.dynamicHost + "indexInternal.es?action=internalMap","_self");
   }
}
function delayattach()
{
   clearInterval(_root.inv_maploader);
   docopy(_root.mapID);
}
function waitAndStartGame()
{
   if(NEED_BG && !loadedBg)
   {
      return undefined;
   }
   docopy(_root.mapID);
   if(g_Connected == false)
   {
      _root.initGame();
      selfObj = {};
      selfObj.z = 999;
      selfObj.z = setInterval(this,"doConnect",1000,selfObj);
      _root.reconnInterval = selfObj.z;
   }
}
function updateBg()
{
   _root.docopy(_root.mapID);
}
function docopy(map_id)
{
   snapshot = new flash.display.BitmapData(2100,1310,false,0);
   if(_level0["map" + map_id] != undefined)
   {
      _root.mapproxy = false;
      snapshot.draw(_level0["map" + map_id],new flash.geom.Matrix());
   }
   else
   {
      _root.mapproxy = true;
      snapshot.fillRect(new flash.geom.Rectangle(0,0,2100,1310),0);
   }
   var _loc3_ = _level0.nebel.nebelbg.nbg.createEmptyMovieClip("nbg",0);
   _level0.nebel.nebelbg.nbg._x = 1000;
   _level0.nebel.nebelbg.nbg.attachBitmap(snapshot,0);
   _level0.nebel.nebelbg.nbg._x = 0;
   _level0.nebel.nebelbg.nbg._y = 0;
}
function capture()
{
   var _loc9_ = new flash.display.BitmapData(2100,1400,false,0);
   var _loc4_ = HUD.thehud.miniBit.createEmptyMovieClip("bitmap_mc",0);
   var _loc3_ = 1;
   var _loc2_ = 1;
   var _loc5_ = 0;
   var _loc7_ = 0;
   if(_root.mapID == 16 || _root.mapID == 29)
   {
      _loc5_ = 38;
      _loc7_ = 25;
      _loc3_ = 0.03571428571428571;
      _loc2_ = 2;
      _root.nebel.nebelbg.nbg._x = 1050;
      _root.nebel.nebelbg.nbg._y = 660;
   }
   else
   {
      _loc3_ = 0.07142857142857142;
      _root.nebel.nebelbg.nbg._x = 0;
      _root.nebel.nebelbg.nbg._y = 0;
   }
   var _loc6_ = new flash.geom.Matrix();
   _loc6_.scale(_loc3_,_loc3_);
   _loc9_.draw(_root.nebel.nebelbg.nbg,_loc6_);
   var _loc8_ = new flash.display.BitmapData(150 / _loc2_,100 / _loc2_,false,0);
   _loc8_.copyPixels(_loc9_,new flash.geom.Rectangle(0,0,150 / _loc2_,100 / _loc2_),new flash.geom.Point(0,0));
   _loc4_.attachBitmap(_loc8_,0);
   _loc4_._x = _loc5_;
   _loc4_._y = _loc7_;
}
var loadedMaps = new Array();
var mapsQueue = new Array();
_root.neighbors = new Array(29);
_root.neighbors[0] = new Array();
_root.neighbors[0][0] = 0;
_root.neighbors[1] = new Array();
_root.neighbors[1][0] = 2;
_root.neighbors[2] = new Array(1,3,4,16);
_root.neighbors[3] = new Array(2,7,4);
_root.neighbors[4] = new Array(2,3,12,13);
_root.neighbors[5] = new Array();
_root.neighbors[5][0] = 6;
_root.neighbors[6] = new Array(5,7,8,16);
_root.neighbors[7] = new Array(3,6,8);
_root.neighbors[8] = new Array(6,7,11,14);
_root.neighbors[9] = new Array();
_root.neighbors[10] = new Array(9,11,12,16);
_root.neighbors[11] = new Array(8,10,12);
_root.neighbors[12] = new Array(4,10,11);
_root.neighbors[13] = new Array(4,14,15,16);
_root.neighbors[14] = new Array(8,14,15,16);
_root.neighbors[15] = new Array(12,14,15,16);
_root.neighbors[16] = new Array(13,14,15,17,21,25);
_root.neighbors[17] = new Array(16,18,19,29);
_root.neighbors[18] = new Array(17,20);
_root.neighbors[19] = new Array(17,20);
_root.neighbors[20] = new Array(18,19);
_root.neighbors[21] = new Array(16,22,23,29);
_root.neighbors[22] = new Array(21,24);
_root.neighbors[23] = new Array(21,24);
_root.neighbors[24] = new Array(22,23);
_root.neighbors[25] = new Array(16,26,27,29);
_root.neighbors[26] = new Array(25,28);
_root.neighbors[27] = new Array(25,28);
_root.neighbors[28] = new Array(26,27);
_root.neighbors[29] = new Array(17,21,25);
var server_ip = new Array();
var ServertoMap = [];
var pingAlive = 0;
var pingID;
var SCAflag = 0;
g_port = [8080,5555,22222,5001,8084,6667,8000,3389,5631];
g_local = 0;
var ConnectionID;
var g_Connected = false;
var NEED_BG = true;
var bgToCome = true;
var gSHostToCome = true;
var loadedBg = false;
var resolvedGSHost = false;
_root.mcMaploader._visible = false;
var inv_maploader = 0;
var progressMovie = "";
var g_chatChannelSuffix;
var g_chatChannelBase;
var g_chatServerName;
var stream = new XMLSocket();
inde;
waiting();
pushMapToQueue(_root.mapID);
_root.neighborsLoaded = false;
_root.mapLoadInProgress = -1;
stream.onClose = function()
{
   _root.loginSent = false;
   g_Connected = false;
   if(_root.self_kill)
   {
      _root.uebermapDontClick = false;
      _root.generalClean();
      return undefined;
   }
   _root.originMapId = _root.mapID;
   if(_root.SCAflag == 0)
   {
      displayStatus(resource.connectionbreak);
      if(_root.cnctDialg == undefined)
      {
         _root.attachMovie("cnctDialg","cnctDialg",_root.getNextHighestDepth());
         cnctDialg._x = 410;
         cnctDialg._y = 150;
         cnctDialg.txtTitle.antiAliasType = "advanced";
         cnctDialg.txtTitle.gridFitType = "pixel";
         cnctDialg.txtTitle.sharpness = 100;
         cnctDialg.txtBody1.antiAliasType = "advanced";
         cnctDialg.txtBody1.gridFitType = "pixel";
         cnctDialg.txtBody1.sharpness = 100;
         cnctDialg.txtReconnectLabel.antiAliasType = "advanced";
         cnctDialg.txtReconnectLabel.gridFitType = "pixel";
         cnctDialg.txtReconnectLabel.sharpness = 100;
         cnctDialg.txtLogoutLabel.antiAliasType = "advanced";
         cnctDialg.txtLogoutLabel.gridFitType = "pixel";
         cnctDialg.txtLogoutLabel.sharpness = 100;
         cnctDialg.txtTitle.autoSize = "left";
         cnctDialg.txtTitle.setTextFormat(_root.defaultH2Fmt);
         cnctDialg.txtTitle._height = _root.defaultH2FontHeight + 4;
         cnctDialg.txtTitle.embedFonts = _root.defaultH2FontEmbed;
         cnctDialg.txtBody1.text = _root.resource.log_verbindunghead + "\n" + _root.resource.log_verbindungtext;
         cnctDialg.txtBody1.autoSize = "left";
         cnctDialg.txtBody1.setTextFormat(_root.defaultPlainBigFmt);
         cnctDialg.txtBody1.embedFonts = _root.defaultPlainBigFontEmbed;
         cnctDialg.txtReconnectLabel.autoSize = "center";
         cnctDialg.txtReconnectLabel.setTextFormat(_root.defaultPlainBigFmt);
         cnctDialg.txtReconnectLabel.embedFonts = _root.defaultPlainBigFontEmbed;
         cnctDialg.txtReconnectLabel._height = _root.defaultPlainBigFontHeight + 4;
         cnctDialg.txtLogoutLabel.autoSize = "center";
         cnctDialg.txtLogoutLabel.setTextFormat(_root.defaultPlainBigFmt);
         cnctDialg.txtLogoutLabel.embedFonts = _root.defaultPlainBigFontEmbed;
         cnctDialg.txtLogoutLabel._height = _root.defaultPlainBigFontHeight + 4;
         cnctDialg.mcCloseBtn.gotoAndStop("std");
         cnctDialg.mcCloseBtn.onRollOver = function()
         {
            this.gotoAndStop("hover");
         };
         cnctDialg.mcCloseBtn.onRollOut = function()
         {
            this.gotoAndStop("std");
         };
         _root.uebermapDontClick = false;
         _root.generalClean();
      }
   }
   else if(_root.SCAflag == 1)
   {
      doReconnect();
   }
   else
   {
      waitAndStartGame();
   }
   _root.SCAflag = 0;
};
stream.onConnect = function(success)
{
   if(success)
   {
      _root.failedConnections = 0;
      clearInterval(_root.reconnInterval);
      clearInterval(ConnectionID);
      displayStatus(resource.welcomeconnect);
      g_Connected = true;
      var _loc3_ = _root.sid;
      var _loc2_ = "LOGIN|" + _root.userID + "|" + _loc3_;
      SendtoStream(_loc2_);
      _root.originMapId = _root.mapID;
      if(_root.originMapId > 0 && _root.originMapId < 29)
      {
         _root.uebermaps.gotoAndStop(_root.originMapId);
      }
      if(_root.cnctDialg != undefined)
      {
         removeMovieClip(_root.cnctDialg);
      }
      _root.laser_count = 0;
      _root.hero_laser_count = 0;
      _root.rocket_count = 0;
      _root.ships_count = 0;
      _root.standard_animation_buffer = _root.ships_count_max;
   }
   else
   {
      stream.close();
      _root.loginSent = false;
   }
};
stream.onData = function(src)
{
   while(src.length > 0 && src.charCodeAt(0) < 32)
   {
      src = src.substring(1);
   }
   onStreamData(src);
};
pingID = setInterval(pingIt,25000);
_root.failedConnections = 0;
