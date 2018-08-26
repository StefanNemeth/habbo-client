
package com.sulake.habbo.communication.messages.parser.quest
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.quest.QuestMessageData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class QuestCompletedMessageParser implements IMessageParser 
    {

        private var _questData:QuestMessageData;

        public function flush():Boolean
        {
            this._questData = null;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._questData = new QuestMessageData(_arg_1);
            return (true);
        }
        public function get questData():QuestMessageData
        {
            return (this._questData);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.quest

// QuestMessageData = "_-2Vr" (String#20275, DoABC#2)
// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// QuestCompletedMessageParser = "_-0UU" (String#4192, DoABC#2)
// _questData = "_-0C" (String#14527, DoABC#2)
// questData = "_-2gU" (String#20709, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


