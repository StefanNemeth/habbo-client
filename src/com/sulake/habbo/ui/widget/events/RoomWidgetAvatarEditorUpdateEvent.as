
package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetAvatarEditorUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const RWUE_HIDE_AVATAR_EDITOR:String = "RWUE_HIDE_AVATAR_EDITOR";
        public static const RWUE_AVATAR_EDITOR_CLOSED:String = "RWUE_AVATAR_EDITOR_CLOSED";

        public function RoomWidgetAvatarEditorUpdateEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_3);
        }
    }
}//package com.sulake.habbo.ui.widget.events

// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// RoomWidgetAvatarEditorUpdateEvent = "_-3AA" (String#7517, DoABC#2)
// RWUE_AVATAR_EDITOR_CLOSED = "_-pF" (String#24243, DoABC#2)
// RWUE_HIDE_AVATAR_EDITOR = "_-1kI" (String#18301, DoABC#2)


