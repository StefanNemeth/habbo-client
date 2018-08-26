
package com.sulake.habbo.communication.messages.parser.users
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RespectNotificationMessageParser implements IMessageParser 
    {

        private var _userId:int = 0;
        private var _respectTotal:int = 0;

        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._userId = _arg_1.readInteger();
            this._respectTotal = _arg_1.readInteger();
            return (true);
        }
        public function get userId():int
        {
            return (this._userId);
        }
        public function get respectTotal():int
        {
            return (this._respectTotal);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.users

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// RespectNotificationMessageParser = "_-1va" (String#5954, DoABC#2)
// _respectTotal = "_-00y" (String#1384, DoABC#2)
// respectTotal = "_-3KU" (String#22304, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


