
package com.sulake.habbo.communication.messages.incoming.handshake
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.handshake.UserObjectMessageParser;

    public class UserObjectEvent extends MessageEvent implements IMessageEvent 
    {

        public function UserObjectEvent(_arg_1:Function)
        {
            super(_arg_1, UserObjectMessageParser);
        }
        public function getParser():UserObjectMessageParser
        {
            return ((this._parser as UserObjectMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.handshake

// UserObjectMessageParser = "_-04X" (String#14223, DoABC#2)
// UserObjectEvent = "_-1HL" (String#17163, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


