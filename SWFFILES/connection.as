function DelayingFnc()
{
   clearInterval(checkServerOffset);
   var _loc2_ = setInterval(this,"DistancefromServer",15000);
}
function initTdmValues()
{
   tdm_phase = 0;
   predraft_time_left = 0;
   predraft_secs = 0;
   predraft_mins = 0;
   draft_time_left = 0;
   draft_secs = 0;
   draft_mins = 0;
   dmz_time_left = 0;
   game_time_left = 0;
   game_secs = 0;
   game_mins = 0;
   remote_predraft_time_left = 0;
   remote_draft_time_left = 0;
   remote_dmz_time_left = 0;
   remote_game_time_left = 0;
   remote_queue_pos = 0;
   remote_draft_chance = 0;
   remote_match_count = 0;
}
function onStreamData(src)
{
   var _loc2_ = src.split("|");
   if(_loc2_[0] == "ERR")
   {
      var _loc18_ = _loc2_[1] * 1;
      if(_loc18_ == 1)
      {
         showNoHitpoints();
         return undefined;
      }
      if(_loc18_ == 2)
      {
         displayStatus(resource.notloggedin);
      }
      else if(_loc18_ == 3)
      {
         displayStatus(resource.doubleloggedin);
      }
      else if(_loc18_ == 4)
      {
         showInvalidSession();
         return undefined;
      }
   }
   _root.addInCmdToGroupDebugUi(_loc2_);
   if(_loc2_[1] == "1")
   {
      var _loc4_ = _loc2_[2] * 1;
      var _loc144_ = int(_loc2_[3]);
      var _loc138_ = int(_loc2_[4]);
      var _loc21_ = int(_loc2_[5]);
      var _loc6_ = _root.cplayer[_loc4_].shipType;
      if(_loc4_ == _root.g_CurClientUser)
      {
         return undefined;
      }
      if(_level0.cplayer[_loc4_] == undefined)
      {
         sendForceInitPlayer(_loc4_);
         return undefined;
      }
      if(_loc6_ <= 90 && _loc6_ >= 71 && _loc6_ != 81)
      {
         _root.moveNPC(_loc4_,_level0.cplayer[_loc4_]._x,_level0.cplayer[_loc4_]._y,_loc144_,_loc138_,_loc21_);
      }
      else if(_loc6_ == 81)
      {
         _root.moveMassiveNPC(_loc4_,_level0.cplayer[_loc4_]._x,_level0.cplayer[_loc4_]._y,_loc144_,_loc138_,_loc21_);
      }
      else if(_loc6_ == 442)
      {
         _root.spaceball.__proto__.moveSpaceball(_loc4_,_level0.cplayer[_loc4_]._x,_level0.cplayer[_loc4_]._y,_loc144_,_loc138_,_loc21_);
      }
      else
      {
         _root.moveOpponent(_loc4_,_level0.cplayer[_loc4_]._x,_level0.cplayer[_loc4_]._y,_loc144_,_loc138_,_loc21_);
      }
   }
   else if(_loc2_[1] == "D")
   {
      srvx = _root.serverX = Number(_loc2_[2]);
      srvy = _root.serverY = Number(_loc2_[3]);
      var _loc22_ = cplayer[_root.g_CurClientUser];
      var _loc86_ = (srvx - _loc22_._x) * (srvx - _loc22_._x) + (srvy - _loc22_._y) * (srvy - _loc22_._y) - 250000;
      if(_loc86_ > 2250000)
      {
         cplayer[_root.g_CurClientUser].theX = srvx;
         cplayer[_root.g_CurClientUser].theX = srvy;
         _level0[_root.g_CurClientUser].theX = srvx;
         _level0[_root.g_CurClientUser].theY = srvy;
         _root.xPos = srvx;
         _root.yPos = srvy;
      }
      var _loc76_ = _root.in_dmz;
      var _loc100_ = int(_loc2_[4]);
      _root.in_dmz = Boolean(_loc100_);
      var _loc64_ = _root.in_dmz != _loc76_;
      if(_loc2_[5] == 1 && _level0[_root.g_CurClientUser].reprob == undefined)
      {
         _root.displayStatus(_root.resource.dorepair);
         var _loc133_ = _level0[_root.g_CurClientUser].attachMovie("reprob","reprob",_level0[_root.g_CurClientUser].getNextHighestDepth());
         _loc133_._y = -30;
      }
      else if(_loc2_[5] == 0)
      {
         if(_level0[_root.g_CurClientUser].reprob != undefined)
         {
            _root.repairState = 0;
            _level0[_root.g_CurClientUser].reprob._visible = false;
            removeMovieClip(_level0[_root.g_CurClientUser].reprob);
            _level0[_root.g_CurClientUser].reprob.removeMovieClip();
            HUD.thehud.selitem.device.z1.gotoAndStop(1);
            _root.g_farming = 0;
         }
      }
      var _loc134_ = _root.in_trade_zone;
      var _loc113_ = int(_loc2_[6]);
      _root.in_trade_zone = Boolean(_loc113_);
      var _loc65_ = _root.in_trade_zone != _loc134_;
      if(Number(_loc2_[7]) == 0 && _root.warningbox != undefined)
      {
         _root.warningbox._visible = false;
         removeMovieClip(_root.warningbox);
      }
      else if(Number(_loc2_[7]) == 1 && _root.warningbox == undefined)
      {
         _root.showRadiationWarningBox();
      }
      var _loc80_ = _root.in_jump_area;
      var _loc139_ = int(_loc2_[8]);
      _root.in_jump_area = Boolean(_loc139_);
      var _loc45_ = _root.in_jump_area != _loc80_;
      if(_loc64_ || _loc65_ || _loc45_)
      {
         updateAreaHintUi(_loc64_,_loc65_,_loc45_);
      }
      var _loc101_ = _root.in_fast_repair_area;
      var _loc17_ = int(_loc2_[9]);
      if(_root.repair_vouchers_count == 0 || _root.repair_vouchers_count == undefined || _loc17_ > -1)
      {
         _root.repair_vouchers_count = _loc17_;
      }
      _root.in_fast_repair_area = Boolean(_loc17_);
      if(_loc17_ == -1)
      {
         _root.in_fast_repair_area = false;
         _root.just_fast_repaired = true;
         updateFastRepairUi();
         _root.fast_repair_just_requested = false;
      }
      else if(_loc101_ != _root.in_fast_repair_area)
      {
         updateFastRepairUi();
      }
      if(_root.fastbuyState)
      {
         _root.fastbuyState = false;
         updateFastBuyBtn();
      }
   }
   else
   {
      if(_loc2_[1] == "a")
      {
         var _loc5_ = int(_loc2_[2]);
         var _loc38_ = int(_loc2_[3]);
         var _loc25_ = int(_loc2_[4]);
         var _loc71_ = cplayer[_loc5_].shipType;
         _root.cplayer[_loc5_].lasercolor = _loc25_;
         _root.cplayer[_loc5_].SnaptoEnemy = true;
         if(_loc71_ < 91 && _loc71_ > 70)
         {
            if(cplayer[_loc5_].activeLaserAttack == false)
            {
               cplayer[_loc5_].gotoAndPlay(2);
               cplayer[_loc5_].Selecttarget = _loc38_;
               cplayer[_loc5_].activeLaserAttack = true;
            }
         }
         else if(_loc25_ == 4)
         {
            mainBeam.__proto__.attachBeam("beam",1,_loc5_,_loc38_);
            cplayer[_loc5_].wildAttstop(Selecteduser);
            cplayer[_loc5_].activeLaserAttack = false;
         }
         else if(cplayer[_loc5_].activeLaserAttack == false)
         {
            cplayer[_loc5_].activeLaserAttack = true;
            onATT(_loc5_,_loc38_,_loc25_);
         }
         else if(_root.cplayer[_loc5_].activeLaserAttack == true)
         {
            if(cplayer[_loc5_].hideFire == true && _root.laser_count < _root.laser_count_max)
            {
               cplayer[_loc5_].dofire = 0;
            }
         }
         return undefined;
      }
      if(_loc2_[1] == "v")
      {
         var _loc48_ = int(_loc2_[2]);
         var _loc123_ = int(_loc2_[3]);
         var _loc95_ = String(_loc2_[4]);
         var _loc148_ = int(_loc2_[5]);
         onRTT(_loc48_,_loc123_,_loc95_,_loc148_);
         if(_loc48_ == _root.g_CurClientUser)
         {
            _level0[_root.g_CurClientUser].updateTopR();
         }
      }
      else if(_loc2_[1] == "C")
      {
         var _loc8_ = 10;
         _loc4_ = int(_loc2_[2]);
         _loc6_ = int(_loc2_[3]);
         var _loc10_ = int(_loc2_[4]);
         var _loc20_ = _loc2_[5];
         var _loc9_ = _loc2_[6];
         var _loc51_ = _loc2_[7];
         var _loc49_ = _loc2_[8];
         var _loc172_ = _loc51_ + 50;
         var _loc170_ = _loc49_ + 50;
         var _loc187_ = _loc2_[9] * 1;
         var _loc32_ = int(_loc2_[10]);
         var _loc60_ = int(_loc2_[13]);
         var _loc55_ = int(_loc2_[14]);
         var _loc77_ = Boolean(parseInt(_loc2_[15]));
         var _loc26_ = checkNewUser(_loc4_);
         if(cplayer[_loc4_].shipType == 6102)
         {
            onJustRemove(_loc4_);
            checkNewUser(_loc4_);
         }
         _root.storedTargetID = 0;
         if(!_loc26_)
         {
            if(cplayer[_loc4_].shipType != _loc6_)
            {
               if(_root.g_FightSelection == _loc4_)
               {
                  _root.storedTargetID = _loc4_;
               }
               _loc26_ = true;
               LaserStopByID(_loc4_);
               _root.decreaseShipCount(cplayer[_loc4_].animationType);
               cplayer.createEmptyMovieClip("instance" + _loc4_,cplayer[_loc4_].getDepth());
               cplayer[_loc4_].removeMovieClip();
               _loc51_ = _loc51_ + 410;
               _loc49_ = _loc49_ + 300;
            }
         }
         if(_loc26_ == true)
         {
            if(_loc6_ <= 90 && _loc6_ >= 71 && _loc6_ != 81)
            {
               if(settingsOptions.convertOppo == 0)
               {
                  _root.NPC.__proto__.attachship(_loc4_,"500",_loc8_,_loc10_,_loc9_,_loc2_[7],_loc2_[8],0,0,0);
               }
               else
               {
                  _root.NPC.__proto__.attachship(_loc4_,_loc6_,_loc8_,_loc10_,_loc9_,_loc2_[7],_loc2_[8],0,0,0);
               }
            }
            else if(_loc6_ == 81)
            {
               if(settingsOptions.convertOppo == 0)
               {
                  _root.massiveNPC.__proto__.attachship(_loc4_,"500",_loc8_,_loc10_,_loc9_,_loc2_[7],_loc2_[8],0,0,0);
               }
               else
               {
                  _root.massiveNPC.__proto__.attachship(_loc4_,_loc6_,_loc8_,_loc10_,_loc9_,_loc2_[7],_loc2_[8],0,0,0);
               }
            }
            else if(_loc6_ == 442)
            {
               _root.spaceball.__proto__.attachship(_loc4_,_loc6_,_loc8_,_loc10_,_loc9_,_loc2_[7],_loc2_[8],0,0,0);
            }
            else
            {
               if(_loc20_ == "GUEST" && _loc32_ == -1)
               {
                  _loc20_ = resource.guest_tag;
               }
               if(settingsOptions.convertOppo == 0)
               {
                  _root.mainOppo.__proto__.attachship(_loc4_,"500",_loc8_,_loc10_,_loc9_,_loc2_[7],_loc2_[8],_loc2_[9],_loc32_,_loc2_[11],_loc2_[12],_loc20_,_loc60_,_loc55_,_loc77_);
               }
               else
               {
                  _root.mainOppo.__proto__.attachship(_loc4_,_loc6_,_loc8_,_loc10_,_loc9_,_loc2_[7],_loc2_[8],_loc2_[9],_loc32_,_loc2_[11],_loc2_[12],_loc20_,_loc60_,_loc55_,_loc77_);
               }
            }
            if(_root.storedTargetID > 0)
            {
               var _loc73_ = cplayer[_root.storedTargetID].pressArea;
               if(cplayer[_root.storedTargetID].pressArea == undefined)
               {
                  _loc73_ = cplayer[_root.storedTargetID];
               }
               _loc73_.onPress();
            }
         }
      }
      else if(_loc2_[1] == "E")
      {
         var _loc66_ = _loc2_[2] * 1;
         var _loc62_ = _loc2_[3] * 1;
         var _loc61_ = _loc2_[4] * 1;
         var _loc107_ = _loc2_[5] * 1;
         var _loc52_ = _loc2_[6] * 1;
         var _loc50_ = _loc2_[7] * 1;
         var _loc47_ = _loc2_[8] * 1;
         tmpval = new Array(_loc66_,_loc62_,_loc61_,_loc107_,_loc52_,_loc50_,_loc47_);
         carcount = _loc66_ + _loc62_ + _loc61_ + _loc47_ + _loc52_ + _loc50_;
         _level0[g_CurClientUser].cargocount = carcount;
         _level0[g_CurClientUser].cargo = tmpval;
         _level0[g_CurClientUser].updatestat();
      }
      else if(_loc2_[1] == "5")
      {
         if(_loc2_[2] == "o")
         {
            if(_loc2_[3] == "b")
            {
               var _loc14_ = resource.bought_bat;
               _loc14_ = _loc14_.replacement("%COUNT%",_loc2_[5]);
               _loc14_ = _loc14_.replacement("%TYPE%",resource["bat" + _loc2_[4] + "name"]);
               displayStatus(_loc14_);
            }
            else if(_loc2_[3] == "r")
            {
               _loc14_ = resource.bought_rok;
               _loc14_ = _loc14_.replacement("%COUNT%",_loc2_[5]);
               _loc14_ = _loc14_.replacement("%TYPE%",resource["rok" + _loc2_[4] + "name"]);
               displayStatus(_loc14_);
            }
         }
         else if(_loc2_[2] == "f")
         {
            if(_loc2_[3] == "F")
            {
               if(_loc2_[4] == "U")
               {
                  displayStatus(resource.ammobuy_fail_uri);
               }
               else if(_loc2_[4] == "C")
               {
                  displayStatus(resource.ammobuy_fail_cre);
               }
            }
            else if(_loc2_[3] == "S")
            {
               displayStatus(resource.ammobuy_fail_space);
            }
         }
         _root.fastbuyState = false;
         _root.updateFastBuyBtn();
      }
      else if(_loc2_[1] == "g")
      {
         if(int(_loc2_[2]) > 0)
         {
            _root.station.pres1 = _loc2_[2];
            _root.station.pres2 = _loc2_[3];
            _root.station.pres3 = _loc2_[4];
            _root.station.pres4 = _loc2_[5];
            _root.station.pres5 = _loc2_[6];
            _root.station.pres6 = _loc2_[7];
         }
         else if(_loc2_[2] == "r")
         {
            _root.station.pres1 = _loc2_[3];
            _root.station.pres2 = _loc2_[4];
            _root.station.pres3 = _loc2_[5];
            _root.station.pres4 = _loc2_[6];
            _root.station.pres5 = _loc2_[7];
            _root.station.pres6 = _loc2_[8];
         }
         else if(_loc2_[2] == "a")
         {
            setAmmoPrices(_loc2_[3],_loc2_[4]);
         }
      }
      else
      {
         if(_loc2_[1] == "r")
         {
            var _loc90_ = _loc2_[2];
            var _loc56_ = int(_loc2_[3]);
            var _loc81_ = int(_loc2_[4]);
            var _loc151_ = int(_loc2_[5]);
            var _loc40_ = _loc2_[6] * 1;
            if(_loc56_ == 20)
            {
               _root.noak = _loc81_;
            }
            if(_loc40_ != 1)
            {
               _loc40_ = 0;
            }
            RXObj.__proto__.plc(_loc90_,_loc56_,_loc2_[4],_loc2_[5],_loc40_);
            return undefined;
         }
         if(_loc2_[1] == "l")
         {
            removeMovieClip(_root.lgoff);
            getUrl("javascript: self.close();", "");
         }
         else if(_loc2_[1] == "t")
         {
            displayStatus(resource.logoutbreak);
            _root.g_farming = 0;
            _root.g_hostileBoxHash = undefined;
            if(_root.lgoff != undefined)
            {
               removeMovieClip(_root.lgoff);
            }
         }
         else if(_loc2_[1] == "c")
         {
            CXObj.__proto__.plc(_loc2_[2],_loc2_[3],_loc2_[4],_loc2_[5]);
         }
         else if(_loc2_[1] == "2")
         {
            CXObj.__proto__.rem(_loc2_[2]);
         }
         else if(_loc2_[1] == "y")
         {
            if(_loc2_[2] == "BTB")
            {
               displayStatus(resource.boxtoobig);
               _root.g_farming = 0;
               _root.g_hostileBoxHash = undefined;
            }
            else if(_loc2_[2] == "BAH")
            {
               displayStatus(resource.boxdisabled);
               _root.g_farming = 0;
               _root.g_hostileBoxHash = undefined;
            }
            else if(_loc2_[2] == "DET")
            {
               displayStatus(resource.easterspecial);
               _root.g_farming = 0;
            }
            else if(_loc2_[2] == "BMP")
            {
               var _loc124_ = Number(_loc2_[3]);
               var _loc29_ = undefined;
               switch(_loc124_)
               {
                  case 2:
                     _loc29_ = "banking_doubler";
                     break;
                  case 3:
                     _loc29_ = "banking_tripler";
                     break;
                  case 4:
                     _loc29_ = "banking_quadruplicator";
                     break;
               }
               displayStatus(resource.special_item_found.replacement("%!",resource[_loc29_]));
               _root.g_farming = 0;
            }
            else if(_loc2_[2] == "SLE")
            {
               _root.gamequest.text = "Anzahl der Gegner: " + _loc2_[3];
            }
            else if(_loc2_[2] == "MIN")
            {
               MineDetonator(_loc2_[3]);
               _root.debugger.text = _root.debugger.text + ("parse" + _loc2_[3]);
            }
            getBonus(src);
         }
         else if(_loc2_[1] == "e")
         {
            g_farming = 0;
            var _loc34_ = _loc2_[2] * 1;
            if(_loc34_ == 1)
            {
               displayStatus(resource.oksammel.replacement("%!","Prometium"));
            }
            else if(_loc34_ == 2)
            {
               displayStatus(resource.oksammel.replacement("%!","Endurium"));
            }
            else if(_loc34_ == 3)
            {
               displayStatus(resource.oksammel.replacement("%!","Terbium"));
            }
         }
         else if(_loc2_[1] == "q")
         {
            RXObj.__proto__.rem(_loc2_[2]);
         }
         else if(_loc2_[1] == "R")
         {
            onJustRemove(int(_loc2_[2]));
         }
         else if(_loc2_[1] == "i")
         {
            _root.mapID = Number(_loc2_[2]);
            _root.getGameserverAddress();
            _root.loadedBg = _root.loadedMaps[_root.mapID];
            _root.pushMapToQueue(_root.mapID);
            _root.pushMapsToQueue(_root.neighbors[_root.mapID]);
            _root.neighborsLoaded = false;
            _root.updateMapQueue();
            var _loc41_ = _loc2_[2] * 1;
            if(_loc41_ >= 101 || _loc41_ != 16 && _loc41_ != 29)
            {
               _root.HUD.updateMMap(0.5);
            }
            else
            {
               _root.HUD.updateMMap(1);
            }
            _root.SCAflag = -1;
         }
         else if(_loc2_[1] == "W")
         {
            if(_loc2_[3] == "0\t")
            {
               if(_loc2_[2] == "R")
               {
                  displayStatus(resource.emptyrok);
                  _root.HUD.unableRok = false;
               }
               else if(_loc2_[2] == "L")
               {
                  var _loc74_ = cplayer[_root.g_FightSelection].username;
                  if(_loc74_ != undefined)
                  {
                     displayStatus(resource.attstop.replacement("%!",_loc74_));
                  }
                  displayStatus(resource.emptybat);
               }
            }
            else if(_loc2_[2] == "R")
            {
               displayStatus(resource.chgrokmanual);
               _root.HUD.unableRok = false;
            }
            else if(_loc2_[2] == "L")
            {
               _loc74_ = cplayer[_root.g_FightSelection].username;
               if(_loc74_ != undefined)
               {
                  displayStatus(resource.attstop.replacement("%!",_loc74_));
               }
               displayStatus(resource.chgbatmanual);
            }
         }
         else if(_loc2_[1] == "G")
         {
            var _loc7_ = int(_loc2_[2]);
            var _loc63_ = int(_loc2_[3]);
            if(cplayer[_loc7_].shipType <= 90 && cplayer[_loc7_].shipType >= 71)
            {
               cplayer[_loc7_].gotoAndStop(1);
               cplayer[_loc7_].wildAttstop(_loc63_);
               cplayer[_loc7_].activeLaserAttack = false;
            }
            else
            {
               onSTPATT(_loc7_,_loc63_);
               cplayer[_loc7_].activeLaserAttack = false;
            }
            if(_root.g_CurClientUser == _loc7_)
            {
               _root.HUD.thehud.attackbtn.special = false;
               _root.HUD.thehud.attackbtn.onRollOut();
            }
         }
         else if(_loc2_[1] == "m")
         {
            var _loc53_ = int(_loc2_[2]);
            _root.mapID = _loc53_;
            _root.loadedBg = _root.loadedMaps[_loc53_];
            _root.pushMapToQueue(_loc53_);
            _root.pushMapsToQueue(_root.neighbors[_loc53_]);
            _root.neighborsLoaded = false;
            _root.updateMapQueue();
            if(HUD.thehud.miniobjekte.mmstation)
            {
               removeMovieClip(HUD.thehud.miniobjekte.mmstation);
            }
            i = 0;
            while(i < g_Portals_ALL.length)
            {
               cplayer[g_Portals_ALL[i]].removeMovieClip();
               HUD.thehud[_root.g_mmfixed[i]].removeMovieClip();
               i++;
            }
            _root.g_mmfixed = [];
            g_Portals_ALL = [];
            portalar = [];
            docopy(_loc53_);
            _level0[g_CurClientUser].mapid = _loc53_;
            if(_root.mapID > 0 && _root.mapID < 30)
            {
               _root.uebermaps.gotoAndStop(_level0[g_CurClientUser].mapid);
            }
            else
            {
               _root.uebermap = 0;
               removeMovieClip(_root.uebermaps);
            }
            _root.mapID = _loc53_;
            setMinimapTitle();
            _loc41_ = int(_loc2_[2]);
            if(_loc41_ >= 101 || _loc41_ == 16 || _loc41_ == 29)
            {
               _root.HUD.updateMMap(0.5);
            }
            else
            {
               _root.HUD.updateMMap(1);
            }
            capture();
         }
         else if(_loc2_[1] == "Q")
         {
            _root.questHandler(src);
         }
         else if(_loc2_[1] == "S")
         {
            if(_loc2_[2] == "CFG")
            {
               var _loc11_ = int(_loc2_[3]);
               if(_loc11_ != 1 && _loc11_ != 2 && _loc11_ != 3)
               {
                  _loc11_ = 1;
               }
               _root.activePreset = _loc11_;
               _root.mcHudTopAlt.txtConfig.text = _loc11_;
               _root.updatePresetBtns();
               _root.initDone = true;
            }
         }
         else if(_loc2_[1] == "p")
         {
            g_Portals_ALL.push("portal" + _loc2_[2]);
            jmpportal.__proto__.port(_loc2_[2],_loc2_[3],_loc2_[4],_loc2_[5],_loc2_[6]);
         }
         else if(_loc2_[1] == "s")
         {
            _root.bugger.text = _root.bugger.text + src;
            _root.station.id = _loc2_[2] * 1;
            _root.station.type = _loc2_[3] * 1;
            _root.station.sname = _loc2_[4];
            _root.station.fraktion = _loc2_[5];
            _root.station.peace = _loc2_[6] * 1;
            var _loc177_ = new Array();
            _root.station.posx = _loc2_[7] * 1;
            _root.station.posy = _loc2_[8] * 1;
            _root.station._visible = 1;
            var _loc43_ = HUD.thehud.miniobjekte.attachMovie("mmstation","mmstation",HUD.thehud.miniobjekte.getNextHighestDepth());
            _loc43_._x = (_root.station.posx - 16 + _root.g_OffsetX - 1200) / HUD.thehud.miniMap.multipx;
            _loc43_._y = (_root.station.posy - 2.5 + _root.g_OffsetY - 1200) / HUD.thehud.miniMap.multipy;
         }
         else if(_loc2_[1] == "A")
         {
            if(_loc2_[2] == "HPT")
            {
               _level0[_root.g_CurClientUser].hitpoints = int(_loc2_[3]);
               _level0[_root.g_CurClientUser].hitmax = int(_loc2_[4]);
               if(_level0[_root.g_CurClientUser].hitpoints == _level0[_root.g_CurClientUser].hitmax)
               {
                  displayStatus(resource.repsuccess);
                  _root.g_farming = 0;
               }
               _level0[_root.g_CurClientUser].updatestat();
            }
            else if(_loc2_[2] == "SHD")
            {
               _level0[_root.g_CurClientUser].shield = int(_loc2_[3]);
               _level0[_root.g_CurClientUser].shieldmax = int(_loc2_[4]);
               _level0[_root.g_CurClientUser].updatestat();
            }
            else if(_loc2_[2] == "RCD")
            {
               _root.HUD.unableRok = false;
               _root.HUD.thehud.racketebtn.symb._alpha = 0;
               _root.HUD.thehud.racketebtn.symb._visible = 0;
               _root.HUD.thehud.racketebtn.special = false;
            }
            else if(_loc2_[2] == "C")
            {
               _level0.debugbox.credits.text = _loc2_[3];
               _level0.debugbox.uridium.text = _loc2_[4];
            }
            else if(_loc2_[2] == "c")
            {
               _level0[_root.g_CurClientUser].cargospacemax = int(_loc2_[3] * 1);
               _level0[_root.g_CurClientUser].updatestat();
            }
            else if(_loc2_[2] == "a")
            {
               _level0[g_CurClientUser].battmax = int(_loc2_[3]);
               _level0[g_CurClientUser].rocketsmax = int(_loc2_[4]);
               _level0[_root.g_CurClientUser].updateTop();
               _level0[_root.g_CurClientUser].updateTopR();
            }
            else if(_loc2_[2] == "ITM")
            {
               var _loc114_ = int(_loc2_[3]);
               _root.updateDroneCpuIndicator(_loc114_ + 3);
               _root.diploscan = int(_loc2_[4]);
               var _loc57_ = int(_loc2_[5]);
               var _loc96_ = int(_loc2_[6]);
               _root.setAmmoBuyIcon(_loc96_);
               var _loc69_ = int(_loc2_[7]);
               var _loc118_ = int(_loc2_[8]);
               _root.hm7_drone_on_board = Boolean(_loc118_);
               if(_root.hm7_drone_on_board && _level0[_root.g_CurClientUser].mcHm7 == undefined)
               {
                  _level0[_root.g_CurClientUser].mcHm7 = _root.attachMovie("hm7","mcHm7",1233);
                  _level0[_root.g_CurClientUser].mcHm7._x = g_OffsetX;
                  _level0[_root.g_CurClientUser].mcHm7._y = g_OffsetY;
                  _level0[_root.g_CurClientUser].mcHm7.stop();
                  _level0[_root.g_CurClientUser].mcHm7._visible = false;
               }
               _root.rt_doubbler = int(_loc2_[9]);
               _root.robOnBoard = Boolean(_loc69_);
               _root.jump_cpu_on_board = Boolean(_loc57_);
               _root.jump_cpu_id = _loc57_;
               _root.jump_cpu_target = "";
               _root.cpu_jumps_left = "";
               _root.aiming_cpu_level = int(_loc2_[13]);
               _root.aiming_cpu_on_board = Boolean(_root.aiming_cpu_level);
               _root.arol_cpu_on_board = Boolean(int(_loc2_[14]));
               _root.cloak_cpu_on_board = Boolean(int(_loc2_[15]));
               _root.updateSpecialsHud();
               HUD.thehud.robotrue = _loc69_;
               _root.smartbomb_cpu_on_board = Boolean(int(_loc2_[10]));
               _root.instashield_cpu_on_board = Boolean(int(_loc2_[11]));
               _root.mine_turbo_level = int(_loc2_[12]);
               _root.mine_turbo_on_board = Boolean(_root.mine_turbo_level);
               _root.updateMineHud();
            }
            else if(_loc2_[2] == "SET")
            {
               _root.settingsForGame.removeMovieClip();
               _root.settingsOptions = {boosten:_loc2_[3] * 1,dsplyDamage:_loc2_[4] * 1,dsplyAllLas:_loc2_[5] * 1,dsplyExplo:_loc2_[6] * 1,dsplyPlayerName:_loc2_[7] * 1,dsplyFirmIcon:_loc2_[8] * 1,dsplyAlphaBg:_loc2_[9] * 1,ignoreRES:_loc2_[10] * 1,ignoreBOX:_loc2_[11] * 1,convertGates:_loc2_[12] * 1,convertOppo:_loc2_[13] * 1,soundOnOff:_loc2_[14] * 1,bgmusicOnOff:_loc2_[15] * 1,dsplyStatus:_loc2_[16] * 1,dsplyBubble:_loc2_[17] * 1,selectedLaser:_loc2_[18] * 1,selectedRocket:_loc2_[19] * 1,dsplyDigits:_loc2_[20] * 1,dsplyChat:_loc2_[21] * 1,dsplyDrones:int(_loc2_[22]),showStarsystem:int(_loc2_[23]),ignoreCARGO:int(_loc2_[24]),ignoreHostileCARGO:int(_loc2_[25]),autochangeAmmo:int(_loc2_[26]),enableFastBuy:int(_loc2_[27])};
               changeLType(_root.settingsOptions.selectedLaser);
               changeRType(_root.settingsOptions.selectedRocket);
               _root.updateFastBuyBtn();
               if(settingsOptions.dsplyDigits == 1)
               {
                  if(debugbox.showbar.barsShown != 0)
                  {
                     debugbox.showbar.onRelease();
                  }
               }
               if(settingsOptions.bgmusicOnOff == 1 && _root.bgplaying == false)
               {
                  playSong(0);
                  _root.bgplaying = true;
               }
               if(settingsOptions.dsplyAlphaBg == 1)
               {
                  fastscroll._alpha = 33;
               }
            }
            else if(_loc2_[2] == "v")
            {
               _level0[g_CurClientUser].baseSpeed = int(_loc2_[3] * 1);
            }
            else if(_loc2_[2] == "CLD")
            {
               var _loc24_ = _loc2_[3];
               var _loc23_ = int(_loc2_[4]);
               if(_loc24_ == "SMB")
               {
                  _root.cooldownTimeSmartbomb = _loc23_;
                  _root.cooldown(_root.COOLDOWN_SMARTBOMB);
               }
               else if(_loc24_ == "ISH")
               {
                  _root.cooldownTimeInstashield = _loc23_;
                  _root.cooldown(_root.COOLDOWN_INSTASHIELD);
               }
               else if(_loc24_ == "MIN")
               {
                  _root.cooldownTimeMine = _loc23_;
                  _root.cooldown(_root.COOLDOWN_MINE);
               }
               else if(_loc24_ == "WIZ")
               {
                  _root.cooldownTimeWiz = _loc23_;
                  _root.cooldownWiz();
               }
            }
            else if(_loc2_[2] == "CLR")
            {
               _loc24_ = _loc2_[3];
               if(_loc24_ == "SMB")
               {
                  _root.finish_cooldown(_root.COOLDOWN_SMARTBOMB);
               }
               else if(_loc24_ == "ISH")
               {
                  _root.finish_cooldown(_root.COOLDOWN_INSTASHIELD);
               }
               else if(_loc24_ == "MIN")
               {
                  _root.finish_cooldown(_root.COOLDOWN_MINE);
               }
               else if(_loc24_ == "WIZ")
               {
                  _root.finish_cooldownWiz();
               }
            }
            else if(_loc2_[2] == "LUP")
            {
               _root.newLevel = int(_loc2_[3]);
               _root.epToGo = int(_loc2_[4]);
               _root.showLevelUpBox();
            }
            else if(_loc2_[2] == "STD")
            {
               displayStatus(_loc2_[3]);
            }
            else if(_loc2_[2] == "STM")
            {
               var _loc128_ = new Array(_loc2_[3],_loc2_[4],_loc2_[5],_loc2_[6],_loc2_[7],_loc2_[8],_loc2_[9]);
               _root.parseandShowStm(_loc128_);
            }
            else if(_loc2_[2] == "CPU" && _loc2_[3] == "J")
            {
               _root.jump_cpu_id = int(_loc2_[4]);
               _root.jump_cpu_target = int(_loc2_[5]);
               _root.cpu_jumps_left = int(_loc2_[6]);
               _root.updateSpecialsHud();
            }
            else if(_loc2_[2] == "CPU" && _loc2_[3] == "C")
            {
               _root.cloaks_left = int(_loc2_[4]);
               _root.updateSpecialsHud();
            }
            else if(_loc2_[2] == "CPU" && _loc2_[3] == "A")
            {
               _root.salvos_left = int(_loc2_[4]);
               _root.aiming_active = Boolean(int(_loc2_[5]));
               _root.updateSpecialsHud();
            }
            else if(_loc2_[2] == "CPU" && _loc2_[3] == "R")
            {
               _root.arolx_active = Boolean(int(_loc2_[4]));
               _root.updateSpecialsHud();
            }
            else if(_loc2_[2] == "CC")
            {
               if(int(_loc2_[3]) == 3)
               {
                  _root.cfg3x_in_use = true;
                  _root.HUD.thehud.mcChgPresetBtn.mcChg3Btn._visible = true;
                  _root.HUD.thehud.mcChgPresetBtn._x = 704;
               }
               else
               {
                  _root.cfg3x_in_use = false;
                  _root.HUD.thehud.mcChgPresetBtn.mcChg3Btn._visible = false;
                  _root.HUD.thehud.mcChgPresetBtn._x = 719;
               }
            }
            else if(_loc2_[2] == "BS")
            {
               var _loc115_ = _loc2_[3];
               _root.boosters = _loc115_.split("/");
               var i = 0;
               while(i < _root.boosters.length)
               {
                  _root.boosters[i] = int(_root.boosters[i]);
                  i++;
               }
               updateBoosterBar();
            }
            else if(_loc2_[2] == "FWX")
            {
               if(_loc2_[3] == "INL")
               {
                  var _loc75_ = parseInt(_loc2_[4]);
                  if(_root.installations != _loc75_)
                  {
                     _root.installations = _loc75_;
                     if(_root.installations == -1)
                     {
                        _root.hideFireworksBug();
                        return undefined;
                     }
                     _root.showFireworksBug();
                     mcFireworksBug.mcInstallations.gotoAndStop(_root.installations + 1);
                     if(_root.installations == 0)
                     {
                        _root.igniteFwEnabled = false;
                        _root.installFwEnabled = true;
                     }
                     else if(_root.installations == 5)
                     {
                        _root.igniteFwEnabled = true;
                        _root.installFwEnabled = false;
                     }
                     else
                     {
                        _root.igniteFwEnabled = true;
                        _root.installFwEnabled = true;
                     }
                     updateFWUI();
                  }
               }
               else if(_loc2_[3] == "FWL")
               {
                  var _loc125_ = parseInt(_loc2_[4]);
                  var _loc140_ = parseInt(_loc2_[5]);
                  var _loc135_ = parseInt(_loc2_[6]);
                  _root.fwLeft = [0,_loc125_,_loc140_,_loc135_];
                  updateFWUI();
               }
            }
            else if(_loc2_[2] == "WIZ")
            {
               _root.curses_left = int(_loc2_[3]);
               _root.updateWizHud();
            }
            else if(_loc2_[2] == "ADM")
            {
               if(_loc2_[3] == "CLI")
               {
                  if(_loc2_[4] == "1")
                  {
                     _root.enablePSUI = true;
                     _root.showGroupBug();
                  }
                  else
                  {
                     _root.enablePSUI = false;
                     _root.hideGroupBug();
                  }
               }
            }
         }
         else if(_loc2_[1] == "k")
         {
            displayStatus(resource.jumplevelfalse.replacement("%!",_loc2_[2]));
         }
         else if(_loc2_[1] == "L")
         {
            _level0[g_CurClientUser].lasercount = _loc2_[5] * 1;
         }
         else if(_loc2_[1] == "B")
         {
            var _loc39_ = Number(_loc2_[2]);
            var _loc36_ = Number(_loc2_[3]);
            var _loc35_ = Number(_loc2_[4]);
            var _loc33_ = Number(_loc2_[5]);
            var _loc30_ = Number(_loc2_[6]);
            var _loc145_ = batcount(_loc39_);
            var _loc141_ = batcount(_loc36_);
            var _loc136_ = batcount(_loc35_);
            var _loc129_ = batcount(_loc33_);
            var _loc126_ = batcount(_loc30_);
            _level0[g_CurClientUser].allschuss = _loc39_ + _loc36_ + _loc35_ + _loc33_ + _loc30_;
            _level0[g_CurClientUser].schuss = new Array(_loc39_,_loc36_,_loc35_,_loc33_,_loc30_);
            _level0[g_CurClientUser].batteries = new Array(_loc145_,_loc141_,_loc136_,_loc129_,_loc126_);
            _level0[g_CurClientUser].updateHud();
            _level0[_root.g_CurClientUser].updateTop();
            _level0[_root.g_CurClientUser].updatestat();
         }
         else if(_loc2_[1] == "N")
         {
            _level0[g_CurClientUser].MyTargetIAttack.hitpoints = int(_loc2_[6]);
            _level0[g_CurClientUser].MyTargetIAttack.hitmax = int(_loc2_[7]);
            _level0[g_CurClientUser].MyTargetIAttack.shield = int(_loc2_[4]);
            _level0[g_CurClientUser].MyTargetIAttack.shieldmax = int(_loc2_[5]);
            oppStat();
         }
         else if(_loc2_[1] == "3")
         {
            _level0[g_CurClientUser].rockets = new Array(int(_loc2_[2]),int(_loc2_[3]),int(_loc2_[4]));
            _level0[g_CurClientUser].mines = int(_loc2_[5]);
            _root.smartbombs_left = int(_loc2_[6]);
            _root.instashields_left = int(_loc2_[7]);
            _root.HUD.thehud.item_rok.mcMineBtn.txtDurability.text = _level0[g_CurClientUser].mines;
            _root.updateMineHud();
            _level0[g_CurClientUser].allrockets = _level0[g_CurClientUser].rockets[0] + _level0[g_CurClientUser].rockets[1] + _level0[g_CurClientUser].rockets[2] + _level0[g_CurClientUser].mines;
            _level0[_root.g_CurClientUser].updatestat();
            _level0[_root.g_CurClientUser].updateTopR();
         }
         else if(_loc2_[1] == "K")
         {
            onKILL(int(_loc2_[2]));
         }
         else if(_loc2_[1] == "Y")
         {
            _level0[_root.g_CurClientUser].hitpoints = int(_loc2_[2]);
            _level0[_root.g_CurClientUser].shield = int(_loc2_[3]);
            if(settingsOptions.dsplyBubble == 1)
            {
               _root.dpsSum = _root.dpsSum + int(_loc2_[5]);
            }
            _level0[_root.g_CurClientUser].updatestat();
         }
         else if(_loc2_[1] == "H")
         {
            _level0[g_CurClientUser].MyTargetIAttack.hitpoints = int(_loc2_[3]);
            _level0[g_CurClientUser].MyTargetIAttack.shield = int(_loc2_[4]);
            if(settingsOptions.dsplyBubble == 1)
            {
               showBubble(_loc2_[5]);
            }
            oppStatclean();
            oppStat();
            if(_loc2_[2] == "L")
            {
               _level0[g_CurClientUser].HitEvent();
            }
         }
         else if(_loc2_[1] == "M")
         {
            if(settingsOptions.dsplyBubble == 1)
            {
               showBubble("MISS");
            }
            if(_loc2_[2] == "L")
            {
               _level0[g_CurClientUser].HitEvent(_loc2_[3],_loc2_[4]);
            }
         }
         else if(_loc2_[1] == "h")
         {
            displayStatus(resource.rohstoffailed);
            g_farming = 0;
         }
         else if(_loc2_[1] == "f")
         {
            displayStatus(resource.loadfull);
            g_farming = 0;
         }
         else if(_loc2_[1] == "V")
         {
            displayStatus(resource.attescape);
         }
         else if(_loc2_[1] == "O")
         {
            displayStatus(resource.outofrange);
            cplayer[g_CurClientUser].dofire = 1;
            _level0[g_CurClientUser].updateRoot();
            StopLaser(cplayer[g_CurClientUser]);
            cplayer[g_CurClientUser].ATTbreak = 1;
            _level0[g_CurClientUser].updateRoot();
         }
         else if(_loc2_[1] == "P")
         {
            displayStatus(resource.peacearea);
         }
         else if(_loc2_[1] == "X")
         {
            exFireLaser(_level0[g_CurClientUser]);
            cplayer[g_CurClientUser].dofire = 1;
            cplayer[g_CurClientUser].ATTbreak = 1;
            _level0[g_CurClientUser].updateRoot();
            displayStatus(resource.fightcont);
         }
         else if(_loc2_[1] == "F")
         {
            displayStatus(resource.fightcanceled);
         }
         else if(_loc2_[1] == "J")
         {
            displayStatus(resource.fightcanceledbyop);
         }
         else if(_loc2_[1] == "U")
         {
            _root.originMapId = _root.mapID;
            streamMapId = Number(_loc2_[2]);
            _root.mapID = Number(_loc2_[2]);
            _level0[_root.g_CurClientUser].mapid = _root.mapID;
            jumpPortalId = Number(_loc2_[3]);
            var _loc169_ = _level0.cplayer["portal" + jumpPortalId].ptyp;
            if(_level0.cplayer["lowportal" + jumpPortalId] != undefined)
            {
               _level0.cplayer["lowportal" + jumpPortalId].gotoAndStop(2);
            }
            else if(_level0.cplayer["portal" + jumpPortalId].isStandard)
            {
               _level0.cplayer["portal" + jumpPortalId].gotoAndStop(2);
            }
            else
            {
               _level0.cplayer["portal" + jumpPortalId].portal_idl._visible = false;
               _level0.cplayer["portal" + jumpPortalId].portal_act._visible = true;
               _level0.cplayer["portal" + jumpPortalId].portal_act.mcVideo.play();
            }
         }
         else if(_loc2_[1] == "z")
         {
            showStarSystemMap();
            generalClean();
         }
         else if(_loc2_[1] == "Z")
         {
            if(settingsOptions.dsplyBubble == 1)
            {
               _root.missCount = _root.missCount + 1;
            }
         }
         else if(_loc2_[1] == "KIK")
         {
            displayStatus(resource.connclosed);
         }
         else if(_loc2_[1] == "n")
         {
            if(String(_loc2_[2]) == "d")
            {
               var _loc68_ = int(_loc2_[3] * 1);
               var _loc70_ = String(_loc2_[4]);
               if(_loc68_ == _root.userID)
               {
                  _level0[g_CurClientUser].setUAV(_loc70_);
               }
               else
               {
                  cplayer[_loc68_].setUAV(_loc70_);
               }
            }
            else if(_loc2_[2] == "e")
            {
               _loc68_ = int(_loc2_[3] * 1);
               _loc70_ = String(_loc2_[4]);
               if(_loc68_ == _root.userID)
               {
                  _level0[g_CurClientUser].setUAValternate(_loc70_);
               }
               else
               {
                  cplayer[_loc68_].setUAValternate(_loc70_);
               }
            }
            else if(_loc2_[2] == "FWI")
            {
               var _loc108_ = String(_loc2_[3]);
               scr[_loc108_].explode = true;
            }
            else if(_loc2_[2] == "FWG")
            {
               var _loc3_ = 3;
               while(_loc3_ < _loc2_.length)
               {
                  scr[_loc2_[_loc3_]].explode = true;
                  _loc3_ = _loc3_ + 1;
               }
            }
            else if(_loc2_[2] == "tdm")
            {
               if(_loc2_[3] == "drf")
               {
                  if(_loc2_[4] == "0")
                  {
                     if(_loc2_[5] == "-1")
                     {
                        setTdmState(_root.TDM_DRAFT_FINISH);
                     }
                     else
                     {
                        _root.remote_predraft_time_left = int(_loc2_[5]);
                        setTdmState(_root.TDM_PRE_DRAFT);
                     }
                  }
                  else if(_loc2_[4] == "1")
                  {
                     _root.remote_draft_time_left = int(_loc2_[5]);
                     setTdmState(_root.TDM_DRAFT);
                  }
               }
               else if(_loc2_[3] == "quu")
               {
                  remote_queue_pos = int(_loc2_[4]);
                  remote_draft_chance = int(_loc2_[5]);
                  mcTdmInfo.txtQueuePosition.text = remote_queue_pos;
                  mcTdmInfo.mcQueueIcon.gotoAndStop(_root.tdmChanceHash[remote_draft_chance]);
                  showQueuePosition();
               }
               else if(_loc2_[3] == "gms")
               {
                  remote_match_count = int(_loc2_[4]);
                  mcTdmInfo.txtMatchCount.text = remote_match_count;
               }
               else if(_loc2_[3] == "evt")
               {
                  if(_loc2_[4] != "dmz" && _loc2_[4] != "go!" && _loc2_[4] != "nfo" && _loc2_[4] != "fnl" && _loc2_[4] != "msg")
                  {
                     if(_root.mcTdmScorebug == undefined)
                     {
                        initTdmScorebug();
                     }
                     _root.remote_game_time_left = int(_loc2_[4]);
                     setTdmState(_root.TDM_GAME_RUNNING);
                     _root.tdmMatch.players_left_home = int(_loc2_[5]);
                     _root.tdmMatch.players_left_guest = int(_loc2_[6]);
                     _root.mcTdmScorebug.txtPlayersLeftHome.text = _root.tdmMatch.players_left_home;
                     _root.mcTdmScorebug.txtPlayersLeftGuest.text = _root.tdmMatch.players_left_guest;
                  }
                  else if(_loc2_[4] == "dmz")
                  {
                     var _loc15_ = int(_loc2_[5]);
                     if(_loc15_ < 11 && _loc15_ > 2)
                     {
                        if(mcTdmStartSplashscreen == undefined && _root.tdmMatch.hostTeam != undefined)
                        {
                           showTdmStartSplashscreen();
                        }
                        _root.tdmDmzSplashscreenTicks = 10 - _loc15_;
                        i = 0;
                        while(i < 10)
                        {
                           if(i > _root.tdmDmzSplashscreenTicks)
                           {
                              mcTdmStartSplashscreen["mcLight" + i].gotoAndStop("off");
                           }
                           else
                           {
                              mcTdmStartSplashscreen["mcLight" + i].gotoAndStop("on");
                           }
                           i++;
                        }
                     }
                     else
                     {
                        dmzTimeLeftVerbose = Math.floor(_loc15_ / 60) + ":";
                        dmzTimeLeftVerbose = dmzTimeLeftVerbose + sprintf2digit(_loc15_ % 60);
                        displayStatus(_root.resource.tdm_no_attack_phase_countdown.replacement("%COUNTDOWN%",dmzTimeLeftVerbose));
                     }
                  }
                  else if(_loc2_[4] == "go!")
                  {
                     displayStatus(_root.resource.tdm_attack_phase);
                  }
                  else if(_loc2_[4] == "nfo")
                  {
                     _root.tdmMatch = {};
                     _root.tdmMatch.hostTeam = int(_loc2_[5]);
                     _root.tdmMatch.guestTeam = int(_loc2_[6]);
                  }
                  else if(_loc2_[4] == "fnl")
                  {
                     hideTdmScorebug();
                     _root.tdm_game_result = int(_loc2_[7]);
                  }
               }
               else if(_loc2_[3] == "msg")
               {
                  msg_key = _loc2_[4];
                  if(_loc2_[5] != undefined)
                  {
                     msg_wildcard = _loc2_[5];
                     msg_replacement = _loc2_[6];
                     displayStatus(_root.resource[msg_key].replacement(msg_wildcard,msg_replacement));
                  }
                  else
                  {
                     displayStatus(_root.resource[msg_key]);
                  }
               }
            }
            else if(_loc2_[2] == "ssi")
            {
               var _loc119_ = int(_loc2_[3]);
               var _loc82_ = int(_loc2_[4]);
               var _loc149_ = int(_loc2_[5]);
               var _loc110_ = int(_loc2_[6]);
               var _loc146_ = getPlanetIntitial(int(_loc2_[7]));
               sbScore = {v_score:_loc149_,e_score:_loc82_,m_score:_loc119_,ball_on:_loc146_,ball_speed:_loc110_};
               mcScorebug._visible = true;
               updateScorebug();
            }
            else if(_loc2_[2] == "ssc")
            {
               var _loc116_ = getPlanetIntitial(int(_loc2_[3]));
               var _loc150_ = int(_loc2_[4]);
               var _loc120_ = int(_loc2_[4]);
               setScore(_loc150_,_loc116_);
               playGateAnimation(_loc120_);
            }
            else if(_loc2_[2] == "sss")
            {
               _loc116_ = getPlanetIntitial(int(_loc2_[3]));
               _loc110_ = int(_loc2_[4]);
               setSpaceballSpeed(_loc110_,_loc116_);
            }
            else if(_loc2_[2] == "isi")
            {
               _loc119_ = int(_loc2_[3]);
               _loc82_ = int(_loc2_[4]);
               _loc149_ = int(_loc2_[5]);
               var _loc121_ = int(_loc2_[6]);
               invasionScore = {v_score:_loc149_,e_score:_loc82_,m_score:_loc119_,wave_count:_loc121_};
               mcInvasionScorebug._visible = true;
               updateInvasionScorebug();
            }
            else if(_loc2_[2] == "isc")
            {
               _loc116_ = getPlanetIntitial(int(_loc2_[3]));
               _loc150_ = int(_loc2_[4]);
               setInvasionScore(_loc150_,_loc116_);
            }
            else if(_loc2_[2] == "isw")
            {
               _loc121_ = int(_loc2_[3]);
               setInvasionWave(_loc121_);
            }
            else if(_loc2_[2] == "ctb")
            {
               if(_loc2_[3] == "p")
               {
                  var _loc130_ = parseInt(_loc2_[4]);
                  var _loc102_ = parseInt(_loc2_[5]);
                  var _loc54_ = convertBeaconDetails(_loc130_);
                  setBeaconMapInScorebug(_loc54_.fromID,_loc54_.forID,_loc102_);
               }
               else if(_loc2_[3] == "c")
               {
                  var _loc103_ = parseInt(_loc2_[4]);
                  _loc130_ = parseInt(_loc2_[5]);
                  _loc54_ = convertBeaconDetails(_loc130_);
                  addFlagOnUser(_loc103_,_loc54_.fromID,_loc54_.forID);
               }
               else if(_loc2_[3] == "s")
               {
                  var _loc137_ = parseInt(_loc2_[4]);
                  var _loc131_ = parseInt(_loc2_[5]);
                  var _loc104_ = parseInt(_loc2_[6]);
                  setCTFScore(_loc137_,_loc131_,_loc104_);
               }
               else if(_loc2_[3] == "r")
               {
                  _loc103_ = parseInt(_loc2_[4]);
                  _loc130_ = parseInt(_loc2_[5]);
                  _loc54_ = convertBeaconDetails(_loc130_);
                  removeFlagFromUser(_loc103_,_loc54_.fromID,_loc54_.forID);
               }
               else if(_loc2_[3] == "m")
               {
                  var _loc83_ = parseInt(_loc2_[4]);
                  if(_loc83_ == 1)
                  {
                     initCTFScoreBug(_level0[_root.g_CurClientUser].fractionID);
                     showCTFScorebug();
                  }
                  else
                  {
                     shutDownCTF();
                  }
               }
               else if(_loc2_[3] == "z")
               {
                  _loc130_ = parseInt(_loc2_[4]);
                  var _loc91_ = parseInt(_loc2_[5]);
                  var _loc87_ = parseInt(_loc2_[6]);
                  setCTBHomeZone(_loc130_,_loc91_,_loc87_);
               }
            }
            else if(_loc2_[2] == "w")
            {
               _root.alertState = int(_loc2_[3] * 1);
               _root.updateAlertState();
            }
            else if(_loc2_[2] == "s")
            {
               _root.spawnAtDoor(int(_loc2_[3] * 1));
            }
            else if(_loc2_[2] == "LSH")
            {
               var _loc105_ = Math.floor(_loc2_[3]);
               var _loc78_ = Math.floor(_loc2_[4]);
               graying(_loc105_,_loc78_);
            }
            else if(_loc2_[2] == "USH")
            {
               regraying(_loc2_[3]);
            }
            else if(_loc2_[2] == "INV")
            {
               var _loc142_ = Math.floor(_loc2_[3]);
               var _loc84_ = Math.floor(_loc2_[4]);
               updateShipViz(_loc142_,_loc84_);
            }
            else if(_loc2_[2] == "CDC")
            {
               _loc68_ = int(_loc2_[3]);
               var _loc28_ = int(_loc2_[4]);
               _root.HUD.thehud["mm" + _loc68_].removeMovieClip();
               if(_loc28_ > -1 && _loc28_ < 4)
               {
                  cplayer[_loc68_].clanDiplid = _loc28_;
                  cplayer[_loc68_].donaming(cplayer[_loc68_].greying);
               }
            }
            else if(_loc2_[2] == "SMB")
            {
               var _loc42_ = _loc2_[3];
               RXObj.__proto__.plc("smb" + _loc42_,20,cplayer[_loc42_]._x,cplayer[_loc42_]._y);
            }
            else if(_loc2_[2] == "ISH")
            {
               _loc42_ = _loc2_[3];
               if(_loc42_ == _root.userID)
               {
                  var _loc67_ = _level0[g_CurClientUser].getNextHighestDepth();
                  _level0[g_CurClientUser].attachMovie("instashield_ore","instashield_ore_" + _loc67_,_loc67_);
               }
               else
               {
                  _loc67_ = cplayer[_loc42_].getNextHighestDepth();
                  cplayer[_loc42_].attachMovie("instashield_ore","instashield_ore_" + _loc67_,_loc67_);
               }
            }
            else if(_loc2_[2] == "MDL")
            {
               var _loc79_ = int(_loc2_[3]);
               _root.showMedalBox(_loc79_);
            }
            else if(_loc2_[2] == "t")
            {
               _loc68_ = int(_loc2_[3]);
               var _loc27_ = undefined;
               var _loc37_ = false;
               if(_root.resource[_loc2_[4]] == undefined)
               {
                  _loc27_ = _loc2_[4];
                  _loc37_ = true;
               }
               else
               {
                  _loc27_ = _root.resource[_loc2_[4]];
               }
               if(_loc68_ == _root.userID)
               {
                  _level0[g_CurClientUser].setUserGameTitle(_loc27_,_loc37_);
               }
               else
               {
                  cplayer[_loc68_].setUserGameTitle(_loc27_,_loc37_);
               }
            }
            else if(_loc2_[2] == "fbo")
            {
               var _loc127_ = int(_loc2_[3]);
               var _loc109_ = int(_loc2_[4]);
               var _loc16_ = _root.resource.booster_found;
               _loc16_ = replaceText(_loc16_,"%BOOSTERNAME%",_root.resource["booster_" + _loc127_ + "_name"]);
               _loc16_ = replaceText(_loc16_,"%HOURS%",_loc109_);
               displayStatus(_loc16_);
            }
            else if(_loc2_[2] == "mt")
            {
               _loc53_ = int(_loc2_[3]);
               var _loc92_ = _loc2_[4];
               allmapids[_loc53_] = _loc92_;
               if(_loc53_ == _root.mapID)
               {
                  setMinimapTitle();
               }
            }
         }
         else if(_loc2_[1] == "4")
         {
            var _loc58_ = _loc2_[2];
            if(_loc58_ == "L")
            {
               _root.restoreLas = int(_loc2_[4]);
               _level0[_root.userID].selbat = _root.restoreLas;
               _level0[_root.userID].updateTop();
               _root.updateLaserBtns();
               _root.HUD.thehud.lasertype = _root.restoreLas;
               displayStatus(resource.chgbat.replacement("%!",resource["bat" + _root.restoreLas + "name"]));
            }
            else if(_loc58_ == "R")
            {
               _root.restoreRok = int(_loc2_[4]);
               displayStatus(resource.chgrok.replacement("%!",resource["rok" + _root.restoreRok + "name"]));
               _level0[_root.userID].selrocket = _root.restoreRok;
               _level0[_root.userID].updateTopR();
               _root.updateRocketBtns();
               _root.HUD.thehud.rockettype = _root.restoreRok;
            }
         }
         else if(_loc2_[1] == "T")
         {
            _loc144_ = int(_loc2_[2]) + 2 * g_OffsetX;
            _loc138_ = int(_loc2_[3]) + 2 * g_OffsetY;
            _level0[_root.g_CurClientUser].onNEWclick(_loc144_,_loc138_);
         }
         else if(_loc2_[1] == "I")
         {
            _root.station._visible = 0;
            LaserStopByID(_root.g_CurClientUser);
            _level0[_root.g_CurClientUser].removeMovieClip();
            cplayer[_root.g_CurClientUser].removeMovieClip();
            g_OpponentsALL.nrem(_loc2_[2]);
            NPC = new createNPC();
            mainPlayer = new createPlayer();
            var _loc12_ = _loc2_[28];
            var _loc59_ = int(_loc2_[16]);
            if(_loc12_ == "GUEST" && _loc59_ == -1)
            {
               _loc12_ = resource.guest_tag;
               _root.clanTag = _loc12_;
            }
            _root.gatesAchievedCount = int(_loc2_[29]);
            _loc77_ = Boolean(parseInt(_loc2_[30]));
            var _loc147_ = new Array(_loc2_[19],_loc2_[20],_loc2_[21],_loc2_[22],_loc2_[23],_loc2_[24],_loc2_[25],_loc2_[26]);
            var _loc97_ = undefined;
            _loc97_ = _loc2_[4];
            mainPlayer.__proto__.attachship(_root.g_CurClientUser,_loc2_[3],_loc97_,Number(_loc2_[5]),_loc2_[6],_loc2_[7],_loc2_[8],_loc2_[9],_loc2_[10],_loc2_[11],_loc2_[12],_loc2_[13],_loc2_[14],_loc2_[15],_loc59_,_loc2_[17],_loc2_[18],_loc147_,_loc2_[27],_loc12_,_root.gatesAchievedCount,_loc77_);
            mainOppo = new createOpponent();
            massiveNPC = new createMassiveNPC();
            _root.spaceball = new createSpaceball();
            mainOppo.__proto__.attachship(_root.g_CurClientUser,444,0,0,0,0,0,0);
            g_OpponentsALL.push(_loc2_[2]);
            _root.g_username = _loc2_[3];
            _root.chatNick = _loc2_[3];
            var _loc85_ = String(_loc2_[15]);
            _root.chatRoomIds = _loc85_;
            if(settingsOptions.dsplyChat == 1)
            {
               if(_loc12_.length > 0)
               {
                  _root.clanTag = _loc12_;
               }
               else
               {
                  _root.clanTag = "noclan";
               }
               _root.chatInit();
            }
            else
            {
               chat._visible = false;
            }
         }
         else if(_loc2_[1] == "8")
         {
            _root.loginSent = true;
         }
         else if(_loc2_[1] == "GUEST_PLEASE_REGISTER")
         {
            _root.self_kill = true;
            var _loc93_ = int(_loc2_[2]);
            var _loc88_ = "/indexInternal.es?action=" + _root.guestAction;
            var _loc111_ = "javascript: opener.location=\'" + _loc88_ + "\';this.focus();";
            _root.attachMovie("guest_alert","mcGuestAlert",_root.getNextHighestDepth());
            _root.mcGuestAlert.getURL(_loc111_);
            _root.mcGuestAlert.bg.onRelease = null;
            _root.mcGuestAlert.bg.useHandCursor = false;
            _root.mcGuestAlert.txtHeader.text = _root.resource.log_verbindung;
            _root.mcGuestAlert.txtHeader.antiAliasType = "advanced";
            _root.mcGuestAlert.txtHeader.gridFitType = "pixel";
            _root.mcGuestAlert.txtHeader.sharpness = 200;
            _root.mcGuestAlert.txtHeader.autoSize = "left";
            _root.mcGuestAlert.txtHeader._height = _root.easternH2FontHeight + 5;
            _root.mcGuestAlert.txtHeader.setTextFormat(_root.defaultH2Fmt);
            _root.mcGuestAlert.txtHeader.embedFonts = _root.defaultH2FontEmbed;
            var _loc44_ = String(resource.please_register).split("%!");
            _root.mcGuestAlert.txtMain.text = _loc44_[0] + _loc93_ + _loc44_[1];
            _root.mcGuestAlert.txtMain.antiAliasType = "advanced";
            _root.mcGuestAlert.txtMain.gridFitType = "pixel";
            _root.mcGuestAlert.txtMain.sharpness = 200;
            _root.mcGuestAlert.txtMain.autoSize = "left";
            _root.mcGuestAlert.txtMain.setTextFormat(_root.defalutPlainBigFmt);
            _root.mcGuestAlert.txtMain.embedFonts = _root.defalutPlainBigFontEmbed;
            _root.mcGuestAlert.txtButton.text = _root.resource.sta_ok;
            _root.mcGuestAlert.txtButton.antiAliasType = "advanced";
            _root.mcGuestAlert.txtButton.gridFitType = "pixel";
            _root.mcGuestAlert.txtButton.sharpness = 200;
            _root.mcGuestAlert.txtButton.autoSize = "center;";
            _root.mcGuestAlert.txtButton._height = _root.easternH2FontHeight + 5;
            _root.mcGuestAlert.txtButton.setTextFormat(_root.defaultH2Fmt);
            _root.mcGuestAlert.txtButton.embedFonts = _root.defaultH2FontEmbed;
         }
         else if(_loc2_[1] == "9")
         {
            if(_loc2_[2] == "ini")
            {
               var _loc89_ = undefined;
               _loc89_ = _loc2_[3];
               qP.__proto__.init(_loc89_);
               var _loc19_ = qP.__proto__.getQuestObj();
               allQuests[_loc19_.id] = _loc19_;
               var _loc72_ = _loc2_[4];
               if(_loc72_ != undefined)
               {
                  specialQuestTypes[_loc19_.id] = _loc72_;
               }
               updateDots();
               if(_root.current_quest_shown == -1)
               {
                  _root.current_quest_shown = _loc19_.id;
                  showQuestInBug(_root.current_quest_shown);
               }
            }
            else if(_loc2_[2] == "upd")
            {
               var _loc13_ = int(_loc2_[3]);
               if(_loc2_[4] != "o")
               {
                  if(_loc2_[4] == "i")
                  {
                     var _loc132_ = int(_loc2_[5]);
                     var _loc94_ = int(_loc2_[6]);
                     var _loc143_ = int(_loc2_[7]);
                     var _loc117_ = Boolean(int(_loc2_[8]));
                     _root.timer_changed[_loc13_] = false;
                     var _loc186_ = _root.changeQuestNumber(allQuests[_loc13_],_loc132_,_loc94_,_loc143_,_loc117_);
                     if(_root.current_quest_shown == -1)
                     {
                        showQuestInBug(_loc13_);
                     }
                     else if(!_root.timer_changed[_loc13_] && (_loc13_ != _root.current_quest_shown || _root.questWindowState == _root.QUEST_WINDOW_WIN))
                     {
                        _root.blinkDot(_loc13_);
                     }
                  }
               }
            }
            else if(_loc2_[2] == "a")
            {
               var _loc98_ = Math.floor(Number(_loc2_[3]));
               var _loc122_ = Math.floor(Number(_loc2_[4]));
               _root.showQuestFinishBox(_loc98_,_loc122_);
               removeQuest(int(_loc2_[3]));
            }
            else if(_loc2_[2] == "as")
            {
               _loc98_ = Math.floor(Number(_loc2_[3]));
               _loc122_ = Math.floor(Number(_loc2_[4]));
               var _loc106_ = _loc2_[5];
               var _loc99_ = _loc2_[6];
               var _loc112_ = true;
               _root.showQuestFinishBox(_loc98_,_loc122_,_loc112_,_loc106_,_loc99_);
               removeQuest(_loc98_);
            }
            else if(_loc2_[2] == "c")
            {
               _loc98_ = int(_loc2_[3]);
               displayStatus(resource.q2_cancel_quest.replacement("%quest_name%",getQuestTitle(_loc98_)));
               removeQuest(_loc98_);
            }
            else if(_loc2_[2] == "f")
            {
               _loc98_ = int(_loc2_[3]);
               displayStatus(resource.q2_failed_quest.replacement("%quest_name%",getQuestTitle(_loc98_)));
               removeQuest(_loc98_);
            }
            else if(_loc2_[2] == "p")
            {
               _loc98_ = int(_loc2_[3]);
               _root.privilegeQuest(_loc98_);
            }
         }
         else if(_loc2_[1] == "6")
         {
            var _loc31_ = cplayer.mcGhostCrosshairs;
            if(cplayer.mcGhostCrosshairs == undefined)
            {
               _loc31_ = cplayer.attachMovie("ghostCrossHair","mcGhostCrosshairs",cplayer.getNextHighestDepth());
            }
            _loc31_._x = Math.floor(Number(_loc2_[2])) + 410;
            _loc31_._y = Math.floor(Number(_loc2_[3])) + 300;
         }
      }
   }
}
function checkNewUser(userID)
{
   if(cplayer[userID] != undefined)
   {
      return false;
   }
   i = 0;
   while(i < _root.g_OpponentsALL.length)
   {
      if(userID == _root.g_OpponentsALL[i])
      {
         return false;
      }
      i++;
   }
   _root.g_OpponentsALL.push(userID);
   return true;
}
function onJustRemove(user_id)
{
   LaserStopByID(user_id);
   _level0.g_OpponentsALL.nrem(user_id);
   HUD.thehud["mm" + user_id].removeMovieClip();
   if(cplayer[user_id] != undefined)
   {
      _root.decreaseShipCount(cplayer[user_id].animationType);
      if(cplayer[user_id].ctfToken != undefined)
      {
         removeFlagFromUser(user_id,cplayer[user_id].ctfFromFaction,cplayer[user_id].ctfForFaction);
      }
      cplayer[user_id].removeMovieClip();
   }
   if(_level0[user_id])
   {
      _root.decreaseShipCount(_level0[user_id].animationType);
      _level0[user_id].removeMovieClip();
   }
}
function batcount(c)
{
   if(c > 0)
   {
      anzahl = 1;
   }
   else
   {
      anzahl = 0;
   }
   return anzahl;
}
function oppStat()
{
   oppStatclean();
   if(cplayer[_root.g_FightSelection].shipType == 442)
   {
      return undefined;
   }
   var _loc2_ = cplayer[_root.g_FightSelection].stati.attachMovie("ScalBarHp","hp",cplayer[_root.g_FightSelection].stati.getNextHighestDepth());
   _loc2_._y = - cplayer[_root.g_FightSelection]._height / 2;
   var _loc3_ = 0;
   if(cplayer[_root.g_FightSelection].hitpoints <= cplayer[_root.g_FightSelection].hitmax)
   {
      _loc3_ = cplayer[_root.g_FightSelection].hitpoints / cplayer[_root.g_FightSelection].hitmax * 100;
      _loc2_._xscale = Math.min(100,_loc3_);
   }
   else
   {
      var _loc4_ = cplayer[_root.g_FightSelection].stati.attachMovie("ScalBarMoreHp","morehp",cplayer[_root.g_FightSelection].stati.getNextHighestDepth());
      _loc3_ = (cplayer[_root.g_FightSelection].hitpoints - cplayer[_root.g_FightSelection].hitmax) / cplayer[_root.g_FightSelection].hitmax * 100;
      _loc4_._xscale = Math.min(100,_loc3_);
      _loc4_._y = _loc2_._y;
      _loc4_._x = (- _loc2_._width) / 2;
   }
   var _loc5_ = cplayer[_root.g_FightSelection].stati.attachMovie("ScalBarSh","sh",cplayer[_root.g_FightSelection].stati.getNextHighestDepth());
   var _loc6_ = cplayer[_root.g_FightSelection].shield / cplayer[_root.g_FightSelection].shieldmax * 100;
   _loc5_._xscale = Math.min(100,_loc6_);
   _loc5_._y = _loc2_._y + 5;
}
function oppStatclean()
{
   removeMovieClip(_level0[g_CurClientUser].MyTargetIAttack.stati.hp);
   removeMovieClip(_level0[g_CurClientUser].MyTargetIAttack.stati.sh);
   removeMovieClip(_level0[g_CurClientUser].MyTargetIAttack.stati.morehp);
   removeMovieClip(cplayer[_root.g_FightSelection].stati.sh);
   removeMovieClip(cplayer[_root.g_FightSelection].stati.hp);
   removeMovieClip(cplayer[_root.g_FightSelection].stati.morehp);
}
function cleanScreen()
{
   var _loc3_ = g_OpponentsALL;
   i = 0;
   while(i < _loc3_.length)
   {
      clearInterval(cplayer[_loc3_[i]].remInterval);
      cplayer[_loc3_[i]].beam.removeMovieClip();
      LaserStopByID(cplayer[_loc3_[i]].UserID);
      removeMovieClip(_root.HUD.thehud["mm" + _loc3_[i]]);
      removeMovieClip(_root.cplayer[_loc3_[i]].UserID);
      i++;
   }
   removeMovieClip(_level0[g_CurClientUser]);
   _root.mm_allied_layer = _root.mm_allied_layer_init;
   _root.mm_default_layer = _root.mm_default_layer_init;
   _root.g_OpponentsALL = [];
   var _loc7_ = _root.allResources;
   i = 0;
   while(i < _loc7_.length)
   {
      removeMovieClip(_root.scr[_loc7_[i]]);
      i++;
   }
   _root.allResources = [];
   var _loc4_ = _root.allBoxes;
   i = 0;
   while(i < _loc4_.length)
   {
      clearInterval(scr[_loc4_[i]].publicboxTimer);
      removeMovieClip(_root.scr[_loc4_[i]]);
      clearInterval(beacons[_loc4_[i]].publicboxTimer);
      removeMovieClip(_root.beacons[_loc4_[i]]);
      i++;
   }
   var i = 0;
   while(i < 6)
   {
      var _loc6_ = _root.HUD.thehud["mmbeacon_" + allBeaconIDs[i][0] + "_" + allBeaconIDs[i][1]];
      if(_loc6_ != undefined)
      {
         _loc6_.removeMovieClip();
      }
      var _loc5_ = scr["ctf_zone_" + allBeaconIDs[i][0] + "_" + allBeaconIDs[i][1]];
      trace1("ctf zone before removal " + _loc5_);
      if(_loc5_ != undefined)
      {
         _loc5_.removeMovieClip();
      }
      i++;
   }
   clearInterval(_global.flagMMUpdateTimer);
   _global.flagMMUpdateTimer = 0;
   _root.HUD.thehud.mm_ctf_zone_1.removeMovieClip();
   _root.HUD.thehud.mm_ctf_zone_2.removeMovieClip();
   _root.HUD.thehud.mm_ctf_zone_3.removeMovieClip();
   _root.allBoxes = [];
   cplayer.createEmptyMovieClip("curion_barrier",10);
   hideTdmInfo();
   hideTdmScorebug();
   initTdmValues();
   hideCTFScorebug();
}
function shutDownCTF()
{
   hideCTFScorebug();
   var _loc3_ = 0;
   while(_loc3_ < 6)
   {
      var _loc6_ = _root.HUD.thehud["mmbeacon_" + allBeaconIDs[_loc3_][0] + "_" + allBeaconIDs[_loc3_][1]];
      if(_loc6_ != undefined)
      {
         _loc6_.removeMovieClip();
      }
      var _loc7_ = scr["ctf_zone_" + allBeaconIDs[_loc3_][0] + "_" + allBeaconIDs[_loc3_][1]];
      if(_loc7_ != undefined)
      {
         _loc7_.removeMovieClip();
      }
      var _loc5_ = beacons[freeBeaconBoxHashes[100 + allBeaconIDs[_loc3_][0] * 10 + allBeaconIDs[_loc3_][1]]];
      if(_loc5_ != undefined)
      {
         beacons[_loc5_].removeMovieClip();
      }
      var _loc4_ = beaconData[allBeaconIDs[_loc3_][0]][allBeaconIDs[_loc3_][1]];
      if(_loc4_ != undefined)
      {
         removeFlagFromUser(_loc4_,allBeaconIDs[_loc3_][0],allBeaconIDs[_loc3_][1]);
      }
      _loc3_ = _loc3_ + 1;
   }
   clearInterval(_global.flagMMUpdateTimer);
   _global.flagMMUpdateTimer = 0;
   _root.HUD.thehud.mm_ctf_zone_1.removeMovieClip();
   _root.HUD.thehud.mm_ctf_zone_2.removeMovieClip();
   _root.HUD.thehud.mm_ctf_zone_3.removeMovieClip();
}
function generalClean()
{
   var _loc3_ = g_OpponentsALL;
   i = 0;
   while(i < _loc3_.length)
   {
      LaserStopByID(cplayer[_loc3_[i]].UserID);
      clearInterval(cplayer[_loc3_[i]].remInterval);
      cplayer[_loc3_[i]].beam.removeMovieClip();
      if(_loc3_[i] == g_CurClientUser)
      {
         LaserStopByID(g_CurClientUser);
         removeMovieClip(_level0[_loc3_[i]]);
      }
      removeMovieClip(_root.HUD.thehud["mm" + _loc3_[i]]);
      removeMovieClip(_root.cplayer[_loc3_[i]]);
      i++;
   }
   _root.mm_allied_layer = _root.mm_allied_layer_init;
   _root.mm_default_layer = _root.mm_default_layer_init;
   _root.mm_ctf_layer = _root.mm_ctf_layer_init;
   var i = 0;
   while(i < 6)
   {
      var _loc5_ = _root.HUD.thehud["mmbeacon_" + allBeaconIDs[i][0] + "_" + allBeaconIDs[i][1]];
      if(_loc5_ != undefined)
      {
         _loc5_.removeMovieClip();
      }
      i++;
   }
   _root.g_OpponentsALL = [];
   var _loc7_ = _root.allResources;
   i = 0;
   while(i < _loc7_.length)
   {
      removeMovieClip(_root.scr[_loc7_[i]]);
      i++;
   }
   _root.allResources = [];
   var _loc4_ = _root.allBoxes;
   i = 0;
   while(i < _loc4_.length)
   {
      clearInterval(scr[_loc4_[i]].publicboxTimer);
      removeMovieClip(_root.scr[_loc4_[i]]);
      clearInterval(beacons[_loc4_[i]].publicboxTimer);
      removeMovieClip(_root.beacons[_loc4_[i]]);
      i++;
   }
   _root.allBoxes = [];
   var i = 0;
   while(i < 6)
   {
      _loc5_ = _root.HUD.thehud["mmbeacon_" + allBeaconIDs[i][0] + "_" + allBeaconIDs[i][1]];
      if(_loc5_ != undefined)
      {
         _loc5_.removeMovieClip();
      }
      var _loc6_ = scr["ctf_zone_" + allBeaconIDs[i][0] + "_" + allBeaconIDs[i][1]];
      if(_loc6_ != undefined)
      {
         _loc6_.removeMovieClip();
      }
      i++;
   }
   _root.HUD.thehud.mm_ctf_zone_1.removeMovieClip();
   _root.HUD.thehud.mm_ctf_zone_2.removeMovieClip();
   _root.HUD.thehud.mm_ctf_zone_3.removeMovieClip();
   clearInterval(_global.flagMMUpdateTimer);
   _global.flagMMUpdateTimer = 0;
   i = 0;
   while(i < g_Portals_ALL.length)
   {
      cplayer[g_Portals_ALL[i]].removeMovieClip();
      HUD.thehud[_root.g_mmfixed[i]].removeMovieClip();
      i++;
   }
   cplayer.createEmptyMovieClip("curion_barrier",10);
   hideTdmInfo();
   hideTdmScorebug();
   initTdmValues();
}
function setAmmoPrices(batteryDetailsRaw, rocketsDetailsRaw)
{
   initShopDb();
   var _loc3_ = batteryDetailsRaw.split(",");
   if(_loc3_[0] == "b")
   {
      _root.batteriesDetails[0] = int(_loc3_[1]);
      var _loc2_ = 2;
      while(_loc2_ < _loc3_.length)
      {
         _root.batteriesDetails[int(_loc3_[_loc2_])] = {price:int(_loc3_[_loc2_ + 1]),currency:_loc3_[_loc2_ + 2]};
         _loc2_ = _loc2_ + 3;
      }
   }
   var _loc4_ = rocketsDetailsRaw.split(",");
   if(_loc4_[0] == "r")
   {
      _root.rocketDetails[0] = int(_loc4_[1]);
      _loc2_ = 2;
      while(_loc2_ < _loc4_.length)
      {
         _root.rocketDetails[int(_loc4_[_loc2_])] = {price:int(_loc4_[_loc2_ + 1]),currency:_loc4_[_loc2_ + 2]};
         _loc2_ = _loc2_ + 3;
      }
   }
   _root.updateFastBuyBtn();
}
function initShopDb()
{
   _root.rocketDetails = new Array();
   _root.rocketDetails[0] = 0;
   _root.rocketDetails[1] = {price:0,currency:"U"};
   _root.rocketDetails[2] = {price:0,currency:"U"};
   _root.rocketDetails[3] = {price:0,currency:"U"};
   _root.batteriesDetails = new Array();
   _root.batteriesDetails[0] = 0;
   _root.batteriesDetails[1] = {price:0,currency:"U"};
   _root.batteriesDetails[2] = {price:0,currency:"U"};
   _root.batteriesDetails[3] = {price:0,currency:"U"};
   _root.batteriesDetails[4] = {price:0,currency:"U"};
   _root.batteriesDetails[5] = {price:0,currency:"U"};
}
function sTt(s)
{
   return s * 1;
}
function getDigit(c, radix)
{
   var _loc2_ = ["0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"," ","!","\"","#","$","%","&","\'","(",")","*","+",",",".","/",":",";","<","=",">","?","@","[","\\","]","^","_","`","{","}","~"];
   var _loc1_ = 0;
   while(_loc1_ < radix)
   {
      if(_loc2_[_loc1_] == c)
      {
         return _loc1_;
      }
      _loc1_ = _loc1_ + 1;
   }
   return -1;
}
function capIntv()
{
   var _loc2_ = false;
   m = 0;
   while(m < _root.g_OpponentsALL.length)
   {
      i = 0;
      while(i < _level0.AllLaserPulses.length)
      {
         if(_root.g_OpponentsALL[m] == _level0.AllLaserPulses[i].UserId)
         {
            _loc2_ = true;
         }
         i++;
      }
      if(!_loc2_)
      {
         stipstop(_level0.AllLaserPulses[i].UserId);
      }
      else
      {
         _loc2_ = false;
      }
      m++;
   }
}
function nana()
{
   i = 0;
   while(i < _level0.AllLaserPulses.length)
   {
      clearInterval(_level0.AllLaserPulses[i].UserId);
      i++;
   }
   _root.laser_count = 0;
   _root.hero_laser_count = 0;
   _root.rocket_count = 0;
}
function LaserStopByID(userid)
{
   var _loc2_ = 0;
   while(_loc2_ < _level0.AllLaserPulses.length)
   {
      if(userid == _level0.AllLaserPulses[_loc2_].UserId)
      {
         if(userid == _root.userID || cplayer[userid].MyTargetIAttack.UserID == _root.userID)
         {
            _root.hero_laser_count = _root.hero_laser_count - 1;
         }
         clearInterval(_level0.AllLaserPulses[_loc2_].IntervalId);
         _level0.AllLaserPulses.splice(_loc2_,1);
         _loc2_ = _loc2_ - 1;
         _root.laser_count = _root.laser_count - 1;
      }
      _loc2_ = _loc2_ + 1;
   }
}
function DistancefromServer()
{
   var _loc4_ = _root.serverX;
   var _loc3_ = _root.serverY;
   var _loc2_ = cplayer[_root.g_CurClientUser];
   var _loc5_ = Math.sqrt((_loc4_ - _loc2_._x) * (_loc4_ - _loc2_._x) + (_loc3_ - _loc2_._y) * (_loc3_ - _loc2_._y)) - 508.5;
   var _loc6_ = Math.round(_loc5_);
   if(_loc6_ >= 1300 && _root.g_Connected == true)
   {
      _root.xPos = _loc4_;
      _root.yPos = _loc3_;
   }
}
function showBubble(pnt)
{
   var _loc2_ = pnt + Math.random(1000);
   var _loc1_ = cplayer.attachMovie("points",_loc2_,cplayer.getNextHighestDepth());
   _loc1_.score = pnt;
   _loc1_._x = _level0[g_CurClientUser].MyTargetIAttack._x;
   _loc1_._y = _level0[g_CurClientUser].MyTargetIAttack._y;
}
function showOwnBubble(pnt)
{
   var _loc3_ = pnt + Math.random(1000);
   var _loc2_ = _root.attachMovie("pointsown",_loc3_,_root.getNextHighestDepth());
   _loc2_.score = pnt;
   _loc2_._x = _level0[g_CurClientUser]._x;
   _loc2_._y = _level0[g_CurClientUser]._y;
}
function changeLType(l_type)
{
   _root.restoreLas = l_type;
   _level0[_root.userID].selbat = _root.restoreLas;
   _level0[_root.userID].updateTop();
   _root.updateLaserBtns();
   _root.HUD.thehud.lasertype = _root.restoreLas;
   var _loc2_ = "u|" + _root.restoreLas;
   _root.SendtoStream(_loc2_);
   _root.updateFastBuyBtn();
}
function changeRType(r_type)
{
   _root.restoreRok = r_type;
   _level0[_root.userID].selrocket = _root.restoreRok;
   _level0[_root.userID].updateTopR();
   _root.updateRocketBtns();
   _root.HUD.thehud.rockettype = _root.restoreRok;
   var _loc2_ = "d|" + _root.restoreRok;
   _root.SendtoStream(_loc2_);
   _root.updateFastBuyBtn();
}
function getPlanetIntitial(company_id)
{
   if(company_id == 3)
   {
      return "v";
   }
   if(company_id == 1)
   {
      return "m";
   }
   if(company_id == 2)
   {
      return "e";
   }
   if(company_id == 0)
   {
      return "n";
   }
}
function sendForceInitPlayer(user_id)
{
   SendtoStream("i|" + user_id);
}
var settingsOptions = {};
var serverX;
var serverY;
var checkServerOffset;
var repairServerOffset;
var rt_doubbler = 0;
var g_Ucheck = fff(userID);
var g_AttackMode = false;
var g_OpponentsALL = new Array();
var g_Portals_ALL = new Array();
_root.station._visible = 0;
var g_username = "";
var tdm_phase;
var TDM_PRE_DRAFT = 2;
var TDM_DRAFT_FINISH = 4;
var TDM_DRAFT = 8;
var TDM_GAME_RUNNING = 16;
var predraft_time_left = 0;
var predraft_secs = 0;
var predraft_mins = 0;
var draft_time_left = 0;
var draft_secs = 0;
var draft_mins = 0;
var dmz_time_left = 0;
var game_time_left = 0;
var game_secs = 0;
var game_mins = 0;
var remote_predraft_time_left = 0;
var remote_draft_time_left = 0;
var remote_dmz_time_left = 0;
var remote_game_time_left = 0;
var specialQuestTypes = {};
var fast_repair_just_requested = false;
var tdmChanceHash = [];
tdmChanceHash[1] = "low";
tdmChanceHash[2] = "std";
tdmChanceHash[3] = "high";
cplayer.createEmptyMovieClip("curion_barrier",10);
var debugcount = 0;
initShopDb();
