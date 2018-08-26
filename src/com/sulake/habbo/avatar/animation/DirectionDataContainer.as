
package com.sulake.habbo.avatar.animation
{
    public class DirectionDataContainer 
    {

        private var _offset:int;

        public function DirectionDataContainer(_arg_1:XML)
        {
            this._offset = parseInt(_arg_1.@offset);
        }
        public function get offset():int
        {
            return (this._offset);
        }

    }
}//package com.sulake.habbo.avatar.animation

// DirectionDataContainer = "_-1Kf" (String#17300, DoABC#2)


