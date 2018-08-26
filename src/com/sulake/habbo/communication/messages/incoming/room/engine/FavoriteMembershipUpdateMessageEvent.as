
package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.FavouriteMembershipUpdateMessageParser;

    public class FavoriteMembershipUpdateMessageEvent extends MessageEvent 
    {

        public function FavoriteMembershipUpdateMessageEvent(_arg_1:Function)
        {
            super(_arg_1, FavouriteMembershipUpdateMessageParser);
        }
        public function getParser():FavouriteMembershipUpdateMessageParser
        {
            return ((_parser as FavouriteMembershipUpdateMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.engine

// FavoriteMembershipUpdateMessageEvent = "_-1tm" (String#18707, DoABC#2)
// FavouriteMembershipUpdateMessageParser = "_-0I" (String#3916, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


