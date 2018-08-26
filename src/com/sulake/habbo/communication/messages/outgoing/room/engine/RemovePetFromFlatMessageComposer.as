
package com.sulake.habbo.communication.messages.outgoing.room.engine
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class RemovePetFromFlatMessageComposer implements IMessageComposer 
    {

        private var _id:int;

        public function RemovePetFromFlatMessageComposer(_arg_1:int)
        {
            this._id = _arg_1;
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

// RemovePetFromFlatMessageComposer = "_-1so" (String#18669, DoABC#2)
// _id = "_-0VE" (String#148, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)


