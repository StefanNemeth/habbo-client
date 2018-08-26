
package com.sulake.habbo.communication.messages.parser.friendlist
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class MessengerErrorMessageParser implements IMessageParser 
    {

        private var _clientMessageId:int;
        private var _errorCode:int;

        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._clientMessageId = _arg_1.readInteger();
            this._errorCode = _arg_1.readInteger();
            return (true);
        }
        public function get clientMessageId():int
        {
            return (this._clientMessageId);
        }
        public function get errorCode():int
        {
            return (this._errorCode);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.friendlist

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// MessengerErrorMessageParser = "_-9x" (String#7864, DoABC#2)
// _errorCode = "_-2il" (String#127, DoABC#2)
// _clientMessageId = "_-2ai" (String#20475, DoABC#2)
// clientMessageId = "_-2xZ" (String#21376, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


