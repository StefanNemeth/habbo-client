
package com.sulake.habbo.communication.messages.parser.help
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.utils.Map;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FaqClientFaqsMessageParser implements IMessageParser 
    {

        private var _urgentData:Map;
        private var _normalData:Map;

        public function get urgentData():Map
        {
            return (this._urgentData);
        }
        public function get normalData():Map
        {
            return (this._normalData);
        }
        public function flush():Boolean
        {
            if (this._urgentData != null){
                this._urgentData.dispose();
            };
            this._urgentData = null;
            if (this._normalData != null){
                this._normalData.dispose();
            };
            this._normalData = null;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_2:int;
            var _local_3:String;
            var _local_4:int;
            var _local_5:int;
            this._urgentData = new Map();
            this._normalData = new Map();
            _local_5 = _arg_1.readInteger();
            _local_4 = 0;
            while (_local_4 < _local_5) {
                _local_2 = _arg_1.readInteger();
                _local_3 = _arg_1.readString();
                this._urgentData.add(_local_2, _local_3);
                _local_4++;
            };
            _local_5 = _arg_1.readInteger();
            _local_4 = 0;
            while (_local_4 < _local_5) {
                _local_2 = _arg_1.readInteger();
                _local_3 = _arg_1.readString();
                this._normalData.add(_local_2, _local_3);
                _local_4++;
            };
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.help

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// FaqClientFaqsMessageParser = "_-2iS" (String#6919, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// _urgentData = "_-0wI" (String#16284, DoABC#2)
// _normalData = "_-1Zi" (String#17879, DoABC#2)
// urgentData = "_-2HK" (String#19697, DoABC#2)
// normalData = "_-2ag" (String#20473, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


