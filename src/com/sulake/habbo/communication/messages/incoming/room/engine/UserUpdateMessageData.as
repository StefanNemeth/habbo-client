
package com.sulake.habbo.communication.messages.incoming.room.engine
{
    public class UserUpdateMessageData 
    {

        private var _id:int = 0;
        private var _x:Number = 0;
        private var _y:Number = 0;
        private var _z:Number = 0;
        private var _localZ:Number = 0;
        private var _targetX:Number = 0;
        private var _targetY:Number = 0;
        private var _targetZ:Number = 0;
        private var _dir:int = 0;
        private var _dirHead:int = 0;
        private var _SafeStr_5141:Array;
        private var _isMoving:Boolean = false;

        public function UserUpdateMessageData(_arg_1:int, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:int, _arg_7:int, _arg_8:Number, _arg_9:Number, _arg_10:Number, _arg_11:Boolean, _arg_12:Array)
        {
            this._SafeStr_5141 = [];
            super();
            this._id = _arg_1;
            this._x = _arg_2;
            this._y = _arg_3;
            this._z = _arg_4;
            this._localZ = _arg_5;
            this._dir = _arg_6;
            this._dirHead = _arg_7;
            this._targetX = _arg_8;
            this._targetY = _arg_9;
            this._targetZ = _arg_10;
            this._isMoving = _arg_11;
            this._SafeStr_5141 = _arg_12;
        }
        public function get id():int
        {
            return (this._id);
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
        public function get localZ():Number
        {
            return (this._localZ);
        }
        public function get targetX():Number
        {
            return (this._targetX);
        }
        public function get targetY():Number
        {
            return (this._targetY);
        }
        public function get targetZ():Number
        {
            return (this._targetZ);
        }
        public function get dir():int
        {
            return (this._dir);
        }
        public function get dirHead():int
        {
            return (this._dirHead);
        }
        public function get isMoving():Boolean
        {
            return (this._isMoving);
        }
        public function get actions():Array
        {
            return (this._SafeStr_5141.slice());
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.engine

// UserUpdateMessageData = "_-2GW" (String#6378, DoABC#2)
// _y = "_-02f" (String#64, DoABC#2)
// _dir = "_-1kY" (String#187, DoABC#2)
// _z = "_-0kf" (String#215, DoABC#2)
// _localZ = "_-1b4" (String#17937, DoABC#2)
// _targetX = "_-2TK" (String#20177, DoABC#2)
// _targetY = "_-35L" (String#21707, DoABC#2)
// _targetZ = "_-0BW" (String#14506, DoABC#2)
// _dirHead = "_-209" (String#6050, DoABC#2)
// _SafeStr_5141 = "_-32J" (String#626, DoABC#2)
// _isMoving = "_-36T" (String#21746, DoABC#2)
// localZ = "_-qW" (String#24293, DoABC#2)
// targetX = "_-1J9" (String#17243, DoABC#2)
// targetY = "_-3HE" (String#22172, DoABC#2)
// targetZ = "_-0iJ" (String#15764, DoABC#2)
// dirHead = "_-2Ej" (String#19594, DoABC#2)
// isMoving = "_-2Cl" (String#19515, DoABC#2)


