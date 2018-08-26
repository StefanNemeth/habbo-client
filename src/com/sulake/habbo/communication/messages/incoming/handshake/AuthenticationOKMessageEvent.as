
package com.sulake.habbo.communication.messages.incoming.handshake
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.handshake.AuthenticationOKMessageParser;

    public class AuthenticationOKMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function AuthenticationOKMessageEvent(_arg_1:Function)
        {
            super(_arg_1, AuthenticationOKMessageParser);
        }
    }
}//package com.sulake.habbo.communication.messages.incoming.handshake

// AuthenticationOKMessageParser = "_-35U" (String#7417, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


