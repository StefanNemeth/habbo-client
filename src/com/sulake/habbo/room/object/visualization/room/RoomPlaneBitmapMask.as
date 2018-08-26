
package com.sulake.habbo.room.object.visualization.room
{
    public class RoomPlaneBitmapMask 
    {

        private var _type:String = null;
        private var _leftSideLoc:Number = 0;
        private var _rightSideLoc:Number = 0;

        public function RoomPlaneBitmapMask(_arg_1:String, _arg_2:Number, _arg_3:Number)
        {
            this._type = _arg_1;
            this._leftSideLoc = _arg_2;
            this._rightSideLoc = _arg_3;
        }
        public function get type():String
        {
            return (this._type);
        }
        public function get leftSideLoc():Number
        {
            return (this._leftSideLoc);
        }
        public function get rightSideLoc():Number
        {
            return (this._rightSideLoc);
        }

    }
}//package com.sulake.habbo.room.object.visualization.room

// rightSideLoc = "_-0jZ" (String#15810, DoABC#2)
// leftSideLoc = "_-38V" (String#21822, DoABC#2)
// _leftSideLoc = "_-X2" (String#2126, DoABC#2)
// _rightSideLoc = "_-2v" (String#1962, DoABC#2)
// RoomPlaneBitmapMask = "_-Nl" (String#8160, DoABC#2)


