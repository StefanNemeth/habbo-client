
package com.sulake.habbo.communication.messages.outgoing.room.publicroom
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class TryBusMessageComposer implements IMessageComposer 
    {

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;

        public function TryBusMessageComposer(_arg_1:int=0, _arg_2:int=0)
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

// TryBusMessageComposer = "_-0ym" (String#16382, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)


