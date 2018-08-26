
package com.sulake.habbo.communication.messages.incoming.poll
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.poll.PollErrorParser;

    public class PollErrorEvent extends MessageEvent implements IMessageEvent 
    {

        public function PollErrorEvent(_arg_1:Function)
        {
            super(_arg_1, PollErrorParser);
        }
        public function getParser():PollErrorParser
        {
            return ((_parser as PollErrorParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.poll

// PollErrorParser = "_-0KC" (String#3956, DoABC#2)
// PollErrorEvent = "_-9t" (String#22614, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


