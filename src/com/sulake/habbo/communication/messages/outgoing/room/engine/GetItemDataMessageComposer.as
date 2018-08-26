
package com.sulake.habbo.communication.messages.outgoing.room.engine
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class GetItemDataMessageComposer implements IMessageComposer 
    {

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var _objectId:int = 0;

        public function GetItemDataMessageComposer(_arg_1:int, _arg_2:int=0, _arg_3:int=0)
        {
            this._objectId = _arg_1;
            this._roomId = _arg_2;
            this._roomCategory = _arg_3;
        }
        public function dispose():void
        {
        }
        public function getMessageArray():Array
        {
            return ([this._objectId]);
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.room.engine

// GetItemDataMessageComposer = "_-i7" (String#23970, DoABC#2)
// _objectId = "_-1YP" (String#18, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)


