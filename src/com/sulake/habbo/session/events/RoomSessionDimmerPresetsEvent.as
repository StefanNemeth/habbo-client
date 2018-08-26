
package com.sulake.habbo.session.events
{
    import com.sulake.habbo.session.IRoomSession;

    public class RoomSessionDimmerPresetsEvent extends RoomSessionEvent 
    {

        public static const RSDPE_PRESETS:String = "RSDPE_PRESETS";

        private var _selectedPresetId:int = 0;
        private var _presets:Array;

        public function RoomSessionDimmerPresetsEvent(_arg_1:String, _arg_2:IRoomSession, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            this._presets = new Array();
            super(_arg_1, _arg_2, _arg_3, _arg_4);
        }
        public function get selectedPresetId():int
        {
            return (this._selectedPresetId);
        }
        public function get presetCount():int
        {
            return (this._presets.length);
        }
        public function set selectedPresetId(_arg_1:int):void
        {
            this._selectedPresetId = _arg_1;
        }
        public function RoomWidgetDimmerUpdateEvent(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):void
        {
            var _local_5:RoomSessionDimmerPresetsEventPresetItem = new RoomSessionDimmerPresetsEventPresetItem(_arg_1, _arg_2, _arg_3, _arg_4);
            this._presets[(_arg_1 - 1)] = _local_5;
        }
        public function RoomWidgetDimmerUpdateEvent(_arg_1:int):RoomSessionDimmerPresetsEventPresetItem
        {
            if ((((_arg_1 < 0)) || ((_arg_1 >= this._presets.count)))){
                return (null);
            };
            return (this._presets[_arg_1]);
        }

    }
}//package com.sulake.habbo.session.events

// IRoomSession = "_-2e4" (String#6835, DoABC#2)
// RoomSessionDimmerPresetsEvent = "_-1lO" (String#5773, DoABC#2)
// RoomSessionDimmerPresetsEventPresetItem = "_-2E" (String#6321, DoABC#2)
// RSDPE_PRESETS = "_-3B3" (String#21925, DoABC#2)
// selectedPresetId = "_-0Pr" (String#15055, DoABC#2)
// presetCount = "_-Gt" (String#22886, DoABC#2)
// RoomWidgetDimmerUpdateEvent = "_-0k4" (String#15834, DoABC#2)
// RoomWidgetDimmerUpdateEvent = "_-0rG" (String#16096, DoABC#2)


