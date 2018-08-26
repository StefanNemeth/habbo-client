
package com.sulake.habbo.communication.messages.incoming.room.session
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.session.YouAreSpectatorMessageParser;

    public class YouAreSpectatorMessageEvent extends MessageEvent 
    {

        public function YouAreSpectatorMessageEvent(_arg_1:Function)
        {
            super(_arg_1, YouAreSpectatorMessageParser);
        }
        public function getParser():YouAreSpectatorMessageParser
        {
            return ((_parser as YouAreSpectatorMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.session

// YouAreSpectatorMessageEvent = "_-PJ" (String#23219, DoABC#2)
// YouAreSpectatorMessageParser = "_-157" (String#4981, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


