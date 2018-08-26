
package com.sulake.habbo.communication.messages.incoming.help
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.help.FaqTextMessageParser;

    public class FaqTextMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function FaqTextMessageEvent(_arg_1:Function)
        {
            super(_arg_1, FaqTextMessageParser);
        }
        public function getParser():FaqTextMessageParser
        {
            return ((_parser as FaqTextMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.help

// FaqTextMessageEvent = "_-0Cr" (String#14565, DoABC#2)
// FaqTextMessageParser = "_-1tS" (String#5910, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


