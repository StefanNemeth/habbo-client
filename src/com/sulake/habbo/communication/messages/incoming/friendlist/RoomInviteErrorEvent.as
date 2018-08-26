
package com.sulake.habbo.communication.messages.incoming.friendlist
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.friendlist.RoomInviteErrorMessageParser;

    public class RoomInviteErrorEvent extends MessageEvent implements IMessageEvent 
    {

        public function RoomInviteErrorEvent(_arg_1:Function)
        {
            super(_arg_1, RoomInviteErrorMessageParser);
        }
        public function getParser():RoomInviteErrorMessageParser
        {
            return ((this._parser as RoomInviteErrorMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.friendlist

// RoomInviteErrorEvent = "_-vN" (String#24504, DoABC#2)
// RoomInviteErrorMessageParser = "_-1Fp" (String#5168, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


