
package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.navigator.RoomRatingMessageParser;

    public class RoomRatingEvent extends MessageEvent implements IMessageEvent 
    {

        public function RoomRatingEvent(_arg_1:Function)
        {
            super(_arg_1, RoomRatingMessageParser);
        }
        public function getParser():RoomRatingMessageParser
        {
            return ((this._parser as RoomRatingMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.navigator

// RoomRatingMessageParser = "_-3KE" (String#7710, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


