
package com.sulake.habbo.communication.messages.incoming.help
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.help.CallForHelpResultMessageParser;

    public class CallForHelpResultMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function CallForHelpResultMessageEvent(_arg_1:Function)
        {
            super(_arg_1, CallForHelpResultMessageParser);
        }
        public function getParser():CallForHelpResultMessageParser
        {
            return ((_parser as CallForHelpResultMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.help

// CallForHelpResultMessageParser = "_-0Hy" (String#3915, DoABC#2)
// CallForHelpResultMessageEvent = "_-07k" (String#14353, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


