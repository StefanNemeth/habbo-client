
package com.sulake.habbo.room.messages
{
    public class RoomObjectAvatarTypingUpdateMessage extends RoomObjectUpdateStateMessage 
    {

        private var _isTyping:Boolean;

        public function RoomObjectAvatarTypingUpdateMessage(_arg_1:Boolean=false)
        {
            this._isTyping = _arg_1;
        }
        public function get isTyping():Boolean
        {
            return (this._isTyping);
        }

    }
}//package com.sulake.habbo.room.messages

// RoomObjectUpdateStateMessage = "_-2WY" (String#6691, DoABC#2)
// RoomObjectAvatarTypingUpdateMessage = "_-2BI" (String#19455, DoABC#2)
// _isTyping = "_-2z6" (String#624, DoABC#2)
// isTyping = "_-1wh" (String#18831, DoABC#2)


