
package com.sulake.habbo.communication.messages.parser.error
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ErrorReportMessageParser implements IMessageParser 
    {

        private var _errorCode:int;
        private var _messageId:int;
        private var _timestamp:String;

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._messageId = _arg_1.readInteger();
            this._errorCode = _arg_1.readInteger();
            this._timestamp = _arg_1.readString();
            return (true);
        }
        public function flush():Boolean
        {
            this._errorCode = 0;
            this._messageId = 0;
            this._timestamp = null;
            return (true);
        }
        public function get errorCode():int
        {
            return (this._errorCode);
        }
        public function get messageId():int
        {
            return (this._messageId);
        }
        public function get timestamp():String
        {
            return (this._timestamp);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.error

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// ErrorReportMessageParser = "_-2xv" (String#7238, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// _errorCode = "_-2il" (String#127, DoABC#2)
// _messageId = "_-1-t" (String#16463, DoABC#2)
// _timestamp = "_-2eR" (String#20622, DoABC#2)
// timestamp = "_-188" (String#16782, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


