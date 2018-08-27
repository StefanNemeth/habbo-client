
package com.sulake.habbo.quest
{
    import com.sulake.core.runtime.IDisposable;
    import flash.utils.Dictionary;
    import flash.display.BitmapData;
    import com.sulake.core.assets.AssetLoaderStruct;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;

    public class TwinkleImages implements IDisposable 
    {

        private static const _SafeStr_12252:int = 6;

        private var _SafeStr_8017:HabboQuestEngine;
        private var _images:Dictionary;

        public function TwinkleImages(_arg_1:HabboQuestEngine)
        {
            this._images = new Dictionary();
            super();
            this._SafeStr_8017 = _arg_1;
            var _local_2:int = 1;
            while (_local_2 <= _SafeStr_12252) {
                this.loadImage(_local_2);
                _local_2++;
            };
        }
        public function dispose():void
        {
            var _local_1:BitmapData;
            this._SafeStr_8017 = null;
            if (this._images){
                for each (_local_1 in this._images) {
                    _local_1.dispose();
                };
                this._images = null;
            };
        }
        public function get disposed():Boolean
        {
            return ((this._SafeStr_8017 == null));
        }
        private function loadImage(_arg_1:int):void
        {
            PendingImage.retrievePreviewAsset(this._SafeStr_8017, ("ach_twinkle" + _arg_1), this.onImageReady);
        }
        public function getImage(_arg_1:int):BitmapData
        {
            return (this._images[("ach_twinkle" + _arg_1)]);
        }
        private function onImageReady(_arg_1:AssetLoaderEvent):void
        {
            var _local_2:AssetLoaderStruct = (_arg_1.target as AssetLoaderStruct);
            if (_local_2 == null){
                return;
            };
            var _local_3:String = _local_2.assetName;
            if (((!(_local_3)) || (!(this._SafeStr_8017.assets)))){
                return;
            };
            var _local_4:BitmapDataAsset = (this._SafeStr_8017.assets.getAssetByName(_local_3) as BitmapDataAsset);
            if (_local_4 == null){
                return;
            };
            Logger.log(("GOT TWINKLE ASSET: " + _local_3));
            this._images[_local_3] = BitmapData(_local_4.content);
        }

    }
}//package com.sulake.habbo.quest

// _SafeStr_12252 = "_-2Yc" (String#20381, DoABC#2)
// loadImage = "_-0DI" (String#14581, DoABC#2)
// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// TwinkleImages = "_-0vX" (String#4758, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// onImageReady = "_-1qK" (String#1767, DoABC#2)
// getImage = "_-eg" (String#2150, DoABC#2)
// _SafeStr_8017 = "_-1jf" (String#150, DoABC#2)
// retrievePreviewAsset = "_-04a" (String#579, DoABC#2)
// AssetLoaderStruct = "_-0R2" (String#4112, DoABC#2)


