
package com.sulake.habbo.ui.widget.furniture.present
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.ui.widget.events.RoomWidgetPresentDataUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetRoomObjectUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetEcotronBoxDataUpdateEvent;
    import flash.events.IEventDispatcher;
    import flash.display.BitmapData;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.geom.Point;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetPresentOpenMessage;

    public class PresentFurniWidget extends RoomWidgetBase 
    {

        private var _window:IWindowContainer;
        private var _objectId:int = -1;
        private var _text:String;
        private var _controller:Boolean;
        private var _SafeStr_3713:Boolean = false;

        public function PresentFurniWidget(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary=null)
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
            _arg_1.addEventListener(RoomWidgetPresentDataUpdateEvent.RWEBDUE_PACKAGEINFO, this.onObjectUpdate);
            _arg_1.addEventListener(RoomWidgetPresentDataUpdateEvent.RWEBDUE_CONTENTS, this.onObjectUpdate);
            _arg_1.addEventListener(RoomWidgetPresentDataUpdateEvent.RWPDUE_CONTENTS_CLUB, this.onObjectUpdate);
            _arg_1.addEventListener(RoomWidgetPresentDataUpdateEvent.RWPDUE_CONTENTS_FLOOR, this.onObjectUpdate);
            _arg_1.addEventListener(RoomWidgetPresentDataUpdateEvent.RWPDUE_CONTENTS_LANDSCAPE, this.onObjectUpdate);
            _arg_1.addEventListener(RoomWidgetPresentDataUpdateEvent.RWPDUE_CONTENTS_WALLPAPER, this.onObjectUpdate);
            _arg_1.addEventListener(RoomWidgetRoomObjectUpdateEvent.RWROUE_FURNI_REMOVED, this.onRoomObjectRemoved);
            _arg_1.addEventListener(RoomWidgetEcotronBoxDataUpdateEvent.RWEBDUE_PACKAGEINFO, this.onEcotronUpdate);
            super.registerUpdateEvents(_arg_1);
        }
        override public function unregisterUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null){
                return;
            };
            _arg_1.removeEventListener(RoomWidgetPresentDataUpdateEvent.RWEBDUE_PACKAGEINFO, this.onObjectUpdate);
            _arg_1.removeEventListener(RoomWidgetPresentDataUpdateEvent.RWEBDUE_CONTENTS, this.onObjectUpdate);
            _arg_1.removeEventListener(RoomWidgetPresentDataUpdateEvent.RWPDUE_CONTENTS_CLUB, this.onObjectUpdate);
            _arg_1.removeEventListener(RoomWidgetPresentDataUpdateEvent.RWPDUE_CONTENTS_FLOOR, this.onObjectUpdate);
            _arg_1.removeEventListener(RoomWidgetPresentDataUpdateEvent.RWPDUE_CONTENTS_LANDSCAPE, this.onObjectUpdate);
            _arg_1.removeEventListener(RoomWidgetPresentDataUpdateEvent.RWPDUE_CONTENTS_WALLPAPER, this.onObjectUpdate);
            _arg_1.removeEventListener(RoomWidgetEcotronBoxDataUpdateEvent.RWEBDUE_PACKAGEINFO, this.onEcotronUpdate);
            _arg_1.removeEventListener(RoomWidgetRoomObjectUpdateEvent.RWROUE_FURNI_REMOVED, this.onRoomObjectRemoved);
        }
        private function onObjectUpdate(_arg_1:RoomWidgetPresentDataUpdateEvent):void
        {
            switch (_arg_1.type){
                case RoomWidgetPresentDataUpdateEvent.RWEBDUE_PACKAGEINFO:
                    this.hideInterface();
                    this._SafeStr_3713 = false;
                    this._objectId = _arg_1.objectId;
                    this._text = _arg_1.text;
                    this._controller = _arg_1.controller;
                    this.showInterface();
                    this.showIcon(_arg_1.iconBitmapData);
                    return;
                case RoomWidgetPresentDataUpdateEvent.RWPDUE_CONTENTS_FLOOR:
                    if (!this._SafeStr_3713){
                        return;
                    };
                    this._objectId = _arg_1.objectId;
                    this._text = _arg_1.text;
                    this.showInterface();
                    this.showCustomIcon("packagecard_icon_floor");
                    return;
                case RoomWidgetPresentDataUpdateEvent.RWPDUE_CONTENTS_LANDSCAPE:
                    if (!this._SafeStr_3713){
                        return;
                    };
                    this._objectId = _arg_1.objectId;
                    this._text = _arg_1.text;
                    this.showInterface();
                    this.showCustomIcon("packagecard_icon_landscape");
                    return;
                case RoomWidgetPresentDataUpdateEvent.RWPDUE_CONTENTS_WALLPAPER:
                    if (!this._SafeStr_3713){
                        return;
                    };
                    this._objectId = _arg_1.objectId;
                    this._text = _arg_1.text;
                    this.showInterface();
                    this.showCustomIcon("packagecard_icon_wallpaper");
                    return;
                case RoomWidgetPresentDataUpdateEvent.RWPDUE_CONTENTS_CLUB:
                    if (!this._SafeStr_3713){
                        return;
                    };
                    this._objectId = _arg_1.objectId;
                    this._text = _arg_1.text;
                    this.showInterface();
                    this.showCustomIcon("packagecard_icon_hc");
                    return;
                case RoomWidgetPresentDataUpdateEvent.RWEBDUE_CONTENTS:
                    if (!this._SafeStr_3713){
                        return;
                    };
                    this._objectId = _arg_1.objectId;
                    this._text = _arg_1.text;
                    this.showGiftOpenedInterface();
                    this.showIcon(_arg_1.iconBitmapData);
                    return;
            };
        }
        private function showGiftOpenedInterface():void
        {
            this.showInterface();
            if (this._window){
                this._window.findChildByName("title").caption = this._text;
                this._window.findChildByName("text").caption = "${widget.furni.present.instructions}";
            };
        }
        private function onRoomObjectRemoved(_arg_1:RoomWidgetRoomObjectUpdateEvent):void
        {
            if (_arg_1.id == this._objectId){
                this.hideInterface();
            };
        }
        private function onEcotronUpdate(_arg_1:RoomWidgetEcotronBoxDataUpdateEvent):void
        {
            switch (_arg_1.type){
                case RoomWidgetEcotronBoxDataUpdateEvent.RWEBDUE_PACKAGEINFO:
                    this.hideInterface();
                    return;
            };
        }
        private function showCustomIcon(_arg_1:String):void
        {
            var _local_3:BitmapData;
            var _local_2:BitmapDataAsset = (assets.getAssetByName(_arg_1) as BitmapDataAsset);
            if (_local_2 != null){
                _local_3 = (_local_2.content as BitmapData);
            };
            this.showIcon(_local_3);
        }
        private function showIcon(_arg_1:BitmapData):void
        {
            if (_arg_1 == null){
                _arg_1 = new BitmapData(1, 1);
            };
            if (this._window == null){
                return;
            };
            var _local_2:IBitmapWrapperWindow = (this._window.findChildByName("gift_image") as IBitmapWrapperWindow);
            if (_local_2.bitmap != null){
                _local_2.bitmap.dispose();
            };
            _local_2.bitmap = new BitmapData(_local_2.width, _local_2.height, true, 0);
            var _local_3:Point = new Point(((_local_2.width - _arg_1.width) / 2), ((_local_2.height - _arg_1.height) / 2));
            _local_2.bitmap.copyPixels(_arg_1, _arg_1.rect, _local_3);
        }
        private function showInterface():void
        {
            var _local_4:ITextWindow;
            var _local_5:BitmapData;
            if (this._objectId < 0){
                return;
            };
            if (this._window != null){
                this._window.dispose();
            };
            var _local_1:XmlAsset = (assets.getAssetByName("packagecard") as XmlAsset);
            this._window = (windowManager.buildFromXML((_local_1.content as XML)) as IWindowContainer);
            this._window.center();
            var _local_2:IBitmapWrapperWindow = (this._window.findChildByName("image_bg") as IBitmapWrapperWindow);
            var _local_3:BitmapDataAsset = (assets.getAssetByName("yellow_highlight") as BitmapDataAsset);
            if (((_local_2) && (_local_3))){
                _local_5 = (_local_3.content as BitmapData);
                if (_local_2.bitmap){
                    _local_2.bitmap.dispose();
                };
                _local_2.bitmap = _local_5.clone();
            };
            _local_4 = (this._window.findChildByName("text") as ITextWindow);
            if (((!((_local_4 == null))) && (!((this._text == null))))){
                _local_4.caption = this._text;
            };
            if (!this._controller){
                this.hideOpenButton();
            };
            this._window.procedure = this.handleWindowEvent;
        }
        private function onWindowClose(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            this._SafeStr_3713 = false;
            this.hideInterface();
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
            var _local_1:RoomWidgetPresentOpenMessage;
            if (((((this._SafeStr_3713) || ((this._objectId == -1)))) || (!(this._controller)))){
                return;
            };
            this._SafeStr_3713 = true;
            if (messageListener != null){
                _local_1 = new RoomWidgetPresentOpenMessage(RoomWidgetPresentOpenMessage.RWVFM_OPEN_PRESENT, this._objectId);
                messageListener.processWidgetMessage(_local_1);
            };
        }
        private function hideOpenButton():void
        {
            if (this._window == null){
                return;
            };
            var _local_1:IWindow = this._window.findChildByName("open");
            if (_local_1 != null){
                _local_1.visible = false;
            };
        }
        private function handleWindowEvent(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            switch (_arg_2.name){
                case "open":
                    this.sendOpen();
                    return;
                case "close":
                    this._SafeStr_3713 = false;
                    this.hideInterface();
                    return;
                default:
                    if (_arg_2.tags.indexOf("close") != -1){
                        this.hideInterface();
                    };
            };
        }

    }
}//package com.sulake.habbo.ui.widget.furniture.present

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// RoomWidgetBase = "_-0eQ" (String#4398, DoABC#2)
// PresentFurniWidget = "_-0WM" (String#4234, DoABC#2)
// RoomWidgetRoomObjectUpdateEvent = "_-37T" (String#7457, DoABC#2)
// RoomWidgetPresentOpenMessage = "_-1ti" (String#18706, DoABC#2)
// RoomWidgetPresentDataUpdateEvent = "_-03a" (String#14185, DoABC#2)
// RoomWidgetEcotronBoxDataUpdateEvent = "_-18a" (String#16797, DoABC#2)
// RWVFM_OPEN_PRESENT = "_-Bb" (String#22674, DoABC#2)
// _objectId = "_-1YP" (String#18, DoABC#2)
// _controller = "_-18D" (String#59, DoABC#2)
// _SafeStr_3713 = "_-0ty" (String#4724, DoABC#2)
// hideInterface = "_-29" (String#304, DoABC#2)
// registerUpdateEvents = "_-1yD" (String#1787, DoABC#2)
// RWEBDUE_PACKAGEINFO = "_-1FM" (String#17088, DoABC#2)
// onObjectUpdate = "_-2l-" (String#248, DoABC#2)
// RWEBDUE_CONTENTS = "_-k8" (String#24041, DoABC#2)
// RWROUE_FURNI_REMOVED = "_-2L6" (String#19851, DoABC#2)
// onRoomObjectRemoved = "_-1GC" (String#842, DoABC#2)
// unregisterUpdateEvents = "_-0-c" (String#3556, DoABC#2)
// showInterface = "_-121" (String#162, DoABC#2)
// showIcon = "_-0R" (String#4111, DoABC#2)
// iconBitmapData = "_-1Ok" (String#17458, DoABC#2)
// sendOpen = "_-2L0" (String#6462, DoABC#2)
// onWindowClose = "_-2tr" (String#136, DoABC#2)
// RWPDUE_CONTENTS_CLUB = "_-06W" (String#14307, DoABC#2)
// RWPDUE_CONTENTS_FLOOR = "_-OX" (String#23188, DoABC#2)
// RWPDUE_CONTENTS_LANDSCAPE = "_-1cD" (String#17979, DoABC#2)
// RWPDUE_CONTENTS_WALLPAPER = "_-o9" (String#24196, DoABC#2)
// onEcotronUpdate = "_-21K" (String#19066, DoABC#2)
// showCustomIcon = "_-3F3" (String#22079, DoABC#2)
// showGiftOpenedInterface = "_-1Xi" (String#17804, DoABC#2)
// hideOpenButton = "_-VL" (String#23463, DoABC#2)
// handleWindowEvent = "_-3C0" (String#21960, DoABC#2)


