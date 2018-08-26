
package com.sulake.habbo.communication.messages.incoming.friendlist
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.friendlist.FriendNotificationMessageParser;

    public class FriendNotificationEvent extends MessageEvent implements IMessageEvent 
    {

        public function FriendNotificationEvent(_arg_1:Function)
        {
            super(_arg_1, FriendNotificationMessageParser);
        }
        public function getParser():FriendNotificationMessageParser
        {
            return ((_parser as FriendNotificationMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.friendlist

// FriendNotificationMessageParser = "_-0Ns" (String#14984, DoABC#2)
// FriendNotificationEvent = "_-2Vl" (String#6679, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


