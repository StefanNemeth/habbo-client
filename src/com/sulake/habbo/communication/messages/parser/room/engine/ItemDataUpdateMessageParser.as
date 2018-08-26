
package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ItemDataUpdateMessageParser implements IMessageParser 
    {

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var _id:int = 0;
        private var _itemData:String;

        public function get roomId():int
        {
            return (this._roomId);
        }
        public function get roomCategory():int
        {
            return (this._roomCategory);
        }
        public function get id():int
        {
            return (this._id);
        }
        public function get itemData():String
        {
            return (this._itemData);
        }
        public function flush():Boolean
        {
            this._id = 0;
            this._itemData = "";
            this._roomId = 0;
            this._roomCategory = 0;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            if (_arg_1 == null){
                return (false);
            };
            var _local_2:String = _arg_1.readString();
            this._id = int(_local_2);
            this._itemData = _arg_1.readString();
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.room.engine

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// ItemDataUpdateMessageParser = "_-0t7" (String#4709, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// _itemData = "_-0uj" (String#4739, DoABC#2)
// itemData = "_-1S3" (String#17584, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


