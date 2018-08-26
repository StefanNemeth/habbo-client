
package com.sulake.habbo.room.object.visualization.room.rasterizer.basic
{
    import flash.display.BitmapData;

    public class PlaneTextureBitmap 
    {

        public static const _SafeStr_12841:Number = -1;
        public static const MAX_NORMAL_COORDINATE_VALUE:Number = 1;

        private var _bitmap:BitmapData = null;
        private var _normalMinX:Number = -1;
        private var _normalMaxX:Number = 1;
        private var _normalMinY:Number = -1;
        private var _normalMaxY:Number = 1;

        public function PlaneTextureBitmap(_arg_1:BitmapData, _arg_2:Number=-1, _arg_3:Number=1, _arg_4:Number=-1, _arg_5:Number=1)
        {
            this._normalMinX = _arg_2;
            this._normalMaxX = _arg_3;
            this._normalMinY = _arg_4;
            this._normalMaxY = _arg_5;
            this._bitmap = _arg_1;
        }
        public function get bitmap():BitmapData
        {
            return (this._bitmap);
        }
        public function get normalMinX():Number
        {
            return (this._normalMinX);
        }
        public function get normalMaxX():Number
        {
            return (this._normalMaxX);
        }
        public function get normalMinY():Number
        {
            return (this._normalMinY);
        }
        public function get normalMaxY():Number
        {
            return (this._normalMaxY);
        }
        public function dispose():void
        {
            this._bitmap = null;
        }

    }
}//package com.sulake.habbo.room.object.visualization.room.rasterizer.basic

// _SafeStr_12841 = "_-TR" (String#23383, DoABC#2)
// _normalMinX = "_-pN" (String#2200, DoABC#2)
// _normalMinY = "_-0m-" (String#1544, DoABC#2)
// _normalMaxY = "_-2Ow" (String#1872, DoABC#2)
// PlaneTextureBitmap = "_-38T" (String#7481, DoABC#2)


