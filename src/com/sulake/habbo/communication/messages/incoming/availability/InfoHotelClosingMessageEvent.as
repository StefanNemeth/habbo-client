
package com.sulake.habbo.communication.messages.incoming.availability
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.availability.InfoHotelClosingMessageParser;

    public class InfoHotelClosingMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function InfoHotelClosingMessageEvent(_arg_1:Function)
        {
            super(_arg_1, InfoHotelClosingMessageParser);
        }
        public function getParser():InfoHotelClosingMessageParser
        {
            return ((_parser as InfoHotelClosingMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.availability

// InfoHotelClosingMessageParser = "_-1Iy" (String#5219, DoABC#2)
// InfoHotelClosingMessageEvent = "_-0eA" (String#15593, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


