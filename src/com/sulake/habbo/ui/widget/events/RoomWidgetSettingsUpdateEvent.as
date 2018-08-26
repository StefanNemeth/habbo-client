
package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetSettingsUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const RWSUE_SETTINGS:String = "RWSUE_SETTINGS";

        private var _volume:Number;

        public function RoomWidgetSettingsUpdateEvent(_arg_1:String, _arg_2:Number, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(_arg_1, _arg_3, _arg_4);
            this._volume = _arg_2;
        }
        public function get volume():Number
        {
            return (this._volume);
        }

    }
}//package com.sulake.habbo.ui.widget.events

// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// RoomWidgetSettingsUpdateEvent = "_-1WG" (String#5478, DoABC#2)
// _volume = "_-hi" (String#311, DoABC#2)
// volume = "_-0SB" (String#1473, DoABC#2)
// RWSUE_SETTINGS = "_-HH" (String#22902, DoABC#2)


