
package com.sulake.habbo.friendbar.events
{
    import flash.events.Event;

    public class FriendRequestUpdateEvent extends Event 
    {

        public static const FBE_REQUESTS:String = "FBE_REQUESTS";

        public function FriendRequestUpdateEvent()
        {
            super(FBE_REQUESTS, false, false);
        }
    }
}//package com.sulake.habbo.friendbar.events

// FriendRequestUpdateEvent = "_-0JS" (String#14820, DoABC#2)
// FBE_REQUESTS = "_-011" (String#14096, DoABC#2)


