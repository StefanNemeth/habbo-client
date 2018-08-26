
package com.sulake.habbo.friendbar.events
{
    import flash.events.Event;

    public class FriendBarUpdateEvent extends Event 
    {

        public static const FBE_UPDATED:String = "FBE_UPDATED";

        public function FriendBarUpdateEvent()
        {
            super(FBE_UPDATED, false, false);
        }
    }
}//package com.sulake.habbo.friendbar.events

// FriendBarUpdateEvent = "_-UZ" (String#23430, DoABC#2)
// FBE_UPDATED = "_-06G" (String#14296, DoABC#2)


