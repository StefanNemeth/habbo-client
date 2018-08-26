
package com.sulake.habbo.communication.messages.outgoing.room.pets
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class GetPetInfoMessageComposer implements IMessageComposer 
    {

        private var _id:int;

        public function GetPetInfoMessageComposer(_arg_1:int)
        {
            this._id = _arg_1;
        }
        public function getMessageArray():Array
        {
            return ([this._id]);
        }
        public function dispose():void
        {
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.room.pets

// GetPetInfoMessageComposer = "_-fj" (String#23877, DoABC#2)
// _id = "_-0VE" (String#148, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)


