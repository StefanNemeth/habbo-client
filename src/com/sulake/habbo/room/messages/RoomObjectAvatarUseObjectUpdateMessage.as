
package com.sulake.habbo.room.messages
{
    public class RoomObjectAvatarUseObjectUpdateMessage extends RoomObjectUpdateStateMessage 
    {

        private var _itemType:int;

        public function RoomObjectAvatarUseObjectUpdateMessage(_arg_1:int)
        {
            this._itemType = _arg_1;
        }
        public function get itemType():int
        {
            return (this._itemType);
        }

    }
}//package com.sulake.habbo.room.messages

// RoomObjectUpdateStateMessage = "_-2WY" (String#6691, DoABC#2)
// RoomObjectAvatarUseObjectUpdateMessage = "_-2HN" (String#19699, DoABC#2)
// _itemType = "_-0dA" (String#242, DoABC#2)
// itemType = "_-De" (String#22756, DoABC#2)


