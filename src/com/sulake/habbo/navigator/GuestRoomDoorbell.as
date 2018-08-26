
package com.sulake.habbo.navigator
{
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
    import com.sulake.core.window.components.ITextWindow;
    import flash.geom.Point;
    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.IWindow;

    public class GuestRoomDoorbell 
    {

        private var _navigator:HabboNavigator;
        private var _window:IFrameWindow;
        private var _SafeStr_12001:GuestRoomData;
        private var _SafeStr_12002:Boolean;

        public function GuestRoomDoorbell(_arg_1:HabboNavigator)
        {
            this._navigator = _arg_1;
        }
        public function show(_arg_1:GuestRoomData, _arg_2:Point=null, _arg_3:Boolean=false):void
        {
            if (_arg_1 == null){
                return;
            };
            this._SafeStr_12001 = _arg_1;
            this._SafeStr_12002 = _arg_3;
            this.createWindow();
            if (this._window == null){
                return;
            };
            if (_arg_2 != null){
                _arg_2.offset((-(this._window.width) / 2), (-(this._window.height) / 2));
                this._window.WindowController(_arg_2);
            };
            this._window.visible = true;
            this._window.activate();
            var _local_4:ITextWindow = (this._window.findChildByName("room_name") as ITextWindow);
            if (_local_4 != null){
                _local_4.text = _arg_1.roomName;
            };
            if (this._SafeStr_12002){
                this.CurrencyIndicatorBase("info", "${navigator.doorbell.waiting}");
                this.CurrencyIndicatorBase("cancel", "${navigator.doorbell.button.cancel.entering}");
                this.InfoStandUserView("ring", false);
            }
            else {
                this.CurrencyIndicatorBase("info", "${navigator.doorbell.info}");
                this.CurrencyIndicatorBase("cancel", "${generic.cancel}");
                this.InfoStandUserView("ring", true);
            };
        }
        public function showWaiting():void
        {
            this.show(this._SafeStr_12001, null, true);
        }
        public function showNoAnswer():void
        {
            if (this._window == null){
                return;
            };
            this._window.visible = true;
            this._window.activate();
            this.CurrencyIndicatorBase("info", "${navigator.doorbell.no.answer}");
            this.InfoStandUserView("ring", false);
        }
        private function InfoStandUserView(_arg_1:String, _arg_2:Boolean):void
        {
            var _local_3:IButtonWindow = (this._window.findChildByName(_arg_1) as IButtonWindow);
            if (_local_3 == null){
                return;
            };
            _local_3.visible = _arg_2;
        }
        private function createWindow():void
        {
            if (this._window != null){
                return;
            };
            var _local_1:XmlAsset = (this._navigator.assets.getAssetByName("doorbell_xml") as XmlAsset);
            this._window = (this._navigator.windowManager.buildFromXML((_local_1.content as XML), 2) as IFrameWindow);
            if (this._window == null){
                return;
            };
            var _local_2:IButtonWindow = (this._window.findChildByName("ring") as IButtonWindow);
            if (_local_2 != null){
                _local_2.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.ringDoorbell);
            };
            var _local_3:IWindow = this._window.findChildByName("cancel_region");
            if (_local_3 != null){
                _local_3.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.close);
            };
            var _local_4:IWindow = this._window.findChildByTag("close");
            if (_local_4 != null){
                _local_4.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.close);
            };
        }
        private function CurrencyIndicatorBase(_arg_1:String, _arg_2:String):void
        {
            if (this._window == null){
                return;
            };
            var _local_3:IWindow = this._window.findChildByName(_arg_1);
            if (_local_3 == null){
                return;
            };
            _local_3.caption = _arg_2;
        }
        public function dispose():void
        {
            if (this._window != null){
                this._window.dispose();
            };
            this._window = null;
            this._navigator = null;
            this._SafeStr_12001 = null;
        }
        private function ringDoorbell(_arg_1:WindowMouseEvent):void
        {
            this._navigator.goToRoom(this._SafeStr_12001.flatId, true);
            this.hide();
        }
        private function close(_arg_1:WindowMouseEvent):void
        {
            if (this._window == null){
                return;
            };
            this._window.dispose();
            this._window = null;
        }
        public function hide():void
        {
            if (this._window == null){
                return;
            };
            this._window.visible = false;
        }

    }
}//package com.sulake.habbo.navigator

// showWaiting = "_-0jH" (String#15802, DoABC#2)
// showNoAnswer = "_-45" (String#22381, DoABC#2)
// _SafeStr_12001 = "_-1U5" (String#5434, DoABC#2)
// _SafeStr_12002 = "_-1q-" (String#18542, DoABC#2)
// ringDoorbell = "_-2ZQ" (String#20414, DoABC#2)
// GuestRoomDoorbell = "_-0D1" (String#3810, DoABC#2)
// GuestRoomData = "_-06S" (String#3692, DoABC#2)
// flatId = "_-3CK" (String#21973, DoABC#2)
// goToRoom = "_-2Jw" (String#6438, DoABC#2)
// CurrencyIndicatorBase = "_-1vu" (String#243, DoABC#2)
// InfoStandUserView = "_-P4" (String#461, DoABC#2)
// WindowController = "_-0OJ" (String#4052, DoABC#2)


