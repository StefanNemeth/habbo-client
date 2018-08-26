
package com.sulake.habbo.communication.messages.incoming.poll
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.poll.PollOfferParser;

    public class PollOfferEvent extends MessageEvent implements IMessageEvent 
    {

        public function PollOfferEvent(_arg_1:Function)
        {
            super(_arg_1, PollOfferParser);
        }
        public function getParser():PollOfferParser
        {
            return ((_parser as PollOfferParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.poll

// PollOfferEvent = "_-37p" (String#21798, DoABC#2)
// PollOfferParser = "_-13H" (String#4940, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


