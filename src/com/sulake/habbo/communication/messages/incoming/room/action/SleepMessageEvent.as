
package com.sulake.habbo.communication.messages.incoming.room.action
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.action.SleepMessageParser;

    public class SleepMessageEvent extends MessageEvent 
    {

        public function SleepMessageEvent(_arg_1:Function)
        {
            super(_arg_1, SleepMessageParser);
        }
        public function getParser():SleepMessageParser
        {
            return ((_parser as SleepMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.action

// SleepMessageEvent = "_-0J0" (String#14800, DoABC#2)
// SleepMessageParser = "_-pi" (String#8702, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


