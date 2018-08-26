
package com.sulake.habbo.communication.messages.incoming.handshake
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.handshake.SecretKeyMessageParser;

    public class SecretKeyEvent extends MessageEvent implements IMessageEvent 
    {

        public function SecretKeyEvent(_arg_1:Function)
        {
            super(_arg_1, SecretKeyMessageParser);
        }
        public function get serverPublicKey():String
        {
            return ((this._parser as SecretKeyMessageParser).serverPublicKey);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.handshake

// SecretKeyEvent = "_-23F" (String#6110, DoABC#2)
// SecretKeyMessageParser = "_-0F-" (String#3850, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// serverPublicKey = "_-1gz" (String#18175, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


