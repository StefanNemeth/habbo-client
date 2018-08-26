
package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.catalog.ChargeInfoMessageParser;

    public class ChargeInfoMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function ChargeInfoMessageEvent(_arg_1:Function)
        {
            super(_arg_1, ChargeInfoMessageParser);
        }
        public function getParser():ChargeInfoMessageParser
        {
            return ((this._parser as ChargeInfoMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.catalog

// ChargeInfoMessageEvent = "_-1mO" (String#18395, DoABC#2)
// ChargeInfoMessageParser = "_-2wl" (String#7219, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


