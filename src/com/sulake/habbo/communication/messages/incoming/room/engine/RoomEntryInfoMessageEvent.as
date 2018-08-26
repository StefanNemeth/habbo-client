
package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.RoomEntryInfoMessageParser;

    public class RoomEntryInfoMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function RoomEntryInfoMessageEvent(_arg_1:Function)
        {
            super(_arg_1, RoomEntryInfoMessageParser);
        }
        public function getParser():RoomEntryInfoMessageParser
        {
            return ((_parser as RoomEntryInfoMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.engine

// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// RoomEntryInfoMessageParser = "_-2Z9" (String#6747, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)
// RoomEntryInfoMessageEvent = "_-nk" (String#24182, DoABC#2)


