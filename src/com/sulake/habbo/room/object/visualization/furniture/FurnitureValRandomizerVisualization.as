
package com.sulake.habbo.room.object.visualization.furniture
{
    public class FurnitureValRandomizerVisualization extends AnimatedFurnitureVisualization 
    {

        private static const _SafeStr_12668:int = 20;
        private static const _SafeStr_12669:int = 10;
        private static const _SafeStr_12670:int = 31;
        private static const _SafeStr_12671:int = 32;
        private static const _SafeStr_12672:int = 30;

        private var _SafeStr_12673:Array;
        private var _running:Boolean = false;

        public function FurnitureValRandomizerVisualization()
        {
            this._SafeStr_12673 = new Array();
            super();
            super.setAnimation(_SafeStr_12672);
        }
        override protected function setAnimation(_arg_1:int):void
        {
            if (_arg_1 == 0){
                if (!this._running){
                    this._running = true;
                    this._SafeStr_12673 = new Array();
                    this._SafeStr_12673.push(_SafeStr_12670);
                    this._SafeStr_12673.push(_SafeStr_12671);
                    return;
                };
            };
            if ((((_arg_1 > 0)) && ((_arg_1 <= _SafeStr_12669)))){
                if (this._running){
                    this._running = false;
                    this._SafeStr_12673 = new Array();
                    if (direction == 2){
                        this._SafeStr_12673.push(((_SafeStr_12668 + 5) - _arg_1));
                        this._SafeStr_12673.push(((_SafeStr_12669 + 5) - _arg_1));
                    }
                    else {
                        this._SafeStr_12673.push((_SafeStr_12668 + _arg_1));
                        this._SafeStr_12673.push((_SafeStr_12669 + _arg_1));
                    };
                    this._SafeStr_12673.push(_SafeStr_12672);
                    return;
                };
                super.setAnimation(_SafeStr_12672);
            };
        }
        override protected function updateAnimation(_arg_1:Number):int
        {
            if (super.AnimatedFurnitureVisualization(11)){
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
// _SafeStr_12670 = "_-YC" (String#8375, DoABC#2)
// _SafeStr_12671 = "_-1Jx" (String#848, DoABC#2)
// _SafeStr_12672 = "_-2Vx" (String#20280, DoABC#2)
// _SafeStr_12673 = "_-14Q" (String#832, DoABC#2)
// AnimatedFurnitureVisualization = "_-0y2" (String#4811, DoABC#2)
// FurnitureValRandomizerVisualization = "_-22J" (String#6091, DoABC#2)
// updateAnimation = "_-XZ" (String#166, DoABC#2)
// setAnimation = "_-ON" (String#252, DoABC#2)
// _running = "_-00c" (String#353, DoABC#2)


