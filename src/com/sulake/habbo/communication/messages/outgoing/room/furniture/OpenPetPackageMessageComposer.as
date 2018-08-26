
package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class OpenPetPackageMessageComposer implements IMessageComposer 
    {

        private var _objectId:int;
        private var _petName:String;

        public function OpenPetPackageMessageComposer(_arg_1:int, _arg_2:String)
        {
            this._objectId = _arg_1;
            this._petName = _arg_2;
        }
        public function getMessageArray():Array
        {
            return ([this._objectId, this._petName]);
        }
        public function dispose():void
        {
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.room.furniture

// OpenPetPackageMessageComposer = "_-uW" (String#24471, DoABC#2)
// _objectId = "_-1YP" (String#18, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)
// _petName = "_-3FT" (String#7618, DoABC#2)


