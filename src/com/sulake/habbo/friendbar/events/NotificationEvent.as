
package com.sulake.habbo.friendbar.events
{
    import flash.events.Event;
    import com.sulake.habbo.friendbar.data.FriendNotification;

    public class NotificationEvent extends Event 
    {

        public static const FBE_NOTIFICATION_EVENT:String = "FBE_NOTIFICATION_EVENT";

        public var friendId:int;
        public var notification:FriendNotification;

        public function NotificationEvent(_arg_1:int, _arg_2:FriendNotification)
        {
            super(FBE_NOTIFICATION_EVENT);
            this.friendId = _arg_1;
            this.notification = _arg_2;
        }
    }
}//package com.sulake.habbo.friendbar.events

// NotificationEvent = "_-mt" (String#24147, DoABC#2)
// FBE_NOTIFICATION_EVENT = "_-cr" (String#23749, DoABC#2)


