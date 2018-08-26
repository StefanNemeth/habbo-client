
package com.sulake.habbo.communication.messages.incoming.availability
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.availability.InfoHotelClosedMessageParser;

    public class InfoHotelClosedMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function InfoHotelClosedMessageEvent(_arg_1:Function)
        {
            super(_arg_1, InfoHotelClosedMessageParser);
        }
        public function getParser():InfoHotelClosedMessageParser
        {
            return ((_parser as InfoHotelClosedMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.availability

// InfoHotelClosedMessageEvent = "_-0it" (String#15786, DoABC#2)
// InfoHotelClosedMessageParser = "_-3K9" (String#7707, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


