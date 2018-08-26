
package com.sulake.habbo.communication.messages.incoming.poll
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.poll.PollContentsParser;

    public class PollContentsEvent extends MessageEvent implements IMessageEvent 
    {

        public function PollContentsEvent(_arg_1:Function)
        {
            super(_arg_1, PollContentsParser);
        }
        public function getParser():PollContentsParser
        {
            return ((_parser as PollContentsParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.poll

// PollContentsEvent = "_-0Fi" (String#14671, DoABC#2)
// PollContentsParser = "_-125" (String#4918, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


