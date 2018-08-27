
package com.sulake.habbo.room.events
{
    public class RoomEngineObjectPlacedEvent extends RoomEngineObjectEvent 
    {

        private var _wallLocation:String = "";
        private var _x:Number = 0;
        private var _y:Number = 0;
        private var _z:Number = 0;
        private var _direction:int = 0;
        private var _placedInRoom:Boolean = false;
        private var _placedOnFloor:Boolean = false;
        private var _placedOnWall:Boolean = false;
        private var _instanceData:String = null;

        public function RoomEngineObjectPlacedEvent(_arg_1:String, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:String, _arg_7:Number, _arg_8:Number, _arg_9:Number, _arg_10:int, _arg_11:Boolean, _arg_12:Boolean, _arg_13:Boolean, _arg_14:String, _arg_15:Boolean=false, _arg_16:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_15, _arg_16);
            this._wallLocation = _arg_6;
            this._x = _arg_7;
            this._y = _arg_8;
            this._z = _arg_9;
            this._direction = _arg_10;
            this._placedInRoom = _arg_11;
            this._placedOnFloor = _arg_12;
            this._placedOnWall = _arg_13;
            this._instanceData = _arg_14;
        }
        public function get wallLocation():String
        {
            return (this._wallLocation);
        }
        public function get x():Number
        {
            return (this._x);
        }
        public function get y():Number
        {
            return (this._y);
        }
        public function get z():Number
        {
            return (this._z);
        }
        public function get direction():int
        {
            return (this._direction);
        }
        public function get placedInRoom():Boolean
        {
            return (this._placedInRoom);
        }
        public function get placedOnFloor():Boolean
        {
            return (this._placedOnFloor);
        }
        public function get placedOnWall():Boolean
        {
            return (this._placedOnWall);
        }
        public function get instanceData():String
        {
            return (this._instanceData);
        }

    }
}//package com.sulake.habbo.room.events

// RoomEngineObjectEvent = "_-10r" (String#16492, DoABC#2)
// RoomEngineObjectPlacedEvent = "_-2zd" (String#21445, DoABC#2)
// _wallLocation = "_-1p1" (String#1763, DoABC#2)
// _y = "_-02f" (String#64, DoABC#2)
// _z = "_-0kf" (String#215, DoABC#2)
// wallLocation = "_-12C" (String#16544, DoABC#2)
// _placedInRoom = "_-07y" (String#14363, DoABC#2)
// _placedOnFloor = "_-1Tz" (String#17665, DoABC#2)
// _placedOnWall = "_-gA" (String#23899, DoABC#2)
// _instanceData = "_-0ui" (String#4738, DoABC#2)
// placedInRoom = "_-1ZC" (String#17861, DoABC#2)
// placedOnFloor = "_-1pD" (String#18509, DoABC#2)
// placedOnWall = "_-1Oh" (String#17457, DoABC#2)


