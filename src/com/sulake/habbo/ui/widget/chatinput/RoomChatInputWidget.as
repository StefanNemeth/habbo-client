
package com.sulake.habbo.ui.widget.chatinput
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import flash.utils.Timer;
    import com.sulake.core.runtime.Component;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import flash.utils.getTimer;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetChatMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetRoomObjectUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetChatInputContentUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUserInfoUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetFloodControlEvent;
    import flash.events.IEventDispatcher;
    import flash.events.TimerEvent;
    import com.sulake.core.window.IWindow;

    public class RoomChatInputWidget extends RoomWidgetBase 
    {

        private static const _SafeStr_6191:int = 5000;

        private var _visualization:RoomChatInputView;
        private var _selectedUserName:String = "";
        private var _floodBlocked:Boolean = false;
        private var _SafeStr_6194:Timer = null;
        private var _SafeStr_6195:int;
        private var _component:Component = null;
        private var _configuration:IHabboConfigurationManager;

        public function RoomChatInputWidget(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary, _arg_4:IHabboLocalizationManager, _arg_5:IHabboConfigurationManager, _arg_6:Component)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
            this._component = _arg_6;
            this._configuration = _arg_5;
            this._visualization = new RoomChatInputView(this);
        }
        public function get floodBlocked():Boolean
        {
            return (this._floodBlocked);
        }
        public function get config():IHabboConfigurationManager
        {
            return (this._configuration);
        }
        override public function dispose():void
        {
            if (this._visualization != null){
                this._visualization.dispose();
                this._visualization = null;
            };
            if (this._SafeStr_6194 != null){
                this._SafeStr_6194.stop();
                this._SafeStr_6194 = null;
            };
            this._component = null;
            this._configuration = null;
            super.dispose();
        }
        public function get allowPaste():Boolean
        {
            return (((getTimer() - this._SafeStr_6195) > _SafeStr_6191));
        }
        public function setLastPasteTime():void
        {
            this._SafeStr_6195 = getTimer();
        }
        public function sendChat(_arg_1:String, _arg_2:int, _arg_3:String=""):void
        {
            if (this._floodBlocked){
                return;
            };
            var _local_4:RoomWidgetChatMessage = new RoomWidgetChatMessage(RoomWidgetChatMessage.RWCM_MESSAGE_CHAT, _arg_1, _arg_2, _arg_3);
            if (messageListener != null){
                messageListener.processWidgetMessage(_local_4);
            };
        }
        override public function registerUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null){
                return;
            };
            _arg_1.addEventListener(RoomWidgetRoomObjectUpdateEvent.RWROUE_OBJECT_DESELECTED, this.onRoomObjectDeselected);
            _arg_1.addEventListener(RoomWidgetChatInputContentUpdateEvent.RWWCIDE_CHAT_INPUT_CONTENT, this.onChatInputUpdate);
            _arg_1.addEventListener(RoomWidgetUserInfoUpdateEvent.RWUIUE_PEER, this.onUserInfo);
            _arg_1.addEventListener(RoomWidgetFloodControlEvent.RWFCE_FLOOD_CONTROL, this.onFloodControl);
            super.registerUpdateEvents(_arg_1);
        }
        override public function unregisterUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null){
                return;
            };
            _arg_1.removeEventListener(RoomWidgetRoomObjectUpdateEvent.RWROUE_OBJECT_DESELECTED, this.onRoomObjectDeselected);
            _arg_1.removeEventListener(RoomWidgetChatInputContentUpdateEvent.RWWCIDE_CHAT_INPUT_CONTENT, this.onChatInputUpdate);
            _arg_1.removeEventListener(RoomWidgetUserInfoUpdateEvent.RWUIUE_PEER, this.onUserInfo);
            _arg_1.removeEventListener(RoomWidgetFloodControlEvent.RWFCE_FLOOD_CONTROL, this.onFloodControl);
        }
        private function onRoomObjectDeselected(_arg_1:RoomWidgetRoomObjectUpdateEvent):void
        {
            this._selectedUserName = "";
        }
        private function onUserInfo(_arg_1:RoomWidgetUserInfoUpdateEvent):void
        {
            this._selectedUserName = _arg_1.name;
        }
        private function onChatInputUpdate(_arg_1:RoomWidgetChatInputContentUpdateEvent):void
        {
            var _local_2:String = "";
            switch (_arg_1.messageType){
                case RoomWidgetChatInputContentUpdateEvent._SafeStr_6208:
                    _local_2 = localizations.getKey("widgets.chatinput.mode.whisper", ":tell");
                    this._visualization.displaySpecialChatMessage(_local_2, _arg_1.userName);
                    return;
                case RoomWidgetChatInputContentUpdateEvent._SafeStr_6209:
                    return;
            };
        }
        private function onReleaseTimerComplete(_arg_1:TimerEvent):void
        {
            Logger.log("Releasing flood blocking");
            this._floodBlocked = false;
            if (this._visualization != null){
                this._visualization.hideFloodBlocking();
            };
            this._SafeStr_6194 = null;
        }
        private function onReleaseTimerTick(_arg_1:TimerEvent):void
        {
            if (this._visualization != null){
                this._visualization.updateBlockText((this._SafeStr_6194.repeatCount - this._SafeStr_6194.currentCount));
            };
        }
        public function get selectedUserName():String
        {
            return (this._selectedUserName);
        }
        public function onFloodControl(_arg_1:RoomWidgetFloodControlEvent):void
        {
            this._floodBlocked = true;
            Logger.log((("Enabling flood blocking for " + _arg_1.seconds) + " seconds"));
            if (this._SafeStr_6194){
                this._SafeStr_6194.reset();
            }
            else {
                this._SafeStr_6194 = new Timer(1000, _arg_1.seconds);
                this._SafeStr_6194.addEventListener(TimerEvent.TIMER, this.onReleaseTimerTick);
                this._SafeStr_6194.addEventListener(TimerEvent.TIMER_COMPLETE, this.onReleaseTimerComplete);
            };
            this._SafeStr_6194.start();
            if (this._visualization != null){
                this._visualization.updateBlockText(_arg_1.seconds);
                this._visualization.showFloodBlocking();
            };
        }
        override public function get mainWindow():IWindow
        {
            return (this._visualization.window);
        }

    }
}//package com.sulake.habbo.ui.widget.chatinput

// RoomWidgetBase = "_-0eQ" (String#4398, DoABC#2)
// RoomChatInputWidget = "_-1Oc" (String#5326, DoABC#2)
// RoomWidgetRoomObjectUpdateEvent = "_-37T" (String#7457, DoABC#2)
// RoomWidgetFloodControlEvent = "_-23V" (String#19155, DoABC#2)
// RoomChatInputView = "_-1bd" (String#5592, DoABC#2)
// RoomWidgetChatInputContentUpdateEvent = "_-2V7" (String#20243, DoABC#2)
// RoomWidgetUserInfoUpdateEvent = "_-28z" (String#6226, DoABC#2)
// RWCM_MESSAGE_CHAT = "_-2Zj" (String#20430, DoABC#2)
// registerUpdateEvents = "_-1yD" (String#1787, DoABC#2)
// unregisterUpdateEvents = "_-0-c" (String#3556, DoABC#2)
// mainWindow = "_-2Lh" (String#1862, DoABC#2)
// RWROUE_OBJECT_DESELECTED = "_-8G" (String#22552, DoABC#2)
// onUserInfo = "_-2pH" (String#623, DoABC#2)
// _component = "_-2cU" (String#305, DoABC#2)
// _SafeStr_6191 = "_-sv" (String#24400, DoABC#2)
// _selectedUserName = "_-2nf" (String#20985, DoABC#2)
// _floodBlocked = "_-1dn" (String#18050, DoABC#2)
// _SafeStr_6194 = "_-1h7" (String#18180, DoABC#2)
// _SafeStr_6195 = "_-b5" (String#23672, DoABC#2)
// floodBlocked = "_-1rk" (String#18620, DoABC#2)
// allowPaste = "_-3Eg" (String#22061, DoABC#2)
// setLastPasteTime = "_-1-D" (String#16438, DoABC#2)
// sendChat = "_-yT" (String#24634, DoABC#2)
// onRoomObjectDeselected = "_-w7" (String#24534, DoABC#2)
// RWWCIDE_CHAT_INPUT_CONTENT = "_-Kj" (String#23034, DoABC#2)
// onChatInputUpdate = "_-HI" (String#22903, DoABC#2)
// RWUIUE_PEER = "_-2Tv" (String#20195, DoABC#2)
// RWFCE_FLOOD_CONTROL = "_-1qL" (String#18556, DoABC#2)
// onFloodControl = "_-xP" (String#8832, DoABC#2)
// messageType = "_-2PA" (String#20008, DoABC#2)
// displaySpecialChatMessage = "_-21Z" (String#19076, DoABC#2)
// _SafeStr_6208 = "_-Px" (String#23247, DoABC#2)
// _SafeStr_6209 = "_-xy" (String#24613, DoABC#2)
// onReleaseTimerComplete = "_-0W5" (String#15281, DoABC#2)
// hideFloodBlocking = "_-5Q" (String#22441, DoABC#2)
// onReleaseTimerTick = "_-ry" (String#24361, DoABC#2)
// updateBlockText = "_-x2" (String#24571, DoABC#2)
// selectedUserName = "_-1YQ" (String#17830, DoABC#2)
// showFloodBlocking = "_-s0" (String#24364, DoABC#2)
// Component = "_-19A" (String#5060, DoABC#2)


