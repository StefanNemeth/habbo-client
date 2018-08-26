
package com.sulake.habbo.communication.messages.parser.friendlist
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendCategoryData;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class MessengerInitMessageParser implements IMessageParser 
    {

        private var _userFriendLimit:int;
        private var _normalFriendLimit:int;
        private var _extendedFriendLimit:int;
        private var _evenMoreExtendedFriendLimit:int;
        private var _categories:Array;
        private var _friends:Array;

        public function flush():Boolean
        {
            this._categories = new Array();
            this._friends = new Array();
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_4:int;
            this._userFriendLimit = _arg_1.readInteger();
            this._normalFriendLimit = _arg_1.readInteger();
            this._extendedFriendLimit = _arg_1.readInteger();
            this._evenMoreExtendedFriendLimit = _arg_1.readInteger();
            var _local_2:int = _arg_1.readInteger();
            _local_4 = 0;
            while (_local_4 < _local_2) {
                this._categories.push(new FriendCategoryData(_arg_1));
                _local_4++;
            };
            var _local_3:int = _arg_1.readInteger();
            _local_4 = 0;
            while (_local_4 < _local_3) {
                this._friends.push(new FriendData(_arg_1));
                _local_4++;
            };
            return (true);
        }
        public function get userFriendLimit():int
        {
            return (this._userFriendLimit);
        }
        public function get normalFriendLimit():int
        {
            return (this._normalFriendLimit);
        }
        public function get extendedFriendLimit():int
        {
            return (this._extendedFriendLimit);
        }
        public function get categories():Array
        {
            return (this._categories);
        }
        public function get friends():Array
        {
            return (this._friends);
        }
        public function get evenMoreExtendedFriendLimit():int
        {
            return (this._evenMoreExtendedFriendLimit);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.friendlist

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// MessengerInitMessageParser = "_-1W5" (String#5474, DoABC#2)
// FriendCategoryData = "_-1Pd" (String#5346, DoABC#2)
// FriendData = "_-XR" (String#23541, DoABC#2)
// _userFriendLimit = "_-11x" (String#16534, DoABC#2)
// _normalFriendLimit = "_-xd" (String#24594, DoABC#2)
// _extendedFriendLimit = "_-2Me" (String#19914, DoABC#2)
// _evenMoreExtendedFriendLimit = "_-0Tx" (String#15203, DoABC#2)
// _categories = "_-EJ" (String#373, DoABC#2)
// _friends = "_-02K" (String#576, DoABC#2)
// userFriendLimit = "_-N8" (String#23129, DoABC#2)
// normalFriendLimit = "_-y2" (String#24616, DoABC#2)
// extendedFriendLimit = "_-0uU" (String#16220, DoABC#2)
// friends = "_-10-" (String#16467, DoABC#2)
// evenMoreExtendedFriendLimit = "_-1AA" (String#16865, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


