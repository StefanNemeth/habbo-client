
package com.sulake.habbo.communication.messages.incoming.room.furniture
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.furniture.ViralFurniGiftReceivedMessageParser;

    public class ViralFurniGiftReceivedEvent extends MessageEvent 
    {

        public function ViralFurniGiftReceivedEvent(_arg_1:Function)
        {
            super(_arg_1, ViralFurniGiftReceivedMessageParser);
        }
        public function getParser():ViralFurniGiftReceivedMessageParser
        {
            return ((_parser as ViralFurniGiftReceivedMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.furniture

// ViralFurniGiftReceivedEvent = "_-35d" (String#21717, DoABC#2)
// ViralFurniGiftReceivedMessageParser = "_-vR" (String#8792, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


