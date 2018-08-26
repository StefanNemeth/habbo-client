
package com.sulake.habbo.communication.messages.incoming.poll
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.poll.VoteResultMessageParser;

    public class VoteResultMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function VoteResultMessageEvent(_arg_1:Function)
        {
            super(_arg_1, VoteResultMessageParser);
        }
        public function getParser():VoteResultMessageParser
        {
            return ((this._parser as VoteResultMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.poll

// VoteResultMessageParser = "_-b6" (String#8443, DoABC#2)
// VoteResultMessageEvent = "_-1Gz" (String#17150, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


