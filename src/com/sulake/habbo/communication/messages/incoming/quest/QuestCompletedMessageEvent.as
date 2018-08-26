
package com.sulake.habbo.communication.messages.incoming.quest
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.quest.QuestCompletedMessageParser;

    public class QuestCompletedMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function QuestCompletedMessageEvent(_arg_1:Function)
        {
            super(_arg_1, QuestCompletedMessageParser);
        }
        public function getParser():QuestCompletedMessageParser
        {
            return ((_parser as QuestCompletedMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.quest

// QuestCompletedMessageEvent = "_-Kr" (String#8100, DoABC#2)
// QuestCompletedMessageParser = "_-0UU" (String#4192, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


