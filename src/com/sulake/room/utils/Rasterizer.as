
package com.sulake.room.utils
{
    import flash.display.BitmapData;
    import flash.geom.Point;
    import flash.geom.Matrix;

    public class Rasterizer 
    {

        public static function line(_arg_1:BitmapData, _arg_2:Point, _arg_3:Point, _arg_4:int):void
        {
            var _local_5:int;
            var _local_6:int;
            var _local_7:int;
            var _local_8:int;
            var _local_9:int;
            var _local_10:int;
            var _local_11:int = _arg_2.x;
            var _local_12:int = _arg_2.y;
            _local_5 = (_arg_3.x - _arg_2.x);
            _local_6 = (_arg_3.y - _arg_2.y);
            _local_8 = (((_local_5)>0) ? 1 : -1);
            _local_9 = (((_local_6)>0) ? 1 : -1);
            _local_5 = Math.abs(_local_5);
            _local_6 = Math.abs(_local_6);
            _arg_1.lock();
            _arg_1.setPixel32(_local_11, _local_12, _arg_4);
            if ((((_local_5 == 0)) && ((_local_6 == 0)))){
                return;
            };
            if (_local_5 > _local_6){
                _local_7 = (_local_5 - 1);
                while (_local_7 >= 0) {
                    _local_10 = (_local_10 + _local_6);
                    _local_11 = (_local_11 + _local_8);
                    if (_local_10 >= (_local_5 / 2)){
                        _local_10 = (_local_10 - _local_5);
                        _local_12 = (_local_12 + _local_9);
                    };
                    _arg_1.setPixel32(_local_11, _local_12, _arg_4);
                    _local_7--;
                };
            }
            else {
                _local_7 = (_local_6 - 1);
                while (_local_7 >= 0) {
                    _local_10 = (_local_10 + _local_5);
                    _local_12 = (_local_12 + _local_9);
                    if (_local_10 >= (_local_6 / 2)){
                        _local_10 = (_local_10 - _local_6);
                        _local_11 = (_local_11 + _local_8);
                    };
                    _arg_1.setPixel32(_local_11, _local_12, _arg_4);
                    _local_7--;
                };
            };
            _arg_1.setPixel32(_arg_3.x, _arg_3.y, _arg_4);
            _arg_1.unlock();
        }
        public static function getFlipHBitmapData(_arg_1:BitmapData):BitmapData
        {
            if (_arg_1 == null){
                return (null);
            };
            var _local_2:BitmapData;
            _local_2 = new BitmapData(_arg_1.width, _arg_1.height, true, 0xFFFFFF);
            var _local_3:Matrix = new Matrix();
            _local_3.scale(-1, 1);
            _local_3.translate(_arg_1.width, 0);
            _local_2.draw(_arg_1, _local_3);
            return (_local_2);
        }
        public static function getFlipVBitmapData(_arg_1:BitmapData):BitmapData
        {
            if (_arg_1 == null){
                return (null);
            };
            var _local_2:BitmapData;
            _local_2 = new BitmapData(_arg_1.width, _arg_1.height, true, 0xFFFFFF);
            var _local_3:Matrix = new Matrix();
            _local_3.scale(1, -1);
            _local_3.translate(0, _arg_1.height);
            _local_2.draw(_arg_1, _local_3);
            return (_local_2);
        }
        public static function getFlipHVBitmapData(_arg_1:BitmapData):BitmapData
        {
            if (_arg_1 == null){
                return (null);
            };
            var _local_2:BitmapData;
            _local_2 = new BitmapData(_arg_1.width, _arg_1.height, true, 0xFFFFFF);
            var _local_3:Matrix = new Matrix();
            _local_3.scale(-1, -1);
            _local_3.translate(_arg_1.width, _arg_1.height);
            _local_2.draw(_arg_1, _local_3);
            return (_local_2);
        }

    }
}//package com.sulake.room.utils

// getFlipVBitmapData = "_-vn" (String#24520, DoABC#2)
// getFlipHVBitmapData = "_-2RA" (String#20090, DoABC#2)
// getFlipHBitmapData = "_-Gl" (String#22880, DoABC#2)
// Rasterizer = "_-jl" (String#8595, DoABC#2)


