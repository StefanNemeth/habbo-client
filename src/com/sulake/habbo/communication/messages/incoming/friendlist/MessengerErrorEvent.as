
package com.sulake.habbo.communication.messages.incoming.friendlist
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.friendlist.MessengerErrorMessageParser;

    public class MessengerErrorEvent extends MessageEvent implements IMessageEvent 
    {

        public function MessengerErrorEvent(_arg_1:Function)
        {
            super(_arg_1, MessengerErrorMessageParser);
        }
        public function getParser():MessengerErrorMessageParser
        {
            return ((this._parser as MessengerErrorMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.friendlist

// MessengerErrorMessageParser = "_-9x" (String#7864, DoABC#2)
// MessengerErrorEvent = "_-2EF" (String#19577, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


