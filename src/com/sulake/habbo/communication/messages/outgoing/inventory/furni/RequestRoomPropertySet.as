
package com.sulake.habbo.communication.messages.outgoing.inventory.furni
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class RequestRoomPropertySet implements IMessageComposer 
    {

        private var _stripId:int = 0;

        public function RequestRoomPropertySet(_arg_1:int)
        {
            this._stripId = _arg_1;
        }
        public function dispose():void
        {
        }
        public function getMessageArray():Array
        {
            var _local_1:Array = new Array();
            _local_1.push(this._stripId);
            return (_local_1);
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.inventory.furni

// RequestRoomPropertySet = "_-6-" (String#22465, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)
// _stripId = "_-dH" (String#2144, DoABC#2)


