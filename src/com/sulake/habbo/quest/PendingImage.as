
package com.sulake.habbo.quest
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.IWindow;
    import flash.net.URLRequest;
    import com.sulake.core.assets.AssetLoaderStruct;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.components.IDisplayObjectWrapper;
    import flash.display.BitmapData;
    import flash.geom.Point;
    import flash.display.Bitmap;
    import com.sulake.core.assets.BitmapDataAsset;

    public class PendingImage implements IDisposable 
    {

        private var _SafeStr_8017:HabboQuestEngine;
        private var _SafeStr_12352:IWindow;

        public function PendingImage(_arg_1:HabboQuestEngine, _arg_2:IWindow, _arg_3:String)
        {
            this._SafeStr_8017 = _arg_1;
            this._SafeStr_12352 = _arg_2;
            this.setImageFromAsset(_arg_2, _arg_3, this.onPreviewImageReady);
        }
        public static function retrievePreviewAsset(_arg_1:HabboQuestEngine, _arg_2:String, _arg_3:Function):void
        {
            if (((!(_arg_2)) || (!(_arg_1.assets)))){
                return;
            };
            var _local_4:String = _arg_1.configuration.getKey("image.library.questing.url");
            var _local_5 = ((_local_4 + _arg_2) + ".png");
            Logger.log(("[HabboQuestEngine] Retrieve Product Preview Asset: " + _local_5));
            var _local_6:URLRequest = new URLRequest(_local_5);
            var _local_7:AssetLoaderStruct = _arg_1.assets.loadAssetFromFile(_arg_2, _local_6, "image/png");
            if (!_local_7){
                return;
            };
            _local_7.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, _arg_3);
        }
        public static function setElementImage(_arg_1:IWindow, _arg_2:BitmapData, _arg_3:int=0):void
        {
            var _local_7:IBitmapWrapperWindow;
            var _local_8:IDisplayObjectWrapper;
            if (_arg_2 == null){
                return;
            };
            if (_arg_1 == null){
                return;
            };
            if (_arg_1.disposed){
                return;
            };
            var _local_4:int = (((_arg_3)>0) ? _arg_3 : _arg_1.height);
            var _local_5:int = ((_arg_1.width - _arg_2.width) / 2);
            var _local_6:int = ((_local_4 - _arg_2.height) / 2);
            if ((_arg_1 as IBitmapWrapperWindow) != null){
                _local_7 = IBitmapWrapperWindow(_arg_1);
                if ((((_local_7.bitmap == null)) || ((_arg_3 > 0)))){
                    _local_7.bitmap = new BitmapData(_arg_1.width, _local_4, true, 0xFFFFFF);
                };
                _local_7.bitmap.fillRect(_local_7.bitmap.rect, 0xFFFFFF);
                _local_7.bitmap.copyPixels(_arg_2, _arg_2.rect, new Point(_local_5, _local_6), null, null, false);
                _arg_1.invalidate();
            }
            else {
                if ((_arg_1 as IDisplayObjectWrapper) != null){
                    _local_8 = IDisplayObjectWrapper(_arg_1);
                    _local_8.setDisplayObject(new Bitmap(_arg_2));
                };
            };
        }

        public function dispose():void
        {
            this._SafeStr_12352 = null;
            this._SafeStr_8017 = null;
        }
        public function get disposed():Boolean
        {
            return ((this._SafeStr_8017 == null));
        }
        private function onPreviewImageReady(_arg_1:AssetLoaderEvent):void
        {
            var _local_2:AssetLoaderStruct;
            if (!this.disposed){
                _local_2 = (_arg_1.target as AssetLoaderStruct);
                if (_local_2 != null){
                    this.setImageFromAsset(this._SafeStr_12352, _local_2.assetName, null);
                };
            };
            this.dispose();
        }
        public function setImageFromAsset(_arg_1:IWindow, _arg_2:String, _arg_3:Function):void
        {
            if (((!(_arg_2)) || (!(this._SafeStr_8017.assets)))){
                return;
            };
            var _local_4:BitmapDataAsset = (this._SafeStr_8017.assets.getAssetByName(_arg_2) as BitmapDataAsset);
            if (_local_4 == null){
                retrievePreviewAsset(this._SafeStr_8017, _arg_2, _arg_3);
                return;
            };
            if (_arg_1){
                setElementImage(_arg_1, (_local_4.content as BitmapData));
            };
        }

    }
}//package com.sulake.habbo.quest

// _SafeStr_12352 = "_-07W" (String#14346, DoABC#2)
// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// IDisplayObjectWrapper = "_-FC" (String#2078, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// setElementImage = "_-1IU" (String#302, DoABC#2)
// setImageFromAsset = "_-1q7" (String#18549, DoABC#2)
// onPreviewImageReady = "_-30x" (String#625, DoABC#2)
// _SafeStr_8017 = "_-1jf" (String#150, DoABC#2)
// retrievePreviewAsset = "_-04a" (String#579, DoABC#2)
// AssetLoaderStruct = "_-0R2" (String#4112, DoABC#2)


