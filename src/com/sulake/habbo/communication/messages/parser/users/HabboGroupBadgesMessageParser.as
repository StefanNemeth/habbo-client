
package com.sulake.habbo.communication.messages.parser.users
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.utils.Map;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class HabboGroupBadgesMessageParser implements IMessageParser 
    {

        protected var _badges:Map;

        public function HabboGroupBadgesMessageParser()
        {
            this._badges = new Map();
        }
        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_3:int;
            var _local_4:String;
            this._badges.dispose();
            this._badges = new Map();
            var _local_2:int = _arg_1.readInteger();
            var _local_5:int;
            while (_local_5 < _local_2) {
                _local_3 = _arg_1.readInteger();
                _local_4 = _arg_1.readString();
                this._badges.add(_local_3, _local_4);
                _local_5++;
            };
            return (true);
        }
        public function get badges():Map
        {
            var _local_1:Map = new Map();
            var _local_2:int;
            while (_local_2 < this._badges.length) {
                _local_1.add(this._badges.getKey(_local_2), this._badges.getWithIndex(_local_2));
                _local_2++;
            };
            return (_local_1);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.users

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// HabboGroupBadgesMessageParser = "_-3Cn" (String#7571, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// _badges = "_-0Gg" (String#298, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


