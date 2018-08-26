
package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetSpamWallPostItEditEvent extends RoomWidgetUpdateEvent 
    {

        public static const RWSWPUE_OPEN_EDITOR:String = "RWSWPUE_OPEN_EDITOR";

        private var _objectId:int;
        private var _location:String;
        private var _objectType:String;

        public function RoomWidgetSpamWallPostItEditEvent(_arg_1:String, _arg_2:int, _arg_3:String, _arg_4:String, _arg_5:Boolean=false, _arg_6:Boolean=false)
        {
            super(_arg_1, _arg_5, _arg_6);
            this._objectId = _arg_2;
            this._location = _arg_3;
            this._objectType = _arg_4;
        }
        public function get location():String
        {
            return (this._location);
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
}//package com.sulake.habbo.ui.widget.events

// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// RoomWidgetSpamWallPostItEditEvent = "_-0n1" (String#15941, DoABC#2)
// _objectId = "_-1YP" (String#18, DoABC#2)
// _location = "_-245" (String#244, DoABC#2)
// _objectType = "_-eP" (String#939, DoABC#2)
// objectType = "_-23O" (String#19148, DoABC#2)
// RWSWPUE_OPEN_EDITOR = "_-1kX" (String#18309, DoABC#2)


