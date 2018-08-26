
package com.sulake.habbo.room.object
{
    public class RoomStairData 
    {

        private var _stairHeight:int;
        private var _neighbourStairMin:Boolean;
        private var _neighbourStairMax:Boolean;
        private var _border:Boolean;

        public function RoomStairData(_arg_1:int, _arg_2:Boolean, _arg_3:Boolean, _arg_4:Boolean)
        {
            this._border = _arg_4;
            this._stairHeight = _arg_1;
            this._neighbourStairMin = _arg_2;
            this._neighbourStairMax = _arg_3;
        }
        public function get stairHeight():int
        {
            return (this._stairHeight);
        }
        public function get neighbourStairMin():Boolean
        {
            return (this._neighbourStairMin);
        }
        public function get neighbourStairMax():Boolean
        {
            return (this._neighbourStairMax);
        }
        public function get neighbourStair():Boolean
        {
            return (((this._neighbourStairMin) || (this._neighbourStairMax)));
        }
        public function get border():Boolean
        {
            return (this._border);
        }

    }
}//package com.sulake.habbo.room.object

// stairHeight = "_-1bE" (String#17944, DoABC#2)
// neighbourStairMax = "_-2p7" (String#21046, DoABC#2)
// neighbourStairMin = "_-13E" (String#16589, DoABC#2)
// neighbourStair = "_-2GD" (String#19651, DoABC#2)
// _stairHeight = "_-qc" (String#24297, DoABC#2)
// _neighbourStairMin = "_-T4" (String#23369, DoABC#2)
// _neighbourStairMax = "_-0RJ" (String#15114, DoABC#2)
// _border = "_-0NB" (String#815, DoABC#2)
// RoomStairData = "_-2Ev" (String#6341, DoABC#2)


