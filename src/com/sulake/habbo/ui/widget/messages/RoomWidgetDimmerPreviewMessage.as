
package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetDimmerPreviewMessage extends RoomWidgetMessage 
    {

        public static const RWDPM_PREVIEW_DIMMER_PRESET:String = "RWDPM_PREVIEW_DIMMER_PRESET";

        private var _color:uint;
        private var _brightness:int;
        private var _bgOnly:Boolean;

        public function RoomWidgetDimmerPreviewMessage(_arg_1:uint, _arg_2:int, _arg_3:Boolean)
        {
            super(RWDPM_PREVIEW_DIMMER_PRESET);
            this._color = _arg_1;
            this._brightness = _arg_2;
            this._bgOnly = _arg_3;
        }
        public function get color():uint
        {
            return (this._color);
        }
        public function get brightness():int
        {
            return (this._brightness);
        }
        public function get bgOnly():Boolean
        {
            return (this._bgOnly);
        }

    }
}//package com.sulake.habbo.ui.widget.messages

// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// RoomWidgetDimmerPreviewMessage = "_-yc" (String#8849, DoABC#2)
// _brightness = "_-2Jm" (String#450, DoABC#2)
// brightness = "_-kZ" (String#24053, DoABC#2)
// RWDPM_PREVIEW_DIMMER_PRESET = "_-14V" (String#16635, DoABC#2)
// _bgOnly = "_-09Q" (String#1411, DoABC#2)
// bgOnly = "_-320" (String#21580, DoABC#2)


