
package com.sulake.habbo.communication.demo
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.components.IDisplayObjectWrapper;
    import com.sulake.core.window.components.IDesktopWindow;
    import com.sulake.core.assets.IAssetLibrary;
    import flash.events.IEventDispatcher;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.habbo.window.IHabboWindowManager;
    import flash.net.URLRequest;
    import com.sulake.core.assets.AssetLoaderStruct;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;
    import flash.display.BitmapData;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.display.Bitmap;
    import flash.events.Event;
    import com.sulake.habbo.communication.enum.HabboHotelViewEvent;

    public class HabboHotelView implements IDisposable 
    {

        private var _window:IDisplayObjectWrapper;
        private var _SafeStr_4581:IDesktopWindow;
        private var _disposed:Boolean = false;
        private var _SafeStr_10697:Function;
        private var _SafeStr_10698:Function;
        private var _SafeStr_5255:IAssetLibrary;
        private var _SafeStr_10699:uint = 0;
        private var _events:IEventDispatcher;
        private var _SafeStr_10700:Boolean;

        public function HabboHotelView(_arg_1:IHabboWindowManager, _arg_2:IAssetLibrary, _arg_3:IEventDispatcher, _arg_4:Boolean=true)
        {
            var _local_5:IAsset;
            var _local_6:XML;
            super();
            this._SafeStr_5255 = _arg_2;
            this._events = _arg_3;
            this._SafeStr_4581 = _arg_1.getDesktop(0);
            this._SafeStr_10700 = _arg_4;
            var _local_7:Array = new Array();
            _local_5 = _arg_2.getAssetByName("hotel_view_window");
            if (_local_5 == null){
                throw (new Error("Missing asset; hotel view window layout!"));
            };
            _local_6 = (XmlAsset(_local_5).content as XML);
            if (_local_6){
                this._window = (_arg_1.buildFromXML(_local_6, 0) as IDisplayObjectWrapper);
                this._window.rectangle = this._window.desktop.rectangle;
            };
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function dispose():void
        {
            if (!this._disposed){
                if (this._window){
                    this._window.dispose();
                    this._window = null;
                };
                this._disposed = true;
                this._SafeStr_10697 = null;
                this._SafeStr_10698 = null;
                this._SafeStr_4581 = null;
                this._events = null;
            };
        }
        public function HabboHotelView(_arg_1:String, _arg_2:Function=null):void
        {
            var _local_3:AssetLoaderStruct = this._SafeStr_5255.loadAssetFromFile("hotelview_png", new URLRequest(_arg_1), "image/png");
            if (_arg_2 == null){
                _local_3.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.HabboHotelView);
                _local_3.addEventListener(AssetLoaderEvent._SafeStr_4221, this.HabboHotelView);
            }
            else {
                this._SafeStr_10698 = _arg_2;
                _local_3.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.HabboHotelView);
                _local_3.addEventListener(AssetLoaderEvent._SafeStr_4221, this.HabboHotelView);
            };
            this._SafeStr_10699++;
        }
        private function HabboHotelView(_arg_1:AssetLoaderEvent):void
        {
            var _local_4:BitmapData;
            var _local_5:IDisplayObjectWrapper;
            var _local_2:AssetLoaderStruct = (_arg_1.target as AssetLoaderStruct);
            var _local_3:IAsset = this._SafeStr_5255.getAssetByName(_local_2.assetName);
            if (_arg_1.type == AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE){
                _local_4 = (BitmapDataAsset(_local_3).content as BitmapData);
                if (((this._window) && (!(this._window.disposed)))){
                    _local_5 = (this._window as IDisplayObjectWrapper);
                    if (_local_5 != null){
                        _local_5.width = _local_4.width;
                        _local_5.height = _local_4.height;
                        _local_5.setDisplayObject(new Bitmap(_local_4));
                    };
                };
            };
            if (!this._SafeStr_10700){
                this.hide();
            };
            _local_2.removeEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.HabboHotelView);
            _local_2.removeEventListener(AssetLoaderEvent._SafeStr_4221, this.HabboHotelView);
        }
        private function HabboHotelView(_arg_1:AssetLoaderEvent):void
        {
            var _local_4:BitmapData;
            var _local_2:AssetLoaderStruct = (_arg_1.target as AssetLoaderStruct);
            var _local_3:IAsset = this._SafeStr_5255.getAssetByName(_local_2.assetName);
            if (_arg_1.type == AssetLoaderEvent._SafeStr_4221){
                if (this._events != null){
                    this._events.dispatchEvent(new Event(HabboHotelViewEvent.RWPUW_ERROR));
                };
            }
            else {
                if (_arg_1.type == AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE){
                    if (this._events != null){
                        this._events.dispatchEvent(new Event(HabboHotelViewEvent.HHVE_LOADED));
                    };
                    _local_4 = (BitmapDataAsset(_local_3).content as BitmapData);
                    if (this._SafeStr_10698 != null){
                        this._SafeStr_10698(_local_4);
                        this._SafeStr_10698 = null;
                    };
                };
            };
            _local_2.removeEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.HabboHotelView);
            _local_2.removeEventListener(AssetLoaderEvent._SafeStr_4221, this.HabboHotelView);
        }
        public function HabboHotelView(_arg_1:String, _arg_2:Function):void
        {
            var _local_3:AssetLoaderStruct = this._SafeStr_5255.loadAssetFromFile(("hotel_view_banner_" + this._SafeStr_10699), new URLRequest(_arg_1), "image/png");
            if (_arg_2 == null){
                _local_3.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.HabboHotelView);
                _local_3.addEventListener(AssetLoaderEvent._SafeStr_4221, this.HabboHotelView);
            }
            else {
                if (this._events != null){
                    this._events.dispatchEvent(new Event(HabboHotelViewEvent.HHVE_START_LOAD));
                };
                this._SafeStr_10697 = _arg_2;
                _local_3.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.HabboHotelView);
                _local_3.addEventListener(AssetLoaderEvent._SafeStr_4221, this.HabboHotelView);
            };
            this._SafeStr_10699++;
        }
        private function HabboHotelView(_arg_1:AssetLoaderEvent):void
        {
            var _local_4:BitmapData;
            var _local_2:AssetLoaderStruct = (_arg_1.target as AssetLoaderStruct);
            var _local_3:IAsset = this._SafeStr_5255.getAssetByName(_local_2.assetName);
            _local_2.removeEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.HabboHotelView);
            _local_2.removeEventListener(AssetLoaderEvent._SafeStr_4221, this.HabboHotelView);
        }
        private function HabboHotelView(_arg_1:AssetLoaderEvent):void
        {
            var _local_4:BitmapData;
            var _local_2:AssetLoaderStruct = (_arg_1.target as AssetLoaderStruct);
            var _local_3:IAsset = this._SafeStr_5255.getAssetByName(_local_2.assetName);
            if (_arg_1.type == AssetLoaderEvent._SafeStr_4221){
                if (this._events != null){
                    this._events.dispatchEvent(new Event(HabboHotelViewEvent.RWPUW_ERROR));
                };
            }
            else {
                if (_arg_1.type == AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE){
                    if (this._events != null){
                        this._events.dispatchEvent(new Event(HabboHotelViewEvent.HHVE_LOADED));
                    };
                    _local_4 = (BitmapDataAsset(_local_3).content as BitmapData);
                    if (this._SafeStr_10697 != null){
                        this._SafeStr_10697(_local_4);
                        this._SafeStr_10697 = null;
                    };
                };
            };
            _local_2.removeEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.HabboHotelView);
            _local_2.removeEventListener(AssetLoaderEvent._SafeStr_4221, this.HabboHotelView);
        }
        public function show():void
        {
            if (((this._window) && (!(this._window.disposed)))){
                this._SafeStr_4581.addChildAt(this._window, 0);
            };
        }
        public function hide():void
        {
            if (((this._window) && (!(this._window.disposed)))){
                this._SafeStr_4581.removeChild(this._window);
            };
        }

    }
}//package com.sulake.habbo.communication.demo

// _SafeStr_10697 = "_-2Eq" (String#19598, DoABC#2)
// _SafeStr_10698 = "_-0wl" (String#16301, DoABC#2)
// _SafeStr_10699 = "_-2M8" (String#19890, DoABC#2)
// _SafeStr_10700 = "_-2Ih" (String#19756, DoABC#2)
// HabboHotelView = "_-0BN" (String#14500, DoABC#2)
// HabboHotelView = "_-1eI" (String#18070, DoABC#2)
// HabboHotelView = "_-2Ca" (String#19509, DoABC#2)
// HabboHotelView = "_-2ad" (String#20471, DoABC#2)
// HabboHotelView = "_-Ny" (String#23164, DoABC#2)
// HabboHotelView = "_-0J5" (String#14803, DoABC#2)
// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// IDisplayObjectWrapper = "_-FC" (String#2078, DoABC#2)
// HabboHotelView = "_-FN" (String#7979, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// _SafeStr_4221 = "_-0eh" (String#15613, DoABC#2)
// _SafeStr_4581 = "_-3--" (String#7285, DoABC#2)
// RWPUW_ERROR = "_-0CA" (String#14535, DoABC#2)
// _SafeStr_5255 = "_-U9" (String#2115, DoABC#2)
// HHVE_START_LOAD = "_-1TG" (String#17635, DoABC#2)
// HHVE_LOADED = "_-rV" (String#24338, DoABC#2)
// HabboHotelViewEvent = "_-hR" (String#23947, DoABC#2)
// AssetLoaderStruct = "_-0R2" (String#4112, DoABC#2)


