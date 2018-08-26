
package com.sulake.habbo.communication.messages.outgoing.room.session
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class GoToFlatMessageComposer implements IMessageComposer 
    {

        private var _roomId:int;
        private var _roomCategory:int = 0;

        public function GoToFlatMessageComposer(_arg_1:int, _arg_2:int=0)
        {
            this._roomId = _arg_1;
            this._roomCategory = _arg_2;
        }
        public function dispose():void
        {
        }
        public function getMessageArray():Array
        {
            return ([this._roomId]);
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.room.session

// GoToFlatMessageComposer = "_-1W0" (String#17744, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)


