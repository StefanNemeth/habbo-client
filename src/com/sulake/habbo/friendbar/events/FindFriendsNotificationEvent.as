
package com.sulake.habbo.friendbar.events
{
    import flash.events.Event;

    public class FindFriendsNotificationEvent extends Event 
    {

        public static const TYPE:String = "FIND_FRIENDS_RESULT";

        private var _success:Boolean;

        public function FindFriendsNotificationEvent(_arg_1:Boolean)
        {
            this._success = _arg_1;
            super(TYPE);
        }
        public function get success():Boolean
        {
            return (this._success);
        }

    }
}//package com.sulake.habbo.friendbar.events

// FindFriendsNotificationEvent = "_-2xi" (String#21383, DoABC#2)
// _success = "_-0Vx" (String#1489, DoABC#2)


