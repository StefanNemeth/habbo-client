
package com.sulake.habbo.communication.messages.incoming.help
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.help.HotelMergeNameChangeParser;

    public class HotelMergeNameChangeEvent extends MessageEvent implements IMessageEvent 
    {

        public function HotelMergeNameChangeEvent(_arg_1:Function)
        {
            super(_arg_1, HotelMergeNameChangeParser);
        }
        public function getParser():HotelMergeNameChangeParser
        {
            return ((_parser as HotelMergeNameChangeParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.help

// HotelMergeNameChangeEvent = "_-32D" (String#21589, DoABC#2)
// HotelMergeNameChangeParser = "_-0El" (String#3845, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


