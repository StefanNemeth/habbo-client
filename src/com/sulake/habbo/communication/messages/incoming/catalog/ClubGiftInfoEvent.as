
package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.catalog.ClubGiftInfoParser;

    public class ClubGiftInfoEvent extends MessageEvent implements IMessageEvent 
    {

        public function ClubGiftInfoEvent(_arg_1:Function)
        {
            super(_arg_1, ClubGiftInfoParser);
        }
        public function getParser():ClubGiftInfoParser
        {
            return ((this._parser as ClubGiftInfoParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.catalog

// ClubGiftInfoEvent = "_-TI" (String#23377, DoABC#2)
// ClubGiftInfoParser = "_-1gX" (String#5674, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


