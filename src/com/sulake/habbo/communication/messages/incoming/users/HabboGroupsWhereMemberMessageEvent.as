
package com.sulake.habbo.communication.messages.incoming.users
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.users.HabboGroupsWhereMemberMessageParser;

    public class HabboGroupsWhereMemberMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function HabboGroupsWhereMemberMessageEvent(_arg_1:Function)
        {
            super(_arg_1, HabboGroupsWhereMemberMessageParser);
        }
        public function get groups():Array
        {
            return (HabboGroupsWhereMemberMessageParser(_parser).groups);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.users

// HabboGroupsWhereMemberMessageEvent = "_-1Yk" (String#5538, DoABC#2)
// HabboGroupsWhereMemberMessageParser = "_-1yA" (String#5998, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


