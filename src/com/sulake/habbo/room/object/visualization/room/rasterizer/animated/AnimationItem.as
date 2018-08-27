
package com.sulake.habbo.room.object.visualization.room.rasterizer.animated
{
    import flash.display.BitmapData;
    import flash.geom.Point;

    public class AnimationItem 
    {

        private var _x:Number = 0;
        private var _y:Number = 0;
        private var _SafeStr_4875:Number = 0;
        private var _SafeStr_4876:Number = 0;
        private var _bitmapData:BitmapData = null;

        public function AnimationItem(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:BitmapData)
        {
            this._x = _arg_1;
            this._y = _arg_2;
            this._SafeStr_4875 = _arg_3;
            this._SafeStr_4876 = _arg_4;
            if (isNaN(this._x)){
                this._x = 0;
            };
            if (isNaN(this._y)){
                this._y = 0;
            };
            if (isNaN(this._SafeStr_4875)){
                this._SafeStr_4875 = 0;
            };
            if (isNaN(this._SafeStr_4876)){
                this._SafeStr_4876 = 0;
            };
            this._bitmapData = _arg_5;
        }
        public function get bitmapData():BitmapData
        {
            return (this._bitmapData);
        }
        public function dispose():void
        {
            this._bitmapData = null;
        }
        public function getPosition(_arg_1:int, _arg_2:int, _arg_3:Number, _arg_4:Number, _arg_5:int):Point
        {
            var _local_6:Number = this._x;
            var _local_7:Number = this._y;
            if (_arg_3 > 0){
                _local_6 = (_local_6 + (((this._SafeStr_4875 / _arg_3) * _arg_5) / 1000));
            };
            if (_arg_4 > 0){
                _local_7 = (_local_7 + (((this._SafeStr_4876 / _arg_4) * _arg_5) / 1000));
            };
            var _local_8:int = ((_local_6 % 1) * _arg_1);
            var _local_9:int = ((_local_7 % 1) * _arg_2);
            return (new Point(_local_8, _local_9));
        }

    }
}//package com.sulake.habbo.room.object.visualization.room.rasterizer.animated

// AnimationItem = "_-zq" (String#8879, DoABC#2)
// _y = "_-02f" (String#64, DoABC#2)
// getPosition = "_-GB" (String#7997, DoABC#2)
// _SafeStr_4875 = "_-7J" (String#22515, DoABC#2)
// _SafeStr_4876 = "_-E6" (String#22776, DoABC#2)


