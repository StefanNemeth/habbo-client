
package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ItemMessageData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ItemsMessageParser implements IMessageParser 
    {

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var _items:Array;

        public function ItemsMessageParser()
        {
            this._items = [];
            super();
        }
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
            this._items = [];
            this._roomId = 0;
            this._roomCategory = 0;
            return (true);
        }
        public function getItemCount():int
        {
            return (this._items.length);
        }
        public function getItem(_arg_1:int):ItemMessageData
        {
            if ((((_arg_1 < 0)) || ((_arg_1 >= this.getItemCount())))){
                return (null);
            };
            var _local_2:ItemMessageData = (this._items[_arg_1] as ItemMessageData);
            if (_local_2 != null){
                _local_2.setReadOnly();
            };
            return (_local_2);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            if (_arg_1 == null){
                return (false);
            };
            this._items = [];
            var _local_2:int = _arg_1.readInteger();
            Logger.log((("We have: " + _local_2) + " items"));
            var _local_3:int;
            while (_local_3 < _local_2) {
                this._items.push(ItemDataParser.parseItemData(_arg_1));
                _local_3++;
            };
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.room.engine

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// ItemMessageData = "_-1Nr" (String#5309, DoABC#2)
// ItemsMessageParser = "_-0XF" (String#4254, DoABC#2)
// ItemDataParser = "_-15y" (String#4993, DoABC#2)
// setReadOnly = "_-5p" (String#22456, DoABC#2)
// parseItemData = "_-34d" (String#7401, DoABC#2)
// getItemCount = "_-1vN" (String#18772, DoABC#2)
// getItem = "_-0un" (String#16229, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


