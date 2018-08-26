
package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.navigator.RoomInfoUpdatedMessageParser;

    public class RoomInfoUpdatedEvent extends MessageEvent implements IMessageEvent 
    {

        public function RoomInfoUpdatedEvent(_arg_1:Function)
        {
            super(_arg_1, RoomInfoUpdatedMessageParser);
        }
        public function getParser():RoomInfoUpdatedMessageParser
        {
            return ((this._parser as RoomInfoUpdatedMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.navigator

// RoomInfoUpdatedEvent = "_-047" (String#14207, DoABC#2)
// RoomInfoUpdatedMessageParser = "_-2KL" (String#6452, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


