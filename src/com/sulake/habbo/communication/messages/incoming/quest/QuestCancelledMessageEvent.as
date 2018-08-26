
package com.sulake.habbo.communication.messages.incoming.quest
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.quest.QuestCancelledMessageParser;

    public class QuestCancelledMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function QuestCancelledMessageEvent(_arg_1:Function)
        {
            super(_arg_1, QuestCancelledMessageParser);
        }
        public function getParser():QuestCancelledMessageParser
        {
            return ((_parser as QuestCancelledMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.quest

// QuestCancelledMessageEvent = "_-0Xi" (String#4262, DoABC#2)
// QuestCancelledMessageParser = "_-2Lc" (String#6475, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


