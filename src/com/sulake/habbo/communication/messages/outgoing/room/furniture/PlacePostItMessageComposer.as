
package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class PlacePostItMessageComposer implements IMessageComposer 
    {

        private var _itemId:int;
        private var _location:String;

        public function PlacePostItMessageComposer(_arg_1:int, _arg_2:String)
        {
            this._itemId = _arg_1;
            this._location = _arg_2;
        }
        public function dispose():void
        {
        }
        public function getMessageArray():Array
        {
            return ([this._itemId, this._location]);
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.room.furniture

// PlacePostItMessageComposer = "_-CG" (String#22700, DoABC#2)
// _location = "_-245" (String#244, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)
// _itemId = "_-01C" (String#574, DoABC#2)


