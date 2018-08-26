
package com.sulake.habbo.communication.messages.parser.handshake
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PingMessageParser implements IMessageParser 
    {

        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.handshake

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// PingMessageParser = "_-08B" (String#3724, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


