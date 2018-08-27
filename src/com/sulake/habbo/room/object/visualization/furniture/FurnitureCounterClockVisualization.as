
package com.sulake.habbo.room.object.visualization.furniture
{
    public class FurnitureCounterClockVisualization extends AnimatedFurnitureVisualization 
    {

        private static const _SafeStr_12695:String = "seconds_sprite";
        private static const _SafeStr_12696:String = "ten_seconds_sprite";
        private static const _SafeStr_12697:String = "minutes_sprite";
        private static const _SafeStr_12698:String = "ten_minutes_sprite";

        override public function get animationId():int
        {
            return (0);
        }
        override protected function getFrameNumber(_arg_1:int, _arg_2:int):int
        {
            var _local_3:String = getSpriteTag(_arg_1, direction, _arg_2);
            var _local_4:int = super.animationId;
            switch (_local_3){
                case _SafeStr_12695:
                    return (((_local_4 % 60) % 10));
                case _SafeStr_12696:
                    return (((_local_4 % 60) / 10));
                case _SafeStr_12697:
                    return (((_local_4 / 60) % 10));
                case _SafeStr_12698:
                    return ((((_local_4 / 60) / 10) % 10));
                default:
                    return (super.getFrameNumber(_arg_1, _arg_2));
            };
        }

    }
}//package com.sulake.habbo.room.object.visualization.furniture

// getSpriteTag = "_-00o" (String#14086, DoABC#2)
// _SafeStr_12695 = "_-2Ap" (String#19435, DoABC#2)
// _SafeStr_12696 = "_-0WQ" (String#15296, DoABC#2)
// _SafeStr_12697 = "_-0yU" (String#16372, DoABC#2)
// _SafeStr_12698 = "_-2Ex" (String#19601, DoABC#2)
// AnimatedFurnitureVisualization = "_-0y2" (String#4811, DoABC#2)
// FurnitureCounterClockVisualization = "_-2GS" (String#6376, DoABC#2)
// getFrameNumber = "_-0XM" (String#436, DoABC#2)


