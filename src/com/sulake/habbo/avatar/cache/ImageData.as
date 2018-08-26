
package com.sulake.habbo.avatar.cache
{
    import flash.display.BitmapData;
    import flash.geom.Point;
    import flash.geom.Matrix;
    import flash.geom.Rectangle;

    public class ImageData 
    {

        private var _bitmap:BitmapData;
        private var _regpoint:Point;

        public function ImageData(_arg_1:BitmapData, _arg_2:Point, _arg_3:Boolean)
        {
            var _local_4:Matrix;
            var _local_5:BitmapData;
            super();
            this._regpoint = _arg_2;
            if (_arg_3){
                _local_4 = new Matrix(-1, 0, 0, 1, _arg_1.width, 0);
                _local_5 = new BitmapData(_arg_1.width, _arg_1.height, true, 0xFFFFFF);
                _local_5.draw(_arg_1, _local_4);
                this._regpoint.x = ((-1 * this._regpoint.x) + _arg_1.width);
                this._bitmap = _local_5;
                _arg_1.dispose();
            }
            else {
                this._bitmap = _arg_1;
            };
        }
        public function dispose():void
        {
            if (this._bitmap){
                this._bitmap.dispose();
            };
            this._bitmap = null;
            this._regpoint = null;
        }
        public function get bitmap():BitmapData
        {
            return (this._bitmap);
        }
        public function set bitmap(_arg_1:BitmapData):void
        {
            this._bitmap = _arg_1;
        }
        public function get regpoint():Point
        {
            return (this._regpoint);
        }
        public function get offsetRect():Rectangle
        {
            var _local_1:Rectangle = this._bitmap.rect.clone();
            _local_1.offset(-(this._regpoint.x), -(this._regpoint.y));
            return (_local_1);
        }

    }
}//package com.sulake.habbo.avatar.cache

// ImageData = "_-1z4" (String#6017, DoABC#2)
// regpoint = "_-3Dc" (String#22018, DoABC#2)
// offsetRect = "_-2sG" (String#21169, DoABC#2)
// _regpoint = "_-2Cn" (String#6299, DoABC#2)


