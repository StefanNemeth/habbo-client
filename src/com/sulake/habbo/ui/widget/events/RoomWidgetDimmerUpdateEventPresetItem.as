
package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetDimmerUpdateEventPresetItem 
    {

        private var _id:int = 0;
        private var _type:int = 0;
        private var _color:uint = 0;
        private var _light:uint = 0;

        public function RoomWidgetDimmerUpdateEventPresetItem(_arg_1:int, _arg_2:int, _arg_3:uint, _arg_4:uint)
        {
            this._id = _arg_1;
            this._type = _arg_2;
            this._color = _arg_3;
            this._light = _arg_4;
        }
        public function get id():int
        {
            return (this._id);
        }
        public function get type():int
        {
            return (this._type);
        }
        public function get color():uint
        {
            return (this._color);
        }
        public function get light():int
        {
            return (this._light);
        }

    }
}//package com.sulake.habbo.ui.widget.events

// RoomWidgetDimmerUpdateEventPresetItem = "_-0U1" (String#4184, DoABC#2)
// _light = "_-dT" (String#462, DoABC#2)


