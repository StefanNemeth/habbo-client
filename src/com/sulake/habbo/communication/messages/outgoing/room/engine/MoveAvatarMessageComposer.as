
package com.sulake.habbo.communication.messages.outgoing.room.engine
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class MoveAvatarMessageComposer implements IMessageComposer 
    {

        private var _x:int;
        private var _y:int;
        private var _roomId:int;
        private var _roomCategory:int = 0;

        public function MoveAvatarMessageComposer(_arg_1:int, _arg_2:int, _arg_3:int=0, _arg_4:int=0)
        {
            this._x = _arg_1;
            this._y = _arg_2;
            this._roomId = _arg_3;
            this._roomCategory = _arg_4;
        }
        public function dispose():void
        {
        }
        public function getMessageArray():Array
        {
            return ([this._x, this._y]);
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.room.engine

// MoveAvatarMessageComposer = "_-1xR" (String#18866, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)
// _y = "_-02f" (String#64, DoABC#2)


