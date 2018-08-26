
package com.sulake.habbo.room.object.visualization.furniture
{
    public class FurnitureScoreBoardVisualization extends AnimatedFurnitureVisualization 
    {

        private static const _SafeStr_12664:String = "ones_sprite";
        private static const _SafeStr_12665:String = "tens_sprite";
        private static const _SafeStr_12666:String = "hundreds_sprite";
        private static const _SafeStr_12667:String = "thousands_sprite";

        override public function get animationId():int
        {
            return (0);
        }
        override protected function getFrameNumber(_arg_1:int, _arg_2:int):int
        {
            var _local_3:String = FurnitureVisualization(_arg_1, direction, _arg_2);
            var _local_4:int = super.animationId;
            switch (_local_3){
                case _SafeStr_12664:
                    return ((_local_4 % 10));
                case _SafeStr_12665:
                    return (((_local_4 / 10) % 10));
                case _SafeStr_12666:
                    return (((_local_4 / 100) % 10));
                case _SafeStr_12667:
                    return (((_local_4 / 1000) % 10));
                default:
                    return (super.getFrameNumber(_arg_1, _arg_2));
            };
        }

    }
}//package com.sulake.habbo.room.object.visualization.furniture

// FurnitureVisualization = "_-00o" (String#14086, DoABC#2)
// _SafeStr_12664 = "_-0ZD" (String#15411, DoABC#2)
// _SafeStr_12665 = "_-2Nr" (String#19958, DoABC#2)
// _SafeStr_12666 = "_-0k2" (String#15832, DoABC#2)
// _SafeStr_12667 = "_-2KF" (String#19814, DoABC#2)
// AnimatedFurnitureVisualization = "_-0y2" (String#4811, DoABC#2)
// FurnitureScoreBoardVisualization = "_-0z7" (String#4827, DoABC#2)
// getFrameNumber = "_-0XM" (String#436, DoABC#2)


