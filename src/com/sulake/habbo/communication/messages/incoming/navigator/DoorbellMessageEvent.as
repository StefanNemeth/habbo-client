
package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.navigator.DoorbellMessageParser;

    public class DoorbellMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function DoorbellMessageEvent(_arg_1:Function)
        {
            super(_arg_1, DoorbellMessageParser);
        }
        public function get userName():String
        {
            return ((this._parser as DoorbellMessageParser).userName);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.navigator

// DoorbellMessageEvent = "_-03C" (String#14170, DoABC#2)
// DoorbellMessageParser = "_-aH" (String#8426, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


