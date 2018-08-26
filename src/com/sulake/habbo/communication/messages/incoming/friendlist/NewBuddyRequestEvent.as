
package com.sulake.habbo.communication.messages.incoming.friendlist
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.friendlist.NewBuddyRequestMessageParser;

    public class NewBuddyRequestEvent extends MessageEvent implements IMessageEvent 
    {

        public function NewBuddyRequestEvent(_arg_1:Function)
        {
            super(_arg_1, NewBuddyRequestMessageParser);
        }
        public function getParser():NewBuddyRequestMessageParser
        {
            return ((this._parser as NewBuddyRequestMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.friendlist

// NewBuddyRequestEvent = "_-1iS" (String#5721, DoABC#2)
// NewBuddyRequestMessageParser = "_-2Qd" (String#6572, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


