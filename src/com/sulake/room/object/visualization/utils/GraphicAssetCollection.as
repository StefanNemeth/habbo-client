
package com.sulake.room.object.visualization.utils
{
    import com.sulake.core.utils.Map;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.assets.IAsset;
    import flash.utils.ByteArray;
    import com.sulake.room.utils.XMLValidator;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.display.BitmapData;

    public class GraphicAssetCollection implements IGraphicAssetCollection 
    {

        private static const _SafeStr_14386:int = 10;

        private var _assets:Map;
        private var _assetLibrary:IAssetLibrary;
        private var _SafeStr_6867:Map;
        private var _SafeStr_14388:Array;
        private var _referenceCount:int = 0;

        public function GraphicAssetCollection()
        {
            this._assets = new Map();
            this._SafeStr_6867 = new Map();
            this._SafeStr_14388 = [];
        }
        public function dispose():void
        {
            var _local_1:String;
            var _local_2:GraphicAsset;
            var _local_3:GraphicAssetPalette;
            if (this._assets != null){
                for (_local_1 in this._assets) {
                    _local_2 = this._assets[_local_1];
                    if (_local_2 != null){
                        _local_2.dispose();
                    };
                };
                this._assets.dispose();
                this._assets = null;
            };
            if (this._SafeStr_6867 != null){
                for (_local_1 in this._SafeStr_6867) {
                    _local_3 = this._SafeStr_6867[_local_1];
                    if (_local_3 != null){
                        _local_3.dispose();
                    };
                };
                this._SafeStr_6867.dispose();
                this._SafeStr_6867 = null;
            };
            if (this._SafeStr_14388 != null){
                this.disposePaletteAssets();
                this._SafeStr_14388 = null;
            };
            this._assetLibrary = null;
        }
        public function set assetLibrary(_arg_1:IAssetLibrary):void
        {
            this._assetLibrary = _arg_1;
        }
        public function ExtendedBitmapData():void
        {
            this._referenceCount++;
        }
        public function removeReference():void
        {
            this._referenceCount--;
            if (this._referenceCount <= 0){
                this._referenceCount = 0;
                this.disposePaletteAssets(false);
            };
        }
        public function define(_arg_1:XML):Boolean
        {
            if (_arg_1 == null){
                return (false);
            };
            var _local_2:XMLList = _arg_1.asset;
            if (_local_2 == null){
                return (false);
            };
            var _local_3:XMLList = _arg_1.palette;
            if (_local_3 != null){
                this.definePalettes(_local_3);
            };
            this.defineAssets(_local_2);
            return (true);
        }
        private function defineAssets(_arg_1:XMLList):void
        {
            var _local_4:XML;
            var _local_5:String;
            var _local_6:String;
            var _local_7:Boolean;
            var _local_8:Boolean;
            var _local_9:Boolean;
            var _local_10:int;
            var _local_11:int;
            var _local_12:IAsset;
            var _local_13:Boolean;
            var _local_14:IGraphicAsset;
            var _local_2:int = _arg_1.length();
            var _local_3:int;
            while (_local_3 < _local_2) {
                _local_4 = _arg_1[_local_3];
                _local_5 = _local_4.@name;
                if (_local_5.length > 0){
                    _local_6 = null;
                    _local_7 = false;
                    _local_8 = false;
                    _local_9 = false;
                    _local_10 = 0;
                    _local_11 = 0;
                    _local_10 = -(int(_local_4.@x));
                    _local_11 = -(int(_local_4.@y));
                    _local_6 = _local_4.@source;
                    if (int(_local_4.@flipH) > 0){
                        if (_local_6.length > 0){
                            _local_7 = true;
                        };
                    };
                    if (int(_local_4.@flipV) > 0){
                        if (_local_6.length > 0){
                            _local_8 = true;
                        };
                    };
                    _local_9 = !((int(_local_4.@usesPalette) == 0));
                    if (_local_6.length == 0){
                        _local_6 = _local_5;
                    };
                    _local_12 = this._assetLibrary.getAssetByName(_local_6);
                    if (_local_12 != null){
                        _local_13 = this.createAsset(_local_5, _local_6, _local_12, _local_7, _local_8, _local_10, _local_11, _local_9);
                        if (!_local_13){
                            _local_14 = this.getAsset(_local_5);
                            if (((!((_local_14 == null))) && (!((_local_14.assetName == _local_14.libraryAssetName))))){
                                _local_13 = this.replaceAsset(_local_5, _local_6, _local_12, _local_7, _local_8, _local_10, _local_11, _local_9);
                            };
                        };
                    };
                };
                _local_3++;
            };
        }
        private function definePalettes(_arg_1:XMLList):void
        {
            var _local_3:XML;
            var _local_4:String;
            var _local_5:String;
            var _local_6:IAsset;
            var _local_7:ByteArray;
            var _local_8:int;
            var _local_9:int;
            var _local_10:String;
            var _local_11:GraphicAssetPalette;
            var _local_2:Array = ["id", "source"];
            for each (_local_3 in _arg_1) {
                if (XMLValidator.checkRequiredAttributes(_local_3, _local_2)){
                    _local_4 = _local_3.@id;
                    _local_5 = _local_3.@source;
                    if (this._SafeStr_6867[_local_4] == null){
                        _local_6 = this._assetLibrary.getAssetByName(_local_5);
                        if ((_local_6.content is Class)){
                            _local_7 = (new (_local_6.content)() as ByteArray);
                        }
                        else {
                            _local_7 = (_local_6.content as ByteArray);
                        };
                        _local_8 = 0xFFFFFF;
                        _local_9 = 0xFFFFFF;
                        _local_10 = _local_3.@color1;
                        if (_local_10.length > 0){
                            _local_8 = parseInt(_local_10, 16);
                            _local_9 = _local_8;
                        };
                        _local_10 = _local_3.@color2;
                        if (_local_10.length > 0){
                            _local_9 = parseInt(_local_10, 16);
                        };
                        _local_11 = new GraphicAssetPalette(_local_7, _local_8, _local_9);
                        this._SafeStr_6867[_local_4] = _local_11;
                    };
                };
            };
        }
        protected function createAsset(_arg_1:String, _arg_2:String, _arg_3:IAsset, _arg_4:Boolean, _arg_5:Boolean, _arg_6:Number, _arg_7:Number, _arg_8:Boolean):Boolean
        {
            if (this._assets[_arg_1] != null){
                return (false);
            };
            var _local_9:GraphicAsset = new GraphicAsset(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8);
            this._assets[_arg_1] = _local_9;
            return (true);
        }
        protected function replaceAsset(_arg_1:String, _arg_2:String, _arg_3:IAsset, _arg_4:Boolean, _arg_5:Boolean, _arg_6:Number, _arg_7:Number, _arg_8:Boolean):Boolean
        {
            var _local_9:GraphicAsset = this._assets.remove(_arg_1);
            if (_local_9 != null){
                _local_9.dispose();
            };
            return (this.createAsset(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8));
        }
        public function getAsset(_arg_1:String):IGraphicAsset
        {
            return (this._assets[_arg_1]);
        }
        public function getAssetWithPalette(_arg_1:String, _arg_2:String):IGraphicAsset
        {
            var _local_5:IGraphicAsset;
            var _local_6:String;
            var _local_7:BitmapDataAsset;
            var _local_8:BitmapData;
            var _local_9:GraphicAssetPalette;
            var _local_10:BitmapData;
            var _local_3:String = ((_arg_1 + "@") + _arg_2);
            var _local_4:IGraphicAsset = this.getAsset(_local_3);
            if (_local_4 == null){
                _local_5 = this.getAsset(_arg_1);
                if ((((_local_5 == null)) || (!(_local_5.usesPalette)))){
                    return (_local_5);
                };
                _local_6 = ((_local_5.libraryAssetName + "@") + _arg_2);
                _local_7 = this.getLibraryAsset(_local_6);
                if (_local_7 == null){
                    _local_8 = (_local_5.asset.content as BitmapData);
                    if (_local_8 != null){
                        _local_9 = this.getPalette(_arg_2);
                        if (_local_9 != null){
                            _local_10 = _local_8.clone();
                            _local_9.colorizeBitmap(_local_10);
                            _local_7 = this.addLibraryAsset(_local_6, _local_10);
                            if (_local_7 == null){
                                _local_10.dispose();
                                return (null);
                            };
                        }
                        else {
                            return (_local_5);
                        };
                    };
                };
                this._SafeStr_14388.push(_local_3);
                this.createAsset(_local_3, _local_6, _local_7, _local_5.flipH, _local_5.flipV, _local_5.originalOffsetX, _local_5.originalOffsetY, false);
                _local_4 = this.getAsset(_local_3);
            };
            return (_local_4);
        }
        public function getPaletteNames():Array
        {
            return (this._SafeStr_6867.getKeys());
        }
        public function getPaletteColors(_arg_1:String):Array
        {
            var _local_2:GraphicAssetPalette = this.getPalette(_arg_1);
            if (_local_2 != null){
                return ([_local_2.primaryColor, _local_2.secondaryColor]);
            };
            return (null);
        }
        private function getPalette(_arg_1:String):GraphicAssetPalette
        {
            return (this._SafeStr_6867[_arg_1]);
        }
        public function addAsset(_arg_1:String, _arg_2:BitmapData, _arg_3:Boolean, _arg_4:int=0, _arg_5:int=0, _arg_6:Boolean=false, _arg_7:Boolean=false):Boolean
        {
            var _local_9:BitmapData;
            if ((((_arg_1 == null)) || ((_arg_2 == null)))){
                return (false);
            };
            if (this._assetLibrary == null){
                return (false);
            };
            var _local_8:BitmapDataAsset = this.getLibraryAsset(_arg_1);
            if (_local_8 == null){
                _local_8 = new BitmapDataAsset(this._assetLibrary.IAssetLibrary(BitmapDataAsset));
                this._assetLibrary.IAssetLibrary(_arg_1, _local_8);
                _local_8.setUnknownContent(_arg_2);
                return (this.createAsset(_arg_1, _arg_1, _local_8, _arg_6, _arg_7, _arg_4, _arg_5, false));
            };
            if (_arg_3){
                _local_9 = (_local_8.content as BitmapData);
                if (((!((_local_9 == null))) && (!((_local_9 == _arg_2))))){
                    _local_9.dispose();
                };
                _local_8.setUnknownContent(_arg_2);
            };
            return (false);
        }
        public function disposeAsset(_arg_1:String):void
        {
            var _local_3:BitmapDataAsset;
            var _local_2:GraphicAsset = this._assets.remove(_arg_1);
            if (_local_2 != null){
                _local_3 = this.getLibraryAsset(_local_2.libraryAssetName);
                if (_local_3 != null){
                    this._assetLibrary.removeAsset(_local_3);
                    _local_3.dispose();
                };
                _local_2.dispose();
            };
        }
        private function getLibraryAsset(_arg_1:String):BitmapDataAsset
        {
            return ((this._assetLibrary.getAssetByName(_arg_1) as BitmapDataAsset));
        }
        private function addLibraryAsset(_arg_1:String, _arg_2:BitmapData):BitmapDataAsset
        {
            var _local_3:BitmapDataAsset = this.getLibraryAsset(_arg_1);
            if (_local_3 == null){
                _local_3 = new BitmapDataAsset(this._assetLibrary.IAssetLibrary(BitmapDataAsset));
                this._assetLibrary.IAssetLibrary(_arg_1, _local_3);
                _local_3.setUnknownContent(_arg_2);
                return (_local_3);
            };
            return (null);
        }
        private function disposePaletteAssets(_arg_1:Boolean=true):void
        {
            var _local_2:String;
            if (this._SafeStr_14388 != null){
                if (((_arg_1) || ((this._SafeStr_14388.length > _SafeStr_14386)))){
                    for each (_local_2 in this._SafeStr_14388) {
                        this.disposeAsset(_local_2);
                    };
                    this._SafeStr_14388 = [];
                };
            };
        }

    }
}//package com.sulake.room.object.visualization.utils

// primaryColor = "_-jL" (String#24012, DoABC#2)
// disposeAsset = "_-2uj" (String#7174, DoABC#2)
// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// getPaletteNames = "_-113" (String#4896, DoABC#2)
// getPaletteColors = "_-1mh" (String#5793, DoABC#2)
// define = "_-19s" (String#5075, DoABC#2)
// _SafeStr_14386 = "_-2eV" (String#20625, DoABC#2)
// _assetLibrary = "_-0dt" (String#15581, DoABC#2)
// _SafeStr_14388 = "_-1gV" (String#18158, DoABC#2)
// _referenceCount = "_-195" (String#5057, DoABC#2)
// disposePaletteAssets = "_-2NT" (String#19943, DoABC#2)
// definePalettes = "_-Pn" (String#23239, DoABC#2)
// defineAssets = "_-1Re" (String#17571, DoABC#2)
// libraryAssetName = "_-1Pi" (String#5348, DoABC#2)
// replaceAsset = "_-VQ" (String#23468, DoABC#2)
// getLibraryAsset = "_-3-n" (String#21492, DoABC#2)
// addLibraryAsset = "_-2sI" (String#21171, DoABC#2)
// originalOffsetX = "_-0og" (String#4607, DoABC#2)
// originalOffsetY = "_-312" (String#7329, DoABC#2)
// IGraphicAssetCollection = "_-24o" (String#6134, DoABC#2)
// GraphicAssetCollection = "_-2uG" (String#7165, DoABC#2)
// IGraphicAsset = "_-1HF" (String#5195, DoABC#2)
// GraphicAssetPalette = "_-1-H" (String#4852, DoABC#2)
// ExtendedBitmapData = "_-2F" (String#6343, DoABC#2)
// _SafeStr_6867 = "_-2YU" (String#893, DoABC#2)
// colorizeBitmap = "_-1Af" (String#16887, DoABC#2)
// setUnknownContent = "_-2zE" (String#7271, DoABC#2)
// IAssetLibrary = "_-08Y" (String#3730, DoABC#2)
// createAsset = "_-0rD" (String#1562, DoABC#2)
// IAssetLibrary = "_-5x" (String#7779, DoABC#2)


