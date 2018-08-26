
package com.sulake.room.object.visualization.utils
{
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.assets.IAsset;
    import flash.display.BitmapData;

    public class GraphicAsset implements IGraphicAsset 
    {

        private var _assetName:String;
        private var _libraryAssetName:String;
        private var _asset:BitmapDataAsset;
        private var _flipH:Boolean;
        private var _flipV:Boolean;
        private var _usesPalette:Boolean;
        private var _offsetX:int;
        private var _originalOffsetY:int;
        private var _width:int;
        private var _height:int;
        private var _initialized:Boolean;

        public function GraphicAsset(_arg_1:String, _arg_2:String, _arg_3:IAsset, _arg_4:Boolean, _arg_5:Boolean, _arg_6:int, _arg_7:int, _arg_8:Boolean=false)
        {
            this._assetName = _arg_1;
            this._libraryAssetName = _arg_2;
            var _local_9:BitmapDataAsset = (_arg_3 as BitmapDataAsset);
            if (_local_9 != null){
                this._asset = _local_9;
                this._initialized = false;
            }
            else {
                this._asset = null;
                this._initialized = true;
            };
            this._flipH = _arg_4;
            this._flipV = _arg_5;
            this._offsetX = _arg_6;
            this._originalOffsetY = _arg_7;
            this._usesPalette = _arg_8;
        }
        public function dispose():void
        {
            this._asset = null;
        }
        private function initialize():void
        {
            var _local_1:BitmapData;
            if (((!(this._initialized)) && (!((this._asset == null))))){
                _local_1 = (this._asset.content as BitmapData);
                if (_local_1 != null){
                    this._width = _local_1.width;
                    this._height = _local_1.height;
                };
                this._initialized = true;
            };
        }
        public function get flipV():Boolean
        {
            return (this._flipV);
        }
        public function get flipH():Boolean
        {
            return (this._flipH);
        }
        public function get width():int
        {
            this.initialize();
            return (this._width);
        }
        public function get height():int
        {
            this.initialize();
            return (this._height);
        }
        public function get assetName():String
        {
            return (this._assetName);
        }
        public function get libraryAssetName():String
        {
            return (this._libraryAssetName);
        }
        public function get asset():IAsset
        {
            return (this._asset);
        }
        public function get usesPalette():Boolean
        {
            return (this._usesPalette);
        }
        public function get offsetX():int
        {
            if (!this._flipH){
                return (this._offsetX);
            };
            return (-((this.width + this._offsetX)));
        }
        public function get offsetY():int
        {
            if (!this._flipV){
                return (this._originalOffsetY);
            };
            return (-((this.height + this._originalOffsetY)));
        }
        public function get originalOffsetX():int
        {
            return (this._offsetX);
        }
        public function get originalOffsetY():int
        {
            return (this._originalOffsetY);
        }

    }
}//package com.sulake.room.object.visualization.utils

// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// libraryAssetName = "_-1Pi" (String#5348, DoABC#2)
// originalOffsetX = "_-0og" (String#4607, DoABC#2)
// originalOffsetY = "_-312" (String#7329, DoABC#2)
// _libraryAssetName = "_-eZ" (String#23825, DoABC#2)
// _usesPalette = "_-2fG" (String#20657, DoABC#2)
// IGraphicAsset = "_-1HF" (String#5195, DoABC#2)
// _width = "_-0Uq" (String#92, DoABC#2)
// _asset = "_-1S7" (String#442, DoABC#2)
// _initialized = "_-0EY" (String#214, DoABC#2)
// _flipH = "_-1nk" (String#863, DoABC#2)
// _flipV = "_-1eo" (String#858, DoABC#2)
// _assetName = "_-33u" (String#910, DoABC#2)
// _originalOffsetY = "_-hb" (String#375, DoABC#2)


