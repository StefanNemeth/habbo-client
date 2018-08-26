
package com.sulake.habbo.room.object.visualization.data
{
    public class ColorData 
    {

        public static const _SafeStr_4861:uint = 0xFFFFFF;

        private var _colors:Array;

        public function ColorData(_arg_1:int)
        {
            this._colors = [];
            super();
            var _local_2:int;
            while (_local_2 < _arg_1) {
                this._colors.push(_SafeStr_4861);
                _local_2++;
            };
        }
        public function dispose():void
        {
            this._colors = null;
        }
        public function setColor(_arg_1:uint, _arg_2:int):void
        {
            if ((((_arg_2 < 0)) || ((_arg_2 >= this._colors.length)))){
                return;
            };
            this._colors[_arg_2] = _arg_1;
        }
        public function getColor(_arg_1:int):uint
        {
            if ((((_arg_1 < 0)) || ((_arg_1 >= this._colors.length)))){
                return (_SafeStr_4861);
            };
            return (this._colors[_arg_1]);
        }

    }
}//package com.sulake.habbo.room.object.visualization.data

// setColor = "_-0-w" (String#3562, DoABC#2)
// ColorData = "_-1Hv" (String#5204, DoABC#2)
// _SafeStr_4861 = "_-0CJ" (String#582, DoABC#2)
// getColor = "_-07L" (String#1406, DoABC#2)


