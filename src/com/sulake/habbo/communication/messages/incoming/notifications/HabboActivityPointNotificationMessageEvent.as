
package com.sulake.habbo.communication.messages.incoming.notifications
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.notifications.HabboActivityPointNotificationMessageParser;

    public class HabboActivityPointNotificationMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function HabboActivityPointNotificationMessageEvent(_arg_1:Function)
        {
            super(_arg_1, HabboActivityPointNotificationMessageParser);
        }
        public function get amount():int
        {
            return ((_parser as HabboActivityPointNotificationMessageParser).amount);
        }
        public function get change():int
        {
            return ((_parser as HabboActivityPointNotificationMessageParser).change);
        }
        public function get type():int
        {
            return ((_parser as HabboActivityPointNotificationMessageParser).type);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.notifications

// HabboActivityPointNotificationMessageEvent = "_-cn" (String#23745, DoABC#2)
// HabboActivityPointNotificationMessageParser = "_-2G8" (String#6368, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// change = "_-Bl" (String#7908, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


