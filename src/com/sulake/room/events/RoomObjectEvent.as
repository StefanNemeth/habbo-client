
package com.sulake.room.events
{
    import flash.events.Event;

    public class RoomObjectEvent extends Event 
    {

        private var _objectId:int = 0;
        private var _objectType:String = "";

        public function RoomObjectEvent(_arg_1:String, _arg_2:int, _arg_3:String, _arg_4:Boolean=false, _arg_5:Boolean=false)
        {
            super(_arg_1, _arg_4, _arg_5);
            this._objectId = _arg_2;
            this._objectType = _arg_3;
        }
        public function get objectId():int
        {
            return (this._objectId);
        }
        public function get objectType():String
        {
            return (this._objectType);
        }

    }
}//package com.sulake.room.events

// _objectId = "_-1YP" (String#18, DoABC#2)
// _objectType = "_-eP" (String#939, DoABC#2)
// objectType = "_-23O" (String#19148, DoABC#2)


