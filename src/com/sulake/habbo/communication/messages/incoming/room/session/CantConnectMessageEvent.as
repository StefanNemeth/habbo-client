
package com.sulake.habbo.communication.messages.incoming.room.session
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.session.CantConnectMessageParser;

    public class CantConnectMessageEvent extends MessageEvent 
    {

        public function CantConnectMessageEvent(_arg_1:Function)
        {
            super(_arg_1, CantConnectMessageParser);
        }
        public function getParser():CantConnectMessageParser
        {
            return ((_parser as CantConnectMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.session

// CantConnectMessageParser = "_-07a" (String#3712, DoABC#2)
// CantConnectMessageEvent = "_-0qQ" (String#16067, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


