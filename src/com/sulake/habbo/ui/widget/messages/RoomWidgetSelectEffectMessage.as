
package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetSelectEffectMessage extends RoomWidgetMessage 
    {

        public static const RWCM_MESSAGE_SELECT_EFFECT:String = "RWCM_MESSAGE_SELECT_EFFECT";
        public static const RWCM_MESSAGE_UNSELECT_EFFECT:String = "RWCM_MESSAGE_UNSELECT_EFFECT";
        public static const RWCM_MESSAGE_UNSELECT_ALL_EFFECTS:String = "RWCM_MESSAGE_UNSELECT_ALL_EFFECTS";

        private var _effectType:int;

        public function RoomWidgetSelectEffectMessage(_arg_1:String, _arg_2:int=-1)
        {
            super(_arg_1);
            this._effectType = _arg_2;
        }
        public function get effectType():int
        {
            return (this._effectType);
        }

    }
}//package com.sulake.habbo.ui.widget.messages

// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// RoomWidgetSelectEffectMessage = "_-382" (String#7474, DoABC#2)
// RWCM_MESSAGE_SELECT_EFFECT = "_-LY" (String#23065, DoABC#2)
// RWCM_MESSAGE_UNSELECT_EFFECT = "_-0rJ" (String#16097, DoABC#2)
// RWCM_MESSAGE_UNSELECT_ALL_EFFECTS = "_-1nv" (String#18458, DoABC#2)
// _effectType = "_-37b" (String#7460, DoABC#2)
// effectType = "_-30t" (String#21534, DoABC#2)


