
package com.sulake.habbo.communication.messages.incoming.friendlist
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.friendlist.FollowFriendFailedMessageParser;

    public class FollowFriendFailedEvent extends MessageEvent implements IMessageEvent 
    {

        public function FollowFriendFailedEvent(_arg_1:Function)
        {
            super(_arg_1, FollowFriendFailedMessageParser);
        }
        public function getParser():FollowFriendFailedMessageParser
        {
            return ((this._parser as FollowFriendFailedMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.friendlist

// FollowFriendFailedMessageParser = "_-0Sn" (String#4155, DoABC#2)
// FollowFriendFailedEvent = "_-1bO" (String#5583, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


