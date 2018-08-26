
package com.sulake.habbo.communication.messages.incoming.room.session
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.session.YouArePlayingGameMessageParser;

    public class YouArePlayingGameMessageEvent extends MessageEvent 
    {

        public function YouArePlayingGameMessageEvent(_arg_1:Function)
        {
            super(_arg_1, YouArePlayingGameMessageParser);
        }
        public function getParser():YouArePlayingGameMessageParser
        {
            return ((_parser as YouArePlayingGameMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.session

// YouArePlayingGameMessageEvent = "_-0ti" (String#16191, DoABC#2)
// YouArePlayingGameMessageParser = "_-0w-" (String#4768, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


