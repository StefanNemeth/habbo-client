
package com.sulake.habbo.ui.widget.furniture.teaser
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.assets.AssetLoaderStruct;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;
    import flash.net.URLRequest;

    public class ImageDownloader implements IDisposable 
    {

        private var _widget:TeaserFurniWidget;
        private var _assets:IAssetLibrary;
        private var _campaignID:String;
        private var _imageName:String;
        private var _viewElementID:String;
        private var _content:AssetLoaderStruct;
        private var _disposed:Boolean;

        public function ImageDownloader(_arg_1:TeaserFurniWidget, _arg_2:IAssetLibrary, _arg_3:String, _arg_4:String, _arg_5:String, _arg_6:String)
        {
            this._widget = _arg_1;
            this._assets = _arg_2;
            this._campaignID = _arg_3;
            this._imageName = _arg_5;
            this._viewElementID = _arg_6;
            this.downloadImage(_arg_4, _arg_5);
        }
        public function dispose():void
        {
            this._widget = null;
            this._assets = null;
            if (this._content){
                this._content.removeEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.onImageReady);
            };
            this._content = null;
            this._disposed = true;
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function get campaignID():String
        {
            return (this._campaignID);
        }
        public function get imageName():String
        {
            return (this._imageName);
        }
        public function get viewElementID():String
        {
            return (this._viewElementID);
        }
        public function downloadImage(_arg_1:String, _arg_2:String):void
        {
            var _local_3:URLRequest = new URLRequest(((_arg_1 + "") + _arg_2));
            if (_local_3 != null){
                this._content = this._assets.loadAssetFromFile(_arg_2, _local_3, "image/png");
                this._content.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.onImageReady);
            };
        }
        private function onImageReady(_arg_1:AssetLoaderEvent):void
        {
            if (this._widget != null){
                this._widget.onDecoImageReady(this);
            };
            if (this._content){
                this._content.removeEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.onImageReady);
            };
            this._content = null;
        }

    }
}//package com.sulake.habbo.ui.widget.furniture.teaser

// TeaserFurniWidget = "_-1kW" (String#5761, DoABC#2)
// ImageDownloader = "_-2EI" (String#6327, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// onImageReady = "_-1qK" (String#1767, DoABC#2)
// _campaignID = "_-eQ" (String#639, DoABC#2)
// campaignID = "_-09Z" (String#14429, DoABC#2)
// onDecoImageReady = "_-3O" (String#22354, DoABC#2)
// imageName = "_-0cN" (String#15528, DoABC#2)
// viewElementID = "_-2MU" (String#19906, DoABC#2)
// _imageName = "_-1RK" (String#17559, DoABC#2)
// _viewElementID = "_-1h-" (String#18176, DoABC#2)
// _content = "_-0lY" (String#299, DoABC#2)
// downloadImage = "_-JQ" (String#22980, DoABC#2)
// AssetLoaderStruct = "_-0R2" (String#4112, DoABC#2)


