
package com.sulake.habbo.communication.messages.incoming.quest
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.quest.QuestMessageParser;

    public class QuestMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function QuestMessageEvent(_arg_1:Function)
        {
            super(_arg_1, QuestMessageParser);
        }
        public function getParser():QuestMessageParser
        {
            return ((_parser as QuestMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.quest

// QuestMessageEvent = "_-2xP" (String#7229, DoABC#2)
// QuestMessageParser = "_-0Wc" (String#4240, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


