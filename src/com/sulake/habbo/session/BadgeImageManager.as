
package com.sulake.habbo.session
{
    import com.sulake.core.assets.IAssetLibrary;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.core.assets.AssetLibrary;
    import flash.display.BitmapData;
    import flash.net.URLRequest;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.assets.AssetLoaderStruct;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;
    import flash.display.Bitmap;
    import com.sulake.habbo.session.events.BadgeImageReadyEvent;

    public class BadgeImageManager 
    {

        public static const _SafeStr_13616:String = "group_badge";
        public static const _SafeStr_13617:String = "normal_badge";

        private const _SafeStr_13618:String = "badge_";

        private var _assets:IAssetLibrary;
        private var _events:IEventDispatcher;
        private var _configuration:IHabboConfigurationManager;
        private var _localization:IHabboLocalizationManager;

        public function BadgeImageManager(_arg_1:IAssetLibrary, _arg_2:IEventDispatcher, _arg_3:IHabboConfigurationManager, _arg_4:IHabboLocalizationManager)
        {
            if (_arg_1 == null){
                _arg_1 = new AssetLibrary("badge_images");
            };
            this._assets = _arg_1;
            this._events = _arg_2;
            this._configuration = _arg_3;
            this._localization = _arg_4;
        }
        public function dispose():void
        {
            this._assets = null;
        }
        public function SessionDataManager(_arg_1:String, _arg_2:String="normal_badge", _arg_3:Boolean=true):BitmapData
        {
            var _local_4:BitmapData = this.getBadgeImageInternal(_arg_1, _arg_2);
            if (((!(_local_4)) && (_arg_3))){
                _local_4 = this.getPlaceholder();
            };
            return (_local_4);
        }
        public function SessionDataManager(_arg_1:String):BadgeInfo
        {
            var _local_2:BitmapData = this.getBadgeImageInternal(_arg_1);
            return ((((_local_2)!=null) ? new BadgeInfo(_local_2, false) : new BadgeInfo(this.getPlaceholder(), true)));
        }
        private function getBadgeImageInternal(_arg_1:String, _arg_2:String="normal_badge"):BitmapData
        {
            var _local_4:URLRequest;
            var _local_5:String;
            var _local_6:BitmapDataAsset;
            var _local_7:AssetLoaderStruct;
            var _local_3:String = (this._SafeStr_13618 + _arg_1);
            Logger.log(("Request badge: " + _arg_1));
            if (this._assets.hasAsset(_local_3)){
                _local_6 = (this._assets.getAssetByName(_local_3) as BitmapDataAsset);
                return ((_local_6.content as BitmapData).clone());
            };
            switch (_arg_2){
                case _SafeStr_13617:
                    if (this._configuration != null){
                        _local_5 = this._configuration.getKey("image.library.url", "http://images.habbo.com/c_images/");
                        _local_5 = (_local_5 + (("album1584/" + _arg_1) + ".gif"));
                        _local_4 = new URLRequest(_local_5);
                    };
                    break;
                case _SafeStr_13616:
                    if (this._configuration != null){
                        if (this._configuration != null){
                            _local_5 = this._configuration.getKey("group.badge.url");
                            _local_5 = _local_5.replace("%imagerdata%", _arg_1);
                            _local_4 = new URLRequest(_local_5);
                        };
                    };
                    break;
            };
            if (_local_4 != null){
                _local_7 = this._assets.loadAssetFromFile(_local_3, _local_4, "image/gif");
                _local_7.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.onBadgeImageReady);
            };
            return (null);
        }
        private function getPlaceholder():BitmapData
        {
            return (BitmapData(this._assets.getAssetByName("loading_icon").content));
        }
        private function onBadgeImageReady(_arg_1:AssetLoaderEvent):void
        {
            var _local_3:Bitmap;
            var _local_4:String;
            var _local_2:AssetLoaderStruct = (_arg_1.target as AssetLoaderStruct);
            if (_local_2 != null){
                if (((!((_local_2.assetLoader == null))) && (!((_local_2.assetLoader.content == null))))){
                    _local_3 = (_local_2.assetLoader.content as Bitmap);
                    if (_local_3 == null){
                        return;
                    };
                    _local_4 = _local_2.assetName.replace(this._SafeStr_13618, "");
                    this._events.dispatchEvent(new BadgeImageReadyEvent(_local_4, _local_3.bitmapData.clone()));
                };
            };
        }

    }
}//package com.sulake.habbo.session

// SessionDataManager = "_-0SD" (String#4143, DoABC#2)
// BadgeImageReadyEvent = "_-03M" (String#14177, DoABC#2)
// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// _SafeStr_13616 = "_-26w" (String#19289, DoABC#2)
// _SafeStr_13617 = "_-0BM" (String#14499, DoABC#2)
// _SafeStr_13618 = "_-3B8" (String#21929, DoABC#2)
// getBadgeImageInternal = "_-1td" (String#18703, DoABC#2)
// getPlaceholder = "_-0Gi" (String#14710, DoABC#2)
// BadgeInfo = "_-3V" (String#7736, DoABC#2)
// BadgeImageManager = "_-1l8" (String#18336, DoABC#2)
// assetLoader = "_-1nR" (String#18439, DoABC#2)
// SessionDataManager = "_-3DK" (String#7581, DoABC#2)
// onBadgeImageReady = "_-2f0" (String#1919, DoABC#2)
// AssetLoaderStruct = "_-0R2" (String#4112, DoABC#2)


