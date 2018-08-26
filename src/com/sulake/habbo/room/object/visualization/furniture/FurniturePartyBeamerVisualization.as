
package com.sulake.habbo.room.object.visualization.furniture
{
    import com.sulake.room.object.visualization.IRoomObjectSprite;
    import flash.geom.Point;

    public class FurniturePartyBeamerVisualization extends AnimatedFurnitureVisualization 
    {

        private static const _SafeStr_4848:int = 2;
        private static const _SafeStr_12681:int = 15;
        private static const _SafeStr_12682:int = 31;
        private static const _SafeStr_12683:int = 2;
        private static const _SafeStr_12684:int = 1;

        private var _SafeStr_12685:Array;
        private var _SafeStr_12686:Array;
        private var _SafeStr_12687:Array;
        private var _SafeStr_12688:Array;
        private var _SafeStr_12689:Array;

        public function FurniturePartyBeamerVisualization()
        {
            this._SafeStr_12689 = new Array();
            super();
        }
        override protected function updateAnimation(_arg_1:Number):int
        {
            var _local_2:IRoomObjectSprite;
            var _local_3:Point;
            if (this._SafeStr_12687 == null){
                this.initItems(_arg_1);
            };
            _local_2 = getSprite(2);
            if (_local_2 != null){
                this._SafeStr_12689[0] = this.getNewPoint(_arg_1, 0);
            };
            _local_2 = getSprite(3);
            if (_local_2 != null){
                this._SafeStr_12689[1] = this.getNewPoint(_arg_1, 1);
            };
            return (super.updateAnimation(_arg_1));
        }
        override protected function getSpriteXOffset(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            if ((((_arg_3 == 2)) || ((_arg_3 == 3)))){
                if (this._SafeStr_12689.length == 2){
                    return (this._SafeStr_12689[(_arg_3 - 2)].x);
                };
            };
            return (super.getSpriteXOffset(_arg_1, _arg_2, _arg_3));
        }
        override protected function getSpriteYOffset(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            if ((((_arg_3 == 2)) || ((_arg_3 == 3)))){
                if (this._SafeStr_12689.length == 2){
                    return (this._SafeStr_12689[(_arg_3 - 2)].y);
                };
            };
            return (super.getSpriteYOffset(_arg_1, _arg_2, _arg_3));
        }
        private function getNewPoint(_arg_1:Number, _arg_2:int):Point
        {
            var _local_7:int;
            var _local_3:Number = this._SafeStr_12685[_arg_2];
            var _local_4:int = this._SafeStr_12686[_arg_2];
            var _local_5:int = this._SafeStr_12687[_arg_2];
            var _local_6:Number = this._SafeStr_12688[_arg_2];
            if (_arg_1 == 32){
                _local_7 = _SafeStr_12681;
            }
            else {
                _local_7 = _SafeStr_12682;
            };
            if (Math.abs((_local_3 + (_local_4 * _local_5))) >= _local_7){
                _local_4 = -(_local_4);
                this._SafeStr_12686[_arg_2] = _local_4;
            };
            var _local_8:Number = ((_local_7 - Math.abs(_local_3)) * _local_6);
            var _local_9:Number = ((_local_4 * Math.sin(Math.abs((_local_3 / 4)))) * _local_8);
            if (_local_4 > 0){
                _local_9 = (_local_9 - _local_8);
            }
            else {
                _local_9 = (_local_9 + _local_8);
            };
            _local_3 = (_local_3 + (_local_4 * _local_5));
            this._SafeStr_12685[_arg_2] = _local_3;
            if (int(_local_9) == 0){
                this._SafeStr_12688[_arg_2] = this.getRandomAmplitudeFactor();
            };
            return (new Point(_local_3, _local_9));
        }
        private function initItems(_arg_1:Number):void
        {
            var _local_2:int;
            if (_arg_1 == 32){
                _local_2 = _SafeStr_12681;
            }
            else {
                _local_2 = _SafeStr_12682;
            };
            this._SafeStr_12685 = new Array();
            this._SafeStr_12685.push(((Math.random() * _local_2) * 1.5));
            this._SafeStr_12685.push(((Math.random() * _local_2) * 1.5));
            this._SafeStr_12686 = new Array();
            this._SafeStr_12686.push(1);
            this._SafeStr_12686.push(-1);
            this._SafeStr_12687 = new Array();
            this._SafeStr_12687.push(_SafeStr_12683);
            this._SafeStr_12687.push(_SafeStr_12684);
            this._SafeStr_12688 = new Array();
            this._SafeStr_12688.push(this.getRandomAmplitudeFactor());
            this._SafeStr_12688.push(this.getRandomAmplitudeFactor());
        }
        private function getRandomAmplitudeFactor():Number
        {
            return ((((Math.random() * 30) / 100) + 0.15));
        }

    }
}//package com.sulake.habbo.room.object.visualization.furniture

// _SafeStr_12681 = "_-1n3" (String#18425, DoABC#2)
// _SafeStr_12682 = "_-Y2" (String#23563, DoABC#2)
// _SafeStr_12683 = "_-032" (String#14165, DoABC#2)
// _SafeStr_12684 = "_-GW" (String#22871, DoABC#2)
// _SafeStr_12685 = "_-1A7" (String#16862, DoABC#2)
// _SafeStr_12686 = "_-1bi" (String#17962, DoABC#2)
// _SafeStr_12687 = "_-2cX" (String#20546, DoABC#2)
// _SafeStr_12688 = "_-Lo" (String#23074, DoABC#2)
// _SafeStr_12689 = "_-mM" (String#24121, DoABC#2)
// initItems = "_-2Km" (String#19835, DoABC#2)
// getNewPoint = "_-2oh" (String#21032, DoABC#2)
// getRandomAmplitudeFactor = "_-E4" (String#22774, DoABC#2)
// AnimatedFurnitureVisualization = "_-0y2" (String#4811, DoABC#2)
// FurniturePartyBeamerVisualization = "_-25b" (String#6153, DoABC#2)
// IRoomObjectSprite = "_-0di" (String#4386, DoABC#2)
// updateAnimation = "_-XZ" (String#166, DoABC#2)
// getSprite = "_-sN" (String#2210, DoABC#2)
// getSpriteXOffset = "_-03Y" (String#354, DoABC#2)
// getSpriteYOffset = "_-3IZ" (String#251, DoABC#2)
// _SafeStr_4848 = "_-0i-" (String#1531, DoABC#2)


