
package com.sulake.habbo.communication.messages.incoming.friendlist
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.friendlist.AcceptBuddyResultMessageParser;

    public class AcceptBuddyResultEvent extends MessageEvent implements IMessageEvent 
    {

        public function AcceptBuddyResultEvent(_arg_1:Function)
        {
            super(_arg_1, AcceptBuddyResultMessageParser);
        }
        public function getParser():AcceptBuddyResultMessageParser
        {
            return ((this._parser as AcceptBuddyResultMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.friendlist

// AcceptBuddyResultMessageParser = "_-2AZ" (String#6257, DoABC#2)
// AcceptBuddyResultEvent = "_-32P" (String#7356, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


