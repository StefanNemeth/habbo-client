
package com.sulake.habbo.room.events
{
    import com.sulake.room.events.RoomObjectMouseEvent;

    public class RoomObjectTileMouseEvent extends RoomObjectMouseEvent 
    {

        private var _tileX:Number;
        private var _tileY:Number;
        private var _tileZ:Number;

        public function RoomObjectTileMouseEvent(_arg_1:String, _arg_2:String, _arg_3:int, _arg_4:String, _arg_5:Number, _arg_6:Number, _arg_7:Number, _arg_8:Boolean=false, _arg_9:Boolean=false, _arg_10:Boolean=false, _arg_11:Boolean=false, _arg_12:Boolean=false, _arg_13:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_8, _arg_9, _arg_10, _arg_11, _arg_12, _arg_13);
            this._tileX = _arg_5;
            this._tileY = _arg_6;
            this._tileZ = _arg_7;
        }
        public function get tileX():Number
        {
            return (this._tileX);
        }
        public function get tileY():Number
        {
            return (this._tileY);
        }
        public function get tileZ():Number
        {
            return (this._tileZ);
        }

    }
}//package com.sulake.habbo.room.events

// RoomObjectMouseEvent = "_-20k" (String#19042, DoABC#2)
// RoomObjectTileMouseEvent = "_-0QU" (String#15080, DoABC#2)
// _tileX = "_-gB" (String#23900, DoABC#2)
// _tileY = "_-0Ym" (String#15391, DoABC#2)
// _tileZ = "_-16h" (String#16724, DoABC#2)
// tileX = "_-2UH" (String#20211, DoABC#2)
// tileY = "_-04c" (String#14226, DoABC#2)
// tileZ = "_-2Ii" (String#19757, DoABC#2)


