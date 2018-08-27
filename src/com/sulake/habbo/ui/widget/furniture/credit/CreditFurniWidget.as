
package com.sulake.habbo.ui.widget.furniture.credit
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.ui.widget.events.RoomWidgetCreditFurniUpdateEvent;
    import flash.events.IEventDispatcher;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.habbo.window.enum.HabboWindowType;
    import com.sulake.habbo.window.enum.HabboWindowStyle;
    import com.sulake.habbo.window.enum.HabboWindowParam;
    import flash.geom.Rectangle;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetCreditFurniRedeemMessage;
    import com.sulake.habbo.utils.HabboWebTools;
    import com.sulake.core.window.events.WindowEvent;

    public class CreditFurniWidget extends RoomWidgetBase 
    {

        private static const _SafeStr_3710:Number = 100;
        private static const _selectedBrightness:Number = 100;

        private var _window:IWindowContainer;
        private var _SafeStr_8180:int = -1;
        private var _SafeStr_8181:Number;

        public function CreditFurniWidget(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary, _arg_4:IHabboLocalizationManager)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
        }
        override public function dispose():void
        {
            this.hideInterface();
            super.dispose();
        }
        override public function registerUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null){
                return;
            };
            _arg_1.addEventListener(RoomWidgetCreditFurniUpdateEvent.RWCFUE_CREDIT_FURNI_UPDATE, this.onObjectUpdate);
            super.registerUpdateEvents(_arg_1);
        }
        override public function unregisterUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null){
                return;
            };
            _arg_1.removeEventListener(RoomWidgetCreditFurniUpdateEvent.RWCFUE_CREDIT_FURNI_UPDATE, this.onObjectUpdate);
        }
        private function onObjectUpdate(_arg_1:RoomWidgetCreditFurniUpdateEvent):void
        {
            this.hideInterface();
            this._SafeStr_8180 = _arg_1.objectId;
            this._SafeStr_8181 = _arg_1.creditValue;
            this.showInterface();
        }
        private function showInterface():void
        {
            var _local_3:IWindow;
            if (this._SafeStr_8180 == -1){
                return;
            };
            if (this._window != null){
                this._window.dispose();
                this._window = null;
            };
            windowManager.registerLocalizationParameter("widgets.furniture.credit.redeem.value", "value", String(this._SafeStr_8181));
            var _local_1:IAsset = assets.getAssetByName("credit_redeem");
            var _local_2:XmlAsset = XmlAsset(_local_1);
            if (_local_2 == null){
                return;
            };
            this._window = (windowManager.createWindow("creditfurniui_container", "", HabboWindowType._SafeStr_3728, HabboWindowStyle._SafeStr_3729, (HabboWindowParam._SafeStr_3730 | HabboWindowParam._SafeStr_3731), new Rectangle(_SafeStr_3710, _selectedBrightness, 2, 2), null, 0) as IWindowContainer);
            this._window.buildFromXML(XML(_local_2.content));
            this._window.background = true;
            this._window.color = 33554431;
            _local_3 = this._window.findChildByName("cancel");
            if (_local_3 != null){
                _local_3.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onMouseEvent);
            };
            _local_3 = this._window.findChildByName("exchange");
            if (_local_3 != null){
                _local_3.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onMouseEvent);
            };
            _local_3 = this._window.findChildByName("link");
            if (_local_3 != null){
                _local_3.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onMouseEvent);
            };
            _local_3 = this._window.findChildByTag("close");
            if (_local_3 != null){
                _local_3.procedure = this.onWindowClose;
            };
            this._window.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onMouseEvent);
        }
        private function hideInterface():void
        {
            if (this._window != null){
                this._window.dispose();
                this._window = null;
            };
            this._SafeStr_8180 = -1;
            this._SafeStr_8181 = 0;
        }
        private function sendRedeemMessage():void
        {
            var _local_1:RoomWidgetCreditFurniRedeemMessage;
            if (this._SafeStr_8180 == -1){
                return;
            };
            if (messageListener != null){
                _local_1 = new RoomWidgetCreditFurniRedeemMessage(RoomWidgetCreditFurniRedeemMessage.RWFCRM_REDEEM, this._SafeStr_8180);
                messageListener.processWidgetMessage(_local_1);
                this.hideInterface();
            };
        }
        private function onMouseEvent(_arg_1:WindowMouseEvent):void
        {
            var _local_4:String;
            var _local_2:IWindow = (_arg_1.target as IWindow);
            var _local_3:String = _local_2.name;
            switch (_local_3){
                case "link":
                    _local_4 = localizations.getKey("widget.furni.info.url");
                    if (_local_4.indexOf("http") == 0){
                        HabboWebTools.navigateToURL(_local_4, "habboMain");
                    };
                    return;
                case "exchange":
                    this.sendRedeemMessage();
                    return;
                case "cancel":
                case "close":
                    this.hideInterface();
                    return;
            };
        }
        private function onWindowClose(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            this.hideInterface();
        }

    }
}//package com.sulake.habbo.ui.widget.furniture.credit

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// HabboWebTools = "_-2pX" (String#21059, DoABC#2)
// HabboWindowParam = "_-29D" (String#6233, DoABC#2)
// HabboWindowStyle = "_-0E1" (String#14608, DoABC#2)
// HabboWindowType = "_-29U" (String#19384, DoABC#2)
// RoomWidgetBase = "_-0eQ" (String#4398, DoABC#2)
// CreditFurniWidget = "_-0Lg" (String#3996, DoABC#2)
// RoomWidgetCreditFurniRedeemMessage = "_-2oe" (String#7051, DoABC#2)
// RoomWidgetCreditFurniUpdateEvent = "_-2z4" (String#7265, DoABC#2)
// RWFCRM_REDEEM = "_-27Y" (String#19313, DoABC#2)
// _SafeStr_3710 = "_-3-S" (String#908, DoABC#2)
// _selectedBrightness = "_-2M9" (String#885, DoABC#2)
// hideInterface = "_-29" (String#304, DoABC#2)
// registerUpdateEvents = "_-1yD" (String#1787, DoABC#2)
// onObjectUpdate = "_-2l-" (String#248, DoABC#2)
// unregisterUpdateEvents = "_-0-c" (String#3556, DoABC#2)
// showInterface = "_-121" (String#162, DoABC#2)
// _SafeStr_3728 = "_-1IW" (String#5215, DoABC#2)
// _SafeStr_3729 = "_-06z" (String#14322, DoABC#2)
// _SafeStr_3730 = "_-1rZ" (String#18611, DoABC#2)
// _SafeStr_3731 = "_-B" (String#22654, DoABC#2)
// onMouseEvent = "_-0ZW" (String#357, DoABC#2)
// onWindowClose = "_-2tr" (String#136, DoABC#2)
// RWCFUE_CREDIT_FURNI_UPDATE = "_-1Xg" (String#17802, DoABC#2)
// _SafeStr_8180 = "_-0Yc" (String#15384, DoABC#2)
// _SafeStr_8181 = "_-UM" (String#23424, DoABC#2)
// creditValue = "_-3Aq" (String#21912, DoABC#2)
// sendRedeemMessage = "_-BJ" (String#22666, DoABC#2)


