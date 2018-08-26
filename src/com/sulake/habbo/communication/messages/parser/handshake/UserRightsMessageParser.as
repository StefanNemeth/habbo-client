
package com.sulake.habbo.communication.messages.parser.handshake
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class UserRightsMessageParser implements IMessageParser 
    {

        private var _clubLevel:int;
        private var _securityLevel:int;

        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._clubLevel = _arg_1.readInteger();
            this._securityLevel = _arg_1.readInteger();
            return (true);
        }
        public function get clubLevel():int
        {
            return (this._clubLevel);
        }
        public function get securityLevel():int
        {
            return (this._securityLevel);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.handshake

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// UserRightsMessageParser = "_-2mN" (String#7011, DoABC#2)
// _securityLevel = "_-0wx" (String#4790, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


