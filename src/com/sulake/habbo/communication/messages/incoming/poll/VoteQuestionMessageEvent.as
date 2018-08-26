
package com.sulake.habbo.communication.messages.incoming.poll
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.poll.VoteQuestionMessageParser;

    public class VoteQuestionMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function VoteQuestionMessageEvent(_arg_1:Function)
        {
            super(_arg_1, VoteQuestionMessageParser);
        }
        public function getParser():VoteQuestionMessageParser
        {
            return ((_parser as VoteQuestionMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.poll

// VoteQuestionMessageEvent = "_-1WZ" (String#17761, DoABC#2)
// VoteQuestionMessageParser = "_-2bI" (String#6778, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


