
package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetDimmerSavePresetMessage extends RoomWidgetMessage 
    {

        public static const RWSDPM_SAVE_PRESET:String = "RWSDPM_SAVE_PRESET";

        private var _presetNumber:int;
        private var _effectTypeId:int;
        private var _color:uint;
        private var _brightness:int;
        private var _apply:Boolean;

        public function RoomWidgetDimmerSavePresetMessage(_arg_1:int, _arg_2:int, _arg_3:uint, _arg_4:int, _arg_5:Boolean)
        {
            super(RWSDPM_SAVE_PRESET);
            this._presetNumber = _arg_1;
            this._effectTypeId = _arg_2;
            this._color = _arg_3;
            this._brightness = _arg_4;
            this._apply = _arg_5;
        }
        public function get presetNumber():int
        {
            return (this._presetNumber);
        }
        public function get effectTypeId():int
        {
            return (this._effectTypeId);
        }
        public function get color():uint
        {
            return (this._color);
        }
        public function get brightness():int
        {
            return (this._brightness);
        }
        public function get apply():Boolean
        {
            return (this._apply);
        }

    }
}//package com.sulake.habbo.ui.widget.messages

// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// RoomWidgetDimmerSavePresetMessage = "_-1D3" (String#5126, DoABC#2)
// RWSDPM_SAVE_PRESET = "_-2RZ" (String#20101, DoABC#2)
// _presetNumber = "_-37x" (String#7468, DoABC#2)
// _effectTypeId = "_-0rw" (String#4684, DoABC#2)
// _brightness = "_-2Jm" (String#450, DoABC#2)
// _apply = "_-0yd" (String#16379, DoABC#2)
// presetNumber = "_-9a" (String#22602, DoABC#2)
// effectTypeId = "_-ra" (String#24342, DoABC#2)
// brightness = "_-kZ" (String#24053, DoABC#2)


