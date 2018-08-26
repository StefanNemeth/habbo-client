
package com.sulake.habbo.communication.messages.incoming.room.permissions
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.permissions.YouAreControllerMessageParser;

    public class YouAreControllerMessageEvent extends MessageEvent 
    {

        public function YouAreControllerMessageEvent(_arg_1:Function)
        {
            super(_arg_1, YouAreControllerMessageParser);
        }
        public function getParser():YouAreControllerMessageParser
        {
            return ((_parser as YouAreControllerMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.permissions

// YouAreControllerMessageEvent = "_-28l" (String#19360, DoABC#2)
// YouAreControllerMessageParser = "_-1Cf" (String#5120, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


