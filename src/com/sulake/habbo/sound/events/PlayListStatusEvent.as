
package com.sulake.habbo.sound.events
{
    import flash.events.Event;

    public class PlayListStatusEvent extends Event 
    {

        public static const RWPLEE_PLAY_LIST_UPDATED:String = "PLUE_PLAY_LIST_UPDATED";
        public static const RWPLEE_PLAY_LIST_FULL:String = "PLUE_PLAY_LIST_FULL";

        public function PlayListStatusEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_3);
        }
    }
}//package com.sulake.habbo.sound.events

// PlayListStatusEvent = "_-a-" (String#8420, DoABC#2)
// RWPLEE_PLAY_LIST_UPDATED = "_-0WY" (String#15300, DoABC#2)
// RWPLEE_PLAY_LIST_FULL = "_-1li" (String#18362, DoABC#2)


