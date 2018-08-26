
package com.sulake.habbo.communication.messages.parser.users
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class HabboUserBadgesMessageParser implements IMessageParser 
    {

        private var _userId:int;
        private var _badges:Array;

        public function flush():Boolean
        {
            this._userId = -1;
            this._badges = [];
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_4:int;
            var _local_5:String;
            this._userId = _arg_1.readInteger();
            var _local_2:int = _arg_1.readInteger();
            var _local_3:int;
            while (_local_3 < _local_2) {
                _local_4 = _arg_1.readInteger();
                _local_5 = _arg_1.readString();
                this._badges.push(_local_5);
                _local_3++;
            };
            return (true);
        }
        public function get badges():Array
        {
            return (this._badges);
        }
        public function get userId():int
        {
            return (this._userId);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.users

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// HabboUserBadgesMessageParser = "_-ZC" (String#8398, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// _badges = "_-0Gg" (String#298, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


