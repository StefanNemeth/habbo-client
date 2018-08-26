
package com.sulake.habbo.communication.messages.parser.quest
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.quest.QuestMessageData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class QuestMessageParser implements IMessageParser 
    {

        private var _quest:QuestMessageData;

        public function flush():Boolean
        {
            this._quest = null;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._quest = new QuestMessageData(_arg_1);
            return (true);
        }
        public function get quest():QuestMessageData
        {
            return (this._quest);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.quest

// QuestMessageData = "_-2Vr" (String#20275, DoABC#2)
// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// QuestMessageParser = "_-0Wc" (String#4240, DoABC#2)
// _quest = "_-26O" (String#876, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


