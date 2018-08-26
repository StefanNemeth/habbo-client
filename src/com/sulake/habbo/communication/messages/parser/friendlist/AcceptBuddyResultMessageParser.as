
package com.sulake.habbo.communication.messages.parser.friendlist
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.friendlist.AcceptBuddyFailureData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class AcceptBuddyResultMessageParser implements IMessageParser 
    {

        private var _failures:Array;

        public function flush():Boolean
        {
            this._failures = new Array();
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_2:int = _arg_1.readInteger();
            var _local_3:int;
            while (_local_3 < _local_2) {
                this._failures.push(new AcceptBuddyFailureData(_arg_1));
                _local_3++;
            };
            return (true);
        }
        public function get failures():Array
        {
            return (this._failures);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.friendlist

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// AcceptBuddyFailureData = "_-06x" (String#14321, DoABC#2)
// AcceptBuddyResultMessageParser = "_-2AZ" (String#6257, DoABC#2)
// _failures = "_-3I9" (String#22208, DoABC#2)
// failures = "_-sX" (String#24379, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


