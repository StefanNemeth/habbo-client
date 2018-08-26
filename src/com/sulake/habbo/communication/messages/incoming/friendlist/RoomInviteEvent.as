
package com.sulake.habbo.communication.messages.incoming.friendlist
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.friendlist.RoomInviteMessageParser;

    public class RoomInviteEvent extends MessageEvent implements IMessageEvent 
    {

        public function RoomInviteEvent(_arg_1:Function)
        {
            super(_arg_1, RoomInviteMessageParser);
        }
        public function getParser():RoomInviteMessageParser
        {
            return ((this._parser as RoomInviteMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.friendlist

// RoomInviteEvent = "_-38C" (String#7476, DoABC#2)
// RoomInviteMessageParser = "_-1OK" (String#17445, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


