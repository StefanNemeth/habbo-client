
package com.sulake.habbo.ui.widget.memenu
{
    import com.sulake.core.window.IWindowContainer;
    import flash.utils.Dictionary;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.habbo.session.HabboClubLevelEnum;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.display.BitmapData;
    import flash.geom.Point;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetDanceMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetWaveMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetRequestWidgetMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetShowOwnRoomsMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetOpenInventoryMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetAvatarEditorMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetOpenCatalogMessage;
    import flash.external.ExternalInterface;
    import com.sulake.habbo.utils.HabboWebTools;
    import com.sulake.habbo.tracking.HabboTracking;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.core.window.events.WindowEvent;

    public class MeMenuMainView implements IMeMenuView 
    {

        private var _widget:MeMenuWidget;
        private var _window:IWindowContainer;
        private var _SafeStr_3935:Dictionary;

        public function init(_arg_1:MeMenuWidget, _arg_2:String):void
        {
            this._SafeStr_3935 = new Dictionary();
            this._SafeStr_3935["rooms_icon"] = ["gohome_white", "gohome_color"];
            this._SafeStr_3935["dance_icon"] = ["dance_white", "dance_color"];
            this._SafeStr_3935["clothes_icon"] = ["clothes_white", "clothes_color"];
            this._SafeStr_3935["effects_icon"] = ["effects_white", "effects_color"];
            this._SafeStr_3935["badges_icon"] = ["badges_white", "badges_color"];
            this._SafeStr_3935["wave_icon"] = ["wave_white", "wave_color"];
            this._SafeStr_3935["hc_icon"] = ["_white", "_color"];
            this._SafeStr_3935["settings_icon"] = ["settings_white", "settings_color"];
            this._SafeStr_3935["credits_icon"] = ["credits_white", "credits_color"];
            this._SafeStr_3935["news_icon"] = ["news_white", "news_color"];
            this._widget = _arg_1;
            this.createWindow(_arg_2);
        }
        public function dispose():void
        {
            this._widget = null;
            if (this._window){
                this._window.dispose();
                this._window = null;
            };
        }
        public function get window():IWindowContainer
        {
            return (this._window);
        }
        public function MeMenuMainView(_arg_1:String, _arg_2:String, _arg_3:String=null, _arg_4:String=null):void
        {
            if (this._SafeStr_3935[_arg_1] == null){
                return;
            };
            if (_arg_3 != null){
                this._SafeStr_3935[_arg_1][0] = _arg_3;
            };
            if (_arg_4 != null){
                this._SafeStr_3935[_arg_1][1] = _arg_4;
            };
            this.PendingImage(_arg_1, _arg_3);
        }
        private function createWindow(_arg_1:String):void
        {
            var _local_4:String;
            var _local_5:IWindow;
            var _local_6:int;
            var _local_7:Array;
            var _local_8:String;
            var _local_9:Number;
            var _local_10:String;
            if (this._widget == null){
                return;
            };
            var _local_2:String = "memenu_main";
            if (((this._widget.config.getBoolean("menu.own_avatar.enabled", false)) && (this._widget.config.getBoolean("simple.memenu.enabled", false)))){
                _local_2 = (_local_2 + "_simple");
            };
            var _local_3:XmlAsset = (this._widget.assets.getAssetByName(_local_2) as XmlAsset);
            Logger.log(("Show window: " + _local_3));
            this._window = (this._widget.windowManager.buildFromXML((_local_3.content as XML)) as IWindowContainer);
            if (this._window == null){
                throw (new Error("Failed to construct me menu main window from XML!"));
            };
            this._window.name = _arg_1;
            for (_local_4 in this._SafeStr_3935) {
                _local_7 = this._SafeStr_3935[_local_4];
                if (!(((_local_7 == null)) || ((_local_7.length == 0)))){
                    _local_8 = _local_7[0];
                    _local_9 = 1;
                    switch (_local_4){
                        case "dance_icon":
                        case "wave_icon":
                            if (this._widget.hasEffectOn){
                                _local_9 = 0.5;
                            };
                            break;
                        case "effects_icon":
                            if (this._widget.isDancing){
                                _local_9 = 0.5;
                            };
                            break;
                        case "hc_icon":
                            _local_8 = (this.MeMenuMainView() + _local_8);
                            if (!this._widget.isHabboClubActive){
                                this.MeMenuMainView("hc_text", this._widget.localizations.getKey("widget.memenu.hc.join"));
                            }
                            else {
                                if (this._widget.habboClubLevel == HabboClubLevelEnum._SafeStr_3939){
                                    _local_10 = "widget.memenu.vip";
                                }
                                else {
                                    _local_10 = "widget.memenu.hc";
                                };
                                if (this._widget.habboClubPeriods > 0){
                                    _local_10 = (_local_10 + ".long");
                                };
                                this._widget.localizations.registerParameter(_local_10, "days", String(this._widget.habboClubDays));
                                this._widget.localizations.registerParameter(_local_10, "months", String(this._widget.habboClubPeriods));
                                this.MeMenuMainView("hc_text", this._widget.localizations.getKey(_local_10));
                            };
                            break;
                        case "news_icon":
                            if (!this._widget.isNewsEnabled){
                                _local_9 = 0.5;
                            };
                            break;
                    };
                    this.PendingImage(_local_4, _local_8, _local_9);
                };
            };
            _local_6 = 0;
            while (_local_6 < this._window.numChildren) {
                _local_5 = this._window.getChildAt(_local_6);
                _local_5.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.InfoStandUserView);
                _local_5.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.MeMenuMainView);
                _local_5.addEventListener(WindowMouseEvent.WME_OUT, this.MeMenuMainView);
                _local_6++;
            };
        }
        private function MeMenuMainView():String
        {
            switch (this._widget.habboClubLevel){
                case HabboClubLevelEnum._SafeStr_3942:
                case HabboClubLevelEnum._SafeStr_3943:
                    return ("club");
                case HabboClubLevelEnum._SafeStr_3939:
                    return ("vip");
            };
            return (null);
        }
        private function PendingImage(_arg_1:String, _arg_2:String, _arg_3:Number=1):void
        {
            var _local_4:IBitmapWrapperWindow = (this._window.findChildByName(_arg_1) as IBitmapWrapperWindow);
            var _local_5:BitmapDataAsset = (this._widget.assets.getAssetByName(_arg_2) as BitmapDataAsset);
            if (_local_4 == null){
                Logger.log(("Could not find element: " + _arg_1));
                return;
            };
            if ((((_local_5 == null)) || ((_local_5.content == null)))){
                Logger.log(("Could not find asset: " + _arg_2));
                return;
            };
            var _local_6:BitmapData = (_local_5.content as BitmapData);
            _local_4.bitmap = new BitmapData(_local_4.width, _local_4.height, true, 0);
            var _local_7:int = ((_local_4.width - _local_6.width) / 2);
            var _local_8:int = ((_local_4.height - _local_6.height) / 2);
            _local_4.bitmap.copyPixels(_local_6, _local_6.rect, new Point(_local_7, _local_8));
            _local_4.blend = _arg_3;
        }
        private function MeMenuMainView(_arg_1:String, _arg_2:String):void
        {
            var _local_3:ITextWindow = (this._window.findChildByName(_arg_1) as ITextWindow);
            if (_local_3 != null){
                _local_3.text = _arg_2;
            };
        }
        private function InfoStandUserView(_arg_1:WindowMouseEvent):void
        {
            var _local_4:Boolean;
            var _local_5:String;
            var _local_2:IWindow = (_arg_1.target as IWindow);
            var _local_3:String = _local_2.name;
            switch (_local_3){
                case "dance":
                    if (this._widget.hasEffectOn){
                        return;
                    };
                    this._widget.MeMenuWidget(MeMenuWidget._SafeStr_3860);
                    break;
                case "wave":
                    if (this._widget.hasEffectOn){
                        return;
                    };
                    if (this._widget.isDancing){
                        this._widget.messageListener.processWidgetMessage(new RoomWidgetDanceMessage(RoomWidgetDanceMessage._SafeStr_3577));
                        this._widget.isDancing = false;
                    };
                    this._widget.messageListener.processWidgetMessage(new RoomWidgetWaveMessage());
                    this._widget.hide();
                    break;
                case "effects":
                    if (this._widget.isDancing){
                        return;
                    };
                    this._widget.messageListener.processWidgetMessage(new RoomWidgetRequestWidgetMessage(RoomWidgetRequestWidgetMessage.RWRWM_EFFECTS));
                    this._widget.hide();
                    break;
                case "rooms":
                    this._widget.messageListener.processWidgetMessage(new RoomWidgetShowOwnRoomsMessage());
                    this._widget.hide();
                    break;
                case "badges":
                    this._widget.messageListener.processWidgetMessage(new RoomWidgetOpenInventoryMessage(RoomWidgetOpenInventoryMessage._SafeStr_3551));
                    this._widget.hide();
                    break;
                case "clothes":
                    this._widget.messageListener.processWidgetMessage(new RoomWidgetAvatarEditorMessage(RoomWidgetAvatarEditorMessage.RWCM_OPEN_AVATAR_EDITOR));
                    this._widget.hide();
                    break;
                case "hc":
                    this._widget.messageListener.processWidgetMessage(new RoomWidgetOpenCatalogMessage(RoomWidgetOpenCatalogMessage.RWOCM_CLUB_MAIN));
                    this._widget.hide();
                    break;
                case "settings":
                    this._widget.MeMenuWidget(MeMenuWidget._SafeStr_3861);
                    break;
                case "news":
                    if (((ExternalInterface.available) && (this._widget.isNewsEnabled))){
                        ExternalInterface.call("FlashExternalInterface.openHabblet", "news");
                        this._widget.hide();
                    };
                    break;
                case "credits":
                    _local_4 = (this._widget.config.getKey("client.credits.embed.enabled", "false") == "true");
                    if (((ExternalInterface.available) && (_local_4))){
                        ExternalInterface.call("FlashExternalInterface.openHabblet", "credits");
                    }
                    else {
                        _local_5 = this._widget.config.getKey("link.format.credits", "/credits");
                        HabboWebTools.navigateToURL(_local_5, "habboMain");
                        this._widget.windowManager.alert("${catalog.alert.external.link.title}", "${catalog.alert.external.link.desc}", 0, this.MeMenuMainView);
                    };
                    this._widget.hide();
                    break;
                default:
                    Logger.log(("Me Menu Main View: unknown button: " + _local_3));
            };
            HabboTracking.getInstance().trackEventLog("MeMenu", "click", _local_3);
        }
        private function MeMenuMainView(_arg_1:IAlertDialog, _arg_2:WindowEvent):void
        {
            _arg_1.dispose();
        }
        private function MeMenuMainView(_arg_1:WindowMouseEvent):void
        {
            var _local_5:Array;
            var _local_6:String;
            var _local_2:IWindow = (_arg_1.target as IWindow);
            var _local_3:String = _local_2.name;
            var _local_4 = (_local_3 + "_icon");
            var _local_7:String = "";
            var _local_8:int = (((_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER)) ? 1 : 0);
            switch (_local_3){
                case "dance":
                    if (this._widget.hasEffectOn){
                        return;
                    };
                    break;
                case "news":
                    if (!this._widget.isNewsEnabled){
                        return;
                    };
                    break;
                case "wave":
                    if (this._widget.hasEffectOn){
                        return;
                    };
                    break;
                case "effects":
                    if (this._widget.isDancing){
                        return;
                    };
                    break;
                case "hc":
                    _local_7 = this.MeMenuMainView();
                    break;
            };
            _local_4 = (_local_3 + "_icon");
            _local_5 = this._SafeStr_3935[_local_4];
            if (_local_5 != null){
                _local_6 = (_local_7 + _local_5[_local_8]);
                this.PendingImage(_local_4, _local_6);
            };
        }

    }
}//package com.sulake.habbo.ui.widget.memenu

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// IAlertDialog = "_-2LY" (String#6472, DoABC#2)
// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// HabboWebTools = "_-2pX" (String#21059, DoABC#2)
// HabboClubLevelEnum = "_-1ZP" (String#17867, DoABC#2)
// MeMenuWidget = "_-02H" (String#3610, DoABC#2)
// RoomWidgetRequestWidgetMessage = "_-XQ" (String#8356, DoABC#2)
// IMeMenuView = "_-Y6" (String#8372, DoABC#2)
// MeMenuMainView = "_-1Jt" (String#5241, DoABC#2)
// RoomWidgetOpenInventoryMessage = "_-1bT" (String#5586, DoABC#2)
// RoomWidgetWaveMessage = "_-OB" (String#8167, DoABC#2)
// RoomWidgetAvatarEditorMessage = "_-2-5" (String#6031, DoABC#2)
// RoomWidgetShowOwnRoomsMessage = "_-1xI" (String#5978, DoABC#2)
// RoomWidgetDanceMessage = "_-1CY" (String#5117, DoABC#2)
// RoomWidgetOpenCatalogMessage = "_-2Cg" (String#6297, DoABC#2)
// RWRWM_EFFECTS = "_-9y" (String#22615, DoABC#2)
// _SafeStr_3551 = "_-2cL" (String#20537, DoABC#2)
// RWCM_OPEN_AVATAR_EDITOR = "_-1Sk" (String#17613, DoABC#2)
// _SafeStr_3577 = "_-Fb" (String#22834, DoABC#2)
// RWOCM_CLUB_MAIN = "_-1FR" (String#17091, DoABC#2)
// _SafeStr_3860 = "_-1SH" (String#17592, DoABC#2)
// _SafeStr_3861 = "_-1HH" (String#17161, DoABC#2)
// MeMenuWidget = "_-0hX" (String#15729, DoABC#2)
// MeMenuMainView = "_-27e" (String#19316, DoABC#2)
// isHabboClubActive = "_-0Ta" (String#15193, DoABC#2)
// habboClubDays = "_-1Et" (String#17066, DoABC#2)
// habboClubPeriods = "_-2O9" (String#19972, DoABC#2)
// habboClubLevel = "_-03V" (String#14181, DoABC#2)
// isNewsEnabled = "_-3-L" (String#21475, DoABC#2)
// InfoStandUserView = "_-2k0" (String#247, DoABC#2)
// trackEventLog = "_-0ML" (String#14927, DoABC#2)
// getInstance = "_-n5" (String#24157, DoABC#2)
// _SafeStr_3935 = "_-NY" (String#23147, DoABC#2)
// PendingImage = "_-1IU" (String#302, DoABC#2)
// MeMenuMainView = "_-0p0" (String#16014, DoABC#2)
// MeMenuMainView = "_-0kv" (String#15862, DoABC#2)
// _SafeStr_3939 = "_-2gR" (String#20706, DoABC#2)
// MeMenuMainView = "_-2jC" (String#20811, DoABC#2)
// WME_OUT = "_-0h2" (String#15712, DoABC#2)
// _SafeStr_3942 = "_-0G0" (String#14684, DoABC#2)
// _SafeStr_3943 = "_-xn" (String#24604, DoABC#2)
// MeMenuMainView = "_-16I" (String#16709, DoABC#2)


