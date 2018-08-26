
package com.sulake.habbo.communication.messages.incoming.room.permissions
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.permissions.YouAreNotControllerMessageParser;

    public class YouAreNotControllerMessageEvent extends MessageEvent 
    {

        public function YouAreNotControllerMessageEvent(_arg_1:Function)
        {
            super(_arg_1, YouAreNotControllerMessageParser);
        }
        public function getParser():YouAreNotControllerMessageParser
        {
            return ((_parser as YouAreNotControllerMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.permissions

// YouAreNotControllerMessageEvent = "_-2jG" (String#20814, DoABC#2)
// YouAreNotControllerMessageParser = "_-2iF" (String#6914, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


