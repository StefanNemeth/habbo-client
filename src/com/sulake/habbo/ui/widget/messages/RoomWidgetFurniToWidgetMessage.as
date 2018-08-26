
package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetFurniToWidgetMessage extends RoomWidgetMessage 
    {

        public static const RWFWM_MESSAGE_REQUEST_CREDITFURNI:String = "RWFWM_MESSAGE_REQUEST_CREDITFURNI";
        public static const RWFWM_MESSAGE_REQUEST_STICKIE:String = "RWFWM_MESSAGE_REQUEST_STICKIE";
        public static const RWFWM_MESSAGE_REQUEST_PRESENT:String = "RWFWM_MESSAGE_REQUEST_PRESENT";
        public static const RWFWM_MESSAGE_REQUEST_TROPHY:String = "RWFWM_MESSAGE_REQUEST_TROPHY";
        public static const RWFWM_MESSAGE_REQUEST_TEASER:String = "RWFWM_MESSAGE_REQUEST_TEASER";
        public static const WIDGET_MESSAGE_REQUEST_ECOTRONBOX_WIDGET:String = "RWFWM_MESSAGE_REQUEST_ECOTRONBOX";
        public static const RWFWM_MESSAGE_REQUEST_DIMMER:String = "RWFWM_MESSAGE_REQUEST_DIMMER";
        public static const RWFWM_MESSAGE_REQUEST_PLACEHOLDER:String = "RWFWM_MESSAGE_REQUEST_PLACEHOLDER";
        public static const RWFWM_MESSAGE_REQUEST_CLOTHING_CHANGE:String = "RWFWM_MESSAGE_REQUEST_CLOTHING_CHANGE";
        public static const RWFWM_MESSAGE_REQUEST_PLAYLIST_EDITOR:String = "RWFWM_MESSAGE_REQUEST_PLAYLIST_EDITOR";

        private var _id:int = 0;
        private var _category:int = 0;
        private var _roomId:int = 0;
        private var _roomCategory:int = 0;

        public function RoomWidgetFurniToWidgetMessage(_arg_1:String, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int)
        {
            super(_arg_1);
            this._id = _arg_2;
            this._category = _arg_3;
            this._roomId = _arg_4;
            this._roomCategory = _arg_5;
        }
        public function get id():int
        {
            return (this._id);
        }
        public function get category():int
        {
            return (this._category);
        }
        public function get roomId():int
        {
            return (this._roomId);
        }
        public function get roomCategory():int
        {
            return (this._roomCategory);
        }

    }
}//package com.sulake.habbo.ui.widget.messages

// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// RoomWidgetFurniToWidgetMessage = "_-2Rk" (String#6600, DoABC#2)
// RWFWM_MESSAGE_REQUEST_CREDITFURNI = "_-20W" (String#19030, DoABC#2)
// RWFWM_MESSAGE_REQUEST_STICKIE = "_-0C3" (String#14529, DoABC#2)
// RWFWM_MESSAGE_REQUEST_PRESENT = "_-2XY" (String#20344, DoABC#2)
// RWFWM_MESSAGE_REQUEST_TROPHY = "_-2dM" (String#20578, DoABC#2)
// RWFWM_MESSAGE_REQUEST_TEASER = "_-2Uv" (String#20235, DoABC#2)
// RWFWM_MESSAGE_REQUEST_DIMMER = "_-30d" (String#21526, DoABC#2)
// RWFWM_MESSAGE_REQUEST_PLACEHOLDER = "_-2S8" (String#20125, DoABC#2)
// RWFWM_MESSAGE_REQUEST_CLOTHING_CHANGE = "_-3Af" (String#21907, DoABC#2)
// RWFWM_MESSAGE_REQUEST_PLAYLIST_EDITOR = "_-mx" (String#24151, DoABC#2)


