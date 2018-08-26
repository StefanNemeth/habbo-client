
package com.sulake.habbo.communication.messages.incoming.quest
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.quest.QuestsMessageParser;

    public class QuestsMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function QuestsMessageEvent(_arg_1:Function)
        {
            super(_arg_1, QuestsMessageParser);
        }
        public function getParser():QuestsMessageParser
        {
            return ((_parser as QuestsMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.quest

// QuestsMessageEvent = "_-0xi" (String#4803, DoABC#2)
// QuestsMessageParser = "_-0ra" (String#4677, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


