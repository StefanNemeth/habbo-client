
package com.sulake.habbo.room.object.visualization.furniture
{
    public class FurnitureQueueTileVisualization extends AnimatedFurnitureVisualization 
    {

        private static const _SafeStr_12671:int = 3;
        private static const _SafeStr_12674:int = 2;
        private static const _SafeStr_12675:int = 1;
        private static const _SafeStr_12676:int = 15;

        private var _SafeStr_12673:Array;
        private var _SafeStr_12677:int;

        public function FurnitureQueueTileVisualization()
        {
            this._SafeStr_12673 = new Array();
            super();
        }
        override protected function setAnimation(_arg_1:int):void
        {
            if (_arg_1 == _SafeStr_12674){
                this._SafeStr_12673 = new Array();
                this._SafeStr_12673.push(_SafeStr_12675);
                this._SafeStr_12677 = _SafeStr_12676;
            };
            super.setAnimation(_arg_1);
        }
        override protected function updateAnimation(_arg_1:Number):int
        {
            if (this._SafeStr_12677 > 0){
                this._SafeStr_12677--;
            };
            if (this._SafeStr_12677 == 0){
                if (this._SafeStr_12673.length > 0){
                    super.setAnimation(this._SafeStr_12673.shift());
                };
            };
            return (super.updateAnimation(_arg_1));
        }
        override protected function usesAnimationResetting():Boolean
        {
            return (true);
        }

    }
}//package com.sulake.habbo.room.object.visualization.furniture

// usesAnimationResetting = "_-1HJ" (String#1651, DoABC#2)
// _SafeStr_12671 = "_-1Jx" (String#848, DoABC#2)
// _SafeStr_12673 = "_-14Q" (String#832, DoABC#2)
// _SafeStr_12674 = "_-1zH" (String#18938, DoABC#2)
// _SafeStr_12675 = "_-2kY" (String#20867, DoABC#2)
// _SafeStr_12676 = "_-2Eb" (String#19589, DoABC#2)
// _SafeStr_12677 = "_-1Qp" (String#17544, DoABC#2)
// AnimatedFurnitureVisualization = "_-0y2" (String#4811, DoABC#2)
// FurnitureQueueTileVisualization = "_-1bL" (String#5582, DoABC#2)
// updateAnimation = "_-XZ" (String#166, DoABC#2)
// setAnimation = "_-ON" (String#252, DoABC#2)


