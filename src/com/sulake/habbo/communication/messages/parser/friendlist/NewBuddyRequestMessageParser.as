
package com.sulake.habbo.communication.messages.parser.friendlist
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendRequestData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class NewBuddyRequestMessageParser implements IMessageParser 
    {

        private var _req:FriendRequestData;

        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._req = new FriendRequestData(_arg_1);
            return (true);
        }
        public function get req():FriendRequestData
        {
            return (this._req);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.friendlist

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// FriendRequestData = "_-1aw" (String#17931, DoABC#2)
// NewBuddyRequestMessageParser = "_-2Qd" (String#6572, DoABC#2)
// _req = "_-2rs" (String#21150, DoABC#2)
// req = "_-8J" (String#22555, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


