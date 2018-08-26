
package com.sulake.habbo.communication.messages.incoming.handshake
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.handshake.PingMessageParser;

    public class PingMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function PingMessageEvent(_arg_1:Function)
        {
            super(_arg_1, PingMessageParser);
        }
    }
}//package com.sulake.habbo.communication.messages.incoming.handshake

// PingMessageEvent = "_-0bC" (String#4327, DoABC#2)
// PingMessageParser = "_-08B" (String#3724, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


