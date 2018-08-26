
package com.sulake.habbo.communication.messages.incoming.room.session
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.session.RoomReadyMessageParser;

    public class RoomReadyMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function RoomReadyMessageEvent(_arg_1:Function)
        {
            super(_arg_1, RoomReadyMessageParser);
        }
        public function getParser():RoomReadyMessageParser
        {
            return ((_parser as RoomReadyMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.session

// RoomReadyMessageEvent = "_-1uW" (String#5930, DoABC#2)
// RoomReadyMessageParser = "_-1zm" (String#18958, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


