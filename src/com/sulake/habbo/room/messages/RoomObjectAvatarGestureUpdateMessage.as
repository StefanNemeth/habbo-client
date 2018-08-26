
package com.sulake.habbo.room.messages
{
    public class RoomObjectAvatarGestureUpdateMessage extends RoomObjectUpdateStateMessage 
    {

        private var _gesture:int = 0;

        public function RoomObjectAvatarGestureUpdateMessage(_arg_1:int)
        {
            this._gesture = _arg_1;
        }
        public function get gesture():int
        {
            return (this._gesture);
        }

    }
}//package com.sulake.habbo.room.messages

// RoomObjectUpdateStateMessage = "_-2WY" (String#6691, DoABC#2)
// RoomObjectAvatarGestureUpdateMessage = "_-2NZ" (String#19946, DoABC#2)
// _gesture = "_-2tH" (String#452, DoABC#2)


