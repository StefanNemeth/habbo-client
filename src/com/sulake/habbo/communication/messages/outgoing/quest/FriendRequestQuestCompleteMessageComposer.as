
package com.sulake.habbo.communication.messages.outgoing.quest
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;

    public class FriendRequestQuestCompleteMessageComposer implements IMessageComposer, IDisposable 
    {

        private var _messageArray:Array;

        public function FriendRequestQuestCompleteMessageComposer()
        {
            this._messageArray = new Array();
            super();
        }
        public function getMessageArray():Array
        {
            return (this._messageArray);
        }
        public function dispose():void
        {
            this._messageArray = null;
        }
        public function get disposed():Boolean
        {
            return (false);
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.quest

// FriendRequestQuestCompleteMessageComposer = "_-3LQ" (String#22344, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// _messageArray = "_-2oC" (String#11, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)


