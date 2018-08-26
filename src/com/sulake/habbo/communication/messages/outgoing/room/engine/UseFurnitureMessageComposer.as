
package com.sulake.habbo.communication.messages.outgoing.room.engine
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class UseFurnitureMessageComposer implements IMessageComposer 
    {

        private var _objectId:int;
        private var _param:int = 0;
        private var _roomId:int;
        private var _roomCategory:int = 0;

        public function UseFurnitureMessageComposer(_arg_1:int, _arg_2:int=0, _arg_3:int=0, _arg_4:int=0)
        {
            this._objectId = _arg_1;
            this._param = _arg_2;
            this._roomId = _arg_3;
            this._roomCategory = _arg_4;
        }
        public function dispose():void
        {
        }
        public function getMessageArray():Array
        {
            return ([this._objectId, this._param]);
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.room.engine

// UseFurnitureMessageComposer = "_-0I2" (String#14759, DoABC#2)
// _objectId = "_-1YP" (String#18, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)
// _param = "_-2d3" (String#306, DoABC#2)


