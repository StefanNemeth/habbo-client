
package com.sulake.habbo.communication.messages.incoming.users
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.users.ScrSendUserInfoMessageParser;

    public class ScrSendUserInfoEvent extends MessageEvent implements IMessageEvent 
    {

        public function ScrSendUserInfoEvent(_arg_1:Function)
        {
            super(_arg_1, ScrSendUserInfoMessageParser);
        }
        public function getParser():ScrSendUserInfoMessageParser
        {
            return ((this._parser as ScrSendUserInfoMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.users

// ScrSendUserInfoEvent = "_-202" (String#6048, DoABC#2)
// ScrSendUserInfoMessageParser = "_-1vA" (String#18764, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


