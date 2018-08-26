
package com.sulake.habbo.communication.messages.incoming.friendlist
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.friendlist.FriendListUpdateMessageParser;

    public class FriendListUpdateEvent extends MessageEvent implements IMessageEvent 
    {

        public function FriendListUpdateEvent(_arg_1:Function)
        {
            super(_arg_1, FriendListUpdateMessageParser);
        }
        public function getParser():FriendListUpdateMessageParser
        {
            return ((this._parser as FriendListUpdateMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.friendlist

// FriendListUpdateEvent = "_-l9" (String#8629, DoABC#2)
// FriendListUpdateMessageParser = "_-1B-" (String#5094, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


