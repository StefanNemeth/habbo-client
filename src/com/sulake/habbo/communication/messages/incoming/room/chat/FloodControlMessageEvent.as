
package com.sulake.habbo.communication.messages.incoming.room.chat
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.chat.FloodControlMessageParser;

    public class FloodControlMessageEvent extends MessageEvent 
    {

        public function FloodControlMessageEvent(_arg_1:Function)
        {
            super(_arg_1, FloodControlMessageParser);
        }
        public function getParser():FloodControlMessageParser
        {
            return ((_parser as FloodControlMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.chat

// FloodControlMessageEvent = "_-Zv" (String#23628, DoABC#2)
// FloodControlMessageParser = "_-1ML" (String#5281, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


