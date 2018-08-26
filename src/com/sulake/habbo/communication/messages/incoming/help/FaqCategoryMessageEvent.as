
package com.sulake.habbo.communication.messages.incoming.help
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.help.FaqCategoryMessageParser;

    public class FaqCategoryMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function FaqCategoryMessageEvent(_arg_1:Function)
        {
            super(_arg_1, FaqCategoryMessageParser);
        }
        public function getParser():FaqCategoryMessageParser
        {
            return ((_parser as FaqCategoryMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.help

// FaqCategoryMessageParser = "_-1hX" (String#5698, DoABC#2)
// FaqCategoryMessageEvent = "_-248" (String#19181, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


