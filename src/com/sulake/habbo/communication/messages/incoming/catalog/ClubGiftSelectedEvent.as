
package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.catalog.ClubGiftSelectedParser;

    public class ClubGiftSelectedEvent extends MessageEvent implements IMessageEvent 
    {

        public function ClubGiftSelectedEvent(_arg_1:Function)
        {
            super(_arg_1, ClubGiftSelectedParser);
        }
        public function getParser():ClubGiftSelectedParser
        {
            return ((this._parser as ClubGiftSelectedParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.catalog

// ClubGiftSelectedParser = "_-03J" (String#3634, DoABC#2)
// ClubGiftSelectedEvent = "_-1am" (String#17925, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


