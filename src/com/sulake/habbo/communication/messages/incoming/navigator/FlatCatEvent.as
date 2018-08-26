
package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.navigator.FlatCatMessageParser;

    public class FlatCatEvent extends MessageEvent implements IMessageEvent 
    {

        public function FlatCatEvent(_arg_1:Function)
        {
            super(_arg_1, FlatCatMessageParser);
        }
        public function getParser():FlatCatMessageParser
        {
            return ((this._parser as FlatCatMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.navigator

// FlatCatEvent = "_-vD" (String#24499, DoABC#2)
// FlatCatMessageParser = "_-mh" (String#8655, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


