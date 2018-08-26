
package com.sulake.habbo.communication.messages.incoming.room.action
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.action.DanceMessageParser;

    public class DanceMessageEvent extends MessageEvent 
    {

        public function DanceMessageEvent(_arg_1:Function)
        {
            super(_arg_1, DanceMessageParser);
        }
        public function getParser():DanceMessageParser
        {
            return ((_parser as DanceMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.action

// DanceMessageEvent = "_-1dk" (String#18047, DoABC#2)
// DanceMessageParser = "_-1U0" (String#5432, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


