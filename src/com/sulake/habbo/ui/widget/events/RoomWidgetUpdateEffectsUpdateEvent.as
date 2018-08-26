
package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetUpdateEffectsUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const RWUEUE_UPDATE_EFFECTS:String = "RWUEUE_UPDATE_EFFECTS";

        private var _effects:Array;

        public function RoomWidgetUpdateEffectsUpdateEvent(_arg_1:Array=null, _arg_2:Boolean=false, _arg_3:Boolean=false)
        {
            super(RWUEUE_UPDATE_EFFECTS, _arg_2, _arg_3);
            this._effects = _arg_1;
        }
        public function get effects():Array
        {
            return (this._effects);
        }

    }
}//package com.sulake.habbo.ui.widget.events

// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// RoomWidgetUpdateEffectsUpdateEvent = "_-14K" (String#4965, DoABC#2)
// RWUEUE_UPDATE_EFFECTS = "_-P2" (String#23208, DoABC#2)
// _effects = "_-1d5" (String#856, DoABC#2)


