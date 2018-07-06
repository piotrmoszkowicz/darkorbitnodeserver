function setupBottomHudBtn(tLabel, btn)
{
   tLabel.antiAliasType = "advanced";
   tLabel.gridFitType = "pixel";
   tLabel.sharpness = 200;
   tLabel.embedFonts = _root.defaultHudBottomMainFontEmbed;
   var _loc5_ = tLabel._width;
   var _loc4_ = tLabel._height;
   tLabel.autoSize = _root.defaultHudBottomMainAutoSize;
   tLabel.setTextFormat(_root.defaultHudBottomMainFmt);
   tLabel._y = tLabel._y + _root.defaultHudBottomMainLabelYOffset;
   tLabel._x = Math.ceil(tLabel._x);
   tLabel._width = _loc5_;
   tLabel._height = _loc4_;
   btn._y = btn._ybase = _root.defaultHudBottomMainBtnYBase;
   btn._ymin = _root.defaultHudBottomMainBtnYMin;
}
function formatGameTime(secs)
{
   mins = Math.floor(secs / 60);
   minSecs = secs - mins * 60;
   minSecsVerbose = minSecs + "";
   if(minSecs < 10)
   {
      minSecsVerbose = "0" + minSecsVerbose;
   }
   return mins + ":" + minSecsVerbose;
}
function updatePresetBtns(initialize)
{
   var _loc3_ = undefined;
   var _loc4_ = undefined;
   var _loc5_ = undefined;
   if(activePreset == 1)
   {
      _loc3_ = _root.HUD.thehud.mcChgPresetBtn.mcChg1Btn;
      _loc4_ = _root.HUD.thehud.mcChgPresetBtn.mcChg2Btn;
      _loc5_ = _root.HUD.thehud.mcChgPresetBtn.mcChg3Btn;
   }
   else if(activePreset == 2)
   {
      _loc3_ = _root.HUD.thehud.mcChgPresetBtn.mcChg2Btn;
      _loc4_ = _root.HUD.thehud.mcChgPresetBtn.mcChg1Btn;
      _loc5_ = _root.HUD.thehud.mcChgPresetBtn.mcChg3Btn;
   }
   else
   {
      _loc3_ = _root.HUD.thehud.mcChgPresetBtn.mcChg3Btn;
      _loc4_ = _root.HUD.thehud.mcChgPresetBtn.mcChg1Btn;
      _loc5_ = _root.HUD.thehud.mcChgPresetBtn.mcChg2Btn;
   }
   _loc3_.mcActiveBtn._visible = true;
   _loc3_.mcPassiveBtn._visible = false;
   _loc4_.mcActiveBtn._visible = false;
   _loc4_.mcPassiveBtn._visible = true;
   _loc5_.mcActiveBtn._visible = false;
   _loc5_.mcPassiveBtn._visible = true;
   if(_root.cfg3x_in_use)
   {
      _root.HUD.thehud.mcChgPresetBtn.mcChg3Btn._visible = true;
      _root.HUD.thehud.mcChgPresetBtn._x = 704;
   }
   else
   {
      _root.HUD.thehud.mcChgPresetBtn.mcChg3Btn._visible = false;
      _root.HUD.thehud.mcChgPresetBtn._x = 719;
   }
   if(initialize)
   {
      _root.HUD.thehud.mcChgPresetBtn.mcChg1Btn.mcPassiveBtn.gotoAndStop("std");
      _root.HUD.thehud.mcChgPresetBtn.mcChg1Btn.mcPassiveBtn.onRollOver = function()
      {
         this.gotoAndStop("hover");
      };
      _root.HUD.thehud.mcChgPresetBtn.mcChg1Btn.mcPassiveBtn.onRollOut = function()
      {
         this.gotoAndStop("std");
      };
      _root.HUD.thehud.mcChgPresetBtn.mcChg1Btn.mcPassiveBtn.onRelease = function()
      {
         if(_root.initDone)
         {
            _root.SendtoStream(this._parent._parent.cmd + "1");
         }
      };
      _root.HUD.thehud.mcChgPresetBtn.mcChg1Btn.mcActiveBtn.gotoAndStop("std");
      _root.HUD.thehud.mcChgPresetBtn.mcChg2Btn.mcPassiveBtn.gotoAndStop("std");
      _root.HUD.thehud.mcChgPresetBtn.mcChg2Btn.mcPassiveBtn.onRollOver = function()
      {
         this.gotoAndStop("hover");
      };
      _root.HUD.thehud.mcChgPresetBtn.mcChg2Btn.mcPassiveBtn.onRollOut = function()
      {
         this.gotoAndStop("std");
      };
      _root.HUD.thehud.mcChgPresetBtn.mcChg2Btn.mcPassiveBtn.onRelease = function()
      {
         if(_root.initDone)
         {
            _root.SendtoStream(this._parent._parent.cmd + "2");
         }
      };
      _root.HUD.thehud.mcChgPresetBtn.mcChg2Btn.mcActiveBtn.gotoAndStop("std");
      _root.HUD.thehud.mcChgPresetBtn.mcChg3Btn.mcPassiveBtn.gotoAndStop("std");
      _root.HUD.thehud.mcChgPresetBtn.mcChg3Btn.mcPassiveBtn.onRollOver = function()
      {
         this.gotoAndStop("hover");
      };
      _root.HUD.thehud.mcChgPresetBtn.mcChg3Btn.mcPassiveBtn.onRollOut = function()
      {
         this.gotoAndStop("std");
      };
      _root.HUD.thehud.mcChgPresetBtn.mcChg3Btn.mcPassiveBtn.onRelease = function()
      {
         if(_root.initDone)
         {
            _root.SendtoStream(this._parent._parent.cmd + "3");
         }
      };
      _root.HUD.thehud.mcChgPresetBtn.mcChg3Btn.mcActiveBtn.gotoAndStop("std");
   }
}
function trace1(msg)
{
   _root.txtDbgOutput._visible = true;
   _root.txtDbgOutput.text = _root.txtDbgOutput.text + (_root.formatTime(_root.secsElapsed) + " " + msg + "\n");
   _root.txtDbgOutput.scroll = _root.txtDbgOutput.maxscroll;
}
function initBoosterUi()
{
   var _loc2_ = _root.mcBoosterUi;
   if(_loc2_ == undefined)
   {
      _loc2_ = _root.attachMovie("boosterUi","mcBoosterUi",_root.getNextHighestDepth());
      _loc2_._y = 240;
      _loc2_._visible = false;
   }
}
function updateBoosterBar()
{
   var _loc5_ = _root.mcBoosterUi;
   boostersMax = _root.boosters.length;
   var _loc6_ = _loc5_.mcTop._y + _loc5_.mcTop._height;
   var _loc7_ = 0;
   var _loc2_ = 1;
   while(_loc2_ <= boostersMax)
   {
      var _loc3_ = _loc5_["mcBooster" + _loc2_];
      var _loc4_ = Boolean(_root.boosters[_loc2_ - 1]);
      if(_loc3_ == undefined && _loc4_)
      {
         _loc3_ = _loc5_.attachMovie("boosterBody","mcBooster" + _loc2_,_loc2_);
      }
      if(_loc4_)
      {
         _loc7_ = _loc7_ + 1;
         _loc3_.gotoAndStop("id" + _loc2_);
         _loc3_._visible = true;
         _loc3_._y = _loc6_;
         _loc6_ = _loc6_ + 23;
         _loc3_.txtBonus.text = _root.boosters[_loc2_ - 1] + "%";
      }
      else
      {
         _loc3_._visible = false;
      }
      _loc2_ = _loc2_ + 1;
   }
   _loc5_.mcBottom._y = _loc6_;
   if(_loc7_ == 0)
   {
      _loc5_._visible = false;
   }
   else
   {
      _loc5_._visible = true;
   }
}
function updateDroneCpuIndicator(cpuState)
{
   if(cpuState > 0 && cpuState < 6)
   {
      _root.HUD.thehud.mcDroCpuIndy._visible = true;
      _root.HUD.thehud.mcDroCpuIndy.gotoAndStop(cpuState);
   }
   else
   {
      _root.HUD.thehud.mcDroCpuIndy._visible = false;
   }
}
function showStarSystemMap()
{
   if(_root.uebermap == 0)
   {
      if(_root.mapID > 0 && _root.mapID < 30)
      {
         var _loc2_ = _root.attachMovie("uebermaps","uebermaps",_root.getNextHighestDepth());
         _root.playerfx("_onfx1",30);
         _loc2_._x = 36;
         _loc2_._y = 95;
         _root.uebermap = 1;
         _root.uebermaps.gotoAndStop(_root.mapID);
         _root.uebermaps.txtStarsystem.antiAliasType = "advanced";
         _root.uebermaps.txtStarsystem.autoSize = "center";
         _root.uebermaps.txtStarsystem.setTextFormat(_root.deafaultH1Fmt);
         _root.uebermaps.txtStarsystem._height = _root.defaultH1FontHeight + 8;
         _root.uebermaps.txtStarsystem.embedFonts = _root.defaultH1FontEmbed;
         _root.uebermaps.txtPortals.antiAliasType = "advanced";
         _root.uebermaps.txtPortals.autoSize = "center";
         _root.uebermaps.txtPortals.setTextFormat(_root.deafaultH1Fmt);
         _root.uebermaps.txtPortals._height = _root.defaultH1FontHeight + 8;
         _root.uebermaps.txtPortals.embedFonts = _root.defaultH1FontEmbed;
      }
   }
   else if(_root.mapID > 0 && _root.mapID < 30)
   {
   }
}
function bringQuestHudToFront()
{
   var _loc2_ = _root.mcQuestTargetLayerBig;
   _loc2_.removeMovieClip();
   _loc2_ = _root.createEmptyMovieClip("mcQuestTargetLayerBig",_root.getNextHighestDepth());
   _loc2_.swapDepths(mcQuestBugBig);
}
function handleAreaAnimationEnd()
{
   _root.resabgabe.removeMovieClip();
   _root.mcMultiAreaBar.removeMovieClip();
   _root.updateAreaHintUi();
}
function showRadiationWarningBox()
{
   if(_root.warningbox == undefined)
   {
      _root.attachMovie("radiation_alert","warningbox",_root.getNextHighestDepth());
      _root.warningbox._x = 410;
      _root.warningbox._y = 100;
      _root.warningbox.txtHead.antiAliasType = "advanced";
      _root.warningbox.txtHead.gridFitType = "pixel";
      _root.warningbox.txtHead.sharpness = 200;
      _root.warningbox.txtBody.antiAliasType = "advanced";
      _root.warningbox.txtBody.gridFitType = "pixel";
      _root.warningbox.txtBody.sharpness = 200;
      _root.warningbox.txtBody.autoSize = "center";
      _root.warningbox.txtBottom.antiAliasType = "advanced";
      _root.warningbox.txtBottom.gridFitType = "pixel";
      _root.warningbox.txtBottom.sharpness = 200;
      _root.warningbox.txtBottom.autoSize = "center";
      _root.warningbox.txtHead.setTextFormat(_root.defaultH1Fmt);
      _root.warningbox.txtHead._height = _root.defaultH1FontHeight + 6;
      _root.warningbox.txtHead.embedFonts = _root.defaultH1FontEmbed;
      _root.warningbox.txtBody.setTextFormat(_root.defaultPlainStdFmt);
      _root.warningbox.txtBody.embedFonts = _root.defaultPlainStdFontEmbed;
      _root.warningbox.txtBottom.setTextFormat(_root.defaultPlainStdFmt);
      _root.warningbox.txtBottom.embedFonts = _root.defaultPlainStdFontEmbed;
      _root.warningbox.txtBottom._y = _root.warningbox.txtBody._y + _root.warningbox.txtBody._height + 15;
      _root.warningbox.mcBg._height = _root.warningbox.txtBottom._y + _root.warningbox.txtBottom._height + 15;
      _root.warningbox.mcFx._height = _root.warningbox.mcBg._height - 30;
      _root.warningbox.mcHint.removeMovieClip();
      var _loc2_ = _root.warningbox.attachMovie("radiationHelp","mcHint",1);
      _root.mcHint = _loc2_;
      var _loc4_ = new flash.filters.GlowFilter(16777215,100,3,3,100,3);
      var _loc3_ = new flash.filters.BlurFilter(2,2,3);
      _loc2_.filters = new Array(_loc3_);
      _loc2_._x = 0;
      _loc2_._y = 200;
      updateHintRotation();
      _root.updateHintRotationinterval = setInterval(_root,"updateHintRotation",2000);
   }
}
function parseandShowStm(keysAndValues)
{
   hashKey = keysAndValues[0];
   replaceStr = keysAndValues[1];
   if(keysAndValues[2] == undefined)
   {
      if(resource[hashKey] != undefined)
      {
         if(replaceStr == undefined)
         {
            displayStatus(resource[hashKey]);
         }
         else
         {
            if(resource[replaceStr] != undefined)
            {
               replaceStr = resource[replaceStr];
            }
            var _loc2_ = resource[hashKey].split("%!");
            displayStatus(_loc2_[0] + replaceStr + _loc2_[1]);
         }
      }
   }
   else
   {
      var _loc3_ = resource[keysAndValues[0]];
      _loc2_ = _loc3_.split(keysAndValues[1]);
      _loc3_ = _loc2_[0] + keysAndValues[2] + _loc2_[1];
      if(keysAndValues[3] != undefined)
      {
         _loc2_ = _loc3_.split(keysAndValues[3]);
         _loc3_ = _loc2_[0] + keysAndValues[4] + _loc2_[1];
      }
      if(keysAndValues[5] != undefined)
      {
         _loc2_ = _loc3_.split(keysAndValues[5]);
         _loc3_ = _loc2_[0] + keysAndValues[6] + _loc2_[1];
      }
      displayStatus(_loc3_);
   }
}
function updateHintRotation()
{
   if(mcHint == undefined)
   {
      clearInterval(_root.updateHintRotationinterval);
      return undefined;
   }
   var _loc2_ = _root.centerx - _root.serverX;
   _loc2_ = _root.centerx - _level0[g_CurClientUser].theX;
   var _loc3_ = _root.centery - _root.serverY;
   _loc3_ = _root.centery - _level0[g_CurClientUser].theY;
   var _loc4_ = Math.atan2(_loc3_,_loc2_);
   var _loc5_ = _loc4_ / 3.141592653589793 * 180;
   _root.mcHint._rotation = _loc5_;
}
function showNoHitpoints()
{
   if(mcNoHitpoints == undefined)
   {
      _root.attachMovie("no_hitpoints_error","mcNoHitpoints",_root.getNextHighestDepth());
      var _loc3_ = _root.dynamicHost + "indexInternal.es?action=internalDock&flashNoHelp=1&subAction=showDroneWarning";
      var _loc2_ = "javascript: opener.location=\'" + _loc3_ + "\';this.focus();";
      _root.mcNoHitpoints.getURL(_loc2_);
      _root.mcNoHitpoints.bg.onRelease = null;
      _root.mcNoHitpoints.bg.useHandCursor = false;
      _root.mcNoHitpoints.txtHeader.text = _root.resource.log_verbindung;
      _root.mcNoHitpoints.txtHeader.antiAliasType = "advanced";
      _root.mcNoHitpoints.txtHeader.gridFitType = "pixel";
      _root.mcNoHitpoints.txtHeader.sharpness = 200;
      _root.mcNoHitpoints.txtHeader.autoSize = "left";
      _root.mcNoHitpoints.txtHeader._height = _root.easternH2FontHeight + 5;
      _root.mcNoHitpoints.txtHeader.setTextFormat(_root.defaultH2Fmt);
      _root.mcNoHitpoints.txtHeader.embedFonts = _root.defaultH2FontEmbed;
      _root.mcNoHitpoints.txtMain.text = _root.resource.nohitpoints;
      _root.mcNoHitpoints.txtMain.antiAliasType = "advanced";
      _root.mcNoHitpoints.txtMain.gridFitType = "pixel";
      _root.mcNoHitpoints.txtMain.sharpness = 200;
      _root.mcNoHitpoints.txtMain.autoSize = "left";
      _root.mcNoHitpoints.txtMain.setTextFormat(_root.defalutPlainBigFmt);
      _root.mcNoHitpoints.txtMain.embedFonts = _root.defalutPlainBigFontEmbed;
      _root.mcNoHitpoints.txtButton.text = _root.resource.sta_ok;
      _root.mcNoHitpoints.txtButton.antiAliasType = "advanced";
      _root.mcNoHitpoints.txtButton.gridFitType = "pixel";
      _root.mcNoHitpoints.txtButton.sharpness = 200;
      _root.mcNoHitpoints.txtButton.autoSize = "center;";
      _root.mcNoHitpoints.txtButton._height = _root.easternH2FontHeight + 5;
      _root.mcNoHitpoints.txtButton.setTextFormat(_root.defaultH2Fmt);
      _root.mcNoHitpoints.txtButton.embedFonts = _root.defaultH2FontEmbed;
   }
}
function showInvalidSession()
{
   if(mcInvalidSession == undefined)
   {
      _root.attachMovie("no_hitpoints_error","mcInvalidSession",_root.getNextHighestDepth());
      var _loc3_ = _root.dynamicHost + "indexInternal.es?action=internalLogout";
      var _loc2_ = "javascript: opener.location=\'" + _loc3_ + "\';this.focus();";
      _root.mcInvalidSession.getURL(_loc2_);
      _root.mcInvalidSession.bg.onRelease = null;
      _root.mcInvalidSession.bg.useHandCursor = false;
      _root.mcInvalidSession.txtHeader.text = _root.resource.log_verbindung;
      _root.mcInvalidSession.txtHeader.antiAliasType = "advanced";
      _root.mcInvalidSession.txtHeader.gridFitType = "pixel";
      _root.mcInvalidSession.txtHeader.sharpness = 200;
      _root.mcInvalidSession.txtHeader.autoSize = "left";
      _root.mcInvalidSession.txtHeader._height = _root.easternH2FontHeight + 5;
      _root.mcInvalidSession.txtHeader.setTextFormat(_root.defaultH2Fmt);
      _root.mcInvalidSession.txtHeader.embedFonts = _root.defaultH2FontEmbed;
      _root.mcInvalidSession.txtMain.text = _root.resource.invalid_session;
      _root.mcInvalidSession.txtMain.antiAliasType = "advanced";
      _root.mcInvalidSession.txtMain.gridFitType = "pixel";
      _root.mcInvalidSession.txtMain.sharpness = 200;
      _root.mcInvalidSession.txtMain.autoSize = "left";
      _root.mcInvalidSession.txtMain.setTextFormat(_root.defaultPlainBigFmt);
      _root.mcInvalidSession.txtMain.embedFonts = _root.defaultPlainBigFontEmbed;
      _root.mcInvalidSession.txtButton.text = _root.resource.sta_ok;
      _root.mcInvalidSession.txtButton.antiAliasType = "advanced";
      _root.mcInvalidSession.txtButton.gridFitType = "pixel";
      _root.mcInvalidSession.txtButton.sharpness = 200;
      _root.mcInvalidSession.txtButton.autoSize = "center;";
      _root.mcInvalidSession.txtButton._height = _root.easternH2FontHeight + 5;
      _root.mcInvalidSession.txtButton.setTextFormat(_root.defaultH2Fmt);
      _root.mcInvalidSession.txtButton.embedFonts = _root.defaultH2FontEmbed;
   }
}
function updateAlertState()
{
   if(_root.alertState < 0)
   {
      _root.HUD.mcAlertState._visible = false;
   }
   else
   {
      _root.HUD.mcAlertState._visible = true;
      _root.HUD.mcAlertState.gotoAndStop(_root.alertState + 1);
      _root.HUD.mcAlertState.cacheAsBitmap = true;
   }
}
function messageontop()
{
   if(_root.mcMultiAreaBar == undefined)
   {
      var _loc2_ = _root.attachMovie("messageswip","mcMultiAreaBar",_root.getNextHighestDepth());
      keeptop(_loc2_);
      _loc2_.onRelease = function()
      {
         _root.HUD.thehud.jumpbtn.onPress();
      };
      _loc2_.useflag = 2;
      _loc2_._x = 240;
      if(_root.toggleFullBottomHud)
      {
         _loc2_._y = 71;
      }
      else
      {
         _loc2_._y = 1071;
      }
      _loc2_.mcTradeHint.texthint = _root.resource.jumpportal;
      _loc2_.mcTradeHint.txtLabel.antiAliasType = "advanced";
      _loc2_.mcTradeHint.txtLabel.gridFitType = "pixel";
      _loc2_.mcTradeHint.txtLabel.sharpness = 200;
      _loc2_.mcTradeHint.txtLabel.setTextFormat(_root.defaultH2Fmt);
      _loc2_.mcTradeHint.txtLabel._height = _root.defaultH2FontHeight + 4;
      _loc2_.mcTradeHint.txtLabel._y = _root.defaultTradeHintProps.y;
      _loc2_.mcTradeHint.txtLabel.embedFonts = _root.defaultH1FontEmbed;
      _loc2_.mcTradeHint.txtLabel.autoSize = "center";
      if(_root.mcNoATTarea != undefined)
      {
         if(_root.mcMultiAreaBar.getDepth() > _root.mcNoATTarea.getDepth())
         {
            _root.mcNoATTarea.swapDepths(_root.mcMultiAreaBar);
         }
      }
   }
}
function setMinimapTitle()
{
   if(_root.mapID >= 101)
   {
      HUD.thehud.i_map.text = "JP";
   }
   else
   {
      HUD.thehud.i_map.text = allmapids[_root.mapID];
   }
}
function initWizHud()
{
   var _loc3_ = _root.HUD.thehud.attachMovie("wizBtn","mcWizBtn",_root.HUD.thehud.getNextHighestDepth());
   _loc3_._x = 345;
   _loc3_._y = 69;
   _loc3_.mcCooldownUI._visible = false;
   _loc3_.mcCooldownSmoother._visible = false;
   _loc3_.txtDurability.text = _root.curses_left;
   _loc3_.onRollOver = function()
   {
      if(!this.disabled)
      {
         this.gotoAndStop("hover");
      }
   };
   _loc3_.onRollOut = function()
   {
      if(!this.disabled)
      {
         this.gotoAndStop(this.stateLabel);
      }
   };
   _loc3_.onRelease = function()
   {
      if(!this.disabled)
      {
         _root.SendtoStream("S|WIZ\n");
      }
   };
}
function updateWizHud()
{
   if(_root.curses_left < 0)
   {
      _root.HUD.thehud.mcWizBtn.removeMovieClip();
      return undefined;
   }
   if(_root.HUD.thehud.mcWizBtn == undefined)
   {
      initWizHud();
   }
   if(_root.curses_left == 0 || _root.wizTicks > 0)
   {
      _root.HUD.thehud.mcWizBtn.stateLabel = "disabled";
      _root.HUD.thehud.mcWizBtn.disabled = true;
   }
   else
   {
      _root.HUD.thehud.mcWizBtn.stateLabel = "std";
      _root.HUD.thehud.mcWizBtn.disabled = false;
   }
   _root.HUD.thehud.mcWizBtn.gotoAndStop(_root.HUD.thehud.mcWizBtn.stateLabel);
   _root.HUD.thehud.mcWizBtn.txtDurability.text = _root.curses_left;
}
function updateSpecialsHud()
{
   _root.HUD.thehud.item_rob.mcAimBtn._visible = _root.aiming_cpu_on_board;
   _root.HUD.thehud.attackbtn.mcAimIndicator._visible = false;
   _root.HUD.thehud.item_rob.mcArolBtn._visible = _root.arol_cpu_on_board;
   _root.HUD.thehud.attackbtn.mcArolxIndicator._visible = false;
   _root.HUD.thehud.item_rob.mcCloakBtn._visible = _root.cloak_cpu_on_board;
   _root.HUD.thehud.item_rob.mcRobBtn._visible = _root.robOnBoard;
   _root.HUD.thehud.item_rob.mcHm7Btn._visible = _root.hm7_drone_on_board;
   _root.HUD.thehud.item_rob.mcJmpBtn._visible = _root.jump_cpu_on_board;
   if(_root.aiming_cpu_on_board)
   {
      _root.HUD.thehud.attackbtn.mcAimIndicator.gotoAndStop(_root.aiming_cpu_level);
      var _loc2_ = _root.HUD.thehud.item_rob.mcAimBtn;
      _loc2_.mcIcon.gotoAndStop("aim" + _root.aiming_cpu_level);
      _loc2_.txtDurability.text = _root.salvos_left;
      if(_root.salvos_left == 0)
      {
         _loc2_.stateLabel = "disabled";
         _loc2_.disabled = true;
      }
      else if(_root.aiming_active)
      {
         _loc2_.stateLabel = "toggle";
         _loc2_.disabled = false;
         _root.HUD.thehud.attackbtn.mcAimIndicator._visible = true;
      }
      else
      {
         _loc2_.stateLabel = "std";
         _loc2_.disabled = false;
         _root.HUD.thehud.attackbtn.mcAimIndicator._visible = false;
      }
      _loc2_.gotoAndStop(_loc2_.stateLabel);
   }
   if(_root.arol_cpu_on_board)
   {
      _loc2_ = _root.HUD.thehud.item_rob.mcArolBtn;
      if(_root.arolx_active)
      {
         _loc2_.stateLabel = "toggle";
         _loc2_.disabled = false;
         _root.HUD.thehud.attackbtn.mcArolxIndicator._visible = true;
      }
      else
      {
         _loc2_.stateLabel = "std";
         _loc2_.disabled = false;
         _root.HUD.thehud.attackbtn.mcArolxIndicator._visible = false;
      }
      _loc2_.gotoAndStop(_loc2_.stateLabel);
   }
   if(_root.cloak_cpu_on_board)
   {
      _root.HUD.thehud.item_rob.mcCloakBtn.txtDurability.text = _root.cloaks_left;
   }
   if(_root.jump_cpu_on_board)
   {
      _root.HUD.thehud.item_rob.mcJmpBtn.mcIcon.gotoAndStop("jmp" + _root.jump_cpu_id);
      _root.HUD.thehud.item_rob.mcJmpBtn.txtTarget.text = allmapids[_root.jump_cpu_target];
      _root.HUD.thehud.item_rob.mcJmpBtn.txtDurability.text = _root.cpu_jumps_left;
   }
}
function updateMineHud()
{
   _root.HUD.thehud.item_rok.mcSmartbombBtn._visible = _root.smartbomb_cpu_on_board;
   _root.HUD.thehud.item_rok.mcInstashieldBtn._visible = _root.instashield_cpu_on_board;
   if(_root.smartbomb_cpu_on_board)
   {
      _root.HUD.thehud.item_rok.mcSmartbombBtn.txtDurability.text = _root.smartbombs_left;
      if(_root.smartbombs_left <= 0 || _root.smartbombTicks > 0)
      {
         _root.HUD.thehud.item_rok.mcSmartbombBtn.stateLabel = "disabled";
         _root.HUD.thehud.item_rok.mcSmartbombBtn.disabled = true;
      }
      else
      {
         _root.HUD.thehud.item_rok.mcSmartbombBtn.stateLabel = "std";
         _root.HUD.thehud.item_rok.mcSmartbombBtn.disabled = false;
      }
      _root.HUD.thehud.item_rok.mcSmartbombBtn.gotoAndStop(_root.HUD.thehud.item_rok.mcSmartbombBtn.stateLabel);
   }
   if(_root.instashield_cpu_on_board)
   {
      _root.HUD.thehud.item_rok.mcInstashieldBtn.txtDurability.text = _root.instashields_left;
      if(_root.instashields_left <= 0 || _root.instashieldTicks > 0)
      {
         _root.HUD.thehud.item_rok.mcInstashieldBtn.stateLabel = "disabled";
         _root.HUD.thehud.item_rok.mcInstashieldBtn.disabled = true;
      }
      else
      {
         _root.HUD.thehud.item_rok.mcInstashieldBtn.stateLabel = "std";
         _root.HUD.thehud.item_rok.mcInstashieldBtn.disabled = false;
      }
      _root.HUD.thehud.item_rok.mcInstashieldBtn.gotoAndStop(_root.HUD.thehud.item_rok.mcInstashieldBtn.stateLabel);
   }
   if(_level0[g_CurClientUser].mines <= 0 || _root.mineTicks > 0)
   {
      _root.HUD.thehud.item_rok.mcMineBtn.stateLabel = "disabled";
      _root.HUD.thehud.item_rok.mcMineBtn.disabled = true;
   }
   else
   {
      _root.HUD.thehud.item_rok.mcMineBtn.stateLabel = "std";
      _root.HUD.thehud.item_rok.mcMineBtn.disabled = false;
   }
   _root.HUD.thehud.item_rok.mcMineBtn.gotoAndStop(_root.HUD.thehud.item_rok.mcMineBtn.stateLabel);
   if(_root.mine_turbo_on_board)
   {
      _root.HUD.thehud.item_rok.mcMineBtn.mcTurboIcon.gotoAndStop(_root.mine_turbo_level);
      _root.HUD.thehud.item_rok.mcMineBtn.mcTurboIcon._visible = true;
      _root.HUD.thehud.item_rok.mcSmartbombBtn.mcTurboIcon.gotoAndStop(_root.mine_turbo_level);
      _root.HUD.thehud.item_rok.mcSmartbombBtn.mcTurboIcon._visible = true;
      _root.HUD.thehud.item_rok.mcInstashieldBtn.mcTurboIcon.gotoAndStop(_root.mine_turbo_level);
      _root.HUD.thehud.item_rok.mcInstashieldBtn.mcTurboIcon._visible = true;
   }
   else
   {
      _root.HUD.thehud.item_rok.mcMineBtn.mcTurboIcon._visible = false;
      _root.HUD.thehud.item_rok.mcSmartbombBtn.mcTurboIcon._visible = false;
      _root.HUD.thehud.item_rok.mcInstashieldBtn.mcTurboIcon._visible = false;
   }
}
function showLevelUpBox()
{
   if(_root.mcQuestFinished != undefined)
   {
      return undefined;
   }
   _root.mcLevelUp.removeMovieClip();
   clearInterval(_root.hideLevelUpBoxInterval);
   var mcLevelUp = _root.attachMovie("levelUp","mcLevelUp",_root.getNextHighestDepth());
   mcLevelUp._x = 373;
   mcLevelUp._y = 124;
   _root.hideLevelUpBoxInterval = setInterval(_root,"fadeOutLevelUpBox",15000);
   if(_root.resource.lvlup_head != undefined)
   {
      mcLevelUp.txtHead.text = _root.resource.lvlup_head;
   }
   else
   {
      mcLevelUp.txtHead.text = "Congratulations!";
   }
   mcLevelUp.txtHead.autoSize = "center";
   mcLevelUp.txtHead.width = mcLevelUp.txtHead.width + 40;
   mcLevelUp.txtHead.antiAliasType = "advanced";
   mcLevelUp.txtHead.gridFitType = "pixel";
   mcLevelUp.txtHead.sharpness = 200;
   mcLevelUp.txtHead._visible = false;
   mcLevelUp.txtHead.setTextFormat(_root.defaultLevelUpHeadFmt);
   mcLevelUp.txtHead.embedFonts = _root.defaultLevelUpHeadFontEmbed;
   mcLevelUp.txtHead._height = _root.defaultLevelUpHeadFontHeight + 6;
   if(_root.resource.lvlup_msg != undefined)
   {
      var _loc3_ = _root.resource.lvlup_msg.split("%!");
      mcLevelUp.txtMsg.text = _loc3_[0] + _root.newLevel;
      if(_loc3_[1] != undefined)
      {
         mcLevelUp.txtMsg.text = mcLevelUp.txtMsg.text + _loc3_[1];
      }
      mcLevelUp.txtMsg.text = mcLevelUp.txtMsg.text + "\n";
   }
   else
   {
      mcLevelUp.txtMsg.text = "New Level: " + _root.newLevel + "\n";
   }
   if(_root.resource.lvlup_msg_p2 != undefined)
   {
      _loc3_ = _root.resource.lvlup_msg_p2.split("%!");
      mcLevelUp.txtMsg.text = mcLevelUp.txtMsg.text + (_loc3_[0] + _root.epToGo);
      if(_loc3_[1] != undefined)
      {
         mcLevelUp.txtMsg.text = mcLevelUp.txtMsg.text + _loc3_[1];
      }
      mcLevelUp.txtMsg.text = mcLevelUp.txtMsg.text + "\n";
   }
   else
   {
      mcLevelUp.txtMsg.text = "EP left for next Level: " + _root.epToGo;
   }
   mcLevelUp.txtMsg.autoSize = "center";
   mcLevelUp.txtMsg.antiAliasType = "advanced";
   mcLevelUp.txtMsg.gridFitType = "pixel";
   mcLevelUp.txtMsg.sharpness = 200;
   mcLevelUp.txtMsg._visible = false;
   mcLevelUp.txtMsg.setTextFormat(_root.defaultLevelUpMsgFmt);
   mcLevelUp.txtMsg.embedFonts = _root.defaultLevelUpMsgFontEmbed;
   mcLevelUp.gotoAndStop("std");
   mcLevelUp.mcStarPulsar.stop();
   mcLevelUp.onRelease = function()
   {
      clearInterval(_root.hideLevelUpBoxInterval);
      _root.hideLevelUpBoxInterval = setInterval(_root,"fadeOutLevelUpBox",8000);
      this.txtHead._visible = true;
      this.txtMsg._visible = true;
      this.mcShiver._visible = false;
      this.mcStar._visible = false;
      this.mcStarPulsar.play();
      this.mcLeftWing._x = mcLevelUp.txtHead._x - 5;
      this.mcRightWing._x = mcLevelUp.txtHead._x + mcLevelUp.txtHead._width + 5;
      this.onRelease = function()
      {
         this.removeMovieClip();
      };
   };
   mcLevelUp.onRollOver = function()
   {
      this.gotoAndStop("hover");
   };
   mcLevelUp.onRollOut = function()
   {
      this.gotoAndStop("std");
   };
}
function fadeOutLevelUpBox()
{
   clearInterval(_root.hideLevelUpBoxInterval);
   mcLevelUp.fadeCount = 0;
   mcLevelUp.fadeViz = 100;
   _root.mcLevelUp.onEnterFrame = function()
   {
      this.fadeViz = this.fadeViz * 0.85;
      this.fadeCount = this.fadeCount + 1;
      this._alpha = int(this.fadeViz);
      if(this.fadeCount > 30)
      {
         this._visible = false;
         this.removeMovieClip();
      }
   };
}
function removeStarAndEffect()
{
   _root.mcLevelUp.mcStarPulsar.stop();
   _root.mcLevelUp.mcStarPulsar._visible = false;
}
function showMedalBox(medal_type)
{
   _root.mcMedalFound.removeMovieClip();
   clearInterval(_root.hideMedalBoxInterval);
   var _loc4_ = undefined;
   if(medal_type == 2)
   {
      _loc4_ = "banking_tripler";
   }
   else if(medal_type == 1)
   {
      _loc4_ = "banking_quadruplicator";
   }
   else
   {
      _loc4_ = "banking_doubler";
      medal_type = 3;
   }
   var _loc3_ = _root.attachMovie("medalFound" + medal_type,"mcMedalFound",_root.getNextHighestDepth());
   _loc3_._x = 373;
   _loc3_._y = 154;
   _root.hideMedalBoxInterval = setInterval(_root,"fadeOutMedalBox",6000);
   _loc3_.txtHead.text = _root.resource.special_item_found.replacement("%!",_root.resource[_loc4_]);
   _loc3_.txtHead.autoSize = "center";
   _loc3_.txtHead.width = _loc3_.txtHead.width + 40;
   _loc3_.txtHead.antiAliasType = "advanced";
   _loc3_.txtHead.gridFitType = "pixel";
   _loc3_.txtHead.sharpness = 200;
   _loc3_.gotoAndStop("std");
   _loc3_.mcCirclePulsar.stop();
   _loc3_.onRelease = function()
   {
      clearInterval(_root.hideMedalBoxInterval);
      this.removeMovieClip();
   };
   _loc3_.onRollOver = function()
   {
      this.gotoAndStop("hover");
   };
   _loc3_.onRollOut = function()
   {
      this.gotoAndStop("std");
   };
}
function fadeOutMedalBox()
{
   clearInterval(_root.hideMedalBoxInterval);
   _root.mcMedalFound.fadeCount = 0;
   _root.mcMedalFound.fadeViz = 100;
   _root.mcMedalFound.onEnterFrame = function()
   {
      this.fadeViz = this.fadeViz * 0.85;
      this.fadeCount = this.fadeCount + 1;
      this._alpha = int(this.fadeViz);
      if(this.fadeCount > 30)
      {
         this._visible = false;
         this.removeMovieClip();
      }
   };
}
function showQuestFinishBox(quest_id, rating_points, sticky, resource_title_key, resource_msg_key)
{
   _root.mcLevelUp.removeMovieClip();
   clearInterval(_root.hideLevelUpBoxInterval);
   _root.mcQuestFinished.removeMovieClip();
   clearInterval(_root.hideQuestFinishBoxInterval);
   var _loc3_ = _root.attachMovie("questFinished","mcQuestFinished",_root.getNextHighestDepth());
   _loc3_._x = 373;
   _loc3_._y = 154;
   if(sticky == undefined || sticky == false)
   {
      _root.hideQuestFinishBoxInterval = setInterval(_root,"fadeOutQuestFinishBox",6000);
   }
   _loc3_.txtHead.text = _root.resource.lvlup_head;
   _loc3_.txtHead.autoSize = "center";
   _loc3_.txtHead.width = _loc3_.txtHead.width + 40;
   _loc3_.txtHead.antiAliasType = "advanced";
   _loc3_.txtHead.gridFitType = "pixel";
   _loc3_.txtHead.sharpness = 200;
   _loc3_.txtHead._visible = false;
   _loc3_.txtHead.setTextFormat(_root.defaultLevelUpHeadFmt);
   _loc3_.txtHead.embedFonts = _root.defaultLevelUpHeadFontEmbed;
   _loc3_.txtHead._height = _root.defaultLevelUpHeadFontHeight + 6;
   if(resource_title_key == undefined)
   {
      _loc3_.txtMsg.text = _root.resource.sta_quest;
   }
   else
   {
      _loc3_.txtMsg.text = _root.resource[resource_title_key];
   }
   if(resource_msg_key == undefined)
   {
      var _loc7_ = _root.resource.quest_success.split("\"XXX\"");
      _loc3_.fullMsg = _loc7_[0] + "\n\"" + _root.getQuestTitle(quest_id) + "\"" + _loc7_[1];
   }
   else
   {
      _loc3_.fullMsg = _root.resource[resource_msg_key];
      var _loc5_ = _root.resource[resource_msg_key].split("%faction%");
      if(_loc5_.length > 1)
      {
         var _loc8_ = _root.factions_ids[_level0[_root.g_CurClientUser].fractionID];
         _loc3_.fullMsg = _loc5_[0] + _loc8_ + _loc5_[1];
      }
      var _loc4_ = _loc3_.fullMsg.split("\\n");
      if(_loc4_.length > 0)
      {
         _loc3_.fullMsg = _loc4_[0];
      }
      l = 1;
      while(l < _loc4_.length)
      {
         _loc3_.fullMsg = _loc3_.fullMsg + ("\n" + _loc4_[l]);
         l++;
      }
   }
   if(rating_points > 0)
   {
      var _loc6_ = _root.resource.quest_rating_verbose.split("%POINTS%");
      _loc3_.fullMsg = _loc3_.fullMsg + ("\n" + _loc6_[0] + rating_points + _loc6_[1]);
   }
   _loc3_.txtMsg.autoSize = "center";
   _loc3_.txtMsg.antiAliasType = "advanced";
   _loc3_.txtMsg.gridFitType = "pixel";
   _loc3_.txtMsg.sharpness = 200;
   _loc3_.txtMsg.setTextFormat(_root.defaultLevelUpMsgFmt);
   _loc3_.txtMsg.embedFonts = _root.defaultLevelUpMsgFontEmbed;
   _loc3_.gotoAndStop("std");
   _loc3_.mcStarPulsar.stop();
   _loc3_.onRelease = function()
   {
      clearInterval(_root.hideQuestFinishBoxInterval);
      _root.hideQuestFinishBoxInterval = setInterval(_root,"fadeOutQuestFinishBox",8000);
      this.txtMsg.text = this.fullMsg;
      this.txtMsg.setTextFormat(_root.defaultLevelUpMsgFmt);
      this.txtHead._visible = true;
      this.mcShiver._visible = false;
      this.mcStar._visible = false;
      this.mcStarPulsar.play();
      this.mcLeftWing._x = this.txtHead._x - 5;
      this.mcRightWing._x = this.txtHead._x + this.txtHead._width + 5;
      this.onRelease = function()
      {
         this.removeMovieClip();
      };
   };
   _loc3_.onRollOver = function()
   {
      this.gotoAndStop("hover");
   };
   _loc3_.onRollOut = function()
   {
      this.gotoAndStop("std");
   };
}
function fadeOutQuestFinishBox()
{
   clearInterval(_root.hideQuestFinishBoxInterval);
   _root.mcQuestFinished.fadeCount = 0;
   _root.mcQuestFinished.fadeViz = 100;
   _root.mcQuestFinished.onEnterFrame = function()
   {
      this.fadeViz = this.fadeViz * 0.85;
      this.fadeCount = this.fadeCount + 1;
      this._alpha = int(this.fadeViz);
      if(this.fadeCount > 30)
      {
         this._visible = false;
         this.removeMovieClip();
      }
   };
}
function showLaserMax(attacker_id)
{
}
function spawnAtDoor(ship_id)
{
   var _loc4_ = int(Math.random() * 2 + 1) * 10;
   var _loc3_ = int(Math.random() * 2 + 1) * 10;
   var _loc2_ = _loc4_;
   if(_loc2_ == 10)
   {
      _loc2_ = _loc2_ + int(Math.random() * 6 + 1);
   }
   else
   {
      _loc2_ = _loc2_ + int(Math.random() * 4 + 1);
   }
   var _loc1_ = int(Math.random() * 4 + 1);
   if(_loc1_ + _loc3_ == _loc2_)
   {
      if(_loc1_ == 1)
      {
         _loc1_ = 2;
      }
      else
      {
         _loc1_ = 1;
      }
   }
   _loc1_ = _loc1_ + _loc3_;
   cplayer[ship_id].bild["mcDoor" + _loc2_].gotoAndPlay("initOpen");
   cplayer[ship_id].bild["mcDoor" + _loc1_].gotoAndPlay("initOpen");
}
function closeTradeDialog()
{
   _root.g_handel = 0;
   if(_root.hm7_in_use && !_root.in_trade_zone)
   {
      _root.resabgabe.removeMovieClip();
      if(_root.resources_traded)
      {
         _level0[_root.g_CurClientUser].mcHm7.stop();
         _level0[_root.g_CurClientUser].mcHm7._visible = true;
         _level0[_root.g_CurClientUser].mcHm7.play();
      }
   }
   else
   {
      _root.resabgabe.gotoAndStop(1);
   }
   _root.keeptop(_root.mcInstaRepBtn);
   _root.hm7_in_use = false;
   updateAreaHintUi(true,true,true);
}
function updateAreaHintUi(dmz_notify, trade_zone_notify, jump_area_notify)
{
   if(_root.hm7_in_use)
   {
      if(_root.in_trade_zone)
      {
         if(_root.g_handel != 1)
         {
            resabgabe.useflag = 3;
            resabgabe.gotoAndStop(2);
            _level0[_root.g_CurClientUser].spchood = false;
            _root.g_handel = 1;
         }
      }
      else if(_root.g_handel != 1)
      {
         var resabgabe = _root.attachMovie("resabgabe","resabgabe",_root.getNextHighestDepth());
         resabgabe.resbut.useflag = 2;
         _root.SendtoStream("b");
         resabgabe._x = 10;
         if(_root.toggleFullBottomHud)
         {
            resabgabe._y = 437;
         }
         else
         {
            resabgabe._y = -563;
         }
         _level0[_root.g_CurClientUser].spchood = false;
         resabgabe.useflag = 3;
         resabgabe.gotoAndStop(2);
         _root.g_handel = 1;
         if(_root.mcNoATTarea != undefined)
         {
            _root.mcNoATTarea.removeMovieClip();
         }
         if(_root.mcMultiAreaBar != undefined)
         {
            _root.mcMultiAreaBar.removeMovieClip();
         }
      }
   }
   else
   {
      if(_root.in_dmz)
      {
         if(_root.mcNoATTarea == undefined)
         {
            _root.attachMovie("noATTarea","mcNoATTarea",_root.getNextHighestDepth());
            _root.mcNoATTarea._x = 410;
            if(_root.toggleFullBottomHud)
            {
               _root.mcNoATTarea._y = 73;
            }
            else
            {
               _root.mcNoATTarea._y = 40;
            }
            _root.mcNoATTarea.txtLabel.text = _root.resource.up_warning;
            _root.mcNoATTarea.txtLabel.antiAliasType = "advanced";
            _root.mcNoATTarea.txtLabel.gridFitType = "pixel";
            _root.mcNoATTarea.txtLabel.sharpness = 200;
            _root.mcNoATTarea.txtLabel.autoSize = "center";
            _root.mcNoATTarea.txtLabel.setTextFormat(_root.defaultH3Fmt);
            _root.mcNoATTarea.txtLabel._height = _root.defaultH3FontHeight + 2;
            _root.mcNoATTarea.txtLabel.embedFonts = _root.defaultH3FontEmbed;
            _root.mcNoATTarea.txtLabel.filters = [_root.statusGlowFilter];
         }
      }
      else if(_root.mcNoATTarea != undefined)
      {
         removeMovieClip(_root.mcNoATTarea);
      }
      if(_root.in_trade_zone)
      {
         if(_root.resabgabe == undefined)
         {
            var resabgabe = _root.attachMovie("resabgabe","resabgabe",_root.getNextHighestDepth());
            resabgabe.resbut.mcTradeHint.texthint = _root.resource.sta_rohstoff;
            resabgabe.resbut.mcTradeHint.txtLabel.autoSize = "center";
            resabgabe.resbut.mcTradeHint.txtLabel.antiAliasType = "advanced";
            resabgabe.resbut.useflag = 2;
            _root.SendtoStream("b");
            resabgabe._x = 10;
            if(_root.toggleFullBottomHud)
            {
               resabgabe._y = 443;
            }
            else
            {
               resabgabe._y = -557;
            }
            _level0[_root.g_CurClientUser].spchood = false;
         }
      }
      else
      {
         _root.g_handel = 0;
         _level0[_root.g_CurClientUser].spchood = false;
         if(_root.resabgabe != undefined)
         {
            _root.resabgabe.resbut.useflag = 1;
            _root.resabgabe.resbut.gotoAndPlay(89);
         }
      }
      if(_root.in_jump_area)
      {
         _root.HUD.thehud.jumpbtn.onRollOver();
         _root.HUD.thehud.jumpbtn.special = true;
         _root.messageontop();
      }
      else
      {
         _root.HUD.thehud.jumpbtn.special = false;
         _root.HUD.thehud.jumpbtn.onRollOut();
         _root.mcMultiAreaBar.gotoAndPlay(89);
      }
   }
}
function toggleSwitchShowBoxes()
{
   if(_root.toggleShowBoxes)
   {
      _root.scr._visible = false;
   }
   else
   {
      _root.scr._visible = true;
   }
   _root.toggleShowBoxes = !_root.toggleShowBoxes;
}
function toggleSwitchShowHud()
{
   if(_root.toggleFullBottomHud)
   {
      _root.HUD._y = _root.HUD._y + 1000;
      _root.BGHUD._y = _root.BGHUD._y + 1000;
      _root.chat._y = _root.chat._y + 1000;
      _root.HUD.thehud.mcWizBtn._y = _root.HUD.thehud.mcWizBtn._y + 1000;
      _root.mcMultiAreaBar._y = _root.mcMultiAreaBar._y - 1000;
      _root.UPHUDBG._y = _root.UPHUDBG._y - 1000;
      _root.debugbox._y = _root.debugbox._y - 1000;
      _root.gameSettings._y = _root.gameSettings._y - 1000;
      _root.mcQuestBugBig._y = _root.mcQuestBugBig._y - 1000;
      _root.mcQuestBugSmall._y = _root.mcQuestBugSmall._y - 1000;
      _root.mcBoosterUi._y = _root.mcBoosterUi._y - 1000;
      _root.resabgabe._y = -563;
      _root.mcNoATTarea._y = 40;
      _root.mcInstaRepBtn._y = _root.mcInstaRepBtn._y - 1000;
      _root.mcInvasionScorebug._y = _root.mcInvasionScorebug._y - 1000;
      _root.toggleFullBottomHud = !_root.toggleFullBottomHud;
      toggleSwitchShowMinimap();
   }
   else
   {
      if(!_root.toggleMinimap)
      {
         toggleSwitchShowMinimap();
      }
      _root.HUD._y = _root.HUD._y - 1000;
      _root.BGHUD._y = _root.BGHUD._y - 1000;
      _root.mcMultiAreaBar._y = _root.mcMultiAreaBar._y + 1000;
      _root.UPHUDBG._y = _root.UPHUDBG._y + 1000;
      _root.debugbox._y = _root.debugbox._y + 1000;
      _root.gameSettings._y = _root.gameSettings._y + 1000;
      _root.mcQuestBugBig._y = _root.mcQuestBugBig._y + 1000;
      _root.mcQuestBugSmall._y = _root.mcQuestBugSmall._y + 1000;
      _root.mcBoosterUi._y = _root.mcBoosterUi._y + 1000;
      _root.resabgabe._y = 441;
      _root.HUD.thehud.mcWizBtn._y = _root.HUD.thehud.mcWizBtn._y - 1000;
      _root.mcNoATTarea._y = 71;
      _root.chat._y = _root.chat._y - 1000;
      _root.mcInstaRepBtn._y = _root.mcInstaRepBtn._y + 1000;
      _root.mcInvasionScorebug._y = _root.mcInvasionScorebug._y + 1000;
      _root.toggleFullBottomHud = !_root.toggleFullBottomHud;
   }
}
function toggleSwitchShowMinimap()
{
   if(_root.toggleFullBottomHud)
   {
      return undefined;
   }
   if(_root.toggleMinimap)
   {
      _root.HUD._y = _root.HUD._y - 1000;
      _root.HUD.btnStarsystem._y = _root.HUD.btnStarsystem._y + 1000;
      _root.HUD.thehud.mcChgPresetBtn._y = _root.HUD.thehud.mcChgPresetBtn._y + 1000;
      _root.HUD.thehud.mcStarstystemBtnBg._y = _root.HUD.thehud.mcStarstystemBtnBg._y + 1000;
      _root.HUD.thehud.u_hud._y = _root.HUD.thehud.u_hud._y + 1000;
      _root.HUD.thehud.item_rok._y = _root.HUD.thehud.item_rok._y + 1000;
      _root.HUD.thehud.item_las._y = _root.HUD.thehud.item_las._y + 1000;
      _root.HUD.thehud.item_rob._y = _root.HUD.thehud.item_rob._y + 1000;
      _root.HUD.thehud.mcFastBuyBtn._y = _root.HUD.thehud.mcFastBuyBtn._y + 1000;
      _root.HUD.thehud.txtLaserAttack._y = _root.HUD.thehud.txtLaserAttack._y + 1000;
      _root.HUD.thehud.txtRocketAttack._y = _root.HUD.thehud.txtRocketAttack._y + 1000;
      _root.HUD.thehud.txtLaserSelect._y = _root.HUD.thehud.txtLaserSelect._y + 1000;
      _root.HUD.thehud.txtRocketSelect._y = _root.HUD.thehud.txtRocketSelect._y + 1000;
      _root.HUD.thehud.txtPortalJump._y = _root.HUD.thehud.txtPortalJump._y + 1000;
      _root.HUD.thehud.txtRobotAndExtras._y = _root.HUD.thehud.txtRobotAndExtras._y + 1000;
      _root.HUD.thehud.mcDroCpuIndy._y = _root.HUD.thehud.mcDroCpuIndy._y + 1000;
      _root.HUD.thehud.mcLaserGfxIco._visible = false;
      _root.HUD.thehud.attackbtn._visible = false;
      _root.HUD.thehud.racketebtn._visible = false;
      _root.HUD.thehud.laserbtn._visible = false;
      _root.HUD.thehud.xprocket._visible = false;
      _root.HUD.thehud.jumpbtn._visible = false;
      _root.HUD.thehud.extras._visible = false;
   }
   else
   {
      _root.HUD._y = _root.HUD._y + 1000;
      _root.HUD.btnStarsystem._y = _root.HUD.btnStarsystem._y - 1000;
      _root.HUD.thehud.mcChgPresetBtn._y = _root.HUD.thehud.mcChgPresetBtn._y - 1000;
      _root.HUD.thehud.mcStarstystemBtnBg._y = _root.HUD.thehud.mcStarstystemBtnBg._y - 1000;
      _root.HUD.thehud.u_hud._y = _root.HUD.thehud.u_hud._y - 1000;
      _root.HUD.thehud.item_rok._y = _root.HUD.thehud.item_rok._y - 1000;
      _root.HUD.thehud.item_las._y = _root.HUD.thehud.item_las._y - 1000;
      _root.HUD.thehud.item_rob._y = _root.HUD.thehud.item_rob._y - 1000;
      _root.HUD.thehud.mcFastBuyBtn._y = _root.HUD.thehud.mcFastBuyBtn._y - 1000;
      _root.HUD.thehud.txtLaserAttack._y = _root.HUD.thehud.txtLaserAttack._y - 1000;
      _root.HUD.thehud.txtRocketAttack._y = _root.HUD.thehud.txtRocketAttack._y - 1000;
      _root.HUD.thehud.txtLaserSelect._y = _root.HUD.thehud.txtLaserSelect._y - 1000;
      _root.HUD.thehud.txtRocketSelect._y = _root.HUD.thehud.txtRocketSelect._y - 1000;
      _root.HUD.thehud.txtPortalJump._y = _root.HUD.thehud.txtPortalJump._y - 1000;
      _root.HUD.thehud.txtRobotAndExtras._y = _root.HUD.thehud.txtRobotAndExtras._y - 1000;
      _root.HUD.thehud.mcDroCpuIndy._y = _root.HUD.thehud.mcDroCpuIndy._y - 1000;
      _root.HUD.thehud.mcLaserGfxIco._visible = true;
      _root.HUD.thehud.attackbtn._visible = true;
      _root.HUD.thehud.racketebtn._visible = true;
      _root.HUD.thehud.laserbtn._visible = true;
      _root.HUD.thehud.xprocket._visible = true;
      _root.HUD.thehud.jumpbtn._visible = true;
      _root.HUD.thehud.extras._visible = true;
   }
   _root.toggleMinimap = !_root.toggleMinimap;
}
function toggleFPSMeter()
{
   _root.HUD.mcFPSMeter._visible = !_root.HUD.mcFPSMeter._visible;
}
function toggleSwitchChangeConfig()
{
   if(!_root.initDone)
   {
      return undefined;
   }
   if(_root.activePreset == 1)
   {
      _root.HUD.thehud.mcChgPresetBtn.mcChg2Btn.mcPassiveBtn.onRelease();
   }
   else if(_root.activePreset == 2 && _root.cfg3x_in_use)
   {
      _root.HUD.thehud.mcChgPresetBtn.mcChg3Btn.mcPassiveBtn.onRelease();
   }
   else
   {
      _root.HUD.thehud.mcChgPresetBtn.mcChg1Btn.mcPassiveBtn.onRelease();
   }
}
function updateAltHpBar(ratio)
{
   ratio = Math.floor(ratio * 100);
   if(ratio > 0)
   {
      if(!_root.mcHudTopAlt.mcHpLeft._visible)
      {
         _root.mcHudTopAlt.mcHpLeft._visible = true;
         _root.mcHudTopAlt.mcHpBody._visible = true;
         _root.mcHudTopAlt.mcHpRight._visible = true;
      }
      if(ratio == 1)
      {
         _root.mcHudTopAlt.mcHpBody._width = 0;
         _root.mcHudTopAlt.mcHpRight._x = _root.mcHudTopAlt.mcHpLeft._x + 1;
      }
      else
      {
         _root.mcHudTopAlt.mcHpBody._width = Math.floor(ratio * 1.25 - 2);
         _root.mcHudTopAlt.mcHpRight._x = _root.mcHudTopAlt.mcHpBody._x + _root.mcHudTopAlt.mcHpBody._width;
      }
   }
   else
   {
      _root.mcHudTopAlt.mcHpLeft._visible = false;
      _root.mcHudTopAlt.mcHpBody._visible = false;
      _root.mcHudTopAlt.mcHpRight._visible = false;
   }
}
function updateAltShieldBar(ratio)
{
   ratio = Math.floor(ratio * 100);
   if(ratio > 0)
   {
      if(!_root.mcHudTopAlt.mcShieldRight._visible)
      {
         _root.mcHudTopAlt.mcShieldLeft._visible = true;
         _root.mcHudTopAlt.mcShieldBody._visible = true;
         _root.mcHudTopAlt.mcShieldRight._visible = true;
      }
      if(ratio == 1)
      {
         _root.mcHudTopAlt.mcShieldBody._width = 0;
         _root.mcHudTopAlt.mcShieldLeft._x = _root.mcHudTopAlt.mcShieldRight._x - 1;
      }
      else
      {
         _root.mcHudTopAlt.mcShieldBody._width = Math.floor(ratio * 1.25 - 2);
         _root.mcHudTopAlt.mcShieldBody._x = _root.mcHudTopAlt.mcShieldRight._x - _root.mcHudTopAlt.mcShieldBody._width;
         _root.mcHudTopAlt.mcShieldLeft._x = _root.mcHudTopAlt.mcShieldBody._x - _root.mcHudTopAlt.mcShieldLeft._width;
      }
   }
   else
   {
      _root.mcHudTopAlt.mcShieldLeft._visible = false;
      _root.mcHudTopAlt.mcShieldBody._visible = false;
      _root.mcHudTopAlt.mcShieldRight._visible = false;
   }
}
function updateLaserBtns()
{
   i = 0;
   while(i < laserTypeCount)
   {
      var _loc3_ = _root.HUD.thehud.item_las["mcLtype" + (i + 1) + "Btn"];
      if(_root.restoreLas == i + 1)
      {
         _loc3_.stateLabel = "active";
      }
      else
      {
         _loc3_.stateLabel = "std";
      }
      _loc3_.gotoAndStop(_loc3_.stateLabel);
      _loc3_.l_type = i + 1;
      _loc3_.mcIcon.gotoAndStop(i + 1);
      _loc3_.onRollOver = function()
      {
         this.gotoAndStop("hover");
      };
      _loc3_.onRollOut = function()
      {
         this.gotoAndStop(this.stateLabel);
      };
      _loc3_.onRelease = function()
      {
         _root.changeLType(this.l_type);
         this.stateLabel = "active";
         this.gotoAndStop(this.stateLabel);
      };
      i++;
   }
}
function updateRocketBtns()
{
   i = 0;
   while(i < rocketTypeCount)
   {
      var _loc3_ = _root.HUD.thehud.item_rok["mcRtype" + (i + 1) + "Btn"];
      if(_root.restoreRok == i + 1)
      {
         _loc3_.stateLabel = "active";
      }
      else
      {
         _loc3_.stateLabel = "std";
      }
      _loc3_.gotoAndStop(_loc3_.stateLabel);
      _loc3_.r_type = i + 1;
      _loc3_.mcIcon.gotoAndStop(i + 1);
      _loc3_.onRollOver = function()
      {
         this.gotoAndStop("hover");
      };
      _loc3_.onRollOut = function()
      {
         this.gotoAndStop(this.stateLabel);
      };
      _loc3_.onRelease = function()
      {
         _root.changeRType(this.r_type);
         this.stateLabel = "active";
         this.gotoAndStop(this.stateLabel);
      };
      i++;
   }
}
function updateMineBtns()
{
   var _loc3_ = _root.HUD.thehud.item_rok.mcMineBtn;
   _loc3_.stateLabel = "std";
   _loc3_.gotoAndStop(_loc3_.stateLabel);
   _loc3_.mcIcon.gotoAndStop("mine");
   _loc3_.mcTurboIcon.gotoAndStop(1);
   _loc3_.mcTurboIcon._visible = false;
   _loc3_.txtDurability.text = "";
   _loc3_.mcCooldownUI._visible = false;
   _loc3_.mcCooldownSmoother._visible = false;
   _loc3_.onRollOver = function()
   {
      if(!this.disabled)
      {
         this.gotoAndStop("hover");
      }
   };
   _loc3_.onRollOut = function()
   {
      if(!this.disabled)
      {
         this.gotoAndStop(this.stateLabel);
      }
   };
   _loc3_.onRelease = function()
   {
      if(!this.disabled)
      {
         _root.SendtoStream("S|MIN\n");
      }
   };
   var _loc4_ = _root.HUD.thehud.item_rok.mcSmartbombBtn;
   _loc4_.stateLabel = "std";
   _loc4_.gotoAndStop(_loc4_.stateLabel);
   _loc4_.mcIcon.gotoAndStop("smb");
   _loc4_.mcTurboIcon.gotoAndStop(1);
   _loc4_.mcTurboIcon._visible = false;
   _loc4_.disabled = false;
   _loc4_.mcCooldownUI._visible = false;
   _loc4_.mcCooldownSmoother._visible = false;
   _loc4_.onRollOver = function()
   {
      if(!this.disabled)
      {
         this.gotoAndStop("hover");
      }
   };
   _loc4_.onRollOut = function()
   {
      if(!this.disabled)
      {
         this.gotoAndStop(this.stateLabel);
      }
   };
   _loc4_.onRelease = function()
   {
      if(!this.disabled)
      {
         _root.SendtoStream("S|SMB\n");
      }
   };
   var _loc5_ = _root.HUD.thehud.item_rok.mcInstashieldBtn;
   _loc5_.stateLabel = "std";
   _loc5_.gotoAndStop(_loc5_.stateLabel);
   _loc5_.mcIcon.gotoAndStop("ish");
   _loc5_.mcTurboIcon.gotoAndStop(1);
   _loc5_.mcTurboIcon._visible = false;
   _loc5_.disabled = false;
   _loc5_.mcCooldownUI._visible = false;
   _loc5_.mcCooldownSmoother._visible = false;
   _loc5_.onRollOver = function()
   {
      if(!this.disabled)
      {
         this.gotoAndStop("hover");
      }
   };
   _loc5_.onRollOut = function()
   {
      if(!this.disabled)
      {
         this.gotoAndStop(this.stateLabel);
      }
   };
   _loc5_.onRelease = function()
   {
      if(!this.disabled)
      {
         _root.SendtoStream("S|ISH\n");
      }
   };
}
function cooldown(weapon)
{
   if(weapon == _root.COOLDOWN_SMARTBOMB)
   {
      clearInterval(_global.smartbombTimer);
      clearInterval(_global.smoothProgressSmartbombTimer);
      _root.smartbombTicks = _root.cooldownTimeSmartbomb;
      var _loc4_ = _root.HUD.thehud.item_rok.mcSmartbombBtn;
      _loc4_.disabled = true;
      _loc4_.stateLabel = "disabled";
      _loc4_.gotoAndStop(_loc4_.stateLabel);
      _loc4_.mcCooldownUI._visible = true;
      _loc4_.mcCooldownUI.cacheAsBitmap = true;
      _loc4_.mcCooldownUI.mcMask._yscale = (_root.smartbombTicks - 1) / _root.cooldownTimeSmartbomb * 100;
      _loc4_.mcCooldownSmoother._visible = true;
      _loc4_.mcCooldownSmoother.cacheAsBitmap = true;
      _loc4_.mcCooldownSmoother.mcMask._yscale = 100;
      _global.smartbombTimer = setInterval(_root.cooldownProgressSmartbomb,1000);
      _global.smoothProgressSmartbombTimer = setInterval(_root.smoothProgressSmartbomb,200);
   }
   else if(weapon == _root.COOLDOWN_INSTASHIELD)
   {
      clearInterval(_global.instashieldTimer);
      clearInterval(_global.smoothProgressInstashieldTimer);
      _root.instashieldTicks = _root.cooldownTimeInstashield;
      var _loc5_ = _root.HUD.thehud.item_rok.mcInstashieldBtn;
      _loc5_.disabled = true;
      _loc5_.stateLabel = "disabled";
      _loc5_.gotoAndStop(_loc5_.stateLabel);
      _loc5_.mcCooldownUI._visible = true;
      _loc5_.mcCooldownUI.cacheAsBitmap = true;
      _loc5_.mcCooldownUI.mcMask._yscale = (_root.instashieldTicks - 1) / _root.cooldownTimeInstashield * 100;
      _loc5_.mcCooldownSmoother._visible = true;
      tmpBtn.mcCooldownSmoother.cacheAsBitmap = true;
      _loc5_.mcCooldownSmoother.mcMask._yscale = 100;
      _global.instashieldTimer = setInterval(_root.cooldownProgressInstahield,1000);
      _global.smoothProgressInstashieldTimer = setInterval(_root.smoothProgressInstahield,200);
   }
   else if(weapon == _root.COOLDOWN_MINE)
   {
      clearInterval(_global.mineTimer);
      clearInterval(_global.smoothProgressMineTimer);
      _root.mineTicks = _root.cooldownTimeMine;
      var _loc3_ = _root.HUD.thehud.item_rok.mcMineBtn;
      _loc3_.disabled = true;
      _loc3_.stateLabel = "disabled";
      _loc3_.gotoAndStop(_loc3_.stateLabel);
      _loc3_.mcCooldownUI._visible = true;
      _loc3_.mcCooldownUI.cacheAsBitmap = true;
      _loc3_.mcCooldownUI.mcMask._yscale = (_root.mineTicks - 1) / _root.cooldownTimeMine * 100;
      _loc3_.mcCooldownSmoother._visible = true;
      _loc3_.mcCooldownSmoother.cacheAsBitmap = true;
      _loc3_.mcCooldownSmoother.mcMask._yscale = 100;
      _global.mineTimer = setInterval(_root.cooldownProgressMine,1000);
      _global.smoothProgressMineTimer = setInterval(_root.smoothProgressMine,200);
   }
}
function cooldownProgressSmartbomb()
{
   _root.smartbombTicks = _root.smartbombTicks - 1;
   _root.HUD.thehud.item_rok.mcSmartbombBtn.mcCooldownSmoother.mcMask._yscale = _root.smartbombTicks / _root.cooldownTimeSmartbomb * 100;
   _root.HUD.thehud.item_rok.mcSmartbombBtn.mcCooldownSmoother._alpha = 100;
   _root.HUD.thehud.item_rok.mcSmartbombBtn.mcCooldownUI.mcMask._yscale = (_root.smartbombTicks - 1) / _root.cooldownTimeSmartbomb * 100;
   if(_root.smartbombTicks <= 0)
   {
      clearInterval(_global.smartbombTimer);
      clearInterval(_global.smoothProgressSmartbombTimer);
      _root.HUD.thehud.item_rok.mcSmartbombBtn.mcCooldownUI._visible = false;
      _root.HUD.thehud.item_rok.mcSmartbombBtn.mcCooldownSmoother._visible = false;
   }
}
function smoothProgressSmartbomb()
{
   _root.HUD.thehud.item_rok.mcSmartbombBtn.mcCooldownSmoother._alpha = _root.HUD.thehud.item_rok.mcSmartbombBtn.mcCooldownSmoother._alpha - 20;
}
function cooldownProgressInstahield()
{
   _root.instashieldTicks = _root.instashieldTicks - 1;
   _root.HUD.thehud.item_rok.mcInstashieldBtn.mcCooldownSmoother.mcMask._yscale = _root.instashieldTicks / _root.cooldownTimeInstashield * 100;
   _root.HUD.thehud.item_rok.mcInstashieldBtn.mcCooldownSmoother._alpha = 100;
   _root.HUD.thehud.item_rok.mcInstashieldBtn.mcCooldownUI.mcMask._yscale = (_root.instashieldTicks - 1) / _root.cooldownTimeInstashield * 100;
   if(_root.instashieldTicks <= 0)
   {
      clearInterval(_global.instashieldTimer);
      clearInterval(_global.smoothProgressInstashieldTimer);
      _root.HUD.thehud.item_rok.mcInstashieldBtn.mcCooldownUI._visible = false;
      _root.HUD.thehud.item_rok.mcInstashieldBtn.mcCooldownSmoother._visible = false;
   }
}
function smoothProgressInstahield()
{
   _root.HUD.thehud.item_rok.mcInstashieldBtn.mcCooldownSmoother._alpha = _root.HUD.thehud.item_rok.mcInstashieldBtn.mcCooldownSmoother._alpha - 20;
}
function cooldownProgressMine()
{
   _root.mineTicks = _root.mineTicks - 1;
   _root.HUD.thehud.item_rok.mcMineBtn.mcCooldownSmoother.mcMask._yscale = _root.mineTicks / _root.cooldownTimeMine * 100;
   _root.HUD.thehud.item_rok.mcMineBtn.mcCooldownSmoother._alpha = 100;
   _root.HUD.thehud.item_rok.mcMineBtn.mcCooldownUI.mcMask._yscale = (_root.mineTicks - 1) / _root.cooldownTimeMine * 100;
   if(_root.mineTicks <= 0)
   {
      clearInterval(_global.mineTimer);
      clearInterval(_global.smoothProgressMineTimer);
      _root.HUD.thehud.item_rok.mcMineBtn.mcCooldownUI._visible = false;
      _root.HUD.thehud.item_rok.mcMineBtn.mcCooldownSmoother._visible = false;
   }
}
function smoothProgressMine()
{
   _root.HUD.thehud.item_rok.mcMineBtn.mcCooldownSmoother._alpha = _root.HUD.thehud.item_rok.mcMineBtn.mcCooldownSmoother._alpha - 20;
}
function finish_cooldown(weapon)
{
   var _loc3_ = undefined;
   if(weapon == _root.COOLDOWN_SMARTBOMB)
   {
      clearInterval(_global.smartbombTimer);
      clearInterval(_global.smoothProgressSmartbombTimer);
      _root.smartbombTicks = 0;
      _loc3_ = _root.HUD.thehud.item_rok.mcSmartbombBtn;
      _loc3_.txtDurability.text = _root.smartbombs_left;
      if(_root.smartbombs_left == 0)
      {
         _loc3_.stateLabel = "disabled";
         _loc3_.disabled = true;
      }
      else
      {
         _loc3_.stateLabel = "std";
         _loc3_.disabled = false;
      }
      _loc3_.stateLabel = "std";
      _loc3_.disabled = false;
      _loc3_.gotoAndStop(_loc3_.stateLabel);
   }
   else if(weapon == _root.COOLDOWN_INSTASHIELD)
   {
      clearInterval(_global.instashieldTimer);
      clearInterval(_global.smoothProgressInstashieldTimer);
      _root.instashieldTicks = 0;
      _loc3_ = _root.HUD.thehud.item_rok.mcInstashieldBtn;
      if(_root.instashields_left == 0)
      {
         _loc3_.stateLabel = "disabled";
         _loc3_.disabled = true;
      }
      else
      {
         _loc3_.stateLabel = "std";
         _loc3_.disabled = false;
      }
      _loc3_.stateLabel = "std";
      _loc3_.disabled = false;
      _loc3_.gotoAndStop(_loc3_.stateLabel);
   }
   else if(weapon == _root.COOLDOWN_MINE)
   {
      clearInterval(_global.mineTimer);
      clearInterval(_global.smoothProgressMineTimer);
      _loc3_ = _root.HUD.thehud.item_rok.mcMineBtn;
      _root.mineTicks = 0;
      if(_level0[_root.g_CurClientUser].mines == 0)
      {
         _loc3_.stateLabel = "disabled";
         _loc3_.disabled = true;
      }
      else
      {
         _loc3_.stateLabel = "std";
         _loc3_.disabled = false;
      }
      _loc3_.stateLabel = "std";
      _loc3_.disabled = false;
      _loc3_.gotoAndStop(_loc3_.stateLabel);
   }
   _loc3_.mcCooldownUI._visible = false;
   _loc3_.mcCooldownSmoother._visible = false;
}
function cooldownWiz()
{
   clearInterval(_global.wizTimer);
   clearInterval(_global.smoothProgressWizTimer);
   _root.wizTicks = _root.cooldownTimeWiz;
   var _loc3_ = _root.HUD.thehud.mcWizBtn;
   _loc3_.disabled = true;
   _loc3_.stateLabel = "disabled";
   _loc3_.gotoAndStop(_loc3_.stateLabel);
   _loc3_.mcCooldownUI._visible = true;
   _loc3_.mcCooldownUI.cacheAsBitmap = true;
   _loc3_.mcCooldownUI.mcMask._yscale = (_root.wizTicks - 1) / _root.cooldownTimeWiz * 100;
   _loc3_.mcCooldownSmoother._visible = true;
   _loc3_.mcCooldownSmoother.cacheAsBitmap = true;
   _loc3_.mcCooldownSmoother.mcMask._yscale = 100;
   _global.wizTimer = setInterval(_root.cooldownProgressWiz,1000);
   _global.smoothProgressWizTimer = setInterval(_root.smoothProgressWiz,200);
}
function cooldownProgressWiz()
{
   _root.wizTicks = _root.wizTicks - 1;
   _root.HUD.thehud.mcWizBtn.mcCooldownSmoother.mcMask._yscale = _root.wizTicks / _root.cooldownTimeWiz * 100;
   _root.HUD.thehud.mcWizBtn.mcCooldownSmoother._alpha = 100;
   _root.HUD.thehud.mcWizBtn.mcCooldownUI.mcMask._yscale = (_root.wizTicks - 1) / _root.cooldownTimeWiz * 100;
   if(_root.wizTicks <= 0)
   {
      clearInterval(_global.wizTimer);
      clearInterval(_global.smoothProgressWizTimer);
      _root.HUD.thehud.mcWizBtn.mcCooldownUI._visible = false;
      _root.HUD.thehud.mcWizBtn.mcCooldownSmoother._visible = false;
   }
}
function smoothProgressWiz()
{
   _root.HUD.thehud.mcWizBtn.mcCooldownSmoother._alpha = _root.HUD.thehud.mcWizBtn.mcCooldownSmoother._alpha - 20;
}
function finish_cooldownWiz()
{
   var _loc3_ = undefined;
   clearInterval(_global.wizTimer);
   clearInterval(_global.smoothProgressWizTimer);
   _root.wizTicks = 0;
   _loc3_ = _root.HUD.thehud.mcWizBtn;
   _loc3_.txtDurability.text = _root.curses_left;
   if(_root.curses_left == 0)
   {
      _loc3_.stateLabel = "disabled";
      _loc3_.disabled = true;
   }
   else
   {
      _loc3_.stateLabel = "std";
      _loc3_.disabled = false;
   }
   _loc3_.gotoAndStop(_loc3_.stateLabel);
   _loc3_.mcCooldownUI._visible = false;
   _loc3_.mcCooldownSmoother._visible = false;
}
function updateExtraBtns()
{
   tmpBtn = _root.HUD.thehud.item_rob.mcAimBtn;
   tmpBtn.mcIcon.gotoAndStop("aim1");
   tmpBtn.stateLabel = "std";
   tmpBtn.gotoAndStop(tmpBtn.stateLabel);
   tmpBtn.disabled = false;
   tmpBtn.txtDurability.text = "";
   tmpBtn.txtTarget._visible = false;
   tmpBtn.cmd = "S|AIM|";
   tmpBtn.onRollOver = function()
   {
      if(!this.disabled)
      {
         this.gotoAndStop("hover");
      }
   };
   tmpBtn.onRollOut = function()
   {
      if(!this.disabled)
      {
         this.gotoAndStop(this.stateLabel);
      }
   };
   tmpBtn.onRelease = function()
   {
      if(!this.disabled)
      {
         if(_root.aiming_active)
         {
            this.cmdToSend = this.cmd + "0";
         }
         else
         {
            this.cmdToSend = this.cmd + "1";
         }
         _root.SendtoStream(this.cmdToSend + "\n");
      }
   };
   tmpBtn = _root.HUD.thehud.item_rob.mcArolBtn;
   tmpBtn.mcIcon.gotoAndStop("arol");
   tmpBtn.stateLabel = "std";
   if(_root.arolx_active)
   {
      tmpBtn.stateLabel = "std";
   }
   else
   {
      tmpBtn.stateLabel = "toggle";
   }
   tmpBtn.gotoAndStop(tmpBtn.stateLabel);
   tmpBtn.disabled = false;
   tmpBtn.cmd = "S|ARL|";
   tmpBtn.onRollOver = function()
   {
      if(!this.disabled)
      {
         this.gotoAndStop("hover");
      }
   };
   tmpBtn.onRollOut = function()
   {
      if(!this.disabled)
      {
         this.gotoAndStop(this.stateLabel);
      }
   };
   tmpBtn.onRelease = function()
   {
      if(!this.disabled)
      {
         if(_root.arolx_active)
         {
            this.cmdToSend = this.cmd + "0";
         }
         else
         {
            this.cmdToSend = this.cmd + "1";
         }
         _root.SendtoStream(this.cmdToSend + "\n");
      }
   };
   tmpBtn = _root.HUD.thehud.item_rob.mcCloakBtn;
   tmpBtn.mcIcon.gotoAndStop("cloak");
   tmpBtn.stateLabel = "std";
   tmpBtn.gotoAndStop(tmpBtn.stateLabel);
   tmpBtn.txtTarget._visible = false;
   tmpBtn.cmd = "S|CLK|";
   tmpBtn.onRollOver = function()
   {
      this.gotoAndStop("hover");
   };
   tmpBtn.onRollOut = function()
   {
      this.gotoAndStop(this.stateLabel);
   };
   tmpBtn.onRelease = function()
   {
      _root.SendtoStream(this.cmd + "\n");
   };
   var tmpBtn = _root.HUD.thehud.item_rob.mcRobBtn;
   if(_root.repairState == 0)
   {
      tmpBtn.stateLabel = "std";
   }
   else
   {
      tmpBtn.stateLabel = "active";
   }
   tmpBtn.gotoAndStop(tmpBtn.stateLabel);
   tmpBtn.mcIcon.gotoAndStop("rob");
   tmpBtn.onRollOver = function()
   {
      this.gotoAndStop("hover");
   };
   tmpBtn.onRollOut = function()
   {
      this.gotoAndStop(this.stateLabel);
   };
   tmpBtn.onRelease = function()
   {
      if(_level0[_root.g_CurClientUser].hitpoints >= _level0[_root.g_CurClientUser].hitmax)
      {
         _root.displayStatus(_root.resource.norepneed);
         return undefined;
      }
      var _loc2_ = "S|ROB\n";
      _root.SendtoStream(_loc2_);
   };
   tmpBtn = _root.HUD.thehud.item_rob.mcHm7Btn;
   tmpBtn.stateLabel = "std";
   tmpBtn.gotoAndStop(tmpBtn.stateLabel);
   tmpBtn.mcIcon.gotoAndStop("hm7");
   tmpBtn.onRollOver = function()
   {
      this.gotoAndStop("hover");
   };
   tmpBtn.onRollOut = function()
   {
      this.gotoAndStop(this.stateLabel);
   };
   tmpBtn.onRelease = function()
   {
      _root.hm7_in_use = true;
      updateAreaHintUi(true,true,true);
   };
   tmpBtn = _root.HUD.thehud.item_rob.mcJmpBtn;
   tmpBtn.mcIcon.gotoAndStop("jmp2");
   tmpBtn.stateLabel = "std";
   tmpBtn.gotoAndStop(tmpBtn.stateLabel);
   tmpBtn.onRollOver = function()
   {
      this.gotoAndStop("hover");
   };
   tmpBtn.onRollOut = function()
   {
      this.gotoAndStop(this.stateLabel);
   };
   tmpBtn.onRelease = function()
   {
      var _loc2_ = "S|J|" + _root.jump_cpu_id;
      _root.SendtoStream(_loc2_);
   };
}
function updateFastBuyBtn()
{
   var _loc3_ = _root.HUD.thehud.mcFastBuyBtn;
   if(_root.settingsOptions.enableFastBuy == 1 && (_root.HUD.thehud.item_las._visible || _root.HUD.thehud.item_rok._visible))
   {
      _loc3_._visible = true;
   }
   else
   {
      _loc3_._visible = false;
   }
   _loc3_.mcLaserIcon._visible = false;
   _loc3_.mcRocketsIcon._visible = false;
   if(_root.HUD.thehud.item_rok._visible)
   {
      _loc3_.ammo_cat = "r";
      _loc3_.ammo_id = _root.restoreRok;
      _loc3_.mcRocketsIcon.gotoAndStop(_root.restoreRok);
      _loc3_.mcRocketsIcon._visible = true;
      _loc3_.price = _root.rocketDetails[_root.restoreRok].price;
      _loc3_.txtPrice.text = _loc3_.price;
      _loc3_.mcCurrency.gotoAndStop(_root.rocketDetails[_root.restoreRok].currency);
      _loc3_.currency = _root.rocketDetails[_root.restoreRok].currency;
      _loc3_.amount = _root.rocketDetails[0];
   }
   else
   {
      _loc3_.ammo_cat = "b";
      _loc3_.ammo_id = _root.restoreLas;
      _loc3_.mcLaserIcon.gotoAndStop(_root.restoreLas);
      _loc3_.mcLaserIcon._visible = true;
      _loc3_.price = _root.batteriesDetails[_root.restoreLas].price;
      _loc3_.txtPrice.text = _loc3_.price;
      _loc3_.mcCurrency.gotoAndStop(_root.batteriesDetails[_root.restoreLas].currency);
      _loc3_.currency = _root.batteriesDetails[_root.restoreLas].currency;
      _loc3_.amount = _root.batteriesDetails[0];
   }
   if(_loc3_.price == 0)
   {
      _loc3_.stateLabel = "inactive";
      _loc3_.isEnabled = false;
      _loc3_.mcCurrency._visible = false;
      _loc3_.mcRocketsIcon._visible = false;
      _loc3_.mcLaserIcon._visible = false;
      _loc3_.txtPrice._visible = false;
      _loc3_.mcIconBg._visible = false;
   }
   else if(_root.fastbuyState)
   {
      _loc3_.stateLabel = "active";
      _loc3_.isEnabled = true;
      _loc3_.mcCurrency._visible = true;
      _loc3_.txtPrice._visible = true;
      _loc3_.mcIconBg._visible = true;
   }
   else
   {
      _loc3_.stateLabel = "std";
      _loc3_.isEnabled = true;
      _loc3_.mcCurrency._visible = true;
      _loc3_.txtPrice._visible = true;
      _loc3_.mcIconBg._visible = true;
   }
   _loc3_.gotoAndStop(_loc3_.stateLabel);
   _loc3_.onRollOver = function()
   {
      if(!_root.fastbuyState && this.isEnabled)
      {
         this.gotoAndStop("hover");
      }
   };
   _loc3_.onRollOut = function()
   {
      if(!_root.fastbuyState && this.isEnabled)
      {
         this.gotoAndStop(this.stateLabel);
      }
   };
   _loc3_.onRelease = function()
   {
      if(this.isEnabled)
      {
         var _loc3_ = "5|" + this.ammo_cat + "|" + this.ammo_id + "|" + this.amount + "\n";
         _root.SendtoStream(_loc3_);
         _root.fastbuyState = true;
         updateFastBuyBtn();
      }
   };
}
function updateFastRepairUi()
{
   if(_root.in_fast_repair_area)
   {
      if(_root.mcInstaRepBtn != undefined)
      {
         removeMovieClip(_root.mcInstaRepBtn);
      }
      var _loc3_ = _root.attachMovie("fastRepBtn","mcInstaRepBtn",_root.getNextHighestDepth());
      _loc3_.txtVoucherCount.antiAliasType = "advanced";
      _loc3_.txtVoucherCount.gridFitType = "pixel";
      _loc3_.txtVoucherCount.sharpness = 200;
      _loc3_.txtVoucherCount.text = compactFormat(_root.repair_vouchers_count);
      _loc3_.stop();
      _loc3_._x = 230;
      if(_root.toggleFullBottomHud)
      {
         _loc3_._y = 70;
      }
      else
      {
         _loc3_._y = 38;
      }
      _loc3_.onRollOver = function()
      {
         if(!_root.just_fast_repaired)
         {
            this.gotoAndPlay("std");
         }
      };
      _loc3_.onRollOut = function()
      {
         if(!_root.just_fast_repaired)
         {
            this.gotoAndStop("std");
         }
      };
      _loc3_.onRelease = function()
      {
         var _loc2_ = "S|IR\n";
         _root.SendtoStream(_loc2_);
         _root.fast_repair_just_requested = true;
      };
      _root.fast_repair_just_requested = false;
      _root.just_fast_repaired = false;
   }
   else if(_root.just_fast_repaired)
   {
      if(_root.mcInstaRepBtn != undefined)
      {
         _root.mcInstaRepBtn.txtVoucherCount.text = compactFormat(_root.repair_vouchers_count);
         _root.mcInstaRepBtn.gotoAndPlay("hover");
      }
   }
   else if(_root.mcInstaRepBtn != undefined)
   {
      removeMovieClip(_root.mcInstaRepBtn);
   }
}
function compactFormat(number)
{
   var _loc2_ = undefined;
   if(number > 1.0E12)
   {
      number = int(number / 1.0E11);
      _loc2_ = number / 10 + "T";
   }
   else if(number > 1000000000)
   {
      number = int(number / 100000000);
      _loc2_ = number / 10 + "G";
   }
   else if(number > 1000000)
   {
      number = int(number / 100000);
      _loc2_ = number / 10 + "M";
   }
   else if(number > 1000)
   {
      number = int(number / 100);
      _loc2_ = number / 10 + "K";
   }
   else
   {
      _loc2_ = number;
   }
   return _loc2_;
}
function toggleScorebugSize()
{
   if(sbScorebugState == SCOREBUG_STATE_MAX)
   {
      sbScorebugState = SCOREBUG_STATE_MIN;
      hideScorebugMax();
      showScorebugMin();
   }
   else
   {
      sbScorebugState = SCOREBUG_STATE_MAX;
      hideScorebugMin();
      showScorebugMax();
   }
   updateScorebug();
}
function updateScorebug()
{
   if(sbScorebugState == SCOREBUG_STATE_MIN)
   {
      mcScorebug._x = scorebugDefault.x;
      mcScorebug._y = scorebugDefault.y;
      mcScorebug.mcScorebugMin.txtScoreV.text = sbScore.v_score;
      mcScorebug.mcScorebugMin.txtScoreE.text = sbScore.e_score;
      mcScorebug.mcScorebugMin.txtScoreM.text = sbScore.m_score;
   }
   else
   {
      mcScorebug._x = scorebugCurrent.x;
      mcScorebug._y = scorebugCurrent.y;
      mcScorebug.mcScorebugMax.txtScoreV.text = sbScore.v_score;
      mcScorebug.mcScorebugMax.txtScoreE.text = sbScore.e_score;
      mcScorebug.mcScorebugMax.txtScoreM.text = sbScore.m_score;
      if(sbScore.ball_on == "n")
      {
         mcScorebug.mcScorebugMax.mcSpeedIcon._visible = false;
      }
      else
      {
         mcScorebug.mcScorebugMax.mcSpeedIcon._visible = true;
         mcScorebug.mcScorebugMax.mcSpeedIcon._x = speedIconDefault[sbScore.ball_on];
         mcScorebug.mcScorebugMax.mcSpeedIcon.gotoAndStop(sbScore.ball_speed);
      }
   }
}
function showScorebugMax()
{
   mcScorebug.mcScorebugMax._visible = true;
}
function hideScorebugMax()
{
   mcScorebug.mcScorebugMax._visible = false;
}
function showScorebugMin()
{
   mcScorebug.mcScorebugMin._visible = true;
}
function hideScorebugMin()
{
   mcScorebug.mcScorebugMin._visible = false;
}
function updateScoreDisplay(win, company)
{
   mcScorebug["mcScorebug" + win]["txtScore" + company.toUpperCase()].text = sbScore[company + "_score"];
}
function setSpaceballSpeed(newSpeed, company)
{
   sbScore.ball_on = company;
   newSpeed = int(newSpeed);
   if(newSpeed == 1 || newSpeed == 2 || newSpeed == 3)
   {
      sbScore.ball_speed = newSpeed;
   }
   else
   {
      sbScore.ball_on = "n";
   }
   updateScorebug();
}
function setScore(newScore, company)
{
   sbScore[company + "_score"] = int(newScore);
   if(sbScorebugState == SCOREBUG_STATE_MIN)
   {
      mcScorebug.mcScorebugMin["mcScorechange" + company.toUpperCase()].gotoAndPlay("out");
   }
   else
   {
      mcScorebug.mcScorebugMax["mcScorechange" + company.toUpperCase()].gotoAndPlay("out");
   }
}
function toggleTdmInfoDockState()
{
   if(_root.tdmInfoCurrent._state == _root.TDM_INFO_STATE_FLOATING)
   {
      _root.tdmInfoCurrent._state = _root.TDM_INFO_STATE_DOCKED;
      _root.mcTdmInfo.mcToggleSizeBtn.mcIcon.gotoAndStop("maximize");
      _root.mcTdmInfo._x = _root.tdmInfoDefault.x;
      _root.mcTdmInfo._y = _root.tdmInfoDefault.y;
   }
   else
   {
      _root.tdmInfoCurrent._state = _root.TDM_INFO_STATE_FLOATING;
      _root.mcTdmInfo.mcToggleSizeBtn.mcIcon.gotoAndStop("minimize");
      _root.mcTdmInfo._x = _root.tdmInfoDefault.x - 5;
      _root.mcTdmInfo._y = _root.tdmInfoDefault.y;
   }
}
function hideTdmInfo()
{
   mcTdmInfo._visible = false;
   mcTdmInfo.mcToggleSizeBtn.mcIcon.stop();
   mcTdmInfo.mcToggleSizeBtn.stop();
}
function delayHideTdmInfo()
{
   _root.delayHideTdmInfoTimer = setInterval(function()
   {
      _root.hideTdmInfo();
      clearInterval(_root.delayHideTdmInfoTimer);
   }
   ,5000);
}
function showTdmInfo()
{
   mcTdmInfo._visible = true;
   mcTdmInfo.txtMatchCount.text = "-";
   mcTdmInfo.txtQueuePosition.text = "-";
   mcTdmInfo.mcAlert.gotoAndStop("std");
   hideQueuePosition();
}
function initTdmScorebug()
{
   removeMovieClip(_root.mcTdmScorebug);
   _root.mcTdmScorebug = _root.attachMovie("tdmScorebug","mcTdmScorebug",_root.getNextHighestDepth());
   _root.mcTdmScorebug._x = 670;
   _root.mcTdmScorebug._y = 90;
   mcTdmScorebug.mcTeamIconHome.gotoAndStop(_root.tdmMatch.hostTeam);
   mcTdmScorebug.mcTeamIconGuest.gotoAndStop(_root.tdmMatch.guestTeam);
   mcTdmScorebug.txtPlayersLeftHome.antiAliasType = "advanced";
   mcTdmScorebug.txtPlayersLeftHome.gridFitType = "pixel";
   mcTdmScorebug.txtPlayersLeftHome.sharpness = 200;
   mcTdmScorebug.txtPlayersLeftGuest.antiAliasType = "advanced";
   mcTdmScorebug.txtPlayersLeftGuest.gridFitType = "pixel";
   mcTdmScorebug.txtPlayersLeftGuest.sharpness = 200;
   mcTdmScorebug.txtMin.antiAliasType = "advanced";
   mcTdmScorebug.txtMin.gridFitType = "pixel";
   mcTdmScorebug.txtMin.sharpness = 200;
   mcTdmScorebug.txtSec.antiAliasType = "advanced";
   mcTdmScorebug.txtSec.gridFitType = "pixel";
   mcTdmScorebug.txtSec.sharpness = 200;
   mcTdmScorebug.txtPlayersLeftHome.text = "-";
   mcTdmScorebug.txtPlayersLeftGuest.text = "-";
   mcTdmScorebug.txtMin.text = "-";
   mcTdmScorebug.txtSec.text = "-";
}
function hideTdmScorebug()
{
   removeMovieClip(_root.mcTdmScorebug);
   _root.mcTdmScorebug.removeMovieClip();
   _root.mcTdmScorebug = undefined;
}
function updateTDMMatchTime()
{
   if(Math.abs(game_time_left - remote_game_time_left) > 2)
   {
      game_time_left = remote_game_time_left;
      game_mins = Math.floor(game_time_left / 60);
      game_secs = game_time_left % 60;
   }
}
function setTdmState(tdmState)
{
   if(tdmState == _root.TDM_DRAFT_FINISH)
   {
      if(tdm_phase == _root.TDM_DRAFT)
      {
         stopTdmCountdown(_root.TDM_DRAFT);
      }
      else
      {
         stopAllTdmCountdowns();
      }
      tdm_phase = null;
      _root.mcTdmInfo.txtMin.text = "0";
      _root.mcTdmInfo.txtSec.text = "00";
      displayStatus(_root.resource.tdm_pull_phase_finished);
   }
   else if(tdmState == _root.TDM_DRAFT)
   {
      updateTDMInfo();
      if(tdm_phase != _root.TDM_DRAFT)
      {
         if(tdm_phase == _root.TDM_PRE_DRAFT)
         {
            stopTdmCountdown(_root.TDM_PRE_DRAFT);
         }
         else
         {
            stopAllTdmCountdowns();
         }
         tdm_phase = _root.TDM_DRAFT;
         startTdmCountdown(_root.TDM_DRAFT);
         displayStatus(_root.resource.tdm_pull_phase);
      }
   }
   else if(tdmState == _root.TDM_PRE_DRAFT)
   {
      updateTDMInfo();
      if(tdm_phase != _root.TDM_PRE_DRAFT)
      {
         tdm_phase = _root.TDM_PRE_DRAFT;
         stopAllTdmCountdowns();
         startTdmCountdown(_root.TDM_PRE_DRAFT);
      }
   }
   else if(tdmState == _root.TDM_GAME_RUNNING)
   {
      updateTDMMatchTime();
      hideTdmInfo();
      if(tdm_phase != _root.TDM_GAME_RUNNING)
      {
         tdm_phase = _root.TDM_GAME_RUNNING;
         stopAllTdmCountdowns();
         startTdmCountdown(_root.TDM_GAME_RUNNING);
      }
   }
}
function updateTDMInfo()
{
   if(!mcTdmInfo._visible)
   {
      showTdmInfo();
   }
   if(Math.abs(predraft_time_left - remote_predraft_time_left) > 2)
   {
      predraft_time_left = remote_predraft_time_left;
      predraft_mins = Math.floor(predraft_time_left / 60);
      predraft_secs = predraft_time_left % 60;
   }
   if(Math.abs(draft_time_left - remote_draft_time_left) > 2)
   {
      draft_time_left = remote_draft_time_left;
      draft_mins = Math.floor(draft_time_left / 60);
      draft_secs = draft_time_left % 60;
   }
}
function showQueuePosition()
{
   if(mcTdmInfo.mcLine1._visible == false)
   {
      mcTdmInfo.mcLine1._visible = true;
      mcTdmInfo.mcQueueIcon._visible = true;
      mcTdmInfo.txtQueuePosition._visible = true;
      mcTdmInfo.lineOffestY = mcTdmInfo.mcLine1._y - mcTdmInfo.mcLine0._y;
      mcTdmInfo.mcBottom._y = mcTdmInfo.mcLine1._y + mcTdmInfo.lineOffestY;
      mcTdmInfo.mcMatchesIcon._y = mcTdmInfo.mcQueueIcon._y + mcTdmInfo.lineOffestY;
      mcTdmInfo.txtMatchCount._y = mcTdmInfo.txtQueuePosition._y + mcTdmInfo.lineOffestY;
   }
}
function hideQueuePosition()
{
   if(mcTdmInfo.mcLine1._visible == true)
   {
      mcTdmInfo.mcLine1._visible = false;
      mcTdmInfo.mcQueueIcon._visible = false;
      mcTdmInfo.txtQueuePosition._visible = false;
      mcTdmInfo.mcBottom._y = mcTdmInfo.mcLine1._y;
      mcTdmInfo.mcMatchesIcon._y = mcTdmInfo.mcQueueIcon._y;
      mcTdmInfo.txtMatchCount._y = mcTdmInfo.txtQueuePosition._y;
   }
}
function startTdmCountdown(phase)
{
   if(phase == _root.TDM_DRAFT)
   {
      _root.predraft_time_left = _root.predraft_time_left + 1;
      draft_tick();
      _root.draftInterval = setInterval(draft_tick,950);
      mcTdmInfo.mcAlert.gotoAndStop("std");
   }
   else if(phase == _root.TDM_PRE_DRAFT)
   {
      _root.draft_time_left = _root.draft_time_left + 1;
      pre_draft_tick();
      mcTdmInfo.mcClockIcon.gotoAndStop("predraft");
      _root.predraftInterval = setInterval(pre_draft_tick,950);
   }
   else if(phase == _root.TDM_GAME_RUNNING)
   {
      _root.game_time_left = _root.game_time_left + 1;
      tdm_match_tick();
      _root.tdmGameInterval = setInterval(tdm_match_tick,950);
   }
}
function stopTdmCountdown(phase, quiet)
{
   mcTdmInfo.mcClockIcon.gotoAndStop("std");
   mcTdmInfo.mcAlert.gotoAndStop("std");
   if(phase == _root.TDM_DRAFT)
   {
      clearInterval(_root.draftInterval);
   }
   else if(phase == _root.TDM_PRE_DRAFT)
   {
      clearInterval(_root.predraftInterval);
   }
   else if(phase == _root.TDM_GAME_RUNNING)
   {
      clearInterval(_root.tdmGameInterval);
   }
}
function stopAllTdmCountdowns()
{
   var _loc2_ = true;
   _root.stopTdmCountdown(_root.TDM_PRE_DRAFT,_loc2_);
   _root.stopTdmCountdown(_root.TDM_DRAFT,_loc2_);
   _root.stopTdmCountdown(_root.TDM_GAME_RUNNING,_loc2_);
}
function pre_draft_tick()
{
   _root.predraft_time_left = _root.predraft_time_left - 1;
   if(_root.predraft_time_left <= 0)
   {
      _root.stopTdmCountdown(_root.TDM_PRE_DRAFT);
      _root.mcTdmInfo.txtMin.text = "0";
      _root.mcTdmInfo.txtSec.text = "00";
      _root.mcTdmInfo.mcAlert.gotoAndStop("std");
      return undefined;
   }
   if(_root.predraft_time_left <= 10)
   {
      _root.mcTdmInfo.mcAlert.gotoAndStop("predraftredalert");
   }
   else if(_root.predraft_time_left <= 60)
   {
      _root.mcTdmInfo.mcAlert.gotoAndStop("predraftalert");
   }
   predraft_mins = Math.floor(predraft_time_left / 60);
   predraft_secs = predraft_time_left % 60;
   _root.mcTdmInfo.txtMin.text = predraft_mins;
   _root.mcTdmInfo.txtSec.text = sprintf2digit(predraft_secs);
}
function draft_tick()
{
   _root.draft_time_left = _root.draft_time_left - 1;
   if(_root.draft_time_left <= 0)
   {
      _root.stopTdmCountdown(_root.TDM_DRAFT);
      _root.mcTdmInfo.txtMin.text = "0";
      _root.mcTdmInfo.txtSec.text = "00";
      _root.mcTdmInfo.mcAlert.gotoAndStop("std");
      return undefined;
   }
   if(_root.draft_time_left <= 60)
   {
      _root.mcTdmInfo.mcAlert.gotoAndStop("draftalert");
   }
   draft_mins = Math.floor(draft_time_left / 60);
   draft_secs = draft_time_left % 60;
   _root.mcTdmInfo.txtMin.text = draft_mins;
   _root.mcTdmInfo.txtSec.text = sprintf2digit(draft_secs);
}
function dmz_tick()
{
}
function tdm_match_tick()
{
   _root.game_time_left = _root.game_time_left - 1;
   if(_root.game_time_left <= 0)
   {
      _root.stopTdmCountdown(_root.TDM_GAME_RUNNING);
      _root.mcTdmScorebug.txtMin.text = "0";
      _root.mcTdmScorebug.txtSec.text = "00";
      return undefined;
   }
   if(_root.game_time_left <= 10)
   {
   }
   game_mins = Math.floor(game_time_left / 60);
   game_secs = game_time_left % 60;
   _root.mcTdmScorebug.txtMin.text = game_mins;
   _root.mcTdmScorebug.txtSec.text = sprintf2digit(game_secs);
}
function sprintf2digit(numberToBeFormatted)
{
   var _loc1_ = String(numberToBeFormatted);
   if(numberToBeFormatted < 10)
   {
      _loc1_ = "0" + numberToBeFormatted;
   }
   return _loc1_;
}
function showTdmStartSplashscreen()
{
   if(_root.mcTdmStartSplashscreen != undefined)
   {
      removeMovieClip(_root.mcTdmStartSplashscreen);
   }
   var _loc3_ = _root.attachMovie("matchStartSplashscreen","mcTdmStartSplashscreen",_root.getNextHighestDepth());
   _loc3_.mcMask._visible = false;
   _loc3_._x = 225;
   _loc3_._yTarget = 150;
   _loc3_._yOffset = 1000;
   _loc3_.currentOffset = _loc3_._yOffset;
   _loc3_._y = _loc3_._yTarget + _loc3_._yOffset;
   _loc3_.onEnterFrame = function()
   {
      if(this.currentOffset > 1)
      {
         this.currentOffset = this.currentOffset * 0.6666666666666666;
         this._y = this._yTarget + this.currentOffset;
      }
      else
      {
         this._y = this._yTarget;
         delete this.onEnterFrame;
      }
   };
   _loc3_.mcCompanyLogoLeft.gotoAndStop(_root.tdmMatch.hostTeam);
   _loc3_.mcCompanyLogoRight.gotoAndStop(_root.tdmMatch.guestTeam);
   _root.tdmDmzSplashscreenTicks = 0;
   _root.tdmDmzSplashscreenInterval = setInterval(tdmDmzSplashscreenTick,1000);
   i = 0;
   while(i < 10)
   {
      _loc3_["mcLight" + i].gotoAndStop("off");
      i++;
   }
}
function tdmDmzSplashscreenTick()
{
   _root.tdmDmzSplashscreenTicks = _root.tdmDmzSplashscreenTicks + 1;
   if(_root.tdmDmzSplashscreenTicks > 10)
   {
      clearInterval(_root.tdmDmzSplashscreenInterval);
      mcTdmStartSplashscreen.mcMask._alpha = 0;
      mcTdmStartSplashscreen.mcMask._visible = true;
      mcTdmStartSplashscreen.mcMask.onEnterFrame = function()
      {
         this._alpha = this._alpha + 10;
         if(this._alpha > 90)
         {
            this.onEnterFrame = undefined;
            removeMovieClip(_root.mcTdmStartSplashscreen);
         }
      };
   }
   mcTdmStartSplashscreen["mcLight" + (_root.tdmDmzSplashscreenTicks - 1)].gotoAndStop("on");
}
function updateInvasionScorebug()
{
   mcInvasionScorebug._visible = true;
   if(invasionScore.wave_count > 0)
   {
      mcInvasionScorebug.mcFooterBg._visible = true;
      mcInvasionScorebug.txtWaveCount._visible = true;
      mcInvasionScorebug.txtTitleFooter._visible = true;
      mcInvasionScorebug.txtWaveCount.text = invasionScore.wave_count;
   }
   else
   {
      mcInvasionScorebug.mcFooterBg._visible = false;
      mcInvasionScorebug.txtWaveCount._visible = false;
      mcInvasionScorebug.txtTitleFooter._visible = false;
   }
   mcInvasionScorebug.txtScoreV.text = invasionScore.v_score;
   mcInvasionScorebug.txtScoreE.text = invasionScore.e_score;
   mcInvasionScorebug.txtScoreM.text = invasionScore.m_score;
}
function showInvasionScorebug()
{
   mcInvasionScorebug._visible = true;
}
function hideInvasionScorebug()
{
   mcInvasionScorebug._visible = false;
}
function setInvasionWave(newWave)
{
   invasionScore.wave_count = newWave;
   updateInvasionScorebug();
}
function setInvasionScore(newScore, company)
{
   invasionScore[company + "_score"] = int(newScore);
   mcInvasionScorebug["txtScore" + company.toUpperCase()].text = invasionScore[company + "_score"];
}
function setAmmoBuyIcon(ammo_type)
{
   if(ammo_type > 0)
   {
      _root.HUD.thehud.item_las.mcAmmoBuy._visible = true;
      _root.HUD.thehud.item_las.mcAmmoBuy._x = (ammo_type - 1) * 49 + 37;
   }
   else
   {
      _root.HUD.thehud.item_las.mcAmmoBuy._visible = false;
   }
}
function playGateAnimation(gate_id)
{
   if(_level0.cplayer["portal" + gate_id] != undefined)
   {
      _level0.cplayer["portal" + gate_id].gotoAndStop(2);
   }
   else if(_level0.cplayer["lowportal" + gate_id] != undefined)
   {
      _level0.cplayer["lowportal" + gate_id].gotoAndStop(2);
   }
}
function showGroupBug()
{
   _root.mcGroupDebugUi._visible = true;
}
function hideGroupBug()
{
   _root.mcGroupDebugUi._visible = false;
}
function initGroupBug()
{
   _root.mcGroupDebugUi.txtOutput.text = "";
   _root.mcGroupDebugUi.txtInput.text = "";
   _root.mcGroupDebugUi.mcBg.onRelease = _root.mcGroupDebugUi.mcBg.onReleaseOutside = function()
   {
   };
   _root.mcGroupDebugUi.mcBg.useHandCursor = false;
   _root.mcGroupDebugUi.mcPan.useHandCursor = false;
   _root.mcGroupDebugUi.mcPan.onPress = function()
   {
      _root.mcGroupDebugUi.startDrag();
   };
   _root.mcGroupDebugUi.mcPan.onRelease = _root.mcGroupDebugUi.mcPan.onReleaseOutside = function()
   {
      _root.mcGroupDebugUi.stopDrag();
   };
   var _loc4_ = {};
   _loc4_.onKeyDown = function()
   {
      if(Key.getCode() == 13)
      {
         var _loc2_ = _root.mcGroupDebugUi.txtInput.text;
         if(_loc2_ != "")
         {
            if(_loc2_.charAt(0) == "+")
            {
               _loc2_ = _loc2_.substring(1,_loc2_.length);
               _root.addToCmdWhiteList(_loc2_.split(","));
            }
            else if(_loc2_.charAt(0) == "-")
            {
               _loc2_ = _loc2_.substring(1,_loc2_.length);
               _root.removeFromCmdWhiteList(_loc2_.split(","));
            }
            else if(_loc2_ == "/i")
            {
               var _loc3_ = "";
               for(cmd in _root.cmdWhiteList)
               {
                  _loc3_ = _loc3_ + (cmd + "; ");
               }
               _root.addLineToGroupDebugUi(_loc3_);
            }
            else
            {
               _root.SendtoStream(_root.mcGroupDebugUi.txtInput.text);
            }
            _root.mcGroupDebugUi.txtInput.text = "";
         }
      }
   };
   Key.addListener(_loc4_);
}
function addToCmdWhiteList(cmds)
{
   var _loc2_ = 0;
   while(_loc2_ < cmds.length)
   {
      _root.cmdWhiteList[cmds[_loc2_]] = true;
      _loc2_ = _loc2_ + 1;
   }
}
function removeFromCmdWhiteList(cmds)
{
   var _loc2_ = 0;
   while(_loc2_ < cmds.length)
   {
      delete _root.cmdWhiteList.cmds[_loc2_];
      _loc2_ = _loc2_ + 1;
   }
}
function addLineToGroupDebugUi(line)
{
   if(_root.mcGroupDebugUi.txtOutput.scroll > 15)
   {
      var _loc2_ = _root.mcGroupDebugUi.txtOutput.text;
      _root.mcGroupDebugUi.txtOutput.text = _loc2_.substring(_loc2_.indexOf("\n"),_loc2_.length);
   }
   _root.mcGroupDebugUi.txtOutput.text = _root.mcGroupDebugUi.txtOutput.text + (line + "\n");
   _root.mcGroupDebugUi.txtOutput.scroll = _root.mcGroupDebugUi.txtOutput.maxscroll;
}
function addOutCmdToGroupDebugUi(cmd)
{
   if(_root.enablePSUI)
   {
      _root.addLineToGroupDebugUi("  >" + cmd);
   }
}
function addInCmdToGroupDebugUi(cmdList)
{
   if(_root.enablePSUI && _root.cmdWhiteList[cmdList[1]])
   {
      var _loc2_ = cmdList.toString();
      _loc2_ = _loc2_.substring(2,_loc2_.length);
      _root.addLineToGroupDebugUi(_loc2_);
   }
}
function addFlagOnUser(userID, fromFactionID, forFactionID)
{
   totalCTFFlags++;
   _root.mm_ctf_layer = _root.mm_ctf_layer + 1;
   if(beaconData[fromFactionID][forFactionID] != undefined)
   {
      removeFlagFromUser(beaconData[fromFactionID][forFactionID],fromFactionID,forFactionID);
   }
   beaconData[fromFactionID][forFactionID] = userID;
   if(userID == _root.userID)
   {
      _level0[userID].attachCTFToken(fromFactionID,forFactionID);
      _level0[userID].ctfFromFaction = fromFactionID;
      _level0[userID].ctfForFaction = forFactionID;
   }
   else
   {
      cplayer[userID].attachCTFToken(fromFactionID,forFactionID);
      cplayer[userID].ctfFromFaction = fromFactionID;
      cplayer[userID].ctfForFaction = forFactionID;
   }
   var _loc6_ = "mmbeacon_" + fromFactionID + "_" + forFactionID;
   if(_root.HUD.thehud[_loc6_] == undefined)
   {
      _root.HUD.thehud.attachMovie(_loc6_,_loc6_,_root.mm_ctf_layer);
   }
   _root.HUD.thehud[_loc6_].userID = userID;
   if(_global.flagMMUpdateTimer == 0)
   {
      _global.flagMMUpdateTimer = setInterval(_root.flagMMUpdate,500);
      flagMMUpdate();
   }
}
function removeFlagFromUser(userID, fromFactionID, forFactionID)
{
   beaconData[fromFactionID][forFactionID] = undefined;
   _root.HUD.thehud["mmbeacon_" + fromFactionID + "_" + forFactionID].removeMovieClip();
   if(userID == _root.userID)
   {
      _level0[userID].ctfToken.removeMovieClip();
      _level0[userID].ctfFromFaction = 0;
      _level0[userID].ctfForFaction = 0;
   }
   else
   {
      cplayer[userID].ctfToken.removeMovieClip();
      cplayer[userID].ctfFromFaction = 0;
      cplayer[userID].ctfForFaction = 0;
   }
   totalCTFFlags--;
   if(totalCTFFlags == 0 && _global.flagMMUpdateTimer != 0)
   {
      clearInterval(_global.flagMMUpdateTimer);
      _global.flagMMUpdateTimer = 0;
   }
}
function flagMMUpdate()
{
   var _loc2_ = 0;
   while(_loc2_ < 6)
   {
      if(beaconData[allBeaconIDs[_loc2_][0]][allBeaconIDs[_loc2_][1]])
      {
         var _loc3_ = _root.HUD.thehud["mmbeacon_" + allBeaconIDs[_loc2_][0] + "_" + allBeaconIDs[_loc2_][1]];
         var _loc4_ = Math.max(Math.floor((cplayer[_loc3_.userID]._x - _root.g_OffsetX) / _root.HUD.thehud.miniMap.multipx),0);
         var _loc5_ = Math.max(Math.floor((cplayer[_loc3_.userID]._y - _root.g_OffsetY) / _root.HUD.thehud.miniMap.multipy),0);
         _loc4_ = Math.min(_loc4_,157);
         _loc5_ = Math.min(_loc5_,98);
         _loc3_._x = 679 + _loc4_;
         _loc3_._y = _loc5_;
      }
      _loc2_ = _loc2_ + 1;
   }
}
function showCTFScorebug()
{
   mcCTFScorebug._visible = true;
}
function hideCTFScorebug()
{
   mcCTFScorebug._visible = false;
}
function initCTFScoreBug(heroCompany)
{
   setLabelRenderProperties(mcCTFScorebug.txtTitle);
   mcCTFScorebug.h_1.txtLabel.text = "M M O";
   mcCTFScorebug.h_1.mcBg.gotoAndStop(1);
   mcCTFScorebug.h_2.txtLabel.text = "E I C";
   mcCTFScorebug.h_2.mcBg.gotoAndStop(2);
   mcCTFScorebug.h_3.txtLabel.text = "V R U";
   mcCTFScorebug.h_3.mcBg.gotoAndStop(3);
   setLabelRenderProperties(mcCTFScorebug.h_1.txtLabel);
   setLabelRenderProperties(mcCTFScorebug.h_2.txtLabel);
   setLabelRenderProperties(mcCTFScorebug.h_3.txtLabel);
   mcCTFScorebug.beacon_1_2.txtMap.text = "";
   mcCTFScorebug.beacon_1_2.mcFactionIcon.gotoAndStop(2);
   mcCTFScorebug.beacon_1_3.txtMap.text = "-";
   mcCTFScorebug.beacon_1_3.mcHomeIcon._visible = false;
   mcCTFScorebug.beacon_1_3.mcFactionIcon.gotoAndStop(3);
   mcCTFScorebug.beacon_2_1.txtMap.text = "-";
   mcCTFScorebug.beacon_2_1.mcFactionIcon.gotoAndStop(1);
   mcCTFScorebug.beacon_2_1.mcHomeIcon._visible = false;
   mcCTFScorebug.beacon_2_3.txtMap.text = "-";
   mcCTFScorebug.beacon_2_3.mcFactionIcon.gotoAndStop(3);
   mcCTFScorebug.beacon_2_3.mcHomeIcon._visible = false;
   mcCTFScorebug.beacon_3_1.txtMap.text = "-";
   mcCTFScorebug.beacon_3_1.mcFactionIcon.gotoAndStop(1);
   mcCTFScorebug.beacon_3_1.mcHomeIcon._visible = false;
   mcCTFScorebug.beacon_3_2.txtMap.text = "-";
   mcCTFScorebug.beacon_3_2.mcFactionIcon.gotoAndStop(2);
   mcCTFScorebug.beacon_3_2.mcHomeIcon._visible = false;
   setLabelRenderProperties(mcCTFScorebug.beacon_1_2.txtMap);
   setLabelRenderProperties(mcCTFScorebug.beacon_1_3.txtMap);
   setLabelRenderProperties(mcCTFScorebug.beacon_2_1.txtMap);
   setLabelRenderProperties(mcCTFScorebug.beacon_2_3.txtMap);
   setLabelRenderProperties(mcCTFScorebug.beacon_3_1.txtMap);
   setLabelRenderProperties(mcCTFScorebug.beacon_3_2.txtMap);
   mcCTFScorebug.s_1.txtLabel.text = "-";
   mcCTFScorebug.s_2.txtLabel.text = "-";
   mcCTFScorebug.s_3.txtLabel.text = "-";
   setLabelRenderProperties(mcCTFScorebug.s_1.txtLabel);
   setLabelRenderProperties(mcCTFScorebug.s_2.txtLabel);
   setLabelRenderProperties(mcCTFScorebug.s_3.txtLabel);
   mcCTFScorebug.mcIoiBar.gotoAndStop(heroCompany);
   if(heroCompany == 1)
   {
      mcCTFScorebug.h_1._x = _root.CTF_TABLE_LEFT;
      mcCTFScorebug.h_2._x = _root.CTF_TABLE_LEFT + _root.CTF_TABLE_CELL_PADDING_WITDH + _root.CTF_TABLE_COLUMN_WIDTH;
      mcCTFScorebug.h_3._x = _root.CTF_TABLE_LEFT + 2 * _root.CTF_TABLE_CELL_PADDING_WITDH + 2 * _root.CTF_TABLE_COLUMN_WIDTH;
      mcCTFScorebug.beacon_1_2._x = _root.CTF_TABLE_LEFT;
      mcCTFScorebug.beacon_1_3._x = _root.CTF_TABLE_LEFT;
      mcCTFScorebug.beacon_2_1._x = _root.CTF_TABLE_LEFT + _root.CTF_TABLE_CELL_PADDING_WITDH + _root.CTF_TABLE_COLUMN_WIDTH;
      mcCTFScorebug.beacon_2_2._x = _root.CTF_TABLE_LEFT + _root.CTF_TABLE_CELL_PADDING_WITDH + _root.CTF_TABLE_COLUMN_WIDTH;
      mcCTFScorebug.beacon_3_1._x = _root.CTF_TABLE_LEFT + 2 * _root.CTF_TABLE_CELL_PADDING_WITDH + 2 * _root.CTF_TABLE_COLUMN_WIDTH;
      mcCTFScorebug.beacon_3_2._x = _root.CTF_TABLE_LEFT + 2 * _root.CTF_TABLE_CELL_PADDING_WITDH + 2 * _root.CTF_TABLE_COLUMN_WIDTH;
      mcCTFScorebug.beacon_1_2._y = _root.CTF_TABLE_TOP + _root.CTF_TABLE_ROW_HEIGHT + _root.CTF_TABLE_CELL_PADDING_HEIGHT;
      mcCTFScorebug.beacon_2_1._y = _root.CTF_TABLE_TOP + _root.CTF_TABLE_ROW_HEIGHT + _root.CTF_TABLE_CELL_PADDING_HEIGHT;
      mcCTFScorebug.beacon_3_1._y = _root.CTF_TABLE_TOP + _root.CTF_TABLE_ROW_HEIGHT + _root.CTF_TABLE_CELL_PADDING_HEIGHT;
      mcCTFScorebug.beacon_1_3._y = _root.CTF_TABLE_TOP + 2 * _root.CTF_TABLE_ROW_HEIGHT + 2 * _root.CTF_TABLE_CELL_PADDING_HEIGHT;
      mcCTFScorebug.beacon_2_3._y = _root.CTF_TABLE_TOP + 2 * _root.CTF_TABLE_ROW_HEIGHT + 2 * _root.CTF_TABLE_CELL_PADDING_HEIGHT;
      mcCTFScorebug.beacon_3_2._y = _root.CTF_TABLE_TOP + 2 * _root.CTF_TABLE_ROW_HEIGHT + 2 * _root.CTF_TABLE_CELL_PADDING_HEIGHT;
   }
   else if(heroCompany == 2)
   {
      mcCTFScorebug.h_2._x = _root.CTF_TABLE_LEFT;
      mcCTFScorebug.h_1._x = _root.CTF_TABLE_LEFT + _root.CTF_TABLE_CELL_PADDING_WITDH + _root.CTF_TABLE_COLUMN_WIDTH;
      mcCTFScorebug.h_3._x = _root.CTF_TABLE_LEFT + 2 * _root.CTF_TABLE_CELL_PADDING_WITDH + 2 * _root.CTF_TABLE_COLUMN_WIDTH;
      mcCTFScorebug.beacon_2_1._x = _root.CTF_TABLE_LEFT;
      mcCTFScorebug.beacon_2_3._x = _root.CTF_TABLE_LEFT;
      mcCTFScorebug.beacon_1_2._x = _root.CTF_TABLE_LEFT + _root.CTF_TABLE_CELL_PADDING_WITDH + _root.CTF_TABLE_COLUMN_WIDTH;
      mcCTFScorebug.beacon_1_3._x = _root.CTF_TABLE_LEFT + _root.CTF_TABLE_CELL_PADDING_WITDH + _root.CTF_TABLE_COLUMN_WIDTH;
      mcCTFScorebug.beacon_3_2._x = _root.CTF_TABLE_LEFT + 2 * _root.CTF_TABLE_CELL_PADDING_WITDH + 2 * _root.CTF_TABLE_COLUMN_WIDTH;
      mcCTFScorebug.beacon_3_1._x = _root.CTF_TABLE_LEFT + 2 * _root.CTF_TABLE_CELL_PADDING_WITDH + 2 * _root.CTF_TABLE_COLUMN_WIDTH;
      mcCTFScorebug.beacon_2_1._y = _root.CTF_TABLE_TOP + _root.CTF_TABLE_ROW_HEIGHT + _root.CTF_TABLE_CELL_PADDING_HEIGHT;
      mcCTFScorebug.beacon_1_2._y = _root.CTF_TABLE_TOP + _root.CTF_TABLE_ROW_HEIGHT + _root.CTF_TABLE_CELL_PADDING_HEIGHT;
      mcCTFScorebug.beacon_3_2._y = _root.CTF_TABLE_TOP + _root.CTF_TABLE_ROW_HEIGHT + _root.CTF_TABLE_CELL_PADDING_HEIGHT;
      mcCTFScorebug.beacon_2_3._y = _root.CTF_TABLE_TOP + 2 * _root.CTF_TABLE_ROW_HEIGHT + 2 * _root.CTF_TABLE_CELL_PADDING_HEIGHT;
      mcCTFScorebug.beacon_1_3._y = _root.CTF_TABLE_TOP + 2 * _root.CTF_TABLE_ROW_HEIGHT + 2 * _root.CTF_TABLE_CELL_PADDING_HEIGHT;
      mcCTFScorebug.beacon_3_1._y = _root.CTF_TABLE_TOP + 2 * _root.CTF_TABLE_ROW_HEIGHT + 2 * _root.CTF_TABLE_CELL_PADDING_HEIGHT;
   }
   else
   {
      mcCTFScorebug.h_3._x = _root.CTF_TABLE_LEFT;
      mcCTFScorebug.h_1._x = _root.CTF_TABLE_LEFT + _root.CTF_TABLE_CELL_PADDING_WITDH + _root.CTF_TABLE_COLUMN_WIDTH;
      mcCTFScorebug.h_2._x = _root.CTF_TABLE_LEFT + 2 * _root.CTF_TABLE_CELL_PADDING_WITDH + 2 * _root.CTF_TABLE_COLUMN_WIDTH;
      mcCTFScorebug.beacon_3_1._x = _root.CTF_TABLE_LEFT;
      mcCTFScorebug.beacon_3_2._x = _root.CTF_TABLE_LEFT;
      mcCTFScorebug.beacon_1_3._x = _root.CTF_TABLE_LEFT + _root.CTF_TABLE_CELL_PADDING_WITDH + _root.CTF_TABLE_COLUMN_WIDTH;
      mcCTFScorebug.beacon_1_2._x = _root.CTF_TABLE_LEFT + _root.CTF_TABLE_CELL_PADDING_WITDH + _root.CTF_TABLE_COLUMN_WIDTH;
      mcCTFScorebug.beacon_2_3._x = _root.CTF_TABLE_LEFT + 2 * _root.CTF_TABLE_CELL_PADDING_WITDH + 2 * _root.CTF_TABLE_COLUMN_WIDTH;
      mcCTFScorebug.beacon_2_1._x = _root.CTF_TABLE_LEFT + 2 * _root.CTF_TABLE_CELL_PADDING_WITDH + 2 * _root.CTF_TABLE_COLUMN_WIDTH;
      mcCTFScorebug.beacon_3_1._y = _root.CTF_TABLE_TOP + _root.CTF_TABLE_ROW_HEIGHT + _root.CTF_TABLE_CELL_PADDING_HEIGHT;
      mcCTFScorebug.beacon_1_3._y = _root.CTF_TABLE_TOP + _root.CTF_TABLE_ROW_HEIGHT + _root.CTF_TABLE_CELL_PADDING_HEIGHT;
      mcCTFScorebug.beacon_2_3._y = _root.CTF_TABLE_TOP + _root.CTF_TABLE_ROW_HEIGHT + _root.CTF_TABLE_CELL_PADDING_HEIGHT;
      mcCTFScorebug.beacon_3_2._y = _root.CTF_TABLE_TOP + 2 * _root.CTF_TABLE_ROW_HEIGHT + 2 * _root.CTF_TABLE_CELL_PADDING_HEIGHT;
      mcCTFScorebug.beacon_1_2._y = _root.CTF_TABLE_TOP + 2 * _root.CTF_TABLE_ROW_HEIGHT + 2 * _root.CTF_TABLE_CELL_PADDING_HEIGHT;
      mcCTFScorebug.beacon_2_1._y = _root.CTF_TABLE_TOP + 2 * _root.CTF_TABLE_ROW_HEIGHT + 2 * _root.CTF_TABLE_CELL_PADDING_HEIGHT;
   }
   mcCTFScorebug.s_1._x = mcCTFScorebug.h_1._x;
   mcCTFScorebug.s_2._x = mcCTFScorebug.h_2._x;
   mcCTFScorebug.s_3._x = mcCTFScorebug.h_3._x;
   mcCTFScorebug.mcBg.onRelease = function()
   {
   };
   mcCTFScorebug.mcBg.useHandCursor = false;
   mcCTFScorebug.mcTitlebarBtn.useHandCursor = false;
   mcCTFScorebug.mcTitlebarBtn.onPress = function()
   {
      _root.mcCTFScorebug.startDrag();
   };
   mcCTFScorebug.mcTitlebarBtn.onRelease = mcCTFScorebug.mcTitlebarBtn.onReleaseOutside = function()
   {
      _root.mcCTFScorebug.stopDrag();
      _root.mcCTFScorebug._x = Math.floor(_root.mcCTFScorebug._x);
      _root.mcCTFScorebug._y = Math.floor(_root.mcCTFScorebug._y);
   };
}
function setLabelRenderProperties(_label)
{
   _label.antiAliasType = "advanced";
   _label.gridFitType = "pixel";
   _label.sharpness = 200;
}
function setBeaconMapInScorebug(fromFactionID, forFactionID, mapID)
{
   var _loc1_ = mcCTFScorebug["beacon_" + fromFactionID + "_" + forFactionID];
   if(mapID == 0)
   {
      _loc1_.mcHomeIcon._visible = true;
      _loc1_.txtMap.text = "";
   }
   else
   {
      _loc1_.mcHomeIcon._visible = false;
      _loc1_.txtMap.text = allmapids[mapID];
   }
}
function setCTFScore(scoreMMO, scoreEIC, scoreVRU)
{
   mcCTFScorebug.s_1.txtLabel.text = scoreMMO;
   mcCTFScorebug.s_2.txtLabel.text = scoreEIC;
   mcCTFScorebug.s_3.txtLabel.text = scoreVRU;
}
function convertBeaconDetails(bID)
{
   var _loc1_ = bID % 10;
   var _loc2_ = (bID - 100 - _loc1_) / 10;
   return {fromID:_loc2_,forID:_loc1_};
}
function setCTBHomeZone(beaconID, zone_x, zone_y)
{
   var _loc7_ = convertBeaconDetails(beaconID);
   var _loc10_ = _loc7_.fromID;
   var _loc9_ = _loc7_.forID;
   var _loc4_ = "ctf_zone_" + _loc10_ + "_" + _loc9_;
   if(scr[_loc4_] != undefined)
   {
      scr[_loc4_].removeMovieClip();
   }
   var _loc3_ = scr.attachMovie(_loc4_,_loc4_,scr.getNextHighestDepth());
   _loc3_._x = zone_x + _root.g_OffsetX;
   _loc3_._y = zone_y + _root.g_OffsetY;
   _loc3_._yscale = 71;
   _loc3_.rotationOut = 0;
   _loc3_.rotationIn = 0;
   if(beaconID == 112 || beaconID == 121 || beaconID == 132)
   {
      _loc3_.onEnterFrame = function()
      {
         this.rotationIn = this.rotationIn - 3;
         this.rotationOut = this.rotationOut - 4;
         this.rotationIn = this.rotationIn % 360;
         this.rotationOut = this.rotationOut % 360;
         this.mcIn._rotation = this.rotationIn;
         this.mcOut._rotation = this.rotationOut;
      };
   }
   else
   {
      _loc3_.onEnterFrame = function()
      {
         this.rotationIn = this.rotationIn + 3;
         this.rotationOut = this.rotationOut + 4;
         this.rotationIn = this.rotationIn % 360;
         this.rotationOut = this.rotationOut % 360;
         this.mcIn._rotation = this.rotationIn;
         this.mcOut._rotation = this.rotationOut;
      };
   }
   var _loc5_ = "mm_ctf_zone_" + _loc9_;
   if(_root.HUD.thehud[_loc5_] != undefined)
   {
      _root.HUD.thehud[_loc5_].removeMovieClip();
   }
   var _loc6_ = _root.HUD.thehud.attachMovie(_loc5_,_loc5_,_root.HUD.thehud.getNextHighestDepth());
   _loc6_._x = 679 + zone_x / _root.HUD.thehud.miniMap.multipx;
   _loc6_._y = zone_y / _root.HUD.thehud.miniMap.multipx;
}
function showFireworksBug()
{
   mcFireworksBug._visible = true;
}
function hideFireworksBug()
{
   mcFireworksBug._visible = false;
}
function initFireworksBug()
{
   _root.fwLeft = [0,-1,-1,-1];
   _root.igniteFwEnabled = false;
   _root.installFwEnabled = false;
   setLabelRenderProperties(mcFireworksBug.txtTitle);
   mcFireworksBug.txtTitle._x = 2;
   mcFireworksBug.txtTitle._y = 0;
   mcFireworksBug.txtTitle.text = resource.title_firework;
   mcFireworksBug.txtTitle.autoSize = "left";
   mcFireworksBug.txtTitle.embedFonts = _root.defaultHudBottomMainFontEmbed;
   mcFireworksBug.txtTitle.setTextFormat(_root.defaultHudBottomMainFmt);
   mcFireworksBug.txtTitle._height = _root.defaultHudBottomMainFontHeight + 4;
   mcFireworksBug.mcBg.onRelease = function()
   {
   };
   mcFireworksBug.mcBg.useHandCursor = false;
   mcFireworksBug.mcTitlebarBtn.useHandCursor = false;
   mcFireworksBug.mcTitlebarBtn.onPress = function()
   {
      _root.mcFireworksBug.startDrag();
   };
   mcFireworksBug.mcTitlebarBtn.onRelease = mcFireworksBug.mcTitlebarBtn.onReleaseOutside = function()
   {
      _root.mcFireworksBug.stopDrag();
      _root.mcFireworksBug._x = Math.floor(_root.mcFireworksBug._x);
      _root.mcFireworksBug._y = Math.floor(_root.mcFireworksBug._y);
   };
   mcFireworksBug.txtLeft1.text = "-";
   mcFireworksBug.txtLeft2.text = "-";
   mcFireworksBug.txtLeft3.text = "-";
   initFWBtn(mcFireworksBug.mcFW1Btn,1);
   initFWBtn(mcFireworksBug.mcFW2Btn,2);
   initFWBtn(mcFireworksBug.mcFW3Btn,3);
   initFWBtn(mcFireworksBug.mcIgniteBtn,0);
   mcFireworksBug.mcInstallations.gotoAndStop(1);
   mcFireworksBug.mcIgniteBtn.onRelease = function()
   {
      if(!this.disabled)
      {
         _root.SendtoStream("S|FWI\n");
      }
   };
   updateFWUI();
}
function updateFWUI()
{
   updateFWBtn(1);
   updateFWBtn(2);
   updateFWBtn(3);
   updateIgniteBtn();
}
function updateFWBtn(fwID)
{
   var _loc2_ = mcFireworksBug["mcFW" + fwID + "Btn"];
   if(_root.fwLeft[fwID] > 0 && _root.installFwEnabled)
   {
      _loc2_.stateLabel = "std";
      _loc2_.disabled = false;
   }
   else
   {
      _loc2_.stateLabel = "disabled";
      _loc2_.disabled = true;
   }
   _loc2_.gotoAndStop(_loc2_.stateLabel);
   mcFireworksBug["txtLeft" + fwID].text = _root.fwLeft[fwID];
}
function updateIgniteBtn()
{
   var _loc2_ = mcFireworksBug.mcIgniteBtn;
   if(_root.igniteFwEnabled)
   {
      _loc2_.stateLabel = "std";
      _loc2_.gotoAndStop(_loc2_.stateLabel);
      _loc2_.disabled = false;
   }
   else
   {
      _loc2_.stateLabel = "disabled";
      _loc2_.gotoAndStop(_loc2_.stateLabel);
      _loc2_.disabled = true;
   }
}
function initFWBtn(btn, fwID)
{
   var _loc3_ = btn;
   _loc3_.stateLabel = "disabled";
   _loc3_.gotoAndStop(_loc3_.stateLabel);
   _loc3_.fwType = fwID;
   _loc3_.disabled = true;
   _loc3_.onRollOver = function()
   {
      if(!this.disabled)
      {
         this.gotoAndStop("hover");
      }
   };
   _loc3_.onRollOut = function()
   {
      if(!this.disabled)
      {
         this.gotoAndStop(this.stateLabel);
      }
   };
   _loc3_.onRelease = function()
   {
      if(!this.disabled)
      {
         _root.SendtoStream("S|FWX|" + this.fwType + "\n");
      }
   };
}
function drawRect(t, x, y, w, h)
{
   t.moveTo(x,y);
   t.lineTo(x + w,y);
   t.lineTo(x + w,y + h);
   t.lineTo(x,y + h);
   t.lineTo(x,y);
}
function drawFilledRect(t, x, y, w, h, fillColor)
{
   t.beginFill(fillColor);
   t.moveTo(x,y);
   t.lineTo(x + w,y);
   t.lineTo(x + w,y + h);
   t.lineTo(x,y + h);
   t.lineTo(x,y);
   t.endFill();
}
_root.mm_ctf_layer_init = 11000;
_root.mm_allied_layer_init = 10000;
_root.mm_default_layer_init = 200;
_root.dpsSum = 0;
_root.missCount = 0;
var COOLDOWN_INSTASHIELD = "instashield";
var COOLDOWN_SMARTBOMB = "smartbomb";
var COOLDOWN_MINE = "mine";
var cooldownTimeInstashield = 10;
var cooldownTimeSmartbomb = 15;
var cooldownTimeMine = 10;
_root.mm_allied_layer = _root.mm_allied_layer_init;
_root.mm_default_layer = _root.mm_default_layer_init;
_root.mm_ctf_layer = _root.mm_ctf_layer_init;
_root.HUD.thehud.txtCoordinatesAlt._visible = false;
_root.gamequest.antiAliasType = "advanced";
_root.gamequest.gridFitType = "pixel";
_root.gamequest.sharpness = 200;
_root.mcMaploader.txtPct.antiAliasType = "advanced";
_root.mcMaploader.txtPct.gridFitType = "pixel";
_root.mcMaploader.txtPct.sharpness = 200;
_root.initDone = false;
_root.HUD.thehud.mcChgPresetBtn.txtLabel.text = _root.resource.preset.toUpperCase();
_root.HUD.thehud.mcChgPresetBtn.txtLabel.antiAliasType = "advanced";
_root.HUD.thehud.mcChgPresetBtn.txtLabel.gridFitType = "pixel";
_root.HUD.thehud.mcChgPresetBtn.txtLabel.sharpness = 200;
_root.HUD.thehud.mcChgPresetBtn.mcChg1Btn.mcActiveBtn.txtLabel.text = "1";
_root.HUD.thehud.mcChgPresetBtn.mcChg1Btn.mcPassiveBtn.txtLabel.text = "1";
_root.HUD.thehud.mcChgPresetBtn.mcChg2Btn.mcActiveBtn.txtLabel.text = "2";
_root.HUD.thehud.mcChgPresetBtn.mcChg2Btn.mcPassiveBtn.txtLabel.text = "2";
_root.HUD.thehud.mcChgPresetBtn.mcChg3Btn.mcActiveBtn.txtLabel.text = "3";
_root.HUD.thehud.mcChgPresetBtn.mcChg3Btn.mcPassiveBtn.txtLabel.text = "3";
_root.mcScorebug.mcScorebugMin.txtScoreV.antiAliasType = "advanced";
_root.mcScorebug.mcScorebugMin.txtScoreV.gridFitType = "pixel";
_root.mcScorebug.mcScorebugMin.txtScoreV.sharpness = 200;
_root.mcScorebug.mcScorebugMin.txtScoreE.antiAliasType = "advanced";
_root.mcScorebug.mcScorebugMin.txtScoreE.gridFitType = "pixel";
_root.mcScorebug.mcScorebugMin.txtScoreE.sharpness = 200;
_root.mcScorebug.mcScorebugMin.txtScoreM.antiAliasType = "advanced";
_root.mcScorebug.mcScorebugMin.txtScoreM.gridFitType = "pixel";
_root.mcScorebug.mcScorebugMin.txtScoreM.sharpness = 200;
_root.mcScorebug.mcScorebugMax.txtScoreV.antiAliasType = "advanced";
_root.mcScorebug.mcScorebugMax.txtScoreV.gridFitType = "pixel";
_root.mcScorebug.mcScorebugMax.txtScoreV.sharpness = 200;
_root.mcScorebug.mcScorebugMax.txtScoreE.antiAliasType = "advanced";
_root.mcScorebug.mcScorebugMax.txtScoreE.gridFitType = "pixel";
_root.mcScorebug.mcScorebugMax.txtScoreE.sharpness = 200;
_root.mcScorebug.mcScorebugMax.txtScoreM.antiAliasType = "advanced";
_root.mcScorebug.mcScorebugMax.txtScoreM.gridFitType = "pixel";
_root.mcScorebug.mcScorebugMax.txtScoreM.sharpness = 200;
_root.mcTdmInfo.txtTitle.antiAliasType = "advanced";
_root.mcTdmInfo.txtTitle.gridFitType = "pixel";
_root.mcTdmInfo.txtTitle.sharpness = 200;
_root.mcTdmInfo.txtSec.antiAliasType = "advanced";
_root.mcTdmInfo.txtSec.gridFitType = "pixel";
_root.mcTdmInfo.txtSec.sharpness = 200;
_root.mcTdmInfo.txtMin.antiAliasType = "advanced";
_root.mcTdmInfo.txtMin.gridFitType = "pixel";
_root.mcTdmInfo.txtMin.sharpness = 200;
_root.mcTdmInfo.txtQueuePosition.antiAliasType = "advanced";
_root.mcTdmInfo.txtQueuePosition.gridFitType = "pixel";
_root.mcTdmInfo.txtQueuePosition.sharpness = 200;
_root.mcTdmInfo.txtMatchCount.antiAliasType = "advanced";
_root.mcTdmInfo.txtMatchCount.gridFitType = "pixel";
_root.mcTdmInfo.txtMatchCount.sharpness = 200;
_root.mcInvasionScorebug.txtTitle.antiAliasType = "advanced";
_root.mcInvasionScorebug.txtTitle.gridFitType = "pixel";
_root.mcInvasionScorebug.txtTitle.sharpness = 200;
_root.mcInvasionScorebug.txtScoreM.antiAliasType = "advanced";
_root.mcInvasionScorebug.txtScoreM.gridFitType = "pixel";
_root.mcInvasionScorebug.txtScoreM.sharpness = 200;
_root.mcInvasionScorebug.txtScoreE.antiAliasType = "advanced";
_root.mcInvasionScorebug.txtScoreE.gridFitType = "pixel";
_root.mcInvasionScorebug.txtScoreE.sharpness = 200;
_root.mcInvasionScorebug.txtScoreV.antiAliasType = "advanced";
_root.mcInvasionScorebug.txtScoreV.gridFitType = "pixel";
_root.mcInvasionScorebug.txtScoreV.sharpness = 200;
_root.mcInvasionScorebug.txtWaveCount.antiAliasType = "advanced";
_root.mcInvasionScorebug.txtWaveCount.gridFitType = "pixel";
_root.mcInvasionScorebug.txtWaveCount.sharpness = 200;
_root.mcInvasionScorebug.txtWaveCount._y = _root.mcInvasionScorebug.txtWaveCount._y + _root.defaultInvasionProps.yWaveCount;
_root.mcInvasionScorebug.txtTitleFooter.text = resource.attack_wave;
_root.mcInvasionScorebug.txtTitleFooter.antiAliasType = "advanced";
_root.mcInvasionScorebug.txtTitleFooter.gridFitType = "pixel";
_root.mcInvasionScorebug.txtTitleFooter.sharpness = 200;
_root.mcInvasionScorebug.txtTitleFooter.embedFonts = _root.defaultHudBottomMainFontEmbed;
_root.mcInvasionScorebug.txtTitleFooter.autoSize = _root.defaultHudBottomMainAutoSize;
_root.mcInvasionScorebug.txtTitleFooter._height = _root.defaultHudBottomMainFontHeight + 5;
_root.mcInvasionScorebug.txtTitleFooter._y = _root.mcInvasionScorebug.txtTitleFooter._y + _root.defaultInvasionProps.yTitleFooter;
_root.mcInvasionScorebug.txtTitleFooter.setTextFormat(_root.defaultHudBottomMainFmt);
_root.HUD.thehud.mcChgPresetBtn.cmd = "S|CFG|";
mcViewportlimiter.createEmptyMovieClip("mcTop",0);
mcViewportlimiter.mcTop._x = mcViewportlimiter.mcTop._y = 0;
mcViewportlimiter.createEmptyMovieClip("mcRight",1);
mcViewportlimiter.mcRight._x = mcViewportlimiter.mcRight._y = 0;
mcViewportlimiter.createEmptyMovieClip("mcBottom",2);
mcViewportlimiter.mcBottom._x = mcViewportlimiter.mcBottom._y = 0;
mcViewportlimiter.createEmptyMovieClip("mcLeft",3);
mcViewportlimiter.mcLeft._x = mcViewportlimiter.mcLeft._y = 0;
drawFilledRect(mcViewportlimiter.mcTop,-1000,-500,2820,500,0);
drawFilledRect(mcViewportlimiter.mcLeft,820,0,1000,653,0);
drawFilledRect(mcViewportlimiter.mcBottom,-1000,653,2820,500,0);
drawFilledRect(mcViewportlimiter.mcLeft,-1000,0,1000,653,0);
mcViewportlimiter.mcTop.onRelease = undefined;
mcViewportlimiter.mcLeft.onRelease = undefined;
mcViewportlimiter.mcBottom.onRelease = undefined;
mcViewportlimiter.mcLeft.onRelease = undefined;
this.HUD.mcFPSMeter.txtHeroLaserCountMax.textColor = 16777215;
this.HUD.mcFPSMeter.txtLaserCountMax.textColor = 16777215;
this.HUD.mcFPSMeter.txtShipsCountMax.textColor = 16777215;
_root.HUD.thehud.attackbtn.mcAimIndicator._visible = false;
_root.HUD.thehud.attackbtn.mcArolxIndicator._visible = false;
var bottomHudElements = new Array();
bottomHudElements.push({tLabel:_root.HUD.thehud.txtLaserAttack,btn:_root.HUD.thehud.attackbtn});
bottomHudElements.push({tLabel:_root.HUD.thehud.txtRocketAttack,btn:_root.HUD.thehud.racketebtn});
bottomHudElements.push({tLabel:_root.HUD.thehud.txtLaserSelect,btn:_root.HUD.thehud.laserbtn});
bottomHudElements.push({tLabel:_root.HUD.thehud.txtRocketSelect,btn:_root.HUD.thehud.xprocket});
bottomHudElements.push({tLabel:_root.HUD.thehud.txtPortalJump,btn:_root.HUD.thehud.jumpbtn});
bottomHudElements.push({tLabel:_root.HUD.thehud.txtRobotAndExtras,btn:_root.HUD.thehud.extras});
i = 0;
while(i < bottomHudElements.length)
{
   var hudEl = bottomHudElements[i];
   setupBottomHudBtn(hudEl.tLabel,hudEl.btn);
   i++;
}
_root.HUD.thehud.txtMapLabel.antiAliasType = "advanced";
_root.HUD.thehud.txtMapLabel.gridFitType = "pixel";
_root.HUD.thehud.txtMapLabel.sharpness = 200;
_root.HUD.thehud.txtMapLabel.autoSize = "left";
_root.HUD.thehud.txtMapLabel.embedFonts = _root.defaultHudBottomMainFontEmbed;
_root.HUD.thehud.txtMapLabel.setTextFormat(_root.defaultHudBottomMainFmt);
_root.HUD.thehud.txtMapLabel._height = _root.defaultHudBottomMainFontHeight + 4;
_root.HUD.thehud.txtMapLabel._y = _root.HUD.thehud.txtMapLabel._y + _root.defaultMapLabelProps.y;
_root.HUD.thehud.txtPosLabel.antiAliasType = "advanced";
_root.HUD.thehud.txtPosLabel.gridFitType = "pixel";
_root.HUD.thehud.txtPosLabel.sharpness = 200;
_root.HUD.thehud.txtPosLabel.autoSize = "left";
_root.HUD.thehud.txtPosLabel.embedFonts = _root.defaultHudBottomMainFontEmbed;
_root.HUD.thehud.txtPosLabel.setTextFormat(_root.defaultHudBottomMainFmt);
_root.HUD.thehud.txtPosLabel._height = _root.defaultHudBottomMainFontHeight + 4;
_root.HUD.thehud.txtPosLabel._y = _root.HUD.thehud.txtPosLabel._y + _root.defaultMapLabelProps.y;
_root.HUD.thehud.i_map._x = _root.HUD.thehud.txtMapLabel._x + Math.floor(_root.HUD.thehud.txtMapLabel._width) + 3;
_root.HUD.thehud.txtPosLabel._x = _root.HUD.thehud.i_map._x + 20;
_root.HUD.thehud.coor._x = _root.HUD.thehud.txtPosLabel._x + Math.floor(_root.HUD.thehud.txtPosLabel._width) + 3;
_root.HUD.thehud.i_map._y = _root.HUD.thehud.i_map._y + _root.defaultMapLabelProps.yValue;
_root.HUD.thehud.coor._y = _root.HUD.thehud.coor._y + _root.defaultMapLabelProps.yValue;
_root.HUD.thehud.mcChgPresetBtn.txtLabel.text = _root.resource.preset.toUpperCase();
_root.HUD.thehud.mcChgPresetBtn.txtLabel._y = _root.HUD.thehud.mcChgPresetBtn.txtLabel._y + _root.defaultConfigLabelProps.y;
_root.HUD.thehud.mcChgPresetBtn.txtLabel.embedFonts = _root.defaultHudBottomMainFontEmbed;
_root.HUD.thehud.mcChgPresetBtn.txtLabel.setTextFormat(_root.defaultHudBottomMainFmt);
_root.HUD.thehud.mcChgPresetBtn.txtLabel._height = _root.HUD.thehud.mcChgPresetBtn.txtLabel._height + (_root.defaultHudBottomMainFontHeight + 4);
_root.HUD.thehud.mcChgPresetBtn.mcChg1Btn.mcActiveBtn.txtLabel._y = _root.HUD.thehud.mcChgPresetBtn.mcChg1Btn.mcActiveBtn.txtLabel._y + _root.defaultConfigLabelProps.yValue;
_root.HUD.thehud.mcChgPresetBtn.mcChg1Btn.mcPassiveBtn.txtLabel._y = _root.HUD.thehud.mcChgPresetBtn.mcChg1Btn.mcPassiveBtn.txtLabel._y + _root.defaultConfigLabelProps.yValue;
_root.HUD.thehud.mcChgPresetBtn.mcChg2Btn.mcActiveBtn.txtLabel._y = _root.HUD.thehud.mcChgPresetBtn.mcChg2Btn.mcActiveBtn.txtLabel._y + _root.defaultConfigLabelProps.yValue;
_root.HUD.thehud.mcChgPresetBtn.mcChg2Btn.mcPassiveBtn.txtLabel._y = _root.HUD.thehud.mcChgPresetBtn.mcChg2Btn.mcPassiveBtn.txtLabel._y + _root.defaultConfigLabelProps.yValue;
_root.HUD.thehud.mcChgPresetBtn.mcChg3Btn.mcActiveBtn.txtLabel._y = _root.HUD.thehud.mcChgPresetBtn.mcChg3Btn.mcActiveBtn.txtLabel._y + _root.defaultConfigLabelProps.yValue;
_root.HUD.thehud.mcChgPresetBtn.mcChg3Btn.mcPassiveBtn.txtLabel._y = _root.HUD.thehud.mcChgPresetBtn.mcChg3Btn.mcPassiveBtn.txtLabel._y + _root.defaultConfigLabelProps.yValue;
_root.HUD.thehud.mcStarstystemBtnBg._y = _root.HUD.thehud.mcStarstystemBtnBg._y + _root.defaultMapLabelProps.yBtn;
_root.HUD.thehud.mcChgPresetBtn._y = _root.HUD.thehud.mcChgPresetBtn._y + _root.defaultConfigLabelProps.yBtn;
_root.HUD.thehud.mcChgPresetBtn.mcChg1Btn.mcActiveBtn.txtLabel.text = "1";
_root.HUD.thehud.mcChgPresetBtn.mcChg1Btn.mcPassiveBtn.txtLabel.text = "1";
_root.HUD.thehud.mcChgPresetBtn.mcChg2Btn.mcActiveBtn.txtLabel.text = "2";
_root.HUD.thehud.mcChgPresetBtn.mcChg2Btn.mcPassiveBtn.txtLabel.text = "2";
_root.topHud = _root.debugbox;
_root.topHud.txtLabel1.autoSize = "left";
_root.topHud.txtLabel2.autoSize = "left";
_root.topHud.txtLabel3.autoSize = "left";
_root.topHud.txtLabel4.autoSize = "left";
_root.topHud.txtLabel5.autoSize = "center";
_root.topHud.txtLabel6.autoSize = "center";
_root.topHud.txtLabel7.autoSize = "center";
_root.topHud.credits.autoSize = "center";
_root.topHud.cargospace.autoSize = "center";
_root.topHud.uridium.autoSize = "center";
_root.topHud.txtLabel8.autoSize = "right";
_root.topHud.txtLabel9.autoSize = "right";
_root.topHud.txtLabel10.autoSize = "right";
_root.topHud.txtLabel11.autoSize = "right";
_root.topHud.txtLabel8._y = _root.topHud.txtLabel8._y + _root.defaultHudTopLabelProps.yShipStatsFirst;
_root.topHud.txtLabel10._y = _root.topHud.txtLabel10._y + _root.defaultHudTopLabelProps.yShipStatsFirst;
_root.topHud.txtLabel9._y = _root.topHud.txtLabel9._y + _root.defaultHudTopLabelProps.yShipStatsSecond;
_root.topHud.txtLabel11._y = _root.topHud.txtLabel11._y + _root.defaultHudTopLabelProps.yShipStatsSecond;
var i = 0;
while(i < 12)
{
   _root.topHud["txtLabel" + i].antiAliasType = "advanced";
   _root.topHud["txtLabel" + i].sharpness = 100;
   _root.topHud["txtLabel" + i].embedFonts = _root.defaultHudTopLabelFontEmbed;
   _root.topHud["txtLabel" + i].setTextFormat(_root.defaultHudTopLabelFmt);
   _root.topHud["txtLabel" + i]._height = _root.defaultHudTopLabelFontHeight + 5;
   i++;
}
_root.topHud.txtLabel1._y = _root.defaultHudTopLabelProps.yStatslistV;
_root.topHud.txtLabel2._y = _root.topHud.txtLabel1._y + _root.defaultHudTopLabelFontHeight + _root.defaultHudTopLabelProps.paddingStatslistV;
_root.topHud.txtLabel3._y = _root.topHud.txtLabel2._y + _root.defaultHudTopLabelFontHeight + _root.defaultHudTopLabelProps.paddingStatslistV;
_root.topHud.txtLabel4._y = _root.topHud.txtLabel3._y + _root.defaultHudTopLabelFontHeight + _root.defaultHudTopLabelProps.paddingStatslistV;
_root.topHud.ep._y = _root.topHud.txtLabel1._y + _root.defaultHudTopLabelProps.yValueStatslistV - 1;
_root.topHud.level._y = _root.topHud.ep._y + _root.defaultHudTopLabelFontHeight + _root.defaultHudTopLabelProps.paddingStatslistV;
_root.topHud.honour._y = _root.topHud.level._y + _root.defaultHudTopLabelFontHeight + _root.defaultHudTopLabelProps.paddingStatslistV;
_root.topHud.jack._y = _root.topHud.honour._y + _root.defaultHudTopLabelFontHeight + _root.defaultHudTopLabelProps.paddingStatslistV;
_root.topHud.txtLabel5._y = _root.topHud.txtLabel5._y + _root.defaultHudTopLabelProps.yStatslistH;
_root.topHud.txtLabel6._y = _root.topHud.txtLabel6._y + _root.defaultHudTopLabelProps.yStatslistH;
_root.topHud.txtLabel7._y = _root.topHud.txtLabel7._y + _root.defaultHudTopLabelProps.yStatslistH;
_root.topHud.mcFaqBtn.txtLabel.text = _root.resource.mo_hilfe;
_root.topHud.mcFaqBtn.txtLabel.antiAliasType = "advanced";
_root.topHud.mcFaqBtn.txtLabel.gridFitType = "pixel";
_root.topHud.mcFaqBtn.txtLabel.sharpness = 100;
_root.topHud.mcFaqBtn.txtLabel.embedFonts = _root.defaultHudTopLabelFontEmbed;
_root.topHud.mcFaqBtn.txtLabel.setTextFormat(_root.defaultHudTopLabelFmt);
_root.topHud.mcFaqBtn.txtLabel._height = _root.defaultHudTopLabelFontHeight + 7;
_root.topHud.mcFaqBtn.txtLabel._y = _root.topHud.mcFaqBtn.txtLabel._y + _root.defaultHudTopLabelProps.yHelp;
_root.topHud.mcFaqBtn.txtLabel.autoSize = "left";
_root.topHud.mcFaqBtn.gotoAndStop("std");
_root.topHud.mcFaqBtn.onRollOver = function()
{
   this.gotoAndStop("hover");
};
_root.topHud.mcFaqBtn.onRollOut = function()
{
   this.gotoAndStop("std");
};
_root.topHud.mcFaqBtn.onRelease = function()
{
   _root.updateWindow(true);
};
_root.topHud.mcLogoutBtn._x = Math.round(_root.topHud.mcFaqBtn._x + _root.topHud.mcFaqBtn._width + 5);
_root.topHud.mcLogoutBtn.txtLabel.text = _root.resource.mo_logout;
_root.topHud.mcLogoutBtn.txtLabel.antiAliasType = "advanced";
_root.topHud.mcLogoutBtn.txtLabel.gridFitType = "pixel";
_root.topHud.mcLogoutBtn.txtLabel.sharpness = 100;
_root.topHud.mcLogoutBtn.txtLabel.embedFonts = _root.defaultHudTopLabelFontEmbed;
_root.topHud.mcLogoutBtn.txtLabel.setTextFormat(_root.defaultHudTopLabelFmt);
_root.topHud.mcLogoutBtn.txtLabel._height = _root.defaultHudTopLabelFontHeight + 7;
_root.topHud.mcLogoutBtn.txtLabel._y = _root.topHud.mcLogoutBtn.txtLabel._y + _root.defaultHudTopLabelProps.yHelp;
_root.topHud.mcLogoutBtn.txtLabel.autoSize = "left";
_root.topHud.mcLogoutBtn.gotoAndStop("std");
_root.topHud.mcLogoutBtn.onRollOver = function()
{
   this.gotoAndStop("hover");
};
_root.topHud.mcLogoutBtn.onRollOut = function()
{
   this.gotoAndStop("std");
};
_root.topHud.mcLogoutBtn.onPress = function()
{
   if(_root.lgoff == undefined)
   {
      _root.attachMovie("lgoff","lgoff",_root.getNextHighestDepth());
      _root.lgoff._x = 280;
      _root.lgoff._y = 200;
      _root.lgoff.hb.onRelease = null;
      _root.logOffTimer();
      var _loc2_ = "l";
      _root.SendtoStream(_loc2_);
      _root._level0[_root.g_CurClientUser].onNEWclick(Math.round(_root.cplayer[_root.g_CurClientUser].theX * 1 + _root.g_OffsetX * 1),Math.round(_root.cplayer[_root.g_CurClientUser].theY * 1 + _root.g_OffsetY * 1));
      _root.g_farming = 1;
   }
};
_root.toggleFPSMeter();
_root.activePreset = 1;
_root.txtDbgOutput.text = "";
_root.txtDbgOutput._visible = false;
updatePresetBtns(true);
initBoosterUi();
_root.HUD.thehud.mcDroCpuIndy._visible = false;
_root.HUD.thehud.mcDroCpuIndy.gotoAndStop(3);
_root.topHud = _root.debugbox;
_root.topHud.ep.antiAliasType = "advanced";
_root.topHud.ep.gridFitType = "pixel";
_root.topHud.ep.sharpness = 200;
_root.topHud.level.antiAliasType = "advanced";
_root.topHud.level.gridFitType = "pixel";
_root.topHud.level.sharpness = 200;
_root.topHud.honour.antiAliasType = "advanced";
_root.topHud.honour.gridFitType = "pixel";
_root.topHud.honour.sharpness = 200;
_root.topHud.jack.antiAliasType = "advanced";
_root.topHud.jack.gridFitType = "pixel";
_root.topHud.jack.sharpness = 200;
_root.topHud.cargospace.antiAliasType = "advanced";
_root.topHud.cargospace.gridFitType = "pixel";
_root.topHud.cargospace.sharpness = 200;
_root.topHud.credits.antiAliasType = "advanced";
_root.topHud.credits.gridFitType = "pixel";
_root.topHud.credits.sharpness = 200;
_root.topHud.uridium.antiAliasType = "advanced";
_root.topHud.uridium.gridFitType = "pixel";
_root.topHud.uridium.sharpness = 200;
_root.topHud.shield.antiAliasType = "advanced";
_root.topHud.shield.gridFitType = "pixel";
_root.topHud.shield.sharpness = 200;
_root.topHud.hitpoints.antiAliasType = "advanced";
_root.topHud.hitpoints.gridFitType = "pixel";
_root.topHud.hitpoints.sharpness = 200;
_root.topHud.laser.antiAliasType = "advanced";
_root.topHud.laser.gridFitType = "pixel";
_root.topHud.laser.sharpness = 200;
_root.topHud.rockets.antiAliasType = "advanced";
_root.topHud.rockets.gridFitType = "pixel";
_root.topHud.rockets.sharpness = 200;
var i = 0;
while(i < 12)
{
   _root.topHud["txtLabel" + i].antiAliasType = "advanced";
   _root.topHud["txtLabel" + i].gridFitType = "pixel";
   _root.topHud["txtLabel" + i].sharpness = 200;
   i++;
}
_root.topHud.mologouttxt.antiAliasType = "advanced";
_root.topHud.mologouttxt.gridFitType = "pixel";
_root.topHud.mologouttxt.sharpness = 200;
_root.topHud.mohilfetxt.antiAliasType = "advanced";
_root.topHud.mohilfetxt.gridFitType = "pixel";
_root.topHud.mohilfetxt.sharpness = 200;
_root.chat.firmbut.firmenchattxt.antiAliasType = "advanced";
_root.chat.firmbut.firmenchattxt.gridFitType = "pixel";
_root.chat.firmbut.firmenchattxt.sharpness = 200;
_root.chat.globbut.globalchattxt.antiAliasType = "advanced";
_root.chat.globbut.globalchattxt.gridFitType = "pixel";
_root.chat.globbut.globalchattxt.sharpness = 200;
_root.alertState = -1;
updateAlertState();
_root.wizTicks = 0;
_root.toggleShowBoxes = true;
_root.toggleFullBottomHud = true;
_root.bottomHudDefault._y = _root.HUD._y;
_root.bottomHudBgDefault._y = _root.BGHUD._y;
_root.toggleMinimap = true;
laserTypeCount = 5;
updateLaserBtns();
rocketTypeCount = 3;
updateRocketBtns();
updateMineBtns();
updateFastBuyBtn();
var sbScore = {v_score:0,e_score:0,m_score:0,ball_on:"n",ball_speed:0};
var SCOREBUG_STATE_MAX = 0;
var SCOREBUG_STATE_MIN = 1;
var scorebugDefault = {_state:SCOREBUG_STATE_MIN,x:769,y:450};
var speedIconDefault = {m:27,e:82,v:140};
var scorebugCurrent = {x:scorebugDefault.x - mcScorebug.mcScorebugMax._width + 51,y:scorebugDefault.y};
var sbScorebugState = SCOREBUG_STATE_MIN;
mcScorebug.mcScorebugMax.mcBg.useHandCursor = false;
mcScorebug.mcScorebugMax.mcToggleSizeBtn.mcIcon.gotoAndStop("minimize");
mcScorebug.mcScorebugMax.mcToggleSizeBtn.gotoAndStop("std");
mcScorebug.mcScorebugMax.mcToggleSizeBtn.useHandCursor = false;
mcScorebug.mcScorebugMax.mcToggleSizeBtn.onRollOver = function()
{
   this.gotoAndStop("hover");
};
mcScorebug.mcScorebugMax.mcToggleSizeBtn.onRollOut = function()
{
   this.gotoAndStop("std");
};
mcScorebug.mcScorebugMax.mcToggleSizeBtn.onRelease = function()
{
   _root.toggleScorebugSize();
};
mcScorebug.mcScorebugMin.mcBg.useHandCursor = false;
mcScorebug.mcScorebugMin.mcToggleSizeBtn.mcIcon.gotoAndStop("maximize");
mcScorebug.mcScorebugMin.mcToggleSizeBtn.gotoAndStop("std");
mcScorebug.mcScorebugMin.mcToggleSizeBtn.useHandCursor = false;
mcScorebug.mcScorebugMin.mcToggleSizeBtn.onRollOver = function()
{
   this.gotoAndStop("hover");
};
mcScorebug.mcScorebugMin.mcToggleSizeBtn.onRollOut = function()
{
   this.gotoAndStop("std");
};
mcScorebug.mcScorebugMin.mcToggleSizeBtn.onRelease = function()
{
   _root.toggleScorebugSize();
};
mcScorebug.mcScorebugMax.mcTitlebarBtn.useHandCursor = false;
mcScorebug.mcScorebugMax.mcTitlebarBtn.onPress = function()
{
   _root.mcScorebug.startDrag();
};
mcScorebug.mcScorebugMax.mcTitlebarBtn.onRelease = mcScorebug.mcScorebugMax.mcTitlebarBtn.onReleaseOutside = function()
{
   _root.mcScorebug.stopDrag();
   _root.scorebugCurrent.x = int(_root.mcScorebug._x);
   _root.scorebugCurrent.y = int(_root.mcScorebug._y);
   _root.mcScorebug._x = _root.scorebugCurrent.x;
   _root.mcScorebug._y = _root.scorebugCurrent.y;
};
mcScorebug.mcScorebugMin.mcScorechangeE.gotoAndStop("out");
mcScorebug.mcScorebugMin.mcScorechangeM.gotoAndStop("out");
mcScorebug.mcScorebugMin.mcScorechangeV.gotoAndStop("out");
mcScorebug.mcScorebugMax.mcScorechangeE.gotoAndStop("out");
mcScorebug.mcScorebugMax.mcScorechangeM.gotoAndStop("out");
mcScorebug.mcScorebugMax.mcScorechangeV.gotoAndStop("out");
mcScorebug._visible = false;
toggleScorebugSize();
var TDM_INFO_STATE_FLOATING = 0;
var TDM_INFO_STATE_DOCKED = 1;
var tdmInfoDefault = {_state:TDM_INFO_STATE_DOCKED,x:756,y:393};
var tdmInfoCurrent = {x:tdmInfoDefault.x,y:tdmInfoDefault.y,_state:TDM_INFO_STATE_DOCKED};
mcTdmInfo.mcBg.useHandCursor = false;
mcTdmInfo.mcToggleSizeBtn.mcIcon.gotoAndStop("maximize");
mcTdmInfo.mcToggleSizeBtn.gotoAndStop("std");
mcTdmInfo.mcToggleSizeBtn.useHandCursor = false;
mcTdmInfo.mcToggleSizeBtn.onRollOver = function()
{
   this.gotoAndStop("hover");
};
mcTdmInfo.mcToggleSizeBtn.onRollOut = function()
{
   this.gotoAndStop("std");
};
mcTdmInfo.mcToggleSizeBtn.onRelease = function()
{
   _root.toggleTdmInfoDockState();
};
mcTdmInfo.mcTitlebarBtn.useHandCursor = false;
mcTdmInfo.mcTitlebarBtn.onPress = function()
{
   if(_root.tdmInfoCurrent._state == _root.TDM_INFO_STATE_FLOATING)
   {
      _root.mcTdmInfo.startDrag();
   }
};
mcTdmInfo.mcTitlebarBtn.onRelease = mcTdmInfo.mcTitlebarBtn.onReleaseOutside = function()
{
   _root.mcTdmInfo.stopDrag();
   _root.tdmInfoCurrent.x = int(_root.mcTdmInfo._x);
   _root.tdmInfoCurrent.y = int(_root.mcTdmInfo._y);
   _root.mcTdmInfo._x = _root.tdmInfoCurrent.x;
   _root.mcTdmInfo._y = _root.tdmInfoCurrent.y;
};
hideTdmInfo();
hideQueuePosition();
var invasionScore = {v_score:0,e_score:0,m_score:0,wave_count:0};
mcInvasionScorebug.mcTitlebarBtn.useHandCursor = false;
mcInvasionScorebug.mcTitlebarBtn.onPress = function()
{
   _root.mcInvasionScorebug.startDrag();
};
mcInvasionScorebug.mcTitlebarBtn.onRelease = mcInvasionScorebug.mcTitlebarBtn.onReleaseOutside = function()
{
   _root.mcInvasionScorebug.stopDrag();
};
mcInvasionScorebug._visible = false;
setAmmoBuyIcon(0);
hideGroupBug();
initGroupBug();
var cmdWhiteList = {};
cmdWhiteList.ps = true;
var beaconData = new Array();
beaconData[1] = new Array();
beaconData[2] = new Array();
beaconData[3] = new Array();
var allBeaconIDs = new Array([1,2],[1,3],[2,1],[2,3],[3,1],[3,2]);
var freeBeaconBoxHashes = new Array();
_global.flagMMUpdateTimer = 0;
var totalCTFFlags = 0;
_root.CTF_TABLE_LEFT = 4;
_root.CTF_TABLE_TOP = 16;
_root.CTF_TABLE_CELL_PADDING_WITDH = 2;
_root.CTF_TABLE_CELL_PADDING_HEIGHT = 0;
_root.CTF_TABLE_COLUMN_WIDTH = 52;
_root.CTF_TABLE_ROW_HEIGHT = 11;
hideCTFScorebug();
initFireworksBug();
hideFireworksBug();
