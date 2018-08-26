
package com.sulake.habbo.communication.messages.parser.friendlist
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FindFriendsProcessResultMessageParser implements IMessageParser 
    {

        private var _success:Boolean;

        public function get success():Boolean
        {
            return (this._success);
        }
        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._success = _arg_1.readBoolean();
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.friendlist

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// FindFriendsProcessResultMessageParser = "_-2RN" (String#6592, DoABC#2)
// readBoolean = "_-0ZR" (String#1499, DoABC#2)
// _success = "_-0Vx" (String#1489, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


