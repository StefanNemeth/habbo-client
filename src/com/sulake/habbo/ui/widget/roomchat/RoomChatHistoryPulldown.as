
package com.sulake.habbo.ui.widget.roomchat
{
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.core.assets.IAssetLibrary;
    import flash.display.BitmapData;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.habbo.window.enum.HabboWindowType;
    import com.sulake.habbo.window.enum.HabboWindowStyle;
    import com.sulake.habbo.window.enum.HabboWindowParam;
    import flash.geom.Rectangle;
    import com.sulake.core.window.enum.WindowType;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.utils.profiler.tracking.TrackedBitmapData;
    import flash.geom.Point;

    public class RoomChatHistoryPulldown 
    {

        public static const _SafeStr_12102:int = 3;
        public static const _SafeStr_12100:int = 2;
        public static const _SafeStr_14239:int = 1;
        public static const _SafeStr_14238:int = 0;
        public static const _SafeStr_14178:int = 39;
        private static const _SafeStr_14245:int = 150;
        private static const _SafeStr_14246:int = 250;

        private var _widget:RoomChatWidget;
        private var _windowManager:IHabboWindowManager;
        private var _window:IWindowContainer;
        private var _SafeStr_14247:IBitmapWrapperWindow;
        private var _mainWindow:IWindowContainer;
        private var _region:IRegionWindow;
        private var _assetLibrary:IAssetLibrary;
        private var _SafeStr_14248:int = 0;
        private var _state:int = -1;
        private var _SafeStr_14249:BitmapData;
        private var _SafeStr_14250:BitmapData;
        private var _SafeStr_14251:BitmapData;
        private var _SafeStr_14252:BitmapData;
        private var _SafeStr_14253:BitmapData;
        private var _SafeStr_14254:BitmapData;
        private var _SafeStr_14255:BitmapData;
        private var _SafeStr_14256:int = 30;

        public function RoomChatHistoryPulldown(_arg_1:RoomChatWidget, _arg_2:IHabboWindowManager, _arg_3:IWindowContainer, _arg_4:IAssetLibrary)
        {
            this._widget = _arg_1;
            this._windowManager = _arg_2;
            this._assetLibrary = _arg_4;
            this._mainWindow = _arg_3;
            this._SafeStr_14249 = ((this._assetLibrary.getAssetByName("chat_grapbar_bg") as BitmapDataAsset).content as BitmapData);
            this._SafeStr_14250 = ((this._assetLibrary.getAssetByName("chat_grapbar_grip") as BitmapDataAsset).content as BitmapData);
            this._SafeStr_14251 = ((this._assetLibrary.getAssetByName("chat_grapbar_handle") as BitmapDataAsset).content as BitmapData);
            this._SafeStr_14252 = ((this._assetLibrary.getAssetByName("chat_grapbar_x") as BitmapDataAsset).content as BitmapData);
            this._SafeStr_14253 = ((this._assetLibrary.getAssetByName("chat_grapbar_x_hi") as BitmapDataAsset).content as BitmapData);
            this._SafeStr_14254 = ((this._assetLibrary.getAssetByName("chat_grapbar_x_pr") as BitmapDataAsset).content as BitmapData);
            this._SafeStr_14255 = ((this._assetLibrary.getAssetByName("chat_history_bg") as BitmapDataAsset).content as BitmapData);
            this._SafeStr_14247 = (this._windowManager.createWindow("chat_history_bg", "", HabboWindowType._SafeStr_6022, HabboWindowStyle._SafeStr_3729, HabboWindowParam._SafeStr_6023, new Rectangle(0, 0, _arg_3.width, (_arg_3.height - _SafeStr_14178)), null, 0, 0) as IBitmapWrapperWindow);
            this._mainWindow.addChild(this._SafeStr_14247);
            this._window = (this._windowManager.createWindow("chat_pulldown", "", HabboWindowType._SafeStr_3728, HabboWindowStyle._SafeStr_3729, (HabboWindowParam._SafeStr_3731 | HabboWindowParam._SafeStr_6023), new Rectangle(0, (this._mainWindow.height - _SafeStr_14178), _arg_3.width, _SafeStr_14178), null, 0) as IWindowContainer);
            this._mainWindow.addChild(this._window);
            this._region = (this._windowManager.createWindow("REGIONchat_pulldown", "", WindowType._SafeStr_6090, HabboWindowStyle._SafeStr_4662, (((HabboWindowParam._SafeStr_3731 | HabboWindowParam._SafeStr_6023) | HabboWindowParam._SafeStr_7446) | HabboWindowParam._SafeStr_7455), new Rectangle(0, 0, _arg_3.width, (_arg_3.height - _SafeStr_14178)), null, 0) as IRegionWindow);
            if (this._region != null){
                this._region.background = true;
                this._region.mouseThreshold = 0;
                this._region.addEventListener(WindowMouseEvent.WME_DOWN, this.RoomChatWidget);
                this._mainWindow.addChild(this._region);
                this._region.toolTipCaption = "${chat.history.drag.tooltip}";
                this._region.toolTipDelay = 250;
            };
            var _local_5:XmlAsset = (_arg_4.getAssetByName("chat_history_pulldown") as XmlAsset);
            this._window.buildFromXML((_local_5.content as XML));
            this._window.addEventListener(WindowMouseEvent.WME_DOWN, this.RoomChatWidget);
            var _local_6:IBitmapWrapperWindow = (this._window.findChildByName("GrapBarX") as IBitmapWrapperWindow);
            if (_local_6 != null){
                _local_6.mouseThreshold = 0;
                _local_6.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.RoomChatHistoryPulldown);
                _local_6.addEventListener(WindowMouseEvent.WME_UP, this.RoomChatHistoryPulldown);
                _local_6.addEventListener(WindowMouseEvent.WME_DOWN, this.RoomChatHistoryPulldown);
                _local_6.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.RoomChatHistoryPulldown);
                _local_6.addEventListener(WindowMouseEvent.WME_OUT, this.RoomChatHistoryPulldown);
            };
            this._window.background = true;
            this._window.color = 0;
            this._window.mouseThreshold = 0;
            this.state = _SafeStr_14238;
            this.RoomChatHistoryPulldown();
        }
        public function dispose():void
        {
            if (this._region != null){
                this._region.dispose();
                this._region = null;
            };
            if (this._window != null){
                this._window.dispose();
                this._window = null;
            };
            if (this._SafeStr_14247 != null){
                this._SafeStr_14247.dispose();
                this._SafeStr_14247 = null;
            };
        }
        public function update(_arg_1:uint):void
        {
            switch (this.state){
                case _SafeStr_12100:
                    this._SafeStr_14247.blend = (this._SafeStr_14247.blend + (_arg_1 / _SafeStr_14246));
                    this._window.blend = (this._window.blend + (_arg_1 / _SafeStr_14246));
                    if (this._window.blend >= 1){
                        this.state = _SafeStr_14239;
                    };
                    return;
                case _SafeStr_12102:
                    this._SafeStr_14247.blend = (this._SafeStr_14247.blend - (_arg_1 / _SafeStr_14245));
                    this._window.blend = (this._window.blend - (_arg_1 / _SafeStr_14245));
                    if (this._window.blend <= 0){
                        this.state = _SafeStr_14238;
                    };
                    return;
            };
        }
        public function set state(_arg_1:int):void
        {
            if (_arg_1 == this._state){
                return;
            };
            switch (_arg_1){
                case _SafeStr_14239:
                    if (this._state == _SafeStr_14238){
                        this.state = _SafeStr_12100;
                    }
                    else {
                        if ((((this._window == null)) || ((this._SafeStr_14247 == null)))){
                            return;
                        };
                        this._window.visible = true;
                        this._SafeStr_14247.visible = true;
                        this._region.visible = true;
                        this._state = _arg_1;
                    };
                    return;
                case _SafeStr_14238:
                    if ((((this._window == null)) || ((this._SafeStr_14247 == null)))){
                        return;
                    };
                    this._window.visible = false;
                    this._SafeStr_14247.visible = false;
                    this._region.visible = false;
                    this._state = _arg_1;
                    return;
                case _SafeStr_12100:
                    if ((((this._window == null)) || ((this._SafeStr_14247 == null)))){
                        return;
                    };
                    this._window.blend = 0;
                    this._SafeStr_14247.blend = 0;
                    this._window.visible = true;
                    this._SafeStr_14247.visible = true;
                    this._state = _arg_1;
                    return;
                case _SafeStr_12102:
                    if ((((this._window == null)) || ((this._SafeStr_14247 == null)))){
                        return;
                    };
                    this._window.blend = 1;
                    this._SafeStr_14247.blend = 1;
                    this._state = _arg_1;
                    return;
            };
        }
        public function get state():int
        {
            return (this._state);
        }
        public function RoomChatHistoryViewer(_arg_1:Rectangle):void
        {
            if (this._window != null){
                this._window.x = 0;
                this._window.y = (this._mainWindow.height - _SafeStr_14178);
                this._window.width = this._mainWindow.width;
            };
            if (this._region != null){
                this._region.x = 0;
                this._region.y = (this._mainWindow.height - _SafeStr_14178);
                this._region.width = (this._mainWindow.width - this._SafeStr_14256);
            };
            if (this._SafeStr_14247 != null){
                this._SafeStr_14247.rectangle = this._mainWindow.rectangle;
                this._SafeStr_14247.height = (this._SafeStr_14247.height - _SafeStr_14178);
            };
            this.RoomChatHistoryPulldown();
        }
        private function RoomChatHistoryPulldown():void
        {
            var width:int;
            var height:int;
            var state:int;
            var destBgBitmap:BitmapData;
            var destGripLBitmap:BitmapData;
            var destGripRBitmap:BitmapData;
            if (this._window == null){
                return;
            };
            if (this._SafeStr_14248 == this._window.width){
                return;
            };
            this._SafeStr_14248 = this._window.width;
            var barBg:IBitmapWrapperWindow = (this._window.findChildByName("grapBarBg") as IBitmapWrapperWindow);
            var barX:IBitmapWrapperWindow = (this._window.findChildByName("GrapBarX") as IBitmapWrapperWindow);
            var barGripL:IBitmapWrapperWindow = (this._window.findChildByName("grapBarGripL") as IBitmapWrapperWindow);
            var barGripR:IBitmapWrapperWindow = (this._window.findChildByName("grapBarGripR") as IBitmapWrapperWindow);
            var barHandle:IBitmapWrapperWindow = (this._window.findChildByName("grapBarHandle") as IBitmapWrapperWindow);
            var gripMargin:int = 5;
            if (((!((barX == null))) && (!((barHandle == null))))){
                barHandle.bitmap = this._SafeStr_14251;
                barHandle.disposesBitmap = false;
                barX.bitmap = this._SafeStr_14252;
                barX.disposesBitmap = false;
                this._SafeStr_14256 = (this._window.width - barX.x);
            };
            barGripL.width = (barHandle.x - gripMargin);
            barGripL.x = 0;
            barGripR.x = ((barHandle.x + barHandle.width) + gripMargin);
            barGripR.width = ((barX.x - gripMargin) - barGripR.x);
            if (barGripL.width < 0){
                barGripL.width = 0;
            };
            if (barGripR.width < 0){
                barGripR.width = 0;
            };
            state = 0;
            if (((((!((barBg == null))) && (!((barGripL == null))))) && (!((barGripR == null))))){
                try {
                    state = 1;
                    width = barBg.width;
                    height = barBg.height;
                    if ((((width > 0)) && ((height > 0)))){
                        destBgBitmap = new TrackedBitmapData(this, width, height);
                        this.RoomChatHistoryPulldown(this._SafeStr_14249, destBgBitmap);
                        barBg.disposesBitmap = true;
                        barBg.bitmap = destBgBitmap;
                    };
                    state = 2;
                    width = barGripL.width;
                    height = barGripL.height;
                    if ((((width > 0)) && ((height > 0)))){
                        destGripLBitmap = new TrackedBitmapData(this, width, height);
                        this.RoomChatHistoryPulldown(this._SafeStr_14250, destGripLBitmap);
                        barGripL.disposesBitmap = true;
                        barGripL.bitmap = destGripLBitmap;
                    };
                    state = 3;
                    width = barGripR.width;
                    height = barGripR.height;
                    if ((((width > 0)) && ((height > 0)))){
                        destGripRBitmap = new TrackedBitmapData(this, width, height);
                        this.RoomChatHistoryPulldown(this._SafeStr_14250, destGripRBitmap);
                        barGripR.disposesBitmap = true;
                        barGripR.bitmap = destGripRBitmap;
                    };
                }
                catch(e:Error) {
                    throw (new Error(((((((e.message + " width:") + width) + " height:") + height) + " state:") + state), e.errorID));
                };
            };
            if (this._SafeStr_14247 == null){
                return;
            };
            this._SafeStr_14247.bitmap = this._SafeStr_14255;
            this._SafeStr_14247.disposesBitmap = false;
        }
        private function RoomChatHistoryPulldown(_arg_1:BitmapData, _arg_2:BitmapData):void
        {
            var _local_3:int = (_arg_2.width / _arg_1.width);
            var _local_4:Point = new Point();
            var _local_5:int;
            while (_local_5 < (_local_3 + 1)) {
                _local_4.x = (_local_5 * _arg_1.width);
                _arg_2.copyPixels(_arg_1, _arg_1.rect, _local_4);
                _local_5++;
            };
        }
        private function RoomChatWidget(_arg_1:WindowMouseEvent):void
        {
            if (this._widget != null){
                this._widget.RoomChatWidget(_arg_1);
            };
        }
        private function RoomChatHistoryPulldown(_arg_1:WindowMouseEvent):void
        {
            if (this._widget != null){
                this._widget.RoomChatWidget(_arg_1);
            };
        }
        private function RoomChatHistoryPulldown(_arg_1:WindowMouseEvent):void
        {
            if (this._window == null){
                return;
            };
            if (!this._window.visible){
                return;
            };
            var _local_2:IBitmapWrapperWindow = (this._window.findChildByName("GrapBarX") as IBitmapWrapperWindow);
            if (_local_2 != null){
                _local_2.disposesBitmap = false;
                _local_2.bitmap = this._SafeStr_14253;
            };
        }
        private function RoomChatHistoryPulldown(_arg_1:WindowMouseEvent):void
        {
            if (this._window == null){
                return;
            };
            if (!this._window.visible){
                return;
            };
            var _local_2:IBitmapWrapperWindow = (this._window.findChildByName("GrapBarX") as IBitmapWrapperWindow);
            if (_local_2 != null){
                _local_2.disposesBitmap = false;
                _local_2.bitmap = this._SafeStr_14252;
            };
        }
        private function RoomChatHistoryPulldown(_arg_1:WindowMouseEvent):void
        {
            if (this._window == null){
                return;
            };
            if (!this._window.visible){
                return;
            };
            var _local_2:IBitmapWrapperWindow = (this._window.findChildByName("GrapBarX") as IBitmapWrapperWindow);
            if (_local_2 != null){
                _local_2.disposesBitmap = false;
                _local_2.bitmap = this._SafeStr_14254;
            };
        }
        private function RoomChatHistoryPulldown(_arg_1:WindowMouseEvent):void
        {
            if (this._window == null){
                return;
            };
            if (!this._window.visible){
                return;
            };
            var _local_2:IBitmapWrapperWindow = (this._window.findChildByName("GrapBarX") as IBitmapWrapperWindow);
            if (_local_2 != null){
                _local_2.disposesBitmap = false;
                _local_2.bitmap = this._SafeStr_14253;
            };
        }

    }
}//package com.sulake.habbo.ui.widget.roomchat

// _SafeStr_12100 = "_-14H" (String#4964, DoABC#2)
// _SafeStr_12102 = "_-00H" (String#3568, DoABC#2)
// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// _mainWindow = "_-Xu" (String#8368, DoABC#2)
// _SafeStr_14178 = "_-fB" (String#23854, DoABC#2)
// RoomChatHistoryViewer = "_-7s" (String#22537, DoABC#2)
// RoomChatWidget = "_-2Am" (String#6263, DoABC#2)
// RoomChatWidget = "_-2zb" (String#21443, DoABC#2)
// _SafeStr_14238 = "_-1iW" (String#18228, DoABC#2)
// _SafeStr_14239 = "_-bs" (String#23709, DoABC#2)
// _SafeStr_14245 = "_-0EH" (String#14619, DoABC#2)
// _SafeStr_14246 = "_-1zw" (String#18965, DoABC#2)
// _SafeStr_14247 = "_-20e" (String#19036, DoABC#2)
// _SafeStr_14248 = "_-19y" (String#16855, DoABC#2)
// _SafeStr_14249 = "_-2pP" (String#21054, DoABC#2)
// _SafeStr_14250 = "_-0oS" (String#15993, DoABC#2)
// _SafeStr_14251 = "_-" (String#14008, DoABC#2)
// _SafeStr_14252 = "_-u7" (String#24453, DoABC#2)
// _SafeStr_14253 = "_-2lJ" (String#20895, DoABC#2)
// _SafeStr_14254 = "_-1vo" (String#18791, DoABC#2)
// _SafeStr_14255 = "_-6s" (String#22494, DoABC#2)
// _SafeStr_14256 = "_-0Sw" (String#15166, DoABC#2)
// RoomChatHistoryPulldown = "_-2t9" (String#21207, DoABC#2)
// RoomChatHistoryPulldown = "_-2BR" (String#19462, DoABC#2)
// RoomChatHistoryPulldown = "_-Iv" (String#22965, DoABC#2)
// RoomChatHistoryPulldown = "_-3Kz" (String#22321, DoABC#2)
// RoomChatHistoryPulldown = "_-rF" (String#24326, DoABC#2)
// RoomChatHistoryPulldown = "_-0Ad" (String#14474, DoABC#2)
// RoomChatHistoryPulldown = "_-3GY" (String#22145, DoABC#2)
// HabboWindowParam = "_-29D" (String#6233, DoABC#2)
// HabboWindowStyle = "_-0E1" (String#14608, DoABC#2)
// HabboWindowType = "_-29U" (String#19384, DoABC#2)
// WindowType = "_-1yl" (String#6008, DoABC#2)
// IRegionWindow = "_-dg" (String#2146, DoABC#2)
// RoomChatWidget = "_-Yb" (String#8385, DoABC#2)
// RoomChatHistoryPulldown = "_-0uL" (String#4732, DoABC#2)
// TrackedBitmapData = "_-1gF" (String#5666, DoABC#2)
// _SafeStr_3728 = "_-1IW" (String#5215, DoABC#2)
// _SafeStr_3729 = "_-06z" (String#14322, DoABC#2)
// _SafeStr_3731 = "_-B" (String#22654, DoABC#2)
// WME_OUT = "_-0h2" (String#15712, DoABC#2)
// WME_DOWN = "_-hL" (String#23944, DoABC#2)
// WME_UP = "_-0Cs" (String#14566, DoABC#2)
// _SafeStr_4662 = "_-0g1" (String#15673, DoABC#2)
// _SafeStr_6022 = "_-1t4" (String#18679, DoABC#2)
// _SafeStr_6023 = "_-Mr" (String#23121, DoABC#2)
// _SafeStr_6090 = "_-34m" (String#21687, DoABC#2)
// mouseThreshold = "_-0OA" (String#4051, DoABC#2)
// disposesBitmap = "_-03U" (String#3637, DoABC#2)
// toolTipCaption = "_-0cC" (String#4347, DoABC#2)
// _SafeStr_7446 = "_-3GA" (String#22125, DoABC#2)
// _SafeStr_7455 = "_-24N" (String#19194, DoABC#2)
// toolTipDelay = "_-2W1" (String#6685, DoABC#2)


