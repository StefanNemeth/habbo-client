
package com.sulake.habbo.ui.widget.furniture.ecotronbox
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.ui.widget.events.RoomWidgetEcotronBoxDataUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetRoomObjectUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetPresentDataUpdateEvent;
    import flash.events.IEventDispatcher;
    import flash.display.BitmapData;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.geom.Point;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.habbo.window.enum.HabboWindowType;
    import com.sulake.habbo.window.enum.HabboWindowStyle;
    import com.sulake.habbo.window.enum.HabboWindowParam;
    import flash.geom.Rectangle;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetEcotronBoxOpenMessage;

    public class EcotronBoxFurniWidget extends RoomWidgetBase 
    {

        private static const _SafeStr_3710:Number = 100;
        private static const _selectedBrightness:Number = 100;

        private var _window:IWindowContainer;
        private var _objectId:int = -1;
        private var _text:String;
        private var _controller:Boolean;
        private var _SafeStr_3713:Boolean = false;

        public function EcotronBoxFurniWidget(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary=null)
        {
            super(_arg_1, _arg_2, _arg_3);
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
            _arg_1.addEventListener(RoomWidgetEcotronBoxDataUpdateEvent.RWEBDUE_PACKAGEINFO, this.onObjectUpdate);
            _arg_1.addEventListener(RoomWidgetEcotronBoxDataUpdateEvent.RWEBDUE_CONTENTS, this.onObjectUpdate);
            _arg_1.addEventListener(RoomWidgetRoomObjectUpdateEvent.RWROUE_FURNI_REMOVED, this.onRoomObjectRemoved);
            _arg_1.addEventListener(RoomWidgetPresentDataUpdateEvent.RWEBDUE_PACKAGEINFO, this.onPresentUpdate);
            super.registerUpdateEvents(_arg_1);
        }
        override public function unregisterUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null){
                return;
            };
            _arg_1.removeEventListener(RoomWidgetEcotronBoxDataUpdateEvent.RWEBDUE_PACKAGEINFO, this.onObjectUpdate);
            _arg_1.removeEventListener(RoomWidgetEcotronBoxDataUpdateEvent.RWEBDUE_CONTENTS, this.onObjectUpdate);
            _arg_1.removeEventListener(RoomWidgetPresentDataUpdateEvent.RWEBDUE_PACKAGEINFO, this.onPresentUpdate);
            _arg_1.removeEventListener(RoomWidgetRoomObjectUpdateEvent.RWROUE_FURNI_REMOVED, this.onRoomObjectRemoved);
        }
        private function onObjectUpdate(_arg_1:RoomWidgetEcotronBoxDataUpdateEvent):void
        {
            this.hideInterface();
            switch (_arg_1.type){
                case RoomWidgetEcotronBoxDataUpdateEvent.RWEBDUE_PACKAGEINFO:
                    this._SafeStr_3713 = false;
                    this._objectId = _arg_1.objectId;
                    this._text = _arg_1.text;
                    this._controller = _arg_1.controller;
                    this.showInterface();
                    return;
                case RoomWidgetEcotronBoxDataUpdateEvent.RWEBDUE_CONTENTS:
                    if (!this._SafeStr_3713){
                        return;
                    };
                    this._objectId = _arg_1.objectId;
                    this.showInterface();
                    this.showIcon(_arg_1.iconBitmapData);
                    this.showDescription(_arg_1.text);
                    this.setOpenButton(false);
                    return;
            };
        }
        private function onRoomObjectRemoved(_arg_1:RoomWidgetRoomObjectUpdateEvent):void
        {
            if (_arg_1.id == this._objectId){
                this.hideInterface();
            };
        }
        private function onPresentUpdate(_arg_1:RoomWidgetPresentDataUpdateEvent):void
        {
            switch (_arg_1.type){
                case RoomWidgetPresentDataUpdateEvent.RWEBDUE_PACKAGEINFO:
                    this.hideInterface();
                    return;
            };
        }
        private function showIcon(_arg_1:BitmapData):void
        {
            if (_arg_1 == null){
                _arg_1 = new BitmapData(1, 1);
            };
            if (this._window == null){
                return;
            };
            var _local_2:IBitmapWrapperWindow = (this._window.findChildByName("ecotronbox_card_preview") as IBitmapWrapperWindow);
            if (_local_2 == null){
                return;
            };
            var _local_3:int = ((_local_2.width - _arg_1.width) / 2);
            var _local_4:int = ((_local_2.height - _arg_1.height) / 2);
            if (_local_2.bitmap == null){
                _local_2.bitmap = new BitmapData(_local_2.width, _local_2.height, true, 0xFFFFFF);
            };
            _local_2.bitmap.fillRect(_local_2.bitmap.rect, 0xFFFFFF);
            _local_2.bitmap.copyPixels(_arg_1, _arg_1.rect, new Point(_local_3, _local_4), null, null, false);
        }
        private function showDescription(_arg_1:String):void
        {
            var _local_2:ITextWindow;
            _local_2 = (this._window.findChildByName("ecotronbox_card_msg") as ITextWindow);
            if (((!((_local_2 == null))) && (!((_arg_1 == null))))){
                _local_2.caption = _arg_1;
            };
        }
        private function showInterface():void
        {
            var _local_3:BitmapDataAsset;
            var _local_4:BitmapData;
            var _local_5:IBitmapWrapperWindow;
            var _local_6:ITextWindow;
            var _local_7:IWindow;
            if (this._objectId < 0){
                return;
            };
            var _local_1:IAsset = assets.getAssetByName("ecotronbox_card");
            var _local_2:XmlAsset = XmlAsset(_local_1);
            if (_local_2 == null){
                return;
            };
            if (this._window != null){
                this._window.dispose();
                this._window = null;
            };
            this._window = (windowManager.createWindow("ecotronboxcardui_container", "", HabboWindowType._SafeStr_3728, HabboWindowStyle._SafeStr_3729, (HabboWindowParam._SafeStr_3730 | HabboWindowParam._SafeStr_3731), new Rectangle(_SafeStr_3710, _selectedBrightness, 2, 2), null, 0) as IWindowContainer);
            this._window.buildFromXML(XML(_local_2.content));
            _local_3 = (assets.getAssetByName("ecotronbox_card_bg") as BitmapDataAsset);
            _local_5 = (this._window.findChildByName("ecotronbox_card_bg") as IBitmapWrapperWindow);
            if (_local_3 != null){
                _local_4 = (_local_3.content as BitmapData);
                _local_5.bitmap = _local_4.clone();
            };
            _local_6 = (this._window.findChildByName("ecotronbox_card_date") as ITextWindow);
            if (((!((_local_6 == null))) && (!((this._text == null))))){
                _local_6.caption = this._text;
            };
            _local_7 = this._window.findChildByName("ecotronbox_card_btn_close");
            if (_local_7 != null){
                _local_7.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onMouseEvent);
            };
            this.setOpenButton(true);
        }
        private function setOpenButton(_arg_1:Boolean):void
        {
            var _local_2:IWindow;
            if (this._window == null){
                return;
            };
            _local_2 = this._window.findChildByName("ecotronbox_card_btn_open");
            if (_local_2 != null){
                if (((this._controller) && (_arg_1))){
                    _local_2.visible = true;
                    _local_2.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onMouseEvent);
                }
                else {
                    _local_2.visible = false;
                };
            };
        }
        private function hideInterface():void
        {
            if (this._window != null){
                this._window.dispose();
                this._window = null;
            };
            if (!this._SafeStr_3713){
                this._objectId = -1;
            };
            this._text = "";
            this._controller = false;
        }
        private function sendOpen():void
        {
            var _local_1:RoomWidgetEcotronBoxOpenMessage;
            if (((((this._SafeStr_3713) || ((this._objectId == -1)))) || (!(this._controller)))){
                return;
            };
            this._SafeStr_3713 = true;
            if (messageListener != null){
                _local_1 = new RoomWidgetEcotronBoxOpenMessage(RoomWidgetEcotronBoxOpenMessage.RWEBOM_OPEN_ECOTRONBOX, this._objectId);
                messageListener.processWidgetMessage(_local_1);
            };
        }
        private function onMouseEvent(_arg_1:WindowMouseEvent):void
        {
            var _local_2:IWindow = (_arg_1.target as IWindow);
            var _local_3:String = _local_2.name;
            switch (_local_3){
                case "ecotronbox_card_btn_open":
                    this.sendOpen();
                    return;
                case "ecotronbox_card_btn_close":
                default:
                    this._SafeStr_3713 = false;
                    this.hideInterface();
            };
        }

    }
}//package com.sulake.habbo.ui.widget.furniture.ecotronbox

// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// HabboWindowParam = "_-29D" (String#6233, DoABC#2)
// HabboWindowStyle = "_-0E1" (String#14608, DoABC#2)
// HabboWindowType = "_-29U" (String#19384, DoABC#2)
// RoomWidgetBase = "_-0eQ" (String#4398, DoABC#2)
// EcotronBoxFurniWidget = "_-2cg" (String#6805, DoABC#2)
// RoomWidgetRoomObjectUpdateEvent = "_-37T" (String#7457, DoABC#2)
// RoomWidgetPresentDataUpdateEvent = "_-03a" (String#14185, DoABC#2)
// RoomWidgetEcotronBoxDataUpdateEvent = "_-18a" (String#16797, DoABC#2)
// RoomWidgetEcotronBoxOpenMessage = "_-1bG" (String#17946, DoABC#2)
// _objectId = "_-1YP" (String#18, DoABC#2)
// RWEBOM_OPEN_ECOTRONBOX = "_-0Mx" (String#14952, DoABC#2)
// _SafeStr_3710 = "_-3-S" (String#908, DoABC#2)
// _selectedBrightness = "_-2M9" (String#885, DoABC#2)
// _controller = "_-18D" (String#59, DoABC#2)
// _SafeStr_3713 = "_-0ty" (String#4724, DoABC#2)
// hideInterface = "_-29" (String#304, DoABC#2)
// registerUpdateEvents = "_-1yD" (String#1787, DoABC#2)
// RWEBDUE_PACKAGEINFO = "_-1FM" (String#17088, DoABC#2)
// onObjectUpdate = "_-2l-" (String#248, DoABC#2)
// RWEBDUE_CONTENTS = "_-k8" (String#24041, DoABC#2)
// RWROUE_FURNI_REMOVED = "_-2L6" (String#19851, DoABC#2)
// onRoomObjectRemoved = "_-1GC" (String#842, DoABC#2)
// onPresentUpdate = "_-1su" (String#18673, DoABC#2)
// unregisterUpdateEvents = "_-0-c" (String#3556, DoABC#2)
// showInterface = "_-121" (String#162, DoABC#2)
// showIcon = "_-0R" (String#4111, DoABC#2)
// iconBitmapData = "_-1Ok" (String#17458, DoABC#2)
// showDescription = "_-2Y-" (String#20356, DoABC#2)
// setOpenButton = "_-9R" (String#22597, DoABC#2)
// _SafeStr_3728 = "_-1IW" (String#5215, DoABC#2)
// _SafeStr_3729 = "_-06z" (String#14322, DoABC#2)
// _SafeStr_3730 = "_-1rZ" (String#18611, DoABC#2)
// _SafeStr_3731 = "_-B" (String#22654, DoABC#2)
// onMouseEvent = "_-0ZW" (String#357, DoABC#2)
// sendOpen = "_-2L0" (String#6462, DoABC#2)


