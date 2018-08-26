
package com.sulake.habbo.ui.widget.furniture.dimmer
{
    public class DimmerFurniWidgetPresetItem 
    {

        private var _id:int = 0;
        private var _type:int = 0;
        private var _color:uint = 0;
        private var _light:uint = 0;

        public function DimmerFurniWidgetPresetItem(_arg_1:int, _arg_2:int, _arg_3:uint, _arg_4:uint)
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
        public function get light():uint
        {
            return (this._light);
        }
        public function set type(_arg_1:int):void
        {
            this._type = _arg_1;
        }
        public function set color(_arg_1:uint):void
        {
            this._color = _arg_1;
        }
        public function set light(_arg_1:uint):void
        {
            this._light = _arg_1;
        }

    }
}//package com.sulake.habbo.ui.widget.furniture.dimmer

// DimmerFurniWidgetPresetItem = "_-n2" (String#8658, DoABC#2)
// _light = "_-dT" (String#462, DoABC#2)


