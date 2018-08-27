
package com.sulake.habbo.ui.widget.friendrequest
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.window.enum.HabboWindowParam;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.display.BitmapData;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.geom.Point;
    import flash.geom.Rectangle;

    public class FriendRequestDialog 
    {

        private var _window:IWindowContainer;
        private var _widget:FriendRequestWidget;
        private var _requestId:int;
        private var _userId:int;
        private var _userName:String;
        private var _SafeStr_5951:Boolean = false;
        private var _SafeStr_5952:Boolean = false;
        private var _SafeStr_5953:Boolean = false;

        public function FriendRequestDialog(_arg_1:FriendRequestWidget, _arg_2:int, _arg_3:int, _arg_4:String)
        {
            this._widget = _arg_1;
            this._requestId = _arg_2;
            this._userId = _arg_3;
            this._userName = _arg_4;
        }
        public function dispose():void
        {
            this._widget = null;
            if (this._window){
                this._window.dispose();
            };
            this._window = null;
        }
        private function addMouseClickListener(_arg_1:IWindow, _arg_2:Function):void
        {
            if (_arg_1 != null){
                _arg_1.setParamFlag(HabboWindowParam._SafeStr_3731, true);
                _arg_1.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, _arg_2);
            };
        }
        private function createWindow():void
        {
            if (((((!(this._widget)) || (!(this._widget.assets)))) || (!(this._widget.windowManager)))){
                return;
            };
            var _local_1:XmlAsset = (this._widget.assets.getAssetByName("instant_friend_request") as XmlAsset);
            if (!_local_1){
                return;
            };
            this._window = (this._widget.windowManager.buildFromXML((_local_1.content as XML), 0) as IWindowContainer);
            if (!this._window){
                return;
            };
            this._window.addEventListener(WindowEvent.WE_DEACTIVATED, this.onDeactivated);
            var _local_2:ITextWindow = (this._window.findChildByName("text") as ITextWindow);
            if (_local_2){
                _local_2.text = this._widget.localizations.registerParameter("widget.friendrequest.from", "username", this._userName);
            };
            var _local_3:IWindow = this._window.findChildByName("accept_button");
            this.addMouseClickListener(_local_3, this.onAccept);
            var _local_4:IWindow = this._window.findChildByName("decline_button");
            this.addMouseClickListener(_local_4, this.onDecline);
            var _local_5:IWindow = this._window.findChildByName("close_button");
            this.addMouseClickListener(_local_5, this.onClose);
            this._window.procedure = this.windowEventHandler;
            this._window.visible = false;
        }
        private function windowEventHandler(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (!_arg_1){
                return;
            };
            switch (_arg_1.type){
                case WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER:
                    this._SafeStr_5951 = true;
                    return;
                case WindowMouseEvent.WME_OUT:
                    this._SafeStr_5951 = false;
                    return;
                case WindowMouseEvent.WME_DOWN:
                    this._SafeStr_5952 = true;
                    return;
                case WindowMouseEvent.WME_UP:
                case WindowMouseEvent.WME_UP_OUTSIDE:
                    this._SafeStr_5952 = false;
                    return;
            };
        }
        public function setImageAsset(_arg_1:IBitmapWrapperWindow, _arg_2:String):void
        {
            if (((((!(_arg_1)) || (!(this._widget)))) || (!(this._widget.assets)))){
                return;
            };
            var _local_3:BitmapDataAsset = (this._widget.assets.getAssetByName(_arg_2) as BitmapDataAsset);
            if (!_local_3){
                return;
            };
            var _local_4:BitmapData = (_local_3.content as BitmapData);
            if (!_local_4){
                return;
            };
            if (_arg_1.bitmap){
                _arg_1.bitmap.dispose();
            };
            _arg_1.bitmap = new BitmapData(_arg_1.width, _arg_1.height, true, 0);
            _arg_1.bitmap.draw(_local_4);
        }
        public function get userId():int
        {
            return (this._userId);
        }
        public function show():void
        {
            if (this._window != null){
                this._window.visible = true;
                this._window.activate();
            };
        }
        public function set targetRect(_arg_1:Rectangle):void
        {
            var _local_5:Point;
            if (!_arg_1){
                this._widget.ignoreRequest(this._requestId);
                return;
            };
            if (((this._SafeStr_5951) || (this._SafeStr_5952))){
                return;
            };
            var _local_2:Boolean = true;
            if (!this._window){
                this.createWindow();
                _local_2 = false;
            };
            if (!this._window){
                return;
            };
            var _local_3:Point = new Point(((_arg_1.left + (_arg_1.width / 2)) - (this._window.width / 2)), ((_arg_1.top - this._window.height) + 10));
            var _local_4:Number = Point.distance(this._window.rectangle.topLeft, _local_3);
            if (((_local_2) && ((_local_4 > 5)))){
                _local_5 = Point.interpolate(this._window.rectangle.topLeft, _local_3, 0.5);
                this._window.x = _local_5.x;
                this._window.y = _local_5.y;
            }
            else {
                this._window.x = _local_3.x;
                this._window.y = _local_3.y;
            };
            if (!this._window.visible){
                this.show();
            };
            if (this._SafeStr_5953){
                this.show();
                this._SafeStr_5953 = false;
            };
        }
        private function onDeactivated(_arg_1:WindowEvent):void
        {
            this._SafeStr_5953 = true;
        }
        private function onClose(_arg_1:WindowMouseEvent):void
        {
            if (this._widget != null){
                this._widget.ignoreRequest(this._requestId);
            };
        }
        private function onAccept(_arg_1:WindowMouseEvent):void
        {
            if (this._widget != null){
                this._widget.acceptRequest(this._requestId);
            };
        }
        private function onDecline(_arg_1:WindowMouseEvent):void
        {
            if (this._widget != null){
                this._widget.declineRequest(this._requestId);
            };
        }

    }
}//package com.sulake.habbo.ui.widget.friendrequest

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// HabboWindowParam = "_-29D" (String#6233, DoABC#2)
// FriendRequestWidget = "_-1-w" (String#4866, DoABC#2)
// FriendRequestDialog = "_-2g7" (String#6869, DoABC#2)
// _requestId = "_-1GH" (String#301, DoABC#2)
// _SafeStr_3731 = "_-B" (String#22654, DoABC#2)
// WME_OUT = "_-0h2" (String#15712, DoABC#2)
// WME_DOWN = "_-hL" (String#23944, DoABC#2)
// WME_UP_OUTSIDE = "_-2qi" (String#21110, DoABC#2)
// WME_UP = "_-0Cs" (String#14566, DoABC#2)
// onClose = "_-2Ts" (String#54, DoABC#2)
// windowEventHandler = "_-36j" (String#371, DoABC#2)
// targetRect = "_-2aZ" (String#20467, DoABC#2)
// acceptRequest = "_-3CU" (String#7565, DoABC#2)
// declineRequest = "_-1A2" (String#5078, DoABC#2)
// ignoreRequest = "_-30P" (String#21518, DoABC#2)
// _SafeStr_5951 = "_-1Ge" (String#5180, DoABC#2)
// _SafeStr_5952 = "_-8M" (String#22557, DoABC#2)
// _SafeStr_5953 = "_-1e3" (String#18060, DoABC#2)
// addMouseClickListener = "_-10B" (String#595, DoABC#2)
// WE_DEACTIVATED = "_-1oi" (String#18485, DoABC#2)
// onDeactivated = "_-0p6" (String#16020, DoABC#2)
// onAccept = "_-0Mj" (String#14941, DoABC#2)
// onDecline = "_-10S" (String#16481, DoABC#2)
// setImageAsset = "_-3-s" (String#21496, DoABC#2)


