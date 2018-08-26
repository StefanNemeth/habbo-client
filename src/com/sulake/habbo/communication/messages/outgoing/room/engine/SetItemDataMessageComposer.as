
package com.sulake.habbo.communication.messages.outgoing.room.engine
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class SetItemDataMessageComposer implements IMessageComposer 
    {

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var _objectId:int;
        private var _data:String;

        public function SetItemDataMessageComposer(_arg_1:int, _arg_2:String="", _arg_3:int=0, _arg_4:int=0)
        {
            this._objectId = _arg_1;
            this._data = _arg_2;
            this._roomId = _arg_3;
            this._roomCategory = _arg_4;
        }
        public function dispose():void
        {
        }
        public function getMessageArray():Array
        {
            return ([this._objectId, this._data]);
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.room.engine

// SetItemDataMessageComposer = "_-29t" (String#19399, DoABC#2)
// _objectId = "_-1YP" (String#18, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)


