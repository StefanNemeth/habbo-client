
package com.sulake.habbo.communication.messages.outgoing.room.engine
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class MoveWallItemMessageComposer implements IMessageComposer 
    {

        private var _data:Array;

        public function MoveWallItemMessageComposer(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:int=0, _arg_5:int=0)
        {
            this._data = [];
            super();
            this._data.push(_arg_1);
            this._data.push(_arg_3);
        }
        public function dispose():void
        {
            this._data = null;
        }
        public function getMessageArray():Array
        {
            return (this._data);
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.room.engine

// MoveWallItemMessageComposer = "_-13v" (String#16614, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)


