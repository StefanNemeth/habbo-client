
package com.sulake.habbo.communication.messages.incoming.notifications
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.notifications.MOTDNotificationParser;

    public class MOTDNotificationEvent extends MessageEvent implements IMessageEvent 
    {

        public function MOTDNotificationEvent(_arg_1:Function)
        {
            super(_arg_1, MOTDNotificationParser);
        }
        public function getParser():MOTDNotificationParser
        {
            return ((_parser as MOTDNotificationParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.notifications

// MOTDNotificationEvent = "_-2qQ" (String#21099, DoABC#2)
// MOTDNotificationParser = "_-0ES" (String#3837, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


