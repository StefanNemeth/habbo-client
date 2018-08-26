
package com.sulake.habbo.communication.messages.incoming.room.session
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.session.FlatAccessibleMessageParser;

    public class FlatAccessibleMessageEvent extends MessageEvent 
    {

        public function FlatAccessibleMessageEvent(_arg_1:Function)
        {
            super(_arg_1, FlatAccessibleMessageParser);
        }
        public function getParser():FlatAccessibleMessageParser
        {
            return ((_parser as FlatAccessibleMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.session

// FlatAccessibleMessageEvent = "_-e-" (String#23802, DoABC#2)
// FlatAccessibleMessageParser = "_-1d1" (String#5616, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


