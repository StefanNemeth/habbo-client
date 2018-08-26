
package com.sulake.habbo.communication.messages.incoming.availability
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.availability.LoginFailedHotelClosedMessageParser;

    public class LoginFailedHotelClosedMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function LoginFailedHotelClosedMessageEvent(_arg_1:Function)
        {
            super(_arg_1, LoginFailedHotelClosedMessageParser);
        }
        public function getParser():LoginFailedHotelClosedMessageParser
        {
            return ((_parser as LoginFailedHotelClosedMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.availability

// LoginFailedHotelClosedMessageParser = "_-1rF" (String#5879, DoABC#2)
// LoginFailedHotelClosedMessageEvent = "_-lF" (String#24079, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


