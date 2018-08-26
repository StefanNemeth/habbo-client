
package com.sulake.habbo.communication.messages.parser.tracking
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class LatencyPingResponseMessageParser implements IMessageParser 
    {

        private var _requestId:int;

        public function get requestId():int
        {
            return (this._requestId);
        }
        public function flush():Boolean
        {
            this._requestId = -1;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._requestId = _arg_1.readInteger();
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.tracking

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// LatencyPingResponseMessageParser = "_-1iU" (String#5722, DoABC#2)
// _requestId = "_-1GH" (String#301, DoABC#2)
// requestId = "_-li" (String#24099, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


