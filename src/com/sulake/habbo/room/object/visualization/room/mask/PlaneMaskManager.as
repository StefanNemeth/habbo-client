
package com.sulake.habbo.room.object.visualization.room.mask
{
    import com.sulake.room.object.visualization.utils.IGraphicAssetCollection;
    import com.sulake.core.utils.Map;
    import com.sulake.room.utils.XMLValidator;
    import com.sulake.room.object.visualization.utils.IGraphicAsset;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.display.BitmapData;
    import flash.geom.Point;
    import flash.geom.Matrix;
    import com.sulake.room.utils.IVector3d;

    public class PlaneMaskManager 
    {

        private var _assetCollection:IGraphicAssetCollection = null;
        private var _SafeStr_12837:Map = null;
        private var _data:XML = null;

        public function PlaneMaskManager()
        {
            this._SafeStr_12837 = new Map();
        }
        public function get data():XML
        {
            return (this._data);
        }
        public function dispose():void
        {
            var _local_1:int;
            var _local_2:PlaneMask;
            this._assetCollection = null;
            this._data = null;
            if (this._SafeStr_12837 != null){
                _local_1 = 0;
                while (_local_1 < this._SafeStr_12837.length) {
                    _local_2 = (this._SafeStr_12837.getWithIndex(_local_1) as PlaneMask);
                    if (_local_2 != null){
                        _local_2.dispose();
                    };
                    _local_1++;
                };
                this._SafeStr_12837.dispose();
            };
        }
        public function initialize(_arg_1:XML):void
        {
            this._data = _arg_1;
        }
        public function initializeAssetCollection(_arg_1:IGraphicAssetCollection):void
        {
            if (this.data == null){
                return;
            };
            this._assetCollection = _arg_1;
            this.parseMasks(this.data, _arg_1);
        }
        private function parseMasks(_arg_1:XML, _arg_2:IGraphicAssetCollection):void
        {
            var _local_7:XML;
            var _local_8:String;
            var _local_9:PlaneMask;
            var _local_10:XMLList;
            var _local_11:int;
            var _local_12:XML;
            var _local_13:int;
            var _local_14:PlaneMaskVisualization;
            var _local_15:XMLList;
            if ((((_arg_1 == null)) || ((_arg_2 == null)))){
                return;
            };
            var _local_3:Array = ["id"];
            var _local_4:Array = ["size"];
            var _local_5:XMLList = _arg_1.mask;
            var _local_6:int;
            while (_local_6 < _local_5.length()) {
                _local_7 = _local_5[_local_6];
                if (XMLValidator.checkRequiredAttributes(_local_7, _local_3)){
                    _local_8 = _local_7.@id;
                    if (this._SafeStr_12837.getValue(_local_8) == null){
                        _local_9 = new PlaneMask();
                        _local_10 = _local_7.maskVisualization;
                        _local_11 = 0;
                        while (_local_11 < _local_10.length()) {
                            _local_12 = _local_10[_local_11];
                            if (XMLValidator.checkRequiredAttributes(_local_12, _local_4)){
                                _local_13 = parseInt(_local_12.@size);
                                _local_14 = _local_9.createMaskVisualization(_local_13);
                                if (_local_14 != null){
                                    _local_15 = _local_12.bitmap;
                                    this.parseMaskBitmaps(_local_15, _local_14, _arg_2);
                                };
                            };
                            _local_11++;
                        };
                        this._SafeStr_12837.add(_local_8, _local_9);
                    };
                };
                _local_6++;
            };
        }
        private function parseMaskBitmaps(_arg_1:XMLList, _arg_2:PlaneMaskVisualization, _arg_3:IGraphicAssetCollection):void
        {
            var _local_5:XML;
            var _local_6:Number;
            var _local_7:Number;
            var _local_8:Number;
            var _local_9:Number;
            var _local_10:String;
            var _local_11:IGraphicAsset;
            if (_arg_1 == null){
                return;
            };
            var _local_4:int;
            while (_local_4 < _arg_1.length()) {
                _local_5 = _arg_1[_local_4];
                if (XMLValidator.checkRequiredAttributes(_local_5, ["assetName"])){
                    _local_6 = PlaneMaskVisualization._SafeStr_12841;
                    _local_7 = PlaneMaskVisualization.MAX_NORMAL_COORDINATE_VALUE;
                    _local_8 = PlaneMaskVisualization._SafeStr_12841;
                    _local_9 = PlaneMaskVisualization.MAX_NORMAL_COORDINATE_VALUE;
                    if (String(_local_5.@normalMinX) != ""){
                        _local_6 = parseFloat(_local_5.@normalMinX);
                    };
                    if (String(_local_5.@normalMaxX) != ""){
                        _local_7 = parseFloat(_local_5.@normalMaxX);
                    };
                    if (String(_local_5.@normalMinY) != ""){
                        _local_8 = parseFloat(_local_5.@normalMinY);
                    };
                    if (String(_local_5.@normalMaxY) != ""){
                        _local_9 = parseFloat(_local_5.@normalMaxY);
                    };
                    _local_10 = _local_5.@assetName;
                    _local_11 = _arg_3.getAsset(_local_10);
                    if (_local_11 != null){
                        _arg_2.addBitmap(_local_11, _local_6, _local_7, _local_8, _local_9);
                    };
                };
                _local_4++;
            };
        }
        public function updateMask(_arg_1:BitmapData, _arg_2:String, _arg_3:Number, _arg_4:IVector3d, _arg_5:int, _arg_6:int):Boolean
        {
            var _local_8:IGraphicAsset;
            var _local_9:BitmapDataAsset;
            var _local_10:BitmapData;
            var _local_11:Point;
            var _local_12:Matrix;
            var _local_13:Number;
            var _local_14:Number;
            var _local_15:Number;
            var _local_16:Number;
            var _local_7:PlaneMask = (this._SafeStr_12837.getValue(_arg_2) as PlaneMask);
            if (_local_7 != null){
                _local_8 = _local_7.getGraphicAsset(_arg_3, _arg_4);
                if (_local_8 != null){
                    _local_9 = (_local_8.asset as BitmapDataAsset);
                    if (_local_9 != null){
                        _local_10 = (_local_9.content as BitmapData);
                        if (_local_10 != null){
                            _local_11 = new Point((_arg_5 + _local_8.offsetX), (_arg_6 + _local_8.offsetY));
                            _local_12 = new Matrix();
                            _local_13 = 1;
                            _local_14 = 1;
                            _local_15 = 0;
                            _local_16 = 0;
                            if (_local_8.flipH){
                                _local_13 = -1;
                                _local_15 = _local_10.width;
                            };
                            if (_local_8.flipV){
                                _local_14 = -1;
                                _local_16 = _local_10.height;
                            };
                            _local_12.scale(_local_13, _local_14);
                            _local_12.translate((_local_11.x + _local_15), (_local_11.y + _local_16));
                            _arg_1.draw(_local_10, _local_12);
                        };
                    };
                };
            };
            return (true);
        }

    }
}//package com.sulake.habbo.room.object.visualization.room.mask

// _SafeStr_12837 = "_-014" (String#1385, DoABC#2)
// parseMasks = "_-Kt" (String#23039, DoABC#2)
// createMaskVisualization = "_-0nN" (String#15951, DoABC#2)
// parseMaskBitmaps = "_-U-" (String#23408, DoABC#2)
// _SafeStr_12841 = "_-TR" (String#23383, DoABC#2)
// addBitmap = "_-0pF" (String#16025, DoABC#2)
// updateMask = "_-1EK" (String#5149, DoABC#2)
// getGraphicAsset = "_-2Gu" (String#19679, DoABC#2)
// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// IVector3d = "_-hf" (String#8547, DoABC#2)
// IGraphicAssetCollection = "_-24o" (String#6134, DoABC#2)
// IGraphicAsset = "_-1HF" (String#5195, DoABC#2)
// PlaneMaskManager = "_-Dt" (String#7949, DoABC#2)
// PlaneMask = "_-1y-" (String#5993, DoABC#2)
// PlaneMaskVisualization = "_-7w" (String#7821, DoABC#2)
// _assetCollection = "_-2PR" (String#888, DoABC#2)
// initializeAssetCollection = "_-24a" (String#19205, DoABC#2)


