
package com.sulake.habbo.communication.messages.outgoing.quest
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class AcceptQuestMessageComposer implements IMessageComposer 
    {

        private var _data:Array;

        public function AcceptQuestMessageComposer(_arg_1:int)
        {
            this._data = [];
            super();
            this._data.push(_arg_1);
        }
        public function getMessageArray():Array
        {
            return (this._data);
        }
        public function dispose():void
        {
            this._data = null;
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.quest

// AcceptQuestMessageComposer = "_-Th" (String#23394, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)


