
package com.sulake.habbo.communication.messages.parser.friendlist
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendRequestData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class BuddyRequestsMessageParser implements IMessageParser 
    {

        private var _totalReqCount:int;
        private var _reqs:Array;

        public function flush():Boolean
        {
            this._reqs = new Array();
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._totalReqCount = _arg_1.readInteger();
            var _local_2:int = _arg_1.readInteger();
            Logger.log(((("Received buddy requests: " + this._totalReqCount) + ", ") + _local_2));
            var _local_3:int;
            while (_local_3 < _local_2) {
                this._reqs.push(new FriendRequestData(_arg_1));
                _local_3++;
            };
            return (true);
        }
        public function get totalReqCount():int
        {
            return (this._totalReqCount);
        }
        public function get reqs():Array
        {
            return (this._reqs);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.friendlist

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// BuddyRequestsMessageParser = "_-39D" (String#7495, DoABC#2)
// FriendRequestData = "_-1aw" (String#17931, DoABC#2)
// _totalReqCount = "_-2xh" (String#21382, DoABC#2)
// _reqs = "_-0xd" (String#16338, DoABC#2)
// totalReqCount = "_-0kF" (String#15840, DoABC#2)
// reqs = "_-31c" (String#21563, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


