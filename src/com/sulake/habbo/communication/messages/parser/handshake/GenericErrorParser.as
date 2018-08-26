
package com.sulake.habbo.communication.messages.parser.handshake
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class GenericErrorParser implements IMessageParser 
    {

        private var _errorCode:int;

        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._errorCode = _arg_1.readInteger();
            return (true);
        }
        public function get errorCode():int
        {
            return (this._errorCode);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.handshake

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// GenericErrorParser = "_-2ft" (String#6864, DoABC#2)
// _errorCode = "_-2il" (String#127, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


