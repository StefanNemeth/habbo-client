
package com.sulake.habbo.communication.messages.parser.friendlist
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.friendlist.HabboSearchResultData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class HabboSearchResultMessageParser implements IMessageParser 
    {

        private var _friends:Array;
        private var _others:Array;

        public function flush():Boolean
        {
            this._friends = new Array();
            this._others = new Array();
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_2:int = _arg_1.readInteger();
            var _local_3:int;
            while (_local_3 < _local_2) {
                this._friends.push(new HabboSearchResultData(_arg_1));
                _local_3++;
            };
            var _local_4:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_4) {
                this._others.push(new HabboSearchResultData(_arg_1));
                _local_3++;
            };
            return (true);
        }
        public function get friends():Array
        {
            return (this._friends);
        }
        public function get others():Array
        {
            return (this._others);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.friendlist

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// HabboSearchResultMessageParser = "_-2vu" (String#7199, DoABC#2)
// HabboSearchResultData = "_-1Ub" (String#5446, DoABC#2)
// _friends = "_-02K" (String#576, DoABC#2)
// friends = "_-10-" (String#16467, DoABC#2)
// _others = "_-5r" (String#7778, DoABC#2)
// others = "_-224" (String#19094, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


