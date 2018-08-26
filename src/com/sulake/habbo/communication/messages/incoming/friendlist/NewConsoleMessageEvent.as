
package com.sulake.habbo.communication.messages.incoming.friendlist
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.friendlist.NewConsoleMessageMessageParser;

    public class NewConsoleMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function NewConsoleMessageEvent(_arg_1:Function)
        {
            super(_arg_1, NewConsoleMessageMessageParser);
        }
        public function getParser():NewConsoleMessageMessageParser
        {
            return ((this._parser as NewConsoleMessageMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.friendlist

// NewConsoleMessageMessageParser = "_-01u" (String#14124, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


