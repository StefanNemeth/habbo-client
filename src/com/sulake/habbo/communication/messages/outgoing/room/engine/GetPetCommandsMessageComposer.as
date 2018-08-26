
package com.sulake.habbo.communication.messages.outgoing.room.engine
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class GetPetCommandsMessageComposer implements IMessageComposer 
    {

        private var _id:int;
        private var _roomId:int;
        private var _roomCategory:int;

        public function GetPetCommandsMessageComposer(_arg_1:int, _arg_2:int=0, _arg_3:int=0)
        {
            this._id = _arg_1;
            this._roomId = _arg_2;
            this._roomCategory = _arg_3;
        }
        public function dispose():void
        {
        }
        public function getMessageArray():Array
        {
            return ([this._id]);
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.room.engine

// GetPetCommandsMessageComposer = "_-1Mp" (String#17393, DoABC#2)
// _id = "_-0VE" (String#148, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)


