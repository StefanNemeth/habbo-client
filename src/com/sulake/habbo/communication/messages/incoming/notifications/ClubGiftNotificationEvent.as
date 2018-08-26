
package com.sulake.habbo.communication.messages.incoming.notifications
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.notifications.ClubGiftNotificationParser;

    public class ClubGiftNotificationEvent extends MessageEvent implements IMessageEvent 
    {

        public function ClubGiftNotificationEvent(_arg_1:Function)
        {
            super(_arg_1, ClubGiftNotificationParser);
        }
        public function getParser():ClubGiftNotificationParser
        {
            return ((_parser as ClubGiftNotificationParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.notifications

// ClubGiftNotificationEvent = "_-26N" (String#19269, DoABC#2)
// ClubGiftNotificationParser = "_-0bP" (String#4331, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


