
package com.sulake.habbo.ui.widget.furniture.stickie
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.ui.widget.events.RoomWidgetStickieDataUpdateEvent;
    import flash.events.IEventDispatcher;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.display.BitmapData;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.habbo.window.enum.HabboWindowType;
    import com.sulake.habbo.window.enum.HabboWindowStyle;
    import com.sulake.habbo.window.enum.HabboWindowParam;
    import flash.geom.Rectangle;
    import com.sulake.core.window.events.WindowEvent;
    import flash.geom.Point;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetStickieSendUpdateMessage;

    public class StickieFurniWidget extends RoomWidgetBase 
    {

        private static const _SafeStr_5167:int = 14;
        private static const _SafeStr_5168:int = 500;
        private static const _SafeStr_3710:Number = 100;
        private static const _selectedBrightness:Number = 100;

        private var _window:IWindowContainer;
        protected var _objectId:int = -1;
        protected var _objectType:String;
        protected var _text:String;
        protected var _colorHex:String;
        protected var _controller:Boolean;
        protected var _SafeStr_5170:String = "stickieui_container";

        public function StickieFurniWidget(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary=null)
        {
            super(_arg_1, _arg_2, _arg_3);
        }
        protected function get window():IWindowContainer
        {
            return (this._window);
        }
        override public function dispose():void
        {
            if (disposed){
                return;
            };
            this.hideInterface();
            super.dispose();
        }
        override public function registerUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null){
                return;
            };
            _arg_1.addEventListener(RoomWidgetStickieDataUpdateEvent.RWSDUE_STICKIE_DATA, this.onObjectUpdate);
            super.registerUpdateEvents(_arg_1);
        }
        override public function unregisterUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null){
                return;
            };
            _arg_1.removeEventListener(RoomWidgetStickieDataUpdateEvent.RWSDUE_STICKIE_DATA, this.onObjectUpdate);
        }
        protected function onObjectUpdate(_arg_1:RoomWidgetStickieDataUpdateEvent):void
        {
            this.hideInterface(false);
            this._objectId = _arg_1.objectId;
            this._objectType = _arg_1.objectType;
            this._text = _arg_1.text;
            this._colorHex = _arg_1.colorHex;
            this._controller = _arg_1.controller;
            this.showInterface();
        }
        protected function showInterface():void
        {
            var _local_3:ITextFieldWindow;
            var _local_4:BitmapDataAsset;
            var _local_5:BitmapData;
            var _local_6:IBitmapWrapperWindow;
            if (this._objectId == -1){
                return;
            };
            var _local_1:IAsset = assets.getAssetByName("stickie");
            if (_local_1 == null){
                return;
            };
            var _local_2:XmlAsset = XmlAsset(_local_1);
            if (_local_2 == null){
                return;
            };
            if (this._window == null){
                this._window = (windowManager.createWindow(this._SafeStr_5170, "", HabboWindowType._SafeStr_3728, HabboWindowStyle._SafeStr_3729, (HabboWindowParam._SafeStr_3730 | HabboWindowParam._SafeStr_3731), new Rectangle(_SafeStr_3710, _selectedBrightness, 2, 2), null, 0) as IWindowContainer);
                this._window.buildFromXML(XML(_local_2.content));
            };
            _local_3 = (this._window.findChildByName("text") as ITextFieldWindow);
            if (_local_3 != null){
                _local_3.text = this._text;
                _local_3.addEventListener(WindowEvent.WE_CHANGE, this.onTextWindowEvent);
            };
            _local_6 = (this._window.findChildByTag("bg") as IBitmapWrapperWindow);
            if (_local_6 != null){
                if (this._objectType == "post_it_vd"){
                    _local_4 = (assets.getAssetByName("stickie_vd") as BitmapDataAsset);
                }
                else {
                    _local_4 = (assets.getAssetByName("stickie_blanco") as BitmapDataAsset);
                    _local_6.color = uint(("0xFF" + this._colorHex));
                };
                _local_5 = (_local_4.content as BitmapData);
                _local_6.bitmap = new BitmapData(_local_6.width, _local_6.height, true, 0);
                _local_6.bitmap.copyPixels(_local_5, _local_5.rect, new Point(0, 0));
            };
            _local_6 = (this._window.findChildByTag("close_button") as IBitmapWrapperWindow);
            if (_local_6 != null){
                _local_4 = (assets.getAssetByName("stickie_close") as BitmapDataAsset);
                _local_5 = (_local_4.content as BitmapData);
                _local_6.bitmap = new BitmapData(_local_6.width, _local_6.height, true, 0);
                _local_6.bitmap.copyPixels(_local_5, _local_5.rect, new Point(0, 0));
                _local_6.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onMouseEvent);
            };
            _local_6 = (this._window.findChildByTag("delete_button") as IBitmapWrapperWindow);
            if (((!((_local_6 == null))) && (this._controller))){
                _local_4 = (assets.getAssetByName("stickie_remove") as BitmapDataAsset);
                _local_5 = (_local_4.content as BitmapData);
                _local_6.bitmap = new BitmapData(_local_6.width, _local_6.height, true, 0);
                _local_6.bitmap.copyPixels(_local_5, _local_5.rect, new Point(0, 0));
                _local_6.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onMouseEvent);
            };
            this.setColorButtons(((this._controller) && ((this._objectType == "post_it"))));
        }
        protected function hideInterface(_arg_1:Boolean=true):void
        {
            if (_arg_1){
                this.sendUpdate();
            };
            if (this._window != null){
                this._window.dispose();
                this._window = null;
            };
            this._objectId = -1;
            this._text = null;
            this._controller = false;
        }
        private function setColorButtons(_arg_1:Boolean):void
        {
            var _local_2:IWindow;
            var _local_3:Array = new Array("blue", "purple", "green", "yellow");
            var _local_4:int;
            while (_local_4 <= _local_3.length) {
                _local_2 = this._window.findChildByName(_local_3[_local_4]);
                if (_local_2 != null){
                    if (_arg_1){
                        _local_2.visible = true;
                        _local_2.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onMouseEvent);
                    }
                    else {
                        _local_2.visible = false;
                    };
                };
                _local_4++;
            };
        }
        protected function storeTextFromField():Boolean
        {
            var _local_1:ITextFieldWindow = (this._window.findChildByName("text") as ITextFieldWindow);
            if (_local_1 == null){
                return (false);
            };
            if (this._text == _local_1.text){
                return (false);
            };
            this._text = _local_1.text;
            return (true);
        }
        protected function sendUpdate():void
        {
            var _local_1:RoomWidgetStickieSendUpdateMessage;
            if (this._objectId == -1){
                return;
            };
            if (!this.storeTextFromField()){
                return;
            };
            if (messageListener != null){
                _local_1 = new RoomWidgetStickieSendUpdateMessage(RoomWidgetStickieSendUpdateMessage.RWSUM_STICKIE_SEND_UPDATE, this._objectId, this._text, this._colorHex);
                messageListener.processWidgetMessage(_local_1);
            };
        }
        protected function sendSetColor(_arg_1:uint):void
        {
            var _local_3:RoomWidgetStickieSendUpdateMessage;
            if (this._objectId == -1){
                return;
            };
            this.storeTextFromField();
            var _local_2:String = _arg_1.toString(16).toUpperCase();
            if (_local_2.length > 6){
                _local_2 = _local_2.slice((_local_2.length - 6), _local_2.length);
            };
            if (_local_2 == this._colorHex){
                return;
            };
            this._colorHex = _local_2;
            if (messageListener != null){
                _local_3 = new RoomWidgetStickieSendUpdateMessage(RoomWidgetStickieSendUpdateMessage.RWSUM_STICKIE_SEND_UPDATE, this._objectId, this._text, this._colorHex);
                messageListener.processWidgetMessage(_local_3);
            };
            this.showInterface();
        }
        protected function sendDelete():void
        {
            var _local_1:RoomWidgetStickieSendUpdateMessage;
            if (this._objectId == -1){
                return;
            };
            if (((!((messageListener == null))) && (this._controller))){
                _local_1 = new RoomWidgetStickieSendUpdateMessage(RoomWidgetStickieSendUpdateMessage.RWSUM_STICKIE_SEND_DELETE, this._objectId);
                messageListener.processWidgetMessage(_local_1);
            };
        }
        private function onTextWindowEvent(_arg_1:WindowEvent):void
        {
            var _local_2:ITextFieldWindow;
            _local_2 = (this._window.findChildByName("text") as ITextFieldWindow);
            if (_local_2 == null){
                return;
            };
            _local_2.maxChars = _SafeStr_5168;
            if (_local_2.numLines < _SafeStr_5167){
                return;
            };
            _local_2.text = _local_2.text.slice(0, (_local_2.text.length - 1));
            _local_2.maxChars = _local_2.length;
        }
        protected function onMouseEvent(_arg_1:WindowMouseEvent):void
        {
            var _local_2:IWindow = (_arg_1.target as IWindow);
            var _local_3:String = _local_2.name;
            switch (_local_3){
                case "blue":
                case "purple":
                case "green":
                case "yellow":
                    this.sendSetColor(_local_2.color);
                    return;
                case "close":
                    this.hideInterface();
                    return;
                case "delete":
                    this.sendDelete();
                    this.hideInterface(false);
                    return;
            };
        }

    }
}//package com.sulake.habbo.ui.widget.furniture.stickie

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// HabboWindowParam = "_-29D" (String#6233, DoABC#2)
// HabboWindowStyle = "_-0E1" (String#14608, DoABC#2)
// HabboWindowType = "_-29U" (String#19384, DoABC#2)
// ITextFieldWindow = "_-3EL" (String#2027, DoABC#2)
// RoomWidgetBase = "_-0eQ" (String#4398, DoABC#2)
// StickieFurniWidget = "_-2ud" (String#7171, DoABC#2)
// RoomWidgetStickieDataUpdateEvent = "_-1X9" (String#5500, DoABC#2)
// RoomWidgetStickieSendUpdateMessage = "_-1vS" (String#5950, DoABC#2)
// _objectId = "_-1YP" (String#18, DoABC#2)
// RWSUM_STICKIE_SEND_UPDATE = "_-0Zu" (String#15438, DoABC#2)
// RWSUM_STICKIE_SEND_DELETE = "_-v1" (String#24492, DoABC#2)
// _colorHex = "_-0io" (String#821, DoABC#2)
// colorHex = "_-3I3" (String#22203, DoABC#2)
// _SafeStr_3710 = "_-3-S" (String#908, DoABC#2)
// _selectedBrightness = "_-2M9" (String#885, DoABC#2)
// _controller = "_-18D" (String#59, DoABC#2)
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
// _SafeStr_5167 = "_-ev" (String#8496, DoABC#2)
// _SafeStr_5168 = "_-2sM" (String#7127, DoABC#2)
// _objectType = "_-eP" (String#939, DoABC#2)
// _SafeStr_5170 = "_-6r" (String#22493, DoABC#2)
// RWSDUE_STICKIE_DATA = "_-0tT" (String#16178, DoABC#2)
// objectType = "_-23O" (String#19148, DoABC#2)
// WE_CHANGE = "_-1sp" (String#18670, DoABC#2)
// onTextWindowEvent = "_-0hH" (String#820, DoABC#2)
// setColorButtons = "_-1tQ" (String#18694, DoABC#2)
// sendUpdate = "_-iA" (String#8556, DoABC#2)
// storeTextFromField = "_-24P" (String#19195, DoABC#2)
// sendSetColor = "_-0lK" (String#4530, DoABC#2)
// sendDelete = "_-13W" (String#4943, DoABC#2)


