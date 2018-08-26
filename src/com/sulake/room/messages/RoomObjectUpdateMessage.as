
package com.sulake.room.messages
{
    import com.sulake.room.utils.IVector3d;

    public class RoomObjectUpdateMessage 
    {

        protected var _loc:IVector3d;
        protected var _dir:IVector3d;

        public function RoomObjectUpdateMessage(_arg_1:IVector3d, _arg_2:IVector3d)
        {
            this._loc = _arg_1;
            this._dir = _arg_2;
        }
        public function get loc():IVector3d
        {
            return (this._loc);
        }
        public function get dir():IVector3d
        {
            return (this._dir);
        }

    }
}//package com.sulake.room.messages

// IVector3d = "_-hf" (String#8547, DoABC#2)
// RoomObjectUpdateMessage = "_-73" (String#22503, DoABC#2)
// _dir = "_-1kY" (String#187, DoABC#2)
// _loc = "_-0OE" (String#185, DoABC#2)
// loc = "_-0fh" (String#15660, DoABC#2)


