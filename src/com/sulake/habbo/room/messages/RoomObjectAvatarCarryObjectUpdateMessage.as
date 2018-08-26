
package com.sulake.habbo.room.messages
{
    public class RoomObjectAvatarCarryObjectUpdateMessage extends RoomObjectUpdateStateMessage 
    {

        private var _itemType:int;
        private var _itemName:String;

        public function RoomObjectAvatarCarryObjectUpdateMessage(_arg_1:int, _arg_2:String)
        {
            this._itemType = _arg_1;
            this._itemName = _arg_2;
        }
        public function get itemType():int
        {
            return (this._itemType);
        }
        public function get itemName():String
        {
            return (this._itemName);
        }

    }
}//package com.sulake.habbo.room.messages

// RoomObjectUpdateStateMessage = "_-2WY" (String#6691, DoABC#2)
// RoomObjectAvatarCarryObjectUpdateMessage = "_-ft" (String#23885, DoABC#2)
// _itemType = "_-0dA" (String#242, DoABC#2)
// itemType = "_-De" (String#22756, DoABC#2)
// _itemName = "_-IX" (String#8051, DoABC#2)
// itemName = "_-1cf" (String#17996, DoABC#2)


