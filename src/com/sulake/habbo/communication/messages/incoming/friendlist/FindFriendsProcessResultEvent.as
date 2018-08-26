
package com.sulake.habbo.communication.messages.incoming.friendlist
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.friendlist.FindFriendsProcessResultMessageParser;

    public class FindFriendsProcessResultEvent extends MessageEvent implements IMessageEvent 
    {

        public function FindFriendsProcessResultEvent(_arg_1:Function)
        {
            super(_arg_1, FindFriendsProcessResultMessageParser);
        }
        public function get success():Boolean
        {
            return (FindFriendsProcessResultMessageParser(_parser).success);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.friendlist

// FindFriendsProcessResultEvent = "_-3IG" (String#7672, DoABC#2)
// FindFriendsProcessResultMessageParser = "_-2RN" (String#6592, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


