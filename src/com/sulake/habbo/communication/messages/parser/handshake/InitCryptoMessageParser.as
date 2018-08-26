
package com.sulake.habbo.communication.messages.parser.handshake
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class InitCryptoMessageParser implements IMessageParser 
    {

        protected var _isClientEncrypted:Boolean;
        protected var _isServerEncrypted:Boolean;
        protected var _token:String;

        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._token = _arg_1.readString();
            var _local_2:int = _arg_1.readInteger();
            this._isServerEncrypted = (((_local_2)>0) ? true : false);
            return (true);
        }
        public function get token():String
        {
            return (this._token);
        }
        public function get isServerEncrypted():Boolean
        {
            return (this._isServerEncrypted);
        }
        public function get isClientEncrypted():Boolean
        {
            return (this._isClientEncrypted);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.handshake

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// InitCryptoMessageParser = "_-0MH" (String#4007, DoABC#2)
// token = "_-dt" (String#23796, DoABC#2)
// isServerEncrypted = "_-0WR" (String#15297, DoABC#2)
// isClientEncrypted = "_-v" (String#24489, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// _isClientEncrypted = "_-0UE" (String#15215, DoABC#2)
// _isServerEncrypted = "_-1dC" (String#18022, DoABC#2)
// _token = "_-01j" (String#3597, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


