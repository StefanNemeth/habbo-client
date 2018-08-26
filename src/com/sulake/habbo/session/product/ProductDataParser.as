
package com.sulake.habbo.session.product
{
    import flash.events.EventDispatcher;
    import flash.utils.Dictionary;
    import com.sulake.core.assets.AssetLibrary;
    import flash.net.URLRequest;
    import com.sulake.core.assets.AssetLoaderStruct;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;
    import flash.events.Event;
    import com.sulake.habbo.utils.HabboWebTools;

    public class ProductDataParser extends EventDispatcher 
    {

        public static const _localization:String = "ready";

        private var _products:Dictionary;
        private var _SafeStr_5255:AssetLibrary;

        public function ProductDataParser(_arg_1:String, _arg_2:Dictionary)
        {
            this._products = _arg_2;
            this._SafeStr_5255 = new AssetLibrary("ProductDataParserAssetLib");
            var _local_3:AssetLoaderStruct = this._SafeStr_5255.loadAssetFromFile(_arg_1, new URLRequest(_arg_1), "text/plain");
            _local_3.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.parseProductsData);
            _local_3.addEventListener(AssetLoaderEvent._SafeStr_4221, this.productsDataError);
        }
        public function dispose():void
        {
            if (this._SafeStr_5255){
                this._SafeStr_5255.dispose();
                this._SafeStr_5255 = null;
            };
            this._products = null;
        }
        private function parseProductsData(_arg_1:Event):void
        {
            var _local_10:String;
            var _local_11:Array;
            var _local_12:String;
            var _local_13:Array;
            var _local_14:String;
            var _local_15:String;
            var _local_16:String;
            var _local_17:ProductData;
            var _local_2:AssetLoaderStruct = (_arg_1.target as AssetLoaderStruct);
            if (_local_2 == null){
                return;
            };
            if ((((_local_2.assetLoader == null)) || ((_local_2.assetLoader.content == null)))){
                return;
            };
            var _local_3:String = (_local_2.assetLoader.content as String);
            var _local_4:Array = new Array();
            var _local_5:RegExp = /\n\r{1,}|\n{1,}|\r{1,}/mg;
            var _local_6:RegExp = /^\s+|\s+$/g;
            var _local_7:RegExp = /\[+?((.)*?)\]/g;
            _local_3 = _local_3.replace(/"{1,}/mg, "");
            var _local_8:Array = _local_3.split(_local_5);
            var _local_9:int;
            for each (_local_10 in _local_8) {
                _local_11 = _local_10.match(_local_7);
                for each (_local_12 in _local_11) {
                    _local_12 = _local_12.replace(/\[{1,}/mg, "");
                    _local_12 = _local_12.replace(/\]{1,}/mg, "");
                    _local_13 = _local_12.split(",");
                    _local_14 = _local_13.shift();
                    _local_15 = _local_13.shift();
                    _local_16 = _local_13.join(",");
                    _local_17 = new ProductData(_local_14, _local_15, _local_16);
                    this._products[_local_14] = _local_17;
                };
                _local_9++;
            };
            dispatchEvent(new Event(_localization));
        }
        private function productsDataError(_arg_1:AssetLoaderEvent):void
        {
            HabboWebTools.logEventLog(("productdata download error " + _arg_1.status));
        }

    }
}//package com.sulake.habbo.session.product

// HabboWebTools = "_-2pX" (String#21059, DoABC#2)
// ProductDataParser = "_-aW" (String#23653, DoABC#2)
// ProductData = "_-2XG" (String#6705, DoABC#2)
// _SafeStr_4221 = "_-0eh" (String#15613, DoABC#2)
// logEventLog = "_-1qw" (String#18578, DoABC#2)
// _products = "_-f0" (String#640, DoABC#2)
// _localization = "_-1" (String#16427, DoABC#2)
// _SafeStr_5255 = "_-U9" (String#2115, DoABC#2)
// parseProductsData = "_-qJ" (String#24284, DoABC#2)
// productsDataError = "_-XD" (String#23531, DoABC#2)
// assetLoader = "_-1nR" (String#18439, DoABC#2)
// AssetLoaderStruct = "_-0R2" (String#4112, DoABC#2)


