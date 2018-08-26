
package com.sulake.habbo.room.events
{
    import com.sulake.room.events.RoomObjectEvent;

    public class RoomObjectWidgetRequestEvent extends RoomObjectEvent 
    {

        public static const REOE_WIDGET_REQUEST_PLACEHOLDER:String = "ROWRE_WIDGET_REQUEST_PLACEHOLDER";
        public static const ROOM_OBJECT_WIDGET_REQUEST_CREDITFURNI:String = "ROWRE_WIDGET_REQUEST_CREDITFURNI";
        public static const REOE_WIDGET_REQUEST_STICKIE:String = "ROWRE_WIDGET_REQUEST_STICKIE";
        public static const REOE_WIDGET_REQUEST_PRESENT:String = "ROWRE_WIDGET_REQUEST_PRESENT";
        public static const REOE_WIDGET_REQUEST_TROPHY:String = "ROWRE_WIDGET_REQUEST_TROPHY";
        public static const REOE_WIDGET_REQUEST_TEASER:String = "ROWRE_WIDGET_REQUEST_TEASER";
        public static const REOE_WIDGET_REQUEST_ECOTRONBOX:String = "ROWRE_WIDGET_REQUEST_ECOTRONBOX";
        public static const REOE_WIDGET_REQUEST_DIMMER:String = "ROWRE_WIDGET_REQUEST_DIMMER";
        public static const REOR_REMOVE_DIMMER:String = "ROWRE_WIDGET_REMOVE_DIMMER";
        public static const REOR_REQUEST_CLOTHING_CHANGE:String = "ROWRE_WIDGET_REQUEST_CLOTHING_CHANGE";
        public static const REOR_WIDGET_REQUEST_PLAYLIST_EDITOR:String = "ROWRE_WIDGET_REQUEST_JUKEBOX_PLAYLIST_EDITOR";

        public function RoomObjectWidgetRequestEvent(_arg_1:String, _arg_2:int, _arg_3:String, _arg_4:Boolean=false, _arg_5:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }
    }
}//package com.sulake.habbo.room.events

// RoomObjectWidgetRequestEvent = "_-0Oy" (String#15023, DoABC#2)
// REOE_WIDGET_REQUEST_PLACEHOLDER = "_-0mW" (String#15918, DoABC#2)
// REOE_WIDGET_REQUEST_STICKIE = "_-IJ" (String#22941, DoABC#2)
// REOE_WIDGET_REQUEST_PRESENT = "_-3D0" (String#21997, DoABC#2)
// REOE_WIDGET_REQUEST_TROPHY = "_-0gt" (String#15704, DoABC#2)
// REOE_WIDGET_REQUEST_TEASER = "_-0u1" (String#16204, DoABC#2)
// REOE_WIDGET_REQUEST_ECOTRONBOX = "_-mP" (String#24123, DoABC#2)
// REOE_WIDGET_REQUEST_DIMMER = "_-2Sl" (String#20149, DoABC#2)
// REOR_REMOVE_DIMMER = "_-1pt" (String#18537, DoABC#2)
// REOR_REQUEST_CLOTHING_CHANGE = "_-8e" (String#22566, DoABC#2)
// REOR_WIDGET_REQUEST_PLAYLIST_EDITOR = "_-0k" (String#15828, DoABC#2)


