
package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.navigator.FlatAccessDeniedMessageParser;

    public class FlatAccessDeniedMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function FlatAccessDeniedMessageEvent(_arg_1:Function)
        {
            super(_arg_1, FlatAccessDeniedMessageParser);
        }
        public function getParser():FlatAccessDeniedMessageParser
        {
            return ((_parser as FlatAccessDeniedMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.navigator

// FlatAccessDeniedMessageParser = "_-1oe" (String#5835, DoABC#2)
// FlatAccessDeniedMessageEvent = "_-3Cj" (String#7570, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


