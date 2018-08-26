
package com.sulake.habbo.communication.messages.incoming.notifications
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.notifications.PetLevelNotificationParser;

    public class PetLevelNotificationEvent extends MessageEvent implements IMessageEvent 
    {

        public function PetLevelNotificationEvent(_arg_1:Function)
        {
            super(_arg_1, PetLevelNotificationParser);
        }
        public function getParser():PetLevelNotificationParser
        {
            return ((_parser as PetLevelNotificationParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.notifications

// PetLevelNotificationEvent = "_-3HY" (String#22182, DoABC#2)
// PetLevelNotificationParser = "_-21" (String#6064, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


