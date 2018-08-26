
package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class RoomDimmerChangeStateMessageComposer implements IMessageComposer 
    {

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;

        public function RoomDimmerChangeStateMessageComposer(_arg_1:int=0, _arg_2:int=0)
        {
            this._roomId = _arg_1;
            this._roomCategory = _arg_2;
        }
        public function getMessageArray():Array
        {
            return ([]);
        }
        public function dispose():void
        {
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.room.furniture

// RoomDimmerChangeStateMessageComposer = "_-IN" (String#22945, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)


