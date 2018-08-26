
package com.sulake.habbo.communication.messages.parser.notifications
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.utils.Map;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class UnseenItemsParser implements IMessageParser 
    {

        private var _items:Map;

        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_2:int;
            var _local_3:Array;
            var _local_6:int;
            var _local_7:int;
            this._items = new Map();
            var _local_4:int = _arg_1.readInteger();
            var _local_5:int;
            while (_local_5 < _local_4) {
                _local_2 = _arg_1.readInteger();
                _local_3 = [];
                _local_6 = _arg_1.readInteger();
                _local_7 = 0;
                while (_local_7 < _local_6) {
                    _local_3.push(_arg_1.readInteger());
                    _local_7++;
                };
                this._items.add(_local_2, _local_3);
                _local_5++;
            };
            return (true);
        }
        public function getCategories():Array
        {
            return (this._items.getKeys());
        }
        public function getItemsByCategory(_arg_1:int):Array
        {
            return (this._items.getValue(_arg_1));
        }

    }
}//package com.sulake.habbo.communication.messages.parser.notifications

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// UnseenItemsParser = "_-185" (String#16780, DoABC#2)
// getCategories = "_-3E" (String#22033, DoABC#2)
// getItemsByCategory = "_-1Md" (String#17385, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


