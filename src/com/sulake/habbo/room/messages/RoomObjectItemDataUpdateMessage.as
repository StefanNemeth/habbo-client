
package com.sulake.habbo.room.messages
{
    import com.sulake.room.messages.RoomObjectUpdateMessage;

    public class RoomObjectItemDataUpdateMessage extends RoomObjectUpdateMessage 
    {

        private var _itemData:String;

        public function RoomObjectItemDataUpdateMessage(_arg_1:String)
        {
            super(null, null);
            this._itemData = _arg_1;
        }
        public function get itemData():String
        {
            return (this._itemData);
        }

    }
}//package com.sulake.habbo.room.messages

// RoomObjectUpdateMessage = "_-73" (String#22503, DoABC#2)
// RoomObjectItemDataUpdateMessage = "_-1yC" (String#18895, DoABC#2)
// _itemData = "_-0uj" (String#4739, DoABC#2)
// itemData = "_-1S3" (String#17584, DoABC#2)


