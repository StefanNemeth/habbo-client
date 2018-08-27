
package com.sulake.habbo.navigator.mainview
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.navigator.HabboNavigator;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.net.URLRequest;
    import com.sulake.core.assets.AssetLoaderStruct;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;
    import flash.display.BitmapData;

    public class OfficialRoomImageLoader implements IDisposable 
    {

        private var _navigator:HabboNavigator;
        private var _picRef:String;
        private var _url:String;
        private var _SafeStr_4218:IBitmapWrapperWindow;
        private var _disposed:Boolean;

        public function OfficialRoomImageLoader(_arg_1:HabboNavigator, _arg_2:String, _arg_3:IBitmapWrapperWindow)
        {
            this._navigator = _arg_1;
            this._picRef = _arg_2;
            this._SafeStr_4218 = _arg_3;
            var _local_4:String = this._navigator.configuration.getKey("image.library.url");
            this._url = (_local_4 + this._picRef);
            Logger.log(("[OFFICIAL ROOM ICON IMAGE DOWNLOADER] : " + this._url));
        }
        public function startLoad():void
        {
            var _local_1:URLRequest;
            var _local_2:AssetLoaderStruct;
            if (this._navigator.assets.hasAsset(this._picRef)){
                this.setImage();
            }
            else {
                _local_1 = new URLRequest(this._url);
                _local_2 = this._navigator.assets.loadAssetFromFile(this._picRef, _local_1, "image/gif");
                _local_2.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.onImageReady);
                _local_2.addEventListener(AssetLoaderEvent._SafeStr_4221, this.onLoadError);
            };
        }
        private function onImageReady(_arg_1:AssetLoaderEvent):void
        {
            if (this._disposed){
                return;
            };
            var _local_2:AssetLoaderStruct = (_arg_1.target as AssetLoaderStruct);
            if (_local_2 == null){
                Logger.log((("Loading pic from url: " + this._url) + " failed. loaderStruct == null"));
                return;
            };
            Logger.log(((("IMAGE READY: " + this._picRef) + ", ") + _local_2));
            this.setImage();
        }
        private function setImage():void
        {
            var _local_1:BitmapData = this._navigator.getButtonImage(this._picRef, "");
            this._SafeStr_4218.bitmap = _local_1;
            this._SafeStr_4218.width = _local_1.width;
            this._SafeStr_4218.height = _local_1.height;
            this._SafeStr_4218.visible = true;
            this.dispose();
        }
        private function onLoadError(_arg_1:AssetLoaderEvent):void
        {
            Logger.log(((("Error loading image: " + this._url) + ", ") + _arg_1));
            this.dispose();
        }
        public function dispose():void
        {
            if (this._disposed){
                return;
            };
            this._disposed = true;
            this._SafeStr_4218 = null;
            this._navigator = null;
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }

    }
}//package com.sulake.habbo.navigator.mainview

// OfficialRoomImageLoader = "_-2Zw" (String#6758, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// startLoad = "_-1TH" (String#17636, DoABC#2)
// _picRef = "_-2bD" (String#6775, DoABC#2)
// _url = "_-3Jl" (String#151, DoABC#2)
// _SafeStr_4218 = "_-0Uc" (String#15228, DoABC#2)
// setImage = "_-1NZ" (String#603, DoABC#2)
// onImageReady = "_-1qK" (String#1767, DoABC#2)
// _SafeStr_4221 = "_-0eh" (String#15613, DoABC#2)
// onLoadError = "_-2jJ" (String#20815, DoABC#2)
// AssetLoaderStruct = "_-0R2" (String#4112, DoABC#2)


