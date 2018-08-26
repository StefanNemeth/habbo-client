
package com.sulake.habbo.room
{
    public class PetColorResult 
    {

        private var _primaryColor:int = 0;
        private var _secondaryColor:int = 0;

        public function PetColorResult(_arg_1:int, _arg_2:int)
        {
            this._primaryColor = (_arg_1 & 0xFFFFFF);
            this._secondaryColor = (_arg_2 & 0xFFFFFF);
        }
        public function get primaryColor():int
        {
            return (this._primaryColor);
        }
        public function get secondaryColor():int
        {
            return (this._secondaryColor);
        }

    }
}//package com.sulake.habbo.room

// primaryColor = "_-jL" (String#24012, DoABC#2)
// _primaryColor = "_-0Wz" (String#4248, DoABC#2)
// _secondaryColor = "_-ub" (String#8775, DoABC#2)
// PetColorResult = "_-06Y" (String#3693, DoABC#2)


