
package com.sulake.habbo.communication.messages.incoming.notifications
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.notifications.UnseenItemsParser;

    public class UnseenItemsEvent extends MessageEvent implements IMessageEvent 
    {

        public function UnseenItemsEvent(_arg_1:Function)
        {
            super(_arg_1, UnseenItemsParser);
        }
        public function getParser():UnseenItemsParser
        {
            return ((_parser as UnseenItemsParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.notifications

// UnseenItemsParser = "_-185" (String#16780, DoABC#2)
// UnseenItemsEvent = "_-0ZA" (String#4282, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


