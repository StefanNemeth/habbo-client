
package com.sulake.habbo.session.events
{
    import flash.events.Event;

    public class UserTagsReceivedEvent extends Event 
    {

        public static const RWUTUE_USER_TAGS:String = "UTRE_USER_TAGS_RECEIVED";

        private var _userId:int;
        private var _tags:Array;

        public function UserTagsReceivedEvent(_arg_1:int, _arg_2:Array, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(RWUTUE_USER_TAGS, _arg_3, _arg_4);
            this._userId = _arg_1;
            this._tags = _arg_2;
        }
        public function get userId():int
        {
            return (this._userId);
        }
        public function get tags():Array
        {
            return (this._tags);
        }

    }
}//package com.sulake.habbo.session.events

// UserTagsReceivedEvent = "_-09C" (String#14416, DoABC#2)
// _tags = "_-1NU" (String#163, DoABC#2)
// RWUTUE_USER_TAGS = "_-1la" (String#18357, DoABC#2)


