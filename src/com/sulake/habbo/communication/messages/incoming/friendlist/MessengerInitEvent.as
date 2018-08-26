
package com.sulake.habbo.communication.messages.incoming.friendlist
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.friendlist.MessengerInitMessageParser;

    public class MessengerInitEvent extends MessageEvent implements IMessageEvent 
    {

        public function MessengerInitEvent(_arg_1:Function)
        {
            super(_arg_1, MessengerInitMessageParser);
        }
        public function getParser():MessengerInitMessageParser
        {
            return ((this._parser as MessengerInitMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.friendlist

// MessengerInitEvent = "_-0pu" (String#4632, DoABC#2)
// MessengerInitMessageParser = "_-1W5" (String#5474, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


