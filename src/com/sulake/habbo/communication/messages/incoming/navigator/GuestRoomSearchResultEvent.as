
package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.navigator.GuestRoomSearchResultMessageParser;

    public class GuestRoomSearchResultEvent extends MessageEvent implements IMessageEvent 
    {

        public function GuestRoomSearchResultEvent(_arg_1:Function)
        {
            super(_arg_1, GuestRoomSearchResultMessageParser);
        }
        public function getParser():GuestRoomSearchResultMessageParser
        {
            return ((this._parser as GuestRoomSearchResultMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.navigator

// GuestRoomSearchResultEvent = "_-7-" (String#22500, DoABC#2)
// GuestRoomSearchResultMessageParser = "_-37Q" (String#7455, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


