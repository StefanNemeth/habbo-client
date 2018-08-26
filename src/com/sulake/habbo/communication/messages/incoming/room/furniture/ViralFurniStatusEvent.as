
package com.sulake.habbo.communication.messages.incoming.room.furniture
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.furniture.ViralFurniStatusMessageParser;

    public class ViralFurniStatusEvent extends MessageEvent 
    {

        public function ViralFurniStatusEvent(_arg_1:Function)
        {
            super(_arg_1, ViralFurniStatusMessageParser);
        }
        public function getParser():ViralFurniStatusMessageParser
        {
            return ((_parser as ViralFurniStatusMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.furniture

// ViralFurniStatusEvent = "_-yK" (String#24627, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


