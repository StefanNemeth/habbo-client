
package com.sulake.habbo.communication.messages.outgoing.room.publicroom
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class ChangeRoomMessageComposer implements IMessageComposer 
    {

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var _worldId:int = 0;

        public function ChangeRoomMessageComposer(_arg_1:int, _arg_2:int=0, _arg_3:int=0)
        {
            this._roomId = _arg_2;
            this._roomCategory = _arg_3;
            this._worldId = _arg_1;
        }
        public function dispose():void
        {
        }
        public function getMessageArray():Array
        {
            return ([this._worldId]);
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.room.publicroom

// ChangeRoomMessageComposer = "_-12g" (String#16566, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)
// _worldId = "_-pp" (String#944, DoABC#2)


