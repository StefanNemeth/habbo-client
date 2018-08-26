
package com.sulake.habbo.communication.messages.parser.help
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.utils.Map;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FaqSearchResultsMessageParser implements IMessageParser 
    {

        private var _data:Map;

        public function get data():Map
        {
            return (this._data);
        }
        public function flush():Boolean
        {
            if (this._data != null){
                this._data.dispose();
            };
            this._data = null;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_2:int;
            var _local_3:String;
            this._data = new Map();
            var _local_4:int = _arg_1.readInteger();
            var _local_5:int;
            while (_local_5 < _local_4) {
                _local_2 = _arg_1.readInteger();
                _local_3 = _arg_1.readString();
                this._data.add(_local_2, _local_3);
                _local_5++;
            };
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.help

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// FaqSearchResultsMessageParser = "_-0wG" (String#4775, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


