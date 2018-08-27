
package com.sulake.habbo.room.object.visualization.room.rasterizer.basic
{
    import flash.display.BitmapData;
    import com.sulake.room.object.visualization.utils.IGraphicAsset;
    import flash.geom.Point;
    import com.sulake.room.utils.IVector3d;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.geom.Matrix;
    import com.sulake.habbo.room.object.visualization.room.utils.Randomizer;

    public class PlaneMaterialCell 
    {

        private var _SafeStr_12879:BitmapData = null;
        private var _SafeStr_12880:PlaneTexture;
        private var _extraItemOffsets:Array;
        private var _SafeStr_12881:Array;
        private var _SafeStr_12882:int = 0;

        public function PlaneMaterialCell(_arg_1:PlaneTexture, _arg_2:Array=null, _arg_3:Array=null, _arg_4:int=0)
        {
            var _local_5:int;
            var _local_6:IGraphicAsset;
            var _local_7:Point;
            this._extraItemOffsets = [];
            this._SafeStr_12881 = [];
            super();
            this._SafeStr_12880 = _arg_1;
            if (((((!((_arg_2 == null))) && ((_arg_2.length > 0)))) && ((_arg_4 > 0)))){
                _local_5 = 0;
                _local_5 = 0;
                while (_local_5 < _arg_2.length) {
                    _local_6 = (_arg_2[_local_5] as IGraphicAsset);
                    if (_local_6 != null){
                        this._SafeStr_12881.push(_local_6);
                    };
                    _local_5++;
                };
                if (this._SafeStr_12881.length > 0){
                    if (_arg_3 != null){
                        _local_5 = 0;
                        while (_local_5 < _arg_3.length) {
                            _local_7 = (_arg_3[_local_5] as Point);
                            if (_local_7 != null){
                                this._extraItemOffsets.push(new Point(_local_7.x, _local_7.y));
                            };
                            _local_5++;
                        };
                    };
                    this._SafeStr_12882 = _arg_4;
                };
            };
        }
        public function get isStatic():Boolean
        {
            return ((this._SafeStr_12882 == 0));
        }
        public function dispose():void
        {
            if (this._SafeStr_12880 != null){
                this._SafeStr_12880.dispose();
                this._SafeStr_12880 = null;
            };
            if (this._SafeStr_12879 != null){
                this._SafeStr_12879.dispose();
                this._SafeStr_12879 = null;
            };
            this._SafeStr_12881 = null;
            this._extraItemOffsets = null;
        }
        public function clearCache():void
        {
            if (this._SafeStr_12879 != null){
                this._SafeStr_12879.dispose();
                this._SafeStr_12879 = null;
            };
        }
        public function getHeight(_arg_1:IVector3d):int
        {
            var _local_2:BitmapData;
            if (this._SafeStr_12880 != null){
                _local_2 = this._SafeStr_12880.getBitmap(_arg_1);
                if (_local_2 != null){
                    return (_local_2.height);
                };
            };
            return (0);
        }
        public function render(_arg_1:IVector3d):BitmapData
        {
            var _local_2:BitmapData;
            var _local_3:int;
            var _local_4:int;
            var _local_5:Array;
            var _local_6:int;
            var _local_7:Point;
            var _local_8:IGraphicAsset;
            var _local_9:BitmapDataAsset;
            var _local_10:BitmapData;
            var _local_11:Point;
            var _local_12:Matrix;
            var _local_13:Number;
            var _local_14:Number;
            var _local_15:Number;
            var _local_16:Number;
            var _local_17:int;
            if (this._SafeStr_12880 != null){
                _local_2 = this._SafeStr_12880.getBitmap(_arg_1);
                if (_local_2 != null){
                    if (!this.isStatic){
                        if (this._SafeStr_12879 != null){
                            if (((!((this._SafeStr_12879.width == _local_2.width))) || (!((this._SafeStr_12879.height == _local_2.height))))){
                                this._SafeStr_12879.dispose();
                                this._SafeStr_12879 = null;
                            }
                            else {
                                this._SafeStr_12879.copyPixels(_local_2, _local_2.rect, new Point(0, 0));
                            };
                        };
                        if (this._SafeStr_12879 == null){
                            this._SafeStr_12879 = _local_2.clone();
                        };
                        _local_3 = Math.min(this._SafeStr_12882, this._extraItemOffsets.length);
                        _local_4 = Math.max(this._SafeStr_12882, this._extraItemOffsets.length);
                        _local_5 = Randomizer.getArray(this._SafeStr_12882, _local_4);
                        _local_6 = 0;
                        while (_local_6 < _local_3) {
                            _local_7 = (this._extraItemOffsets[_local_5[_local_6]] as Point);
                            _local_8 = (this._SafeStr_12881[(_local_6 % this._SafeStr_12881.length)] as IGraphicAsset);
                            if (((!((_local_7 == null))) && (!((_local_8 == null))))){
                                _local_9 = (_local_8.asset as BitmapDataAsset);
                                if (_local_9 != null){
                                    _local_10 = (_local_9.content as BitmapData);
                                    if (_local_10 != null){
                                        _local_11 = new Point((_local_7.x + _local_8.offsetX), (_local_7.y + _local_8.offsetY));
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
                                        _local_17 = (_local_11.x + _local_15);
                                        _local_17 = ((_local_17 >> 1) << 1);
                                        _local_12.scale(_local_13, _local_14);
                                        _local_12.translate(_local_17, (_local_11.y + _local_16));
                                        this._SafeStr_12879.draw(_local_10, _local_12);
                                    };
                                };
                            };
                            _local_6++;
                        };
                        return (this._SafeStr_12879);
                    };
                    return (_local_2);
                };
            };
            return (null);
        }

    }
}//package com.sulake.habbo.room.object.visualization.room.rasterizer.basic

// getBitmap = "_-0zS" (String#4837, DoABC#2)
// _SafeStr_12879 = "_-3BZ" (String#917, DoABC#2)
// _SafeStr_12880 = "_-1Yy" (String#17850, DoABC#2)
// _SafeStr_12881 = "_-1GI" (String#17126, DoABC#2)
// _SafeStr_12882 = "_-Qa" (String#23270, DoABC#2)
// getHeight = "_-27v" (String#19326, DoABC#2)
// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// IVector3d = "_-hf" (String#8547, DoABC#2)
// IGraphicAsset = "_-1HF" (String#5195, DoABC#2)
// PlaneTexture = "_-1Us" (String#17699, DoABC#2)
// PlaneMaterialCell = "_-3G6" (String#7632, DoABC#2)
// Randomizer = "_-FS" (String#7982, DoABC#2)
// isStatic = "_-2HT" (String#19704, DoABC#2)
// getArray = "_-fJ" (String#23860, DoABC#2)


