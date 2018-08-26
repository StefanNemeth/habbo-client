
package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.catalog.HabboClubExtendOfferMessageParser;

    public class HabboClubExtendOfferMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function HabboClubExtendOfferMessageEvent(_arg_1:Function)
        {
            super(_arg_1, HabboClubExtendOfferMessageParser);
        }
        public function getParser():HabboClubExtendOfferMessageParser
        {
            return ((this._parser as HabboClubExtendOfferMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.catalog

// HabboClubExtendOfferMessageEvent = "_-2CH" (String#19495, DoABC#2)
// HabboClubExtendOfferMessageParser = "_-0BJ" (String#3785, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


