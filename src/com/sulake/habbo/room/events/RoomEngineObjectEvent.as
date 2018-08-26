
package com.sulake.habbo.room.events
{
    public class RoomEngineObjectEvent extends RoomEngineEvent 
    {

        public static const REOE_OBJECT_SELECTED:String = "REOE_OBJECT_SELECTED";
        public static const REOE_OBJECT_DESELECTED:String = "REOE_OBJECT_DESELECTED";
        public static const REOB_OBJECT_ADDED:String = "REOB_OBJECT_ADDED";
        public static const REOE_OBJECT_REMOVED:String = "REOE_OBJECT_REMOVED";
        public static const REOB_OBJECT_PLACED:String = "REOB_OBJECT_PLACED";
        public static const REOB_OBJECT_CONTENT_UPDATED:String = "REOB_OBJECT_CONTENT_UPDATED";
        public static const REOB_OBJECT_REQUEST_MOVE:String = "REOB_OBJECT_REQUEST_MOVE";
        public static const ROE_MOUSE_ENTER:String = "REOB_OBJECT_MOUSE_ENTER";
        public static const ROE_MOUSE_LEAVE:String = "REOB_OBJECT_MOUSE_LEAVE";
        public static const REOE_WIDGET_REQUEST_PLACEHOLDER:String = "REOE_WIDGET_REQUEST_PLACEHOLDER";
        public static const ROOM_OBJECT_WIDGET_REQUEST_CREDITFURNI:String = "REOE_WIDGET_REQUEST_CREDITFURNI";
        public static const REOE_WIDGET_REQUEST_STICKIE:String = "REOE_WIDGET_REQUEST_STICKIE";
        public static const REOE_WIDGET_REQUEST_PRESENT:String = "REOE_WIDGET_REQUEST_PRESENT";
        public static const REOE_WIDGET_REQUEST_TROPHY:String = "REOE_WIDGET_REQUEST_TROPHY";
        public static const REOE_WIDGET_REQUEST_TEASER:String = "REOE_WIDGET_REQUEST_TEASER";
        public static const REOE_WIDGET_REQUEST_ECOTRONBOX:String = "REOE_WIDGET_REQUEST_ECOTRONBOX";
        public static const REOE_WIDGET_REQUEST_DIMMER:String = "REOE_WIDGET_REQUEST_DIMMER";
        public static const REOR_REMOVE_DIMMER:String = "REOR_REMOVE_DIMMER";
        public static const REOR_REQUEST_CLOTHING_CHANGE:String = "REOR_REQUEST_CLOTHING_CHANGE";
        public static const REOR_WIDGET_REQUEST_PLAYLIST_EDITOR:String = "REOR_WIDGET_REQUEST_PLAYLIST_EDITOR";
        public static const REOE_ROOM_AD_FURNI_CLICK:String = "REOE_ROOM_AD_FURNI_CLICK";
        public static const REOE_ROOM_AD_FURNI_DOUBLE_CLICK:String = "REOE_ROOM_AD_FURNI_DOUBLE_CLICK";
        public static const REOE_ROOM_AD_TOOLTIP_SHOW:String = "REOE_ROOM_AD_TOOLTIP_SHOW";
        public static const REOE_ROOM_AD_TOOLTIP_HIDE:String = "REOE_ROOM_AD_TOOLTIP_HIDE";

        private var _objectId:int;
        private var _category:int;

        public function RoomEngineObjectEvent(_arg_1:String, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:Boolean=false, _arg_7:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_6, _arg_7);
            this._objectId = _arg_4;
            this._category = _arg_5;
        }
        public function get objectId():int
        {
            return (this._objectId);
        }
        public function get category():int
        {
            return (this._category);
        }

    }
}//package com.sulake.habbo.room.events

// RoomEngineObjectEvent = "_-10r" (String#16492, DoABC#2)
// _objectId = "_-1YP" (String#18, DoABC#2)
// REOB_OBJECT_ADDED = "_-rY" (String#24341, DoABC#2)
// REOB_OBJECT_CONTENT_UPDATED = "_-31j" (String#21568, DoABC#2)
// REOE_OBJECT_SELECTED = "_-Ss" (String#23359, DoABC#2)
// REOE_OBJECT_DESELECTED = "_-1yB" (String#18894, DoABC#2)
// REOE_OBJECT_REMOVED = "_-2ma" (String#20945, DoABC#2)
// REOB_OBJECT_PLACED = "_-2hu" (String#20768, DoABC#2)
// REOB_OBJECT_REQUEST_MOVE = "_-0np" (String#15970, DoABC#2)
// ROE_MOUSE_ENTER = "_-9-" (String#22579, DoABC#2)
// ROE_MOUSE_LEAVE = "_-0o9" (String#15981, DoABC#2)
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
// REOE_ROOM_AD_FURNI_CLICK = "_-Ox" (String#23204, DoABC#2)
// REOE_ROOM_AD_FURNI_DOUBLE_CLICK = "_-2ph" (String#21068, DoABC#2)
// REOE_ROOM_AD_TOOLTIP_SHOW = "_-PN" (String#23220, DoABC#2)
// REOE_ROOM_AD_TOOLTIP_HIDE = "_-yL" (String#24628, DoABC#2)


