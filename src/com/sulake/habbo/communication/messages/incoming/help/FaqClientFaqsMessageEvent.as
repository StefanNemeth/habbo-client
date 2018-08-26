
package com.sulake.habbo.communication.messages.incoming.help
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.help.FaqClientFaqsMessageParser;

    public class FaqClientFaqsMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function FaqClientFaqsMessageEvent(_arg_1:Function)
        {
            super(_arg_1, FaqClientFaqsMessageParser);
        }
        public function getParser():FaqClientFaqsMessageParser
        {
            return ((_parser as FaqClientFaqsMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.help

// FaqClientFaqsMessageParser = "_-2iS" (String#6919, DoABC#2)
// FaqClientFaqsMessageEvent = "_-0vA" (String#16244, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


