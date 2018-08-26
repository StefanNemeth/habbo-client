
package com.sulake.habbo.communication.messages.parser.users
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class IgnoredUsersMessageParser implements IMessageParser 
    {

        protected var _ignoredUsers:Array = null;

        public function IgnoredUsersMessageParser()
        {
            this._ignoredUsers = [];
        }
        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._ignoredUsers = [];
            var _local_2:int = _arg_1.readInteger();
            var _local_3:int;
            while (_local_3 < _local_2) {
                this._ignoredUsers.push(_arg_1.readString());
                _local_3++;
            };
            return (true);
        }
        public function get ignoredUsers():Array
        {
            return (this._ignoredUsers.slice());
        }

    }
}//package com.sulake.habbo.communication.messages.parser.users

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// IgnoredUsersMessageParser = "_-1h9" (String#5688, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// ignoredUsers = "_-2n0" (String#20962, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


