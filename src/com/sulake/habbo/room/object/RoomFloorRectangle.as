
package com.sulake.habbo.room.object
{
    public class RoomFloorRectangle 
    {

        private var _left:int;
        private var _top:int;
        private var _right:int;
        private var _bottom:int;
        private var _altitude:Number;

        public function RoomFloorRectangle(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:Number)
        {
            this._left = _arg_1;
            this._top = _arg_2;
            this._right = _arg_3;
            this._bottom = _arg_4;
            this._altitude = _arg_5;
        }
        public function get left():int
        {
            return (this._left);
        }
        public function get top():int
        {
            return (this._top);
        }
        public function get right():int
        {
            return (this._right);
        }
        public function get bottom():int
        {
            return (this._bottom);
        }
        public function get altitude():Number
        {
            return (this._altitude);
        }

    }
}//package com.sulake.habbo.room.object

// altitude = "_-1QD" (String#17518, DoABC#2)
// _altitude = "_-Fk" (String#22840, DoABC#2)
// RoomFloorRectangle = "_-2lN" (String#6987, DoABC#2)
// _left = "_-iR" (String#8567, DoABC#2)
// _bottom = "_-0nY" (String#4581, DoABC#2)


