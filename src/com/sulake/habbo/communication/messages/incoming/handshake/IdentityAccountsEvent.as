
package com.sulake.habbo.communication.messages.incoming.handshake
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.handshake.IdentityAccountsMessageParser;

    public class IdentityAccountsEvent extends MessageEvent implements IMessageEvent 
    {

        public function IdentityAccountsEvent(_arg_1:Function)
        {
            super(_arg_1, IdentityAccountsMessageParser);
        }
        public function getParser():IdentityAccountsMessageParser
        {
            return ((this._parser as IdentityAccountsMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.handshake

// IdentityAccountsEvent = "_-0GI" (String#3875, DoABC#2)
// IdentityAccountsMessageParser = "_-1jI" (String#5741, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


