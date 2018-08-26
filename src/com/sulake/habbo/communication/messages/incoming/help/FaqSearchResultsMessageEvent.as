
package com.sulake.habbo.communication.messages.incoming.help
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.help.FaqSearchResultsMessageParser;

    public class FaqSearchResultsMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function FaqSearchResultsMessageEvent(_arg_1:Function)
        {
            super(_arg_1, FaqSearchResultsMessageParser);
        }
        public function getParser():FaqSearchResultsMessageParser
        {
            return ((_parser as FaqSearchResultsMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.help

// FaqSearchResultsMessageEvent = "_-Pm" (String#23238, DoABC#2)
// FaqSearchResultsMessageParser = "_-0wG" (String#4775, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


