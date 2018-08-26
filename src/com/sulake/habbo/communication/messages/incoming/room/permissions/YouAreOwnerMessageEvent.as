
package com.sulake.habbo.communication.messages.incoming.room.permissions
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.permissions.YouAreOwnerMessageParser;

    public class YouAreOwnerMessageEvent extends MessageEvent 
    {

        public function YouAreOwnerMessageEvent(_arg_1:Function)
        {
            super(_arg_1, YouAreOwnerMessageParser);
        }
        public function getParser():YouAreOwnerMessageParser
        {
            return ((_parser as YouAreOwnerMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.permissions

// YouAreOwnerMessageEvent = "_-0bo" (String#15504, DoABC#2)
// YouAreOwnerMessageParser = "_-RE" (String#8232, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


