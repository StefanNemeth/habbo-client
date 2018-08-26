
package com.sulake.habbo.communication.messages.parser.help
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class CallForHelpPendingCallsMessageParser implements IMessageParser 
    {

        private var _callArray:Array;

        public function CallForHelpPendingCallsMessageParser()
        {
            this._callArray = new Array();
            super();
        }
        public function get callArray():Array
        {
            return (this._callArray);
        }
        public function get callCount():int
        {
            return (this._callArray.length);
        }
        public function flush():Boolean
        {
            this._callArray = new Array();
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_3:int;
            var _local_4:Object;
            this._callArray = new Array();
            var _local_2:int = _arg_1.readInteger();
            while (_local_3 < _local_2) {
                _local_4 = new Object();
                _local_4.callId = _arg_1.readString();
                _local_4.timeStamp = _arg_1.readString();
                _local_4.message = _arg_1.readString();
                this._callArray.push(_local_4);
                _local_3++;
            };
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.help

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// CallForHelpPendingCallsMessageParser = "_-32G" (String#7351, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// _callArray = "_-2gG" (String#20701, DoABC#2)
// callArray = "_-V1" (String#23449, DoABC#2)
// callCount = "_-1E6" (String#17032, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


