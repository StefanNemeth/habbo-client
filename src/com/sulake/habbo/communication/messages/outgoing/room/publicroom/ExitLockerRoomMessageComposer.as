
package com.sulake.habbo.communication.messages.outgoing.room.publicroom
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class ExitLockerRoomMessageComposer implements IMessageComposer 
    {

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;

        public function ExitLockerRoomMessageComposer(_arg_1:int=0, _arg_2:int=0)
        {
            this._roomId = _arg_1;
            this._roomCategory = _arg_2;
        }
        public function dispose():void
        {
        }
        public function getMessageArray():Array
        {
            return ([]);
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.room.publicroom

// ExitLockerRoomMessageComposer = "_-2Rr" (String#20112, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)


