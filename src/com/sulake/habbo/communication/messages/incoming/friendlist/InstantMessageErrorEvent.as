
package com.sulake.habbo.communication.messages.incoming.friendlist
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.friendlist.InstantMessageErrorMessageParser;

    public class InstantMessageErrorEvent extends MessageEvent implements IMessageEvent 
    {

        public function InstantMessageErrorEvent(_arg_1:Function)
        {
            super(_arg_1, InstantMessageErrorMessageParser);
        }
        public function getParser():InstantMessageErrorMessageParser
        {
            return ((this._parser as InstantMessageErrorMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.friendlist

// InstantMessageErrorEvent = "_-3Eh" (String#22062, DoABC#2)
// InstantMessageErrorMessageParser = "_-1eQ" (String#5636, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


