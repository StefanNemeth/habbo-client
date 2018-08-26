
package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetDimmerUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const RWDUE_PRESETS:String = "RWDUE_PRESETS";
        public static const RWDUE_HIDE:String = "RWDUE_HIDE";

        private var _selectedPresetId:int = 0;
        private var _presets:Array;

        public function RoomWidgetDimmerUpdateEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false)
        {
            this._presets = new Array();
            super(_arg_1, _arg_2, _arg_3);
        }
        public function get selectedPresetId():int
        {
            return (this._selectedPresetId);
        }
        public function get presetCount():int
        {
            return (this._presets.length);
        }
        public function get presets():Array
        {
            return (this._presets);
        }
        public function set selectedPresetId(_arg_1:int):void
        {
            this._selectedPresetId = _arg_1;
        }
        public function RoomWidgetDimmerUpdateEvent(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):void
        {
            var _local_5:RoomWidgetDimmerUpdateEventPresetItem = new RoomWidgetDimmerUpdateEventPresetItem(_arg_1, _arg_2, _arg_3, _arg_4);
            this._presets[(_arg_1 - 1)] = _local_5;
        }
        public function RoomWidgetDimmerUpdateEvent(_arg_1:int):RoomWidgetDimmerUpdateEventPresetItem
        {
            if ((((_arg_1 < 0)) || ((_arg_1 >= this._presets.count)))){
                return (null);
            };
            return (this._presets[_arg_1]);
        }

    }
}//package com.sulake.habbo.ui.widget.events

// presets = "_-0Da" (String#14592, DoABC#2)
// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// RoomWidgetDimmerUpdateEvent = "_-2Fv" (String#6362, DoABC#2)
// RoomWidgetDimmerUpdateEventPresetItem = "_-0U1" (String#4184, DoABC#2)
// selectedPresetId = "_-0Pr" (String#15055, DoABC#2)
// presetCount = "_-Gt" (String#22886, DoABC#2)
// RoomWidgetDimmerUpdateEvent = "_-0k4" (String#15834, DoABC#2)
// RoomWidgetDimmerUpdateEvent = "_-0rG" (String#16096, DoABC#2)
// RWDUE_PRESETS = "_-1i5" (String#18213, DoABC#2)
// RWDUE_HIDE = "_-0KF" (String#14852, DoABC#2)


