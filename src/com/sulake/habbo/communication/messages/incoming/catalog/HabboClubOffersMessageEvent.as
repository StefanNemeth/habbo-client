
package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.catalog.HabboClubOffersMessageParser;

    public class HabboClubOffersMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function HabboClubOffersMessageEvent(_arg_1:Function)
        {
            super(_arg_1, HabboClubOffersMessageParser);
        }
        public function getParser():HabboClubOffersMessageParser
        {
            return ((this._parser as HabboClubOffersMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.catalog

// HabboClubOffersMessageEvent = "_-347" (String#21664, DoABC#2)
// HabboClubOffersMessageParser = "_-254" (String#6142, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


