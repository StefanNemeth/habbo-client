
package com.sulake.habbo.communication.messages.incoming.users
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.users.HabboGroupDetailsMessageParser;

    public class HabboGroupDetailsMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function HabboGroupDetailsMessageEvent(_arg_1:Function)
        {
            super(_arg_1, HabboGroupDetailsMessageParser);
        }
        public function get data():HabboGroupDetailsData
        {
            return (HabboGroupDetailsMessageParser(_parser).data);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.users

// HabboGroupDetailsMessageEvent = "_-2uh" (String#7173, DoABC#2)
// HabboGroupDetailsData = "_-13j" (String#16607, DoABC#2)
// HabboGroupDetailsMessageParser = "_-03r" (String#3643, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


