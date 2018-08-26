
package com.sulake.habbo.inventory.events
{
    import flash.events.Event;

    public class HabboInventoryEffectsEvent extends Event 
    {

        public static const HIEE_EFFECTS_CHANGED:String = "HIEE_EFFECTS_CHANGED";

        private var _effects:Array;

        public function HabboInventoryEffectsEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_3);
        }
    }
}//package com.sulake.habbo.inventory.events

// HabboInventoryEffectsEvent = "_-0Us" (String#15238, DoABC#2)
// _effects = "_-1d5" (String#856, DoABC#2)
// HIEE_EFFECTS_CHANGED = "_-9W" (String#22600, DoABC#2)


