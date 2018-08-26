
package com.sulake.habbo.room.messages
{
    public class RoomObjectAvatarPetGestureUpdateMessage extends RoomObjectUpdateStateMessage 
    {

        private var _gesture:String;

        public function RoomObjectAvatarPetGestureUpdateMessage(_arg_1:String)
        {
            this._gesture = _arg_1;
        }
        public function get gesture():String
        {
            return (this._gesture);
        }

    }
}//package com.sulake.habbo.room.messages

// RoomObjectUpdateStateMessage = "_-2WY" (String#6691, DoABC#2)
// RoomObjectAvatarPetGestureUpdateMessage = "_-3N" (String#22353, DoABC#2)
// _gesture = "_-2tH" (String#452, DoABC#2)


