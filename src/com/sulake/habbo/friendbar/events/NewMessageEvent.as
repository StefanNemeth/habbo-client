
package com.sulake.habbo.friendbar.events
{
    import flash.events.Event;

    public class NewMessageEvent extends Event 
    {

        public static const FBE_MESSAGE:String = "FBE_MESSAGE";

        public var notify:Boolean;
        public var senderId:int;

        public function NewMessageEvent(_arg_1:Boolean, _arg_2:int)
        {
            super(FBE_MESSAGE, false, false);
            this.notify = _arg_1;
            this.senderId = _arg_2;
        }
    }
}//package com.sulake.habbo.friendbar.events

// NewMessageEvent = "_-3Cc" (String#21980, DoABC#2)
// senderId = "_-2GI" (String#19654, DoABC#2)
// FBE_MESSAGE = "_-28K" (String#19344, DoABC#2)


