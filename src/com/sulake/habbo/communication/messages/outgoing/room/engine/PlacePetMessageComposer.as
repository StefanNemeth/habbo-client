
package com.sulake.habbo.communication.messages.outgoing.room.engine
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class PlacePetMessageComposer implements IMessageComposer 
    {

        private var _id:int;
        private var _x:int;
        private var _y:int;
        private var _roomId:int;
        private var _roomCategory:int;

        public function PlacePetMessageComposer(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int=0, _arg_5:int=0)
        {
            this._id = _arg_1;
            this._x = _arg_2;
            this._y = _arg_3;
            this._roomId = _arg_4;
            this._roomCategory = _arg_5;
        }
        public function dispose():void
        {
        }
        public function getMessageArray():Array
        {
            return ([this._id, this._x, this._y]);
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.room.engine

// PlacePetMessageComposer = "_-1qF" (String#18553, DoABC#2)
// _id = "_-0VE" (String#148, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)
// _y = "_-02f" (String#64, DoABC#2)


