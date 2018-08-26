
package com.sulake.habbo.communication.messages.incoming.users
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.users.HabboGroupJoinFailedMessageParser;

    public class HabboGroupJoinFailedMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function HabboGroupJoinFailedMessageEvent(_arg_1:Function)
        {
            super(_arg_1, HabboGroupJoinFailedMessageParser);
        }
        public function get reason():int
        {
            return (HabboGroupJoinFailedMessageParser(_parser).reason);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.users

// HabboGroupJoinFailedMessageEvent = "_-1sF" (String#5890, DoABC#2)
// HabboGroupJoinFailedMessageParser = "_-0ce" (String#4355, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// reason = "_-053" (String#14245, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


