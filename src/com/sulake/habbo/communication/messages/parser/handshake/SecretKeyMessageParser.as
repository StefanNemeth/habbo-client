
package com.sulake.habbo.communication.messages.parser.handshake
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class SecretKeyMessageParser implements IMessageParser 
    {

        protected var _serverPublicKey:String;

        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._serverPublicKey = _arg_1.readString();
            return (true);
        }
        public function get serverPublicKey():String
        {
            return (this._serverPublicKey);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.handshake

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// SecretKeyMessageParser = "_-0F-" (String#3850, DoABC#2)
// serverPublicKey = "_-1gz" (String#18175, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// _serverPublicKey = "_-1Pj" (String#17496, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


