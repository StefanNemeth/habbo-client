
package com.sulake.habbo.room.messages
{
    public class RoomObjectAvatarSelectedMessage extends RoomObjectUpdateStateMessage 
    {

        private var _selected:Boolean;

        public function RoomObjectAvatarSelectedMessage(_arg_1:Boolean)
        {
            this._selected = _arg_1;
        }
        public function get selected():Boolean
        {
            return (this._selected);
        }

    }
}//package com.sulake.habbo.room.messages

// RoomObjectUpdateStateMessage = "_-2WY" (String#6691, DoABC#2)
// RoomObjectAvatarSelectedMessage = "_-1fk" (String#18125, DoABC#2)


