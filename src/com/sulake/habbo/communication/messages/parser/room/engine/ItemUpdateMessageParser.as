
package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ItemMessageData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ItemUpdateMessageParser implements IMessageParser 
    {

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var _SafeStr_3764:ItemMessageData = null;

        public function get roomId():int
        {
            return (this._roomId);
        }
        public function get roomCategory():int
        {
            return (this._roomCategory);
        }
        public function flush():Boolean
        {
            this._SafeStr_3764 = null;
            this._roomId = 0;
            this._roomCategory = 0;
            return (true);
        }
        public function get data():ItemMessageData
        {
            var _local_1:ItemMessageData = this._SafeStr_3764;
            if (_local_1 != null){
                _local_1.setReadOnly();
            };
            return (_local_1);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            if (_arg_1 == null){
                return (false);
            };
            this._SafeStr_3764 = ItemDataParser.parseItemData(_arg_1);
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.room.engine

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// ItemUpdateMessageParser = "_-1-a" (String#4859, DoABC#2)
// ItemMessageData = "_-1Nr" (String#5309, DoABC#2)
// ItemDataParser = "_-15y" (String#4993, DoABC#2)
// setReadOnly = "_-5p" (String#22456, DoABC#2)
// _SafeStr_3764 = "_-1eS" (String#609, DoABC#2)
// parseItemData = "_-34d" (String#7401, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


