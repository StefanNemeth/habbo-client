
package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetUserTagsUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const RWUTUE_USER_TAGS:String = "RWUTUE_USER_TAGS";

        private var _userId:int;
        private var _tags:Array;
        private var _isOwnUser:Boolean;

        public function RoomWidgetUserTagsUpdateEvent(_arg_1:int, _arg_2:Array, _arg_3:Boolean, _arg_4:Boolean=false, _arg_5:Boolean=false)
        {
            super(RWUTUE_USER_TAGS, _arg_4, _arg_5);
            this._userId = _arg_1;
            this._tags = _arg_2;
            this._isOwnUser = _arg_3;
        }
        public function get userId():int
        {
            return (this._userId);
        }
        public function get tags():Array
        {
            return (this._tags);
        }
        public function get isOwnUser():Boolean
        {
            return (this._isOwnUser);
        }

    }
}//package com.sulake.habbo.ui.widget.events

// _isOwnUser = "_-1AC" (String#5081, DoABC#2)
// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// RoomWidgetUserTagsUpdateEvent = "_-006" (String#14057, DoABC#2)
// _tags = "_-1NU" (String#163, DoABC#2)
// RWUTUE_USER_TAGS = "_-1la" (String#18357, DoABC#2)
// isOwnUser = "_-Je" (String#22991, DoABC#2)


