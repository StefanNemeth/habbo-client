
package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class QuestVendingWallItemMessageComposer implements IMessageComposer 
    {

        private var _objectId:int;

        public function QuestVendingWallItemMessageComposer(_arg_1:int)
        {
            this._objectId = _arg_1;
        }
        public function dispose():void
        {
        }
        public function getMessageArray():Array
        {
            return ([this._objectId]);
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.room.furniture

// QuestVendingWallItemMessageComposer = "_-1Tf" (String#17651, DoABC#2)
// _objectId = "_-1YP" (String#18, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)


