
package com.sulake.habbo.communication.messages.incoming.friendlist
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.friendlist.HabboSearchResultMessageParser;

    public class HabboSearchResultEvent extends MessageEvent implements IMessageEvent 
    {

        public function HabboSearchResultEvent(_arg_1:Function)
        {
            super(_arg_1, HabboSearchResultMessageParser);
        }
        public function getParser():HabboSearchResultMessageParser
        {
            return ((this._parser as HabboSearchResultMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.friendlist

// HabboSearchResultMessageParser = "_-2vu" (String#7199, DoABC#2)
// HabboSearchResultEvent = "_-20z" (String#6063, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


