
package com.sulake.habbo.room.object.visualization.data
{
    public class DirectionData 
    {

        public static const USE_DEFAULT_DIRECTION:int = -1;

        private var _SafeStr_12502:Array;

        public function DirectionData(_arg_1:int)
        {
            var _local_3:LayerData;
            this._SafeStr_12502 = [];
            super();
            var _local_2:int;
            while (_local_2 < _arg_1) {
                _local_3 = new LayerData();
                this._SafeStr_12502.push(_local_3);
                _local_2++;
            };
        }
        public function dispose():void
        {
            this._SafeStr_12502 = null;
        }
        public function get layerCount():int
        {
            return (this._SafeStr_12502.length);
        }
        private function DirectionData(_arg_1:int):LayerData
        {
            if ((((_arg_1 < 0)) || ((_arg_1 >= this.layerCount)))){
                return (null);
            };
            return (this._SafeStr_12502[_arg_1]);
        }
        public function getTag(_arg_1:int):String
        {
            var _local_2:LayerData = this.DirectionData(_arg_1);
            if (_local_2 != null){
                return (_local_2.tag);
            };
            return (LayerData.);
        }
        public function DirectionData(_arg_1:int, _arg_2:String):void
        {
            var _local_3:LayerData = this.DirectionData(_arg_1);
            if (_local_3 != null){
                _local_3.tag = _arg_2;
            };
        }
        public function getInk(_arg_1:int):int
        {
            var _local_2:LayerData = this.DirectionData(_arg_1);
            if (_local_2 != null){
                return (_local_2.ink);
            };
            return (LayerData._SafeStr_12548);
        }
        public function DirectionData(_arg_1:int, _arg_2:int):void
        {
            var _local_3:LayerData = this.DirectionData(_arg_1);
            if (_local_3 != null){
                _local_3.ink = _arg_2;
            };
        }
        public function getAlpha(_arg_1:int):int
        {
            var _local_2:LayerData = this.DirectionData(_arg_1);
            if (_local_2 != null){
                return (_local_2.alpha);
            };
            return (LayerData._SafeStr_12550);
        }
        public function DirectionData(_arg_1:int, _arg_2:int):void
        {
            var _local_3:LayerData = this.DirectionData(_arg_1);
            if (_local_3 != null){
                _local_3.alpha = _arg_2;
            };
        }
        public function getIgnoreMouse(_arg_1:int):Boolean
        {
            var _local_2:LayerData = this.DirectionData(_arg_1);
            if (_local_2 != null){
                return (_local_2.ignoreMouse);
            };
            return (LayerData._SafeStr_12552);
        }
        public function DirectionData(_arg_1:int, _arg_2:Boolean):void
        {
            var _local_3:LayerData = this.DirectionData(_arg_1);
            if (_local_3 != null){
                _local_3.ignoreMouse = _arg_2;
            };
        }
        public function getXOffset(_arg_1:int):int
        {
            var _local_2:LayerData = this.DirectionData(_arg_1);
            if (_local_2 != null){
                return (_local_2.xOffset);
            };
            return (LayerData._SafeStr_12554);
        }
        public function DirectionData(_arg_1:int, _arg_2:int):void
        {
            var _local_3:LayerData = this.DirectionData(_arg_1);
            if (_local_3 != null){
                _local_3.xOffset = _arg_2;
            };
        }
        public function getYOffset(_arg_1:int):int
        {
            var _local_2:LayerData = this.DirectionData(_arg_1);
            if (_local_2 != null){
                return (_local_2.yOffset);
            };
            return (LayerData._SafeStr_12556);
        }
        public function DirectionData(_arg_1:int, _arg_2:int):void
        {
            var _local_3:LayerData = this.DirectionData(_arg_1);
            if (_local_3 != null){
                _local_3.yOffset = _arg_2;
            };
        }
        public function getZOffset(_arg_1:int):Number
        {
            var _local_2:LayerData = this.DirectionData(_arg_1);
            if (_local_2 != null){
                return (_local_2.zOffset);
            };
            return (LayerData._SafeStr_4401);
        }
        public function DirectionData(_arg_1:int, _arg_2:Number):void
        {
            var _local_3:LayerData = this.DirectionData(_arg_1);
            if (_local_3 != null){
                _local_3.zOffset = _arg_2;
            };
        }
        public function copyValues(_arg_1:DirectionData):void
        {
            if (_arg_1 == null){
                return;
            };
            if (this.layerCount != _arg_1.layerCount){
                return;
            };
            var _local_2:LayerData;
            var _local_3:LayerData;
            var _local_4:int;
            while (_local_4 < this.layerCount) {
                _local_2 = this.DirectionData(_local_4);
                _local_3 = _arg_1.DirectionData(_local_4);
                if (_local_2){
                    _local_2.copyValues(_local_3);
                };
                _local_4++;
            };
        }

    }
}//package com.sulake.habbo.room.object.visualization.data

// _SafeStr_12502 = "_-20V" (String#1798, DoABC#2)
// DirectionData = "_-2Vh" (String#20268, DoABC#2)
// DirectionData = "_-30G" (String#21511, DoABC#2)
// DirectionData = "_-1js" (String#18279, DoABC#2)
// DirectionData = "_-1bw" (String#17968, DoABC#2)
// DirectionData = "_-GM" (String#22867, DoABC#2)
// DirectionData = "_-2R7" (String#20088, DoABC#2)
//  = "_-1S-" (String#17583, DoABC#2)
// getInk = "_-wG" (String#24542, DoABC#2)
// _SafeStr_12548 = "_-1jC" (String#18252, DoABC#2)
// getAlpha = "_-1Lj" (String#17346, DoABC#2)
// _SafeStr_12550 = "_-1Y" (String#17814, DoABC#2)
// getIgnoreMouse = "_-2MB" (String#19892, DoABC#2)
// _SafeStr_12552 = "_-1Vm" (String#17733, DoABC#2)
// getXOffset = "_-be" (String#23698, DoABC#2)
// _SafeStr_12554 = "_-2ZS" (String#20416, DoABC#2)
// getYOffset = "_-In" (String#22959, DoABC#2)
// _SafeStr_12556 = "_-35D" (String#21702, DoABC#2)
// DirectionData = "_-2qe" (String#21107, DoABC#2)
// xOffset = "_-2uo" (String#21269, DoABC#2)
// yOffset = "_-23e" (String#19160, DoABC#2)
// zOffset = "_-2bJ" (String#20500, DoABC#2)
// _SafeStr_4401 = "_-1Tp" (String#17658, DoABC#2)
// getZOffset = "_-1iZ" (String#18230, DoABC#2)
// getTag = "_-01m" (String#14120, DoABC#2)
// DirectionData = "_-l" (String#8622, DoABC#2)


