
package com.sulake.habbo.communication.messages.incoming.help
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.help.FaqCategoriesMessageParser;

    public class FaqCategoriesMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function FaqCategoriesMessageEvent(_arg_1:Function)
        {
            super(_arg_1, FaqCategoriesMessageParser);
        }
        public function getParser():FaqCategoriesMessageParser
        {
            return ((_parser as FaqCategoriesMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.help

// FaqCategoriesMessageParser = "_-4R" (String#7755, DoABC#2)
// FaqCategoriesMessageEvent = "_-0OG" (String#14999, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


