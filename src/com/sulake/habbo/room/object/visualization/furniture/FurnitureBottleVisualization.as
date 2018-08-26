
package com.sulake.habbo.room.object.visualization.furniture
{
    public class FurnitureBottleVisualization extends AnimatedFurnitureVisualization 
    {

        private static const _SafeStr_12668:int = 20;
        private static const _SafeStr_12669:int = 9;
        private static const _SafeStr_12671:int = -1;

        private var _SafeStr_12673:Array;
        private var _running:Boolean = false;

        public function FurnitureBottleVisualization()
        {
            this._SafeStr_12673 = new Array();
            super();
        }
        override protected function setAnimation(_arg_1:int):void
        {
            if (_arg_1 == -1){
                if (!this._running){
                    this._running = true;
                    this._SafeStr_12673 = new Array();
                    this._SafeStr_12673.push(_SafeStr_12671);
                    return;
                };
            };
            if ((((_arg_1 >= 0)) && ((_arg_1 <= 7)))){
                if (this._running){
                    this._running = false;
                    this._SafeStr_12673 = new Array();
                    this._SafeStr_12673.push(_SafeStr_12668);
                    this._SafeStr_12673.push((_SafeStr_12669 + _arg_1));
                    this._SafeStr_12673.push(_arg_1);
                    return;
                };
                super.setAnimation(_arg_1);
            };
        }
        override protected function updateAnimation(_arg_1:Number):int
        {
            if (super.AnimatedFurnitureVisualization(0)){
                if (this._SafeStr_12673.length > 0){
                    super.setAnimation(this._SafeStr_12673.shift());
                };
            };
            return (super.updateAnimation(_arg_1));
        }

    }
}//package com.sulake.habbo.room.object.visualization.furniture

// AnimatedFurnitureVisualization = "_-1ZL" (String#5550, DoABC#2)
// _SafeStr_12668 = "_-118" (String#1604, DoABC#2)
// _SafeStr_12669 = "_-8g" (String#2062, DoABC#2)
// _SafeStr_12671 = "_-1Jx" (String#848, DoABC#2)
// _SafeStr_12673 = "_-14Q" (String#832, DoABC#2)
// AnimatedFurnitureVisualization = "_-0y2" (String#4811, DoABC#2)
// FurnitureBottleVisualization = "_-1KT" (String#5253, DoABC#2)
// updateAnimation = "_-XZ" (String#166, DoABC#2)
// setAnimation = "_-ON" (String#252, DoABC#2)
// _running = "_-00c" (String#353, DoABC#2)


