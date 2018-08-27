
package com.sulake.habbo.navigator
{
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.IPasswordFieldWindow;
    import flash.geom.Point;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.IWindow;

    public class GuestRoomPasswordInput 
    {

        private var _navigator:HabboNavigator;
        private var _window:IFrameWindow;
        private var _SafeStr_12001:GuestRoomData;

        public function GuestRoomPasswordInput(_arg_1:HabboNavigator)
        {
            this._navigator = _arg_1;
        }
        public function show(_arg_1:GuestRoomData, _arg_2:Point=null):void
        {
            this._SafeStr_12001 = _arg_1;
            if (this._SafeStr_12001 == null){
                return;
            };
            this.createWindow();
            if (this._window == null){
                return;
            };
            if (_arg_2 != null){
                _arg_2.offset((-(this._window.width) / 2), (-(this._window.height) / 2));
                this._window.setGlobalPosition(_arg_2);
            };
            this._window.visible = true;
            this._window.activate();
            var _local_3:ITextWindow = (this._window.findChildByName("room_name") as ITextWindow);
            if (((!((_local_3 == null))) && (!((_arg_1 == null))))){
                _local_3.text = _arg_1.roomName;
            };
            var _local_4:IPasswordFieldWindow = (this._window.findChildByName("password_input") as IPasswordFieldWindow);
            if (_local_4 != null){
                _local_4.text = "";
            };
            this.setInfoText("${navigator.password.info}");
        }
        private function createWindow():void
        {
            if (this._window != null){
                return;
            };
            var _local_1:XmlAsset = (this._navigator.assets.getAssetByName("password_input_xml") as XmlAsset);
            this._window = (this._navigator.windowManager.buildFromXML((_local_1.content as XML), 2) as IFrameWindow);
            if (this._window == null){
                return;
            };
            var _local_2:IButtonWindow = (this._window.findChildByName("try") as IButtonWindow);
            if (_local_2 != null){
                _local_2.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onTry);
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
        public function showRetry():void
        {
            this.show(this._SafeStr_12001);
            this.setInfoText("${navigator.password.retryinfo}");
        }
        private function setInfoText(_arg_1:String):void
        {
            if (this._window == null){
                return;
            };
            var _local_2:ITextWindow = (this._window.findChildByName("info") as ITextWindow);
            if (_local_2 == null){
                return;
            };
            _local_2.caption = _arg_1;
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
        private function onTry(_arg_1:WindowMouseEvent):void
        {
            var _local_2:IPasswordFieldWindow = (this._window.findChildByName("password_input") as IPasswordFieldWindow);
            if (_local_2 == null){
                return;
            };
            var _local_3:String = _local_2.text;
            this._navigator.goToRoom(this._SafeStr_12001.flatId, true, _local_3);
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
        private function hide(_arg_1:WindowMouseEvent=null):void
        {
            if (this._window == null){
                return;
            };
            this._window.visible = false;
        }

    }
}//package com.sulake.habbo.navigator

// showRetry = "_-0pv" (String#16049, DoABC#2)
// _SafeStr_12001 = "_-1U5" (String#5434, DoABC#2)
// setInfoText = "_-0fa" (String#15654, DoABC#2)
// onTry = "_-0Jh" (String#14830, DoABC#2)
// GuestRoomPasswordInput = "_-2rH" (String#7108, DoABC#2)
// IPasswordFieldWindow = "_-1L7" (String#1664, DoABC#2)
// GuestRoomData = "_-06S" (String#3692, DoABC#2)
// flatId = "_-3CK" (String#21973, DoABC#2)
// goToRoom = "_-2Jw" (String#6438, DoABC#2)
// setGlobalPosition = "_-0OJ" (String#4052, DoABC#2)


