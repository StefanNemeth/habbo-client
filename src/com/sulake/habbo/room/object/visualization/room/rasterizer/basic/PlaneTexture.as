
package com.sulake.habbo.room.object.visualization.room.rasterizer.basic
{
    import flash.display.BitmapData;
    import com.sulake.room.utils.IVector3d;

    public class PlaneTexture 
    {

        public static const _SafeStr_12841:Number = -1;
        public static const MAX_NORMAL_COORDINATE_VALUE:Number = 1;

        private var _SafeStr_12848:Array;

        public function PlaneTexture()
        {
            this._SafeStr_12848 = [];
            super();
        }
        public function dispose():void
        {
            var _local_1:int;
            var _local_2:PlaneTextureBitmap;
            if (this._SafeStr_12848 != null){
                _local_1 = 0;
                while (_local_1 < this._SafeStr_12848.length) {
                    _local_2 = (this._SafeStr_12848[_local_1] as PlaneTextureBitmap);
                    if (_local_2 != null){
                        _local_2.dispose();
                    };
                    _local_1++;
                };
                this._SafeStr_12848 = null;
            };
        }
        public function addBitmap(_arg_1:BitmapData, _arg_2:Number=-1, _arg_3:Number=1, _arg_4:Number=-1, _arg_5:Number=1):void
        {
            var _local_6:PlaneTextureBitmap = new PlaneTextureBitmap(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
            this._SafeStr_12848.push(_local_6);
        }
        public function getBitmap(_arg_1:IVector3d):BitmapData
        {
            var _local_3:PlaneTextureBitmap;
            if (_arg_1 == null){
                return (null);
            };
            var _local_2:int;
            while (_local_2 < this._SafeStr_12848.length) {
                _local_3 = (this._SafeStr_12848[_local_2] as PlaneTextureBitmap);
                if (_local_3 != null){
                    if ((((((((_arg_1.x >= _local_3.normalMinX)) && ((_arg_1.x <= _local_3.normalMaxX)))) && ((_arg_1.y >= _local_3.normalMinY)))) && ((_arg_1.y <= _local_3.normalMaxY)))){
                        return (_local_3.bitmap);
                    };
                };
                _local_2++;
            };
            return (null);
        }

    }
}//package com.sulake.habbo.room.object.visualization.room.rasterizer.basic

// getBitmap = "_-0zS" (String#4837, DoABC#2)
// _SafeStr_12841 = "_-TR" (String#23383, DoABC#2)
// addBitmap = "_-0pF" (String#16025, DoABC#2)
// _SafeStr_12848 = "_-1I5" (String#5208, DoABC#2)
// IVector3d = "_-hf" (String#8547, DoABC#2)
// PlaneTexture = "_-1Us" (String#17699, DoABC#2)
// PlaneTextureBitmap = "_-38T" (String#7481, DoABC#2)


