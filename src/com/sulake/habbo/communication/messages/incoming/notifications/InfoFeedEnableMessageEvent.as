
package com.sulake.habbo.communication.messages.incoming.notifications
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.notifications.InfoFeedEnableMessageParser;

    public class InfoFeedEnableMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function InfoFeedEnableMessageEvent(_arg_1:Function)
        {
            super(_arg_1, InfoFeedEnableMessageParser);
        }
        public function get enabled():Boolean
        {
            return ((_parser as InfoFeedEnableMessageParser).enabled);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.notifications

// InfoFeedEnableMessageEvent = "_-2wz" (String#21347, DoABC#2)
// InfoFeedEnableMessageParser = "_-Ic" (String#8054, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// enabled = "_-0Kh" (String#14868, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


