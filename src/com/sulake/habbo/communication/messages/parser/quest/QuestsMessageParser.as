
package com.sulake.habbo.communication.messages.parser.quest
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.quest.QuestMessageData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class QuestsMessageParser implements IMessageParser 
    {

        private var _quests:Array;
        private var _openWindow:Boolean;

        public function flush():Boolean
        {
            this._quests = [];
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_2:int = _arg_1.readInteger();
            var _local_3:int;
            while (_local_3 < _local_2) {
                this._quests.push(new QuestMessageData(_arg_1));
                _local_3++;
            };
            this._openWindow = _arg_1.readBoolean();
            return (true);
        }
        public function get quests():Array
        {
            return (this._quests);
        }
        public function get openWindow():Boolean
        {
            return (this._openWindow);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.quest

// QuestMessageData = "_-2Vr" (String#20275, DoABC#2)
// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// QuestsMessageParser = "_-0ra" (String#4677, DoABC#2)
// readBoolean = "_-0ZR" (String#1499, DoABC#2)
// _quests = "_-0jY" (String#4492, DoABC#2)
// _openWindow = "_-0ds" (String#15580, DoABC#2)
// quests = "_-Bu" (String#22684, DoABC#2)
// openWindow = "_-1na" (String#18444, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


