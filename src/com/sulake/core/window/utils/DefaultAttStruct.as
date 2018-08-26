
package com.sulake.core.window.utils
{
    public class DefaultAttStruct 
    {

        public static var _SafeStr_9671:Boolean = false;

        public var color:uint = 0xFFFFFF;
        public var background:Boolean = false;
        public var blend:Number = 1;
        public var _SafeStr_9574:uint = 10;
        public var width_min:int = -2147483648;
        public var width_max:int = 2147483647;
        public var height_min:int = -2147483648;
        public var height_max:int = 2147483647;

        public function hasRectLimits():Boolean
        {
            return (((_SafeStr_9671) && ((((((((this.width_min > int.MIN_VALUE)) || ((this.height_min > int.MIN_VALUE)))) || ((this.width_max < int.MAX_VALUE)))) || ((this.height_max < int.MAX_VALUE))))));
        }

    }
}//package com.sulake.core.window.utils

// DefaultAttStruct = "_-2e0" (String#20604, DoABC#2)
// _SafeStr_9574 = "_-2pO" (String#21053, DoABC#2)
// _SafeStr_9671 = "_-1Tc" (String#17649, DoABC#2)
// hasRectLimits = "_-2Rg" (String#20108, DoABC#2)


