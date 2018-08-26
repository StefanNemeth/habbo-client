
package com.sulake.habbo.communication.messages.parser.handshake
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.utils.Map;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class IdentityAccountsMessageParser implements IMessageParser 
    {

        private var _accounts:Map;

        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._accounts = new Map();
            var _local_2:int = _arg_1.readInteger();
            var _local_3:int;
            while (_local_3 < _local_2) {
                this._accounts.add(_arg_1.readInteger(), _arg_1.readString());
                _local_3++;
            };
            return (true);
        }
        public function get accounts():Map
        {
            return (this._accounts);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.handshake

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// IdentityAccountsMessageParser = "_-1jI" (String#5741, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// _accounts = "_-ee" (String#23830, DoABC#2)
// accounts = "_-rq" (String#24354, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


