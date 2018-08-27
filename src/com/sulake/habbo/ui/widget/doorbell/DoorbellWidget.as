
package com.sulake.habbo.ui.widget.doorbell
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.ui.widget.events.RoomWidgetDoorbellEvent;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetLetUserInMessage;

    public class DoorbellWidget extends RoomWidgetBase 
    {

        private static const _SafeStr_5086:int = 50;

        private var _users:Array;
        private var _view:DoorbellView;

        public function DoorbellWidget(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary, _arg_4:IHabboLocalizationManager)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
            this._view = new DoorbellView(this);
            this._users = [];
        }
        override public function get mainWindow():IWindow
        {
            return (this._view.mainWindow);
        }
        public function get users():Array
        {
            return (this._users);
        }
        override public function dispose():void
        {
            if (disposed){
                return;
            };
            if (this._view){
                this._view.dispose();
                this._view = null;
            };
            this._users = null;
            super.dispose();
        }
        override public function registerUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null){
                return;
            };
            _arg_1.addEventListener(RoomWidgetDoorbellEvent.RWDE_RINGING, this.onDoorbellRinging);
            _arg_1.addEventListener(RoomWidgetDoorbellEvent.RWDE_REJECTED, this.onDoorbellHandled);
            _arg_1.addEventListener(RoomWidgetDoorbellEvent.RWDE_ACCEPTED, this.onDoorbellHandled);
            super.registerUpdateEvents(_arg_1);
        }
        override public function unregisterUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null){
                return;
            };
            _arg_1.removeEventListener(RoomWidgetDoorbellEvent.RWDE_RINGING, this.onDoorbellRinging);
            _arg_1.removeEventListener(RoomWidgetDoorbellEvent.RWDE_REJECTED, this.onDoorbellHandled);
            _arg_1.removeEventListener(RoomWidgetDoorbellEvent.RWDE_ACCEPTED, this.onDoorbellHandled);
        }
        private function onDoorbellRinging(_arg_1:RoomWidgetDoorbellEvent):void
        {
            this.addUser(_arg_1.userName);
        }
        private function onDoorbellHandled(_arg_1:RoomWidgetDoorbellEvent):void
        {
            this.removeUser(_arg_1.userName);
        }
        public function addUser(_arg_1:String):void
        {
            if (this._users.indexOf(_arg_1) != -1){
                return;
            };
            if (this._users.length >= _SafeStr_5086){
                this.deny(_arg_1);
                return;
            };
            this._users.push(_arg_1);
            this._view.update();
        }
        public function removeUser(_arg_1:String):void
        {
            var _local_2:int = this._users.indexOf(_arg_1);
            if (_local_2 == -1){
                return;
            };
            this._users.splice(_local_2, 1);
            this._view.update();
        }
        public function accept(_arg_1:String):void
        {
            var _local_2:RoomWidgetLetUserInMessage = new RoomWidgetLetUserInMessage(_arg_1, true);
            messageListener.processWidgetMessage(_local_2);
            this.removeUser(_arg_1);
        }
        public function deny(_arg_1:String):void
        {
            var _local_2:RoomWidgetLetUserInMessage = new RoomWidgetLetUserInMessage(_arg_1, false);
            messageListener.processWidgetMessage(_local_2);
            this.removeUser(_arg_1);
        }
        public function denyAll():void
        {
            while (this._users.length > 0) {
                this.deny(this._users[0]);
            };
        }

    }
}//package com.sulake.habbo.ui.widget.doorbell

// RoomWidgetBase = "_-0eQ" (String#4398, DoABC#2)
// DoorbellWidget = "_-1Qv" (String#5372, DoABC#2)
// RoomWidgetDoorbellEvent = "_-3CX" (String#7566, DoABC#2)
// DoorbellView = "_-0Va" (String#4219, DoABC#2)
// RoomWidgetLetUserInMessage = "_-2Tq" (String#6644, DoABC#2)
// registerUpdateEvents = "_-1yD" (String#1787, DoABC#2)
// unregisterUpdateEvents = "_-0-c" (String#3556, DoABC#2)
// mainWindow = "_-2Lh" (String#1862, DoABC#2)
// RWDE_ACCEPTED = "_-1OB" (String#17441, DoABC#2)
// RWDE_REJECTED = "_-1MV" (String#17378, DoABC#2)
// _SafeStr_5086 = "_-0Ys" (String#15396, DoABC#2)
// users = "_-0nL" (String#15950, DoABC#2)
// RWDE_RINGING = "_-3FK" (String#22090, DoABC#2)
// onDoorbellRinging = "_-0zL" (String#16401, DoABC#2)
// onDoorbellHandled = "_-2wD" (String#21319, DoABC#2)
// addUser = "_-Ho" (String#22923, DoABC#2)
// removeUser = "_-1m8" (String#18385, DoABC#2)
// denyAll = "_-sw" (String#24401, DoABC#2)


