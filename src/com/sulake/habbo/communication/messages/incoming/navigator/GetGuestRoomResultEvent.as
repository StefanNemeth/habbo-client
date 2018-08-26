
package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.navigator.GetGuestRoomResultMessageParser;

    public class GetGuestRoomResultEvent extends MessageEvent implements IMessageEvent 
    {

        public function GetGuestRoomResultEvent(_arg_1:Function)
        {
            super(_arg_1, GetGuestRoomResultMessageParser);
        }
        public function getParser():GetGuestRoomResultMessageParser
        {
            return ((this._parser as GetGuestRoomResultMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.navigator

// GetGuestRoomResultMessageParser = "_-0lh" (String#4540, DoABC#2)
// GetGuestRoomResultEvent = "_-2XI" (String#20334, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


