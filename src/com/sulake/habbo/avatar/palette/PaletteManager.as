
package com.sulake.habbo.avatar.palette
{
    import com.sulake.core.assets.AssetLibraryCollection;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.assets.UnknownAsset;
    import flash.utils.ByteArray;

    public class PaletteManager 
    {

        private var _SafeStr_6867:Array;
        private var _assets:AssetLibraryCollection;

        public function PaletteManager(_arg_1:AssetLibraryCollection)
        {
            this._SafeStr_6867 = new Array();
            this._assets = _arg_1;
        }
        public function dispose():void
        {
            this._assets = null;
            this._SafeStr_6867 = null;
        }
        public function reset():void
        {
            this.init();
        }
        public function init():void
        {
            var _local_2:XmlAsset;
            var _local_3:XML;
            var _local_4:XML;
            var _local_5:int;
            var _local_6:String;
            var _local_7:UnknownAsset;
            var _local_8:ByteArray;
            var _local_9:PaletteMap;
            var _local_1:Array = this._assets.getAssetsByName("petPalettesConfiguration");
            for each (_local_2 in _local_1) {
                if (_local_2 != null){
                    _local_3 = (_local_2.content as XML);
                    for each (_local_4 in _local_3.palette) {
                        _local_5 = parseInt(_local_4.@id);
                        _local_6 = String(_local_4.@asset);
                        _local_7 = (this._assets.getAssetByName(_local_6) as UnknownAsset);
                        if (_local_7 != null){
                            if ((_local_7.content is Class)){
                                _local_8 = (new (_local_7.content)() as ByteArray);
                            }
                            else {
                                _local_8 = (_local_7.content as ByteArray);
                            };
                            _local_9 = new PaletteMap(_local_8);
                            this._SafeStr_6867[_local_5] = _local_9;
                        };
                    };
                };
            };
        }
        public function getPalette(_arg_1:int):PaletteMap
        {
            if (this._SafeStr_6867.length <= _arg_1){
                return (null);
            };
            return (this._SafeStr_6867[_arg_1]);
        }

    }
}//package com.sulake.habbo.avatar.palette

// AssetLibraryCollection = "_-2Pg" (String#6555, DoABC#2)
// PaletteManager = "_-2kk" (String#6972, DoABC#2)
// UnknownAsset = "_-0bU" (String#15496, DoABC#2)
// PaletteMap = "_-2DD" (String#6308, DoABC#2)
// _SafeStr_6867 = "_-2YU" (String#893, DoABC#2)


