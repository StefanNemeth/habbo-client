
package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.navigator.RoomEventMessageParser;

    public class RoomEventEvent extends MessageEvent implements IMessageEvent 
    {

        public function RoomEventEvent(_arg_1:Function)
        {
            super(_arg_1, RoomEventMessageParser);
        }
        public function getParser():RoomEventMessageParser
        {
            return ((this._parser as RoomEventMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.navigator

// RoomEventMessageParser = "_-1on" (String#5836, DoABC#2)
// RoomEventEvent = "_-1Bg" (String#16928, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


