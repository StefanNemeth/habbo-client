
package com.sulake.habbo.communication.messages.incoming.users
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.users.RespectNotificationMessageParser;

    public class RespectNotificationMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function RespectNotificationMessageEvent(_arg_1:Function)
        {
            super(_arg_1, RespectNotificationMessageParser);
        }
        public function get userId():int
        {
            return ((_parser as RespectNotificationMessageParser).userId);
        }
        public function get respectTotal():int
        {
            return ((_parser as RespectNotificationMessageParser).respectTotal);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.users

// RespectNotificationMessageEvent = "_-0xG" (String#16323, DoABC#2)
// RespectNotificationMessageParser = "_-1va" (String#5954, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// respectTotal = "_-3KU" (String#22304, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


