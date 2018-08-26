
package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetToolbarClickedUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const RWUE_REQUEST_ME_MENU_TOOLBAR_CLICKED:String = "RWUE_REQUEST_ME_MENU_TOOLBAR_CLICKED";
        public static const ICON_TYPE_ME_MENU:String = "ICON_TYPE_ME_MENU";
        public static const ICON_TYPE_ROOM_INFO:String = "ICON_TYPE_ROOM_INFO";

        private var _iconType:String;
        private var _active:Boolean = false;

        public function RoomWidgetToolbarClickedUpdateEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(RWUE_REQUEST_ME_MENU_TOOLBAR_CLICKED, _arg_3, _arg_4);
            this._iconType = _arg_1;
            this._active = _arg_2;
        }
        public function get active():Boolean
        {
            return (this._active);
        }
        public function get iconType():String
        {
            return (this._iconType);
        }

    }
}//package com.sulake.habbo.ui.widget.events

// _iconType = "_-VC" (String#23457, DoABC#2)
// iconType = "_-YI" (String#23573, DoABC#2)
// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// RoomWidgetToolbarClickedUpdateEvent = "_-2PS" (String#6551, DoABC#2)
// RWUE_REQUEST_ME_MENU_TOOLBAR_CLICKED = "_-00F" (String#14065, DoABC#2)


