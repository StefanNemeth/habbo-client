
package com.sulake.habbo.room.messages
{
    import com.sulake.room.messages.RoomObjectUpdateMessage;

    public class RoomObjectDataUpdateMessage extends RoomObjectUpdateMessage 
    {

        private var _state:int;
        private var _data:String;
        private var _extra:Number = NaN;

        public function RoomObjectDataUpdateMessage(_arg_1:int, _arg_2:String, _arg_3:Number=NaN)
        {
            super(null, null);
            this._state = _arg_1;
            this._data = _arg_2;
            this._extra = _arg_3;
        }
        public function get state():int
        {
            return (this._state);
        }
        public function get data():String
        {
            return (this._data);
        }
        public function get extra():Number
        {
            return (this._extra);
        }

    }
}//package com.sulake.habbo.room.messages

// RoomObjectUpdateMessage = "_-73" (String#22503, DoABC#2)
// RoomObjectDataUpdateMessage = "_-2N4" (String#19928, DoABC#2)
// extra = "_-2We" (String#6693, DoABC#2)
// _extra = "_-2Rq" (String#246, DoABC#2)


