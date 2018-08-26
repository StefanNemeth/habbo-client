
package com.sulake.habbo.room.object.visualization.room.utils
{
    import flash.display.BitmapData;

    public class PlaneBitmapData 
    {

        private var _bitmap:BitmapData = null;
        private var _timeStamp:int = 0;

        public function PlaneBitmapData(_arg_1:BitmapData, _arg_2:int)
        {
            this._bitmap = _arg_1;
            this._timeStamp = _arg_2;
        }
        public function get bitmap():BitmapData
        {
            return (this._bitmap);
        }
        public function get timeStamp():int
        {
            return (this._timeStamp);
        }
        public function dispose():void
        {
            this._bitmap = null;
        }

    }
}//package com.sulake.habbo.room.object.visualization.room.utils

// PlaneBitmapData = "_-2Mg" (String#6493, DoABC#2)
// _timeStamp = "_-1IA" (String#845, DoABC#2)


