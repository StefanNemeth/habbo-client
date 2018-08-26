
package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetStoreSettingsMessage extends RoomWidgetMessage 
    {

        public static const RWSSM_STORE_SETTINGS:String = "RWSSM_STORE_SETTINGS";
        public static const RWSSM_STORE_SOUND:String = "RWSSM_STORE_SOUND";
        public static const RWSSM_PREVIEW_SOUND:String = "RWSSM_PREVIEW_SOUND";

        private var _volume:Number;

        public function RoomWidgetStoreSettingsMessage(_arg_1:String)
        {
            super(_arg_1);
        }
        public function get volume():Number
        {
            return (this._volume);
        }
        public function set volume(_arg_1:Number):void
        {
            this._volume = _arg_1;
        }

    }
}//package com.sulake.habbo.ui.widget.messages

// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// RoomWidgetStoreSettingsMessage = "_-33h" (String#7379, DoABC#2)
// RWSSM_STORE_SETTINGS = "_-01B" (String#14099, DoABC#2)
// RWSSM_STORE_SOUND = "_-1fr" (String#18131, DoABC#2)
// RWSSM_PREVIEW_SOUND = "_-1Z6" (String#17856, DoABC#2)
// _volume = "_-hi" (String#311, DoABC#2)
// volume = "_-0SB" (String#1473, DoABC#2)


