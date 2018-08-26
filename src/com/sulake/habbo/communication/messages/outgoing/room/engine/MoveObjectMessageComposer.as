
package com.sulake.habbo.communication.messages.outgoing.room.engine
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class MoveObjectMessageComposer implements IMessageComposer 
    {

        private var _objectId:int;
        private var _x:int;
        private var _y:int;
        private var _direction:int;
        private var _roomId:int;
        private var _roomCategory:int = 0;

        public function MoveObjectMessageComposer(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int=0, _arg_6:int=0)
        {
            this._objectId = _arg_1;
            this._x = _arg_2;
            this._y = _arg_3;
            this._direction = _arg_4;
            this._roomId = _arg_5;
            this._roomCategory = _arg_6;
        }
        public function dispose():void
        {
        }
        public function getMessageArray():Array
        {
            return ([this._objectId, this._x, this._y, this._direction]);
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.room.engine

// MoveObjectMessageComposer = "_-0e6" (String#15589, DoABC#2)
// _objectId = "_-1YP" (String#18, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)
// _y = "_-02f" (String#64, DoABC#2)


