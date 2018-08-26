
package com.sulake.habbo.communication.messages.incoming.handshake
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.handshake.InitCryptoMessageParser;

    public class InitCryptoMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function InitCryptoMessageEvent(_arg_1:Function)
        {
            super(_arg_1, InitCryptoMessageParser);
        }
        public function get token():String
        {
            return ((this._parser as InitCryptoMessageParser).token);
        }
        public function get isServerEncrypted():Boolean
        {
            return ((this._parser as InitCryptoMessageParser).isServerEncrypted);
        }
        public function get isClientEncrypted():Boolean
        {
            return ((this._parser as InitCryptoMessageParser).isClientEncrypted);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.handshake

// InitCryptoMessageEvent = "_-Nu" (String#8163, DoABC#2)
// InitCryptoMessageParser = "_-0MH" (String#4007, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// token = "_-dt" (String#23796, DoABC#2)
// isServerEncrypted = "_-0WR" (String#15297, DoABC#2)
// isClientEncrypted = "_-v" (String#24489, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


