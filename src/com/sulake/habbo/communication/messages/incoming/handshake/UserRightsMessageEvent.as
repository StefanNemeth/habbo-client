
package com.sulake.habbo.communication.messages.incoming.handshake
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.handshake.UserRightsMessageParser;

    public class UserRightsMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function UserRightsMessageEvent(_arg_1:Function)
        {
            super(_arg_1, UserRightsMessageParser);
        }
        public function get clubLevel():int
        {
            return ((this._parser as UserRightsMessageParser).clubLevel);
        }
        public function get securityLevel():int
        {
            return ((this._parser as UserRightsMessageParser).securityLevel);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.handshake

// UserRightsMessageEvent = "_-8n" (String#7837, DoABC#2)
// UserRightsMessageParser = "_-2mN" (String#7011, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


