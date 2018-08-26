
package com.sulake.habbo.communication.messages.incoming.notifications
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.notifications.HabboBroadcastMessageParser;

    public class HabboBroadcastMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function HabboBroadcastMessageEvent(_arg_1:Function)
        {
            super(_arg_1, HabboBroadcastMessageParser);
        }
        public function get messageText():String
        {
            return ((_parser as HabboBroadcastMessageParser).messageText);
        }
        public function getParser():HabboBroadcastMessageParser
        {
            return ((_parser as HabboBroadcastMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.notifications

// HabboBroadcastMessageEvent = "_-0xg" (String#16340, DoABC#2)
// HabboBroadcastMessageParser = "_-05N" (String#3673, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// messageText = "_-0EC" (String#14615, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


