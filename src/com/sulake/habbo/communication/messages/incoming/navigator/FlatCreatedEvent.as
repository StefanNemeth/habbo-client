
package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.navigator.FlatCreatedMessageParser;

    public class FlatCreatedEvent extends MessageEvent implements IMessageEvent 
    {

        public function FlatCreatedEvent(_arg_1:Function)
        {
            super(_arg_1, FlatCreatedMessageParser);
        }
        public function getParser():FlatCreatedMessageParser
        {
            return ((this._parser as FlatCreatedMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.navigator

// FlatCreatedEvent = "_-2fj" (String#20682, DoABC#2)
// FlatCreatedMessageParser = "_-2nr" (String#7037, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


