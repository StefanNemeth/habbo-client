
package com.sulake.habbo.communication.messages.incoming.users
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.users.PetRespectNotificationParser;

    public class PetRespectNotificationEvent extends MessageEvent implements IMessageEvent 
    {

        public function PetRespectNotificationEvent(_arg_1:Function)
        {
            super(_arg_1, PetRespectNotificationParser);
        }
        public function getParser():PetRespectNotificationParser
        {
            return ((_parser as PetRespectNotificationParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.users

// PetRespectNotificationParser = "_-1Te" (String#5426, DoABC#2)
// PetRespectNotificationEvent = "_-247" (String#19180, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


