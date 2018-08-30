
package com.sulake.habbo.room.object.visualization.furniture
{
    import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.room.object.visualization.data.SizeData;
    import com.sulake.room.utils.XMLValidator;
    import com.sulake.habbo.room.object.visualization.data.LayerData;
    import com.sulake.habbo.room.object.visualization.data.ColorData;

    public class FurnitureVisualizationData implements IRoomObjectVisualizationData 
    {

        public static const _SafeStr_12526:int = 1000;
        public static const _SafeStr_4405:Array = new Array("a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z");

        private var _SafeStr_12602:Map;
        private var _sizes:Array;
        private var _sizeData:SizeData = null;
        private var _SafeStr_12604:int = -1;
        private var _size:int = -1;
        private var _SafeStr_12606:int = -1;
        private var _type:String = "";

        public function FurnitureVisualizationData()
        {
            this._sizes = [];
            super();
            this._SafeStr_12602 = new Map();
        }
        public function dispose():void
        {
            var _local_1:SizeData;
            var _local_2:int;
            if (this._SafeStr_12602 != null){
                _local_1 = null;
                _local_2 = 0;
                while (_local_2 < this._SafeStr_12602.length) {
                    _local_1 = (this._SafeStr_12602.getWithIndex(_local_2) as SizeData);
                    if (_local_1 != null){
                        _local_1.dispose();
                    };
                    _local_2++;
                };
                this._SafeStr_12602.dispose();
                this._SafeStr_12602 = null;
            };
            this._sizeData = null;
            this._sizes = null;
        }
        public function initialize(_arg_1:XML):Boolean
        {
            this.reset();
            if (_arg_1 == null){
                return (false);
            };
            var _local_2:String = _arg_1.@type;
            if (_local_2.length == 0){
                return (false);
            };
            this._type = _local_2;
            if (!this.defineVisualizations(_arg_1)){
                this.reset();
                return (false);
            };
            return (true);
        }
        protected function reset():void
        {
            this._type = "";
            var _local_1:SizeData;
            var _local_2:int;
            while (_local_2 < this._SafeStr_12602.length) {
                _local_1 = (this._SafeStr_12602.getWithIndex(_local_2) as SizeData);
                if (_local_1 != null){
                    _local_1.dispose();
                };
                _local_2++;
            };
            this._SafeStr_12602.reset();
            this._sizes = [];
            this._sizeData = null;
            this._SafeStr_12604 = -1;
        }
        protected function defineVisualizations(_arg_1:XML):Boolean
        {
            var _local_5:XML;
            var _local_6:int;
            var _local_7:int;
            var _local_8:int;
            var _local_9:SizeData;
            var _local_10:XMLList;
            var _local_11:int;
            var _local_12:XML;
            var _local_2:XMLList = _arg_1.visualization;
            if (_local_2.length() == 0){
                return (false);
            };
            var _local_3:int;
            var _local_4:int;
            while (_local_4 < _local_2.length()) {
                _local_5 = _local_2[_local_4];
                if (!XMLValidator.checkRequiredAttributes(_local_5, ["size", "layerCount", "angle"])){
                    return (false);
                };
                _local_6 = int(_local_5.@size);
                _local_7 = int(_local_5.@layerCount);
                _local_8 = int(_local_5.@angle);
                if (_local_6 < 1){
                    _local_6 = 1;
                };
                if (this._SafeStr_12602.getValue(String(_local_6)) != null){
                    return (false);
                };
                _local_9 = this.createSizeData(_local_6, _local_7, _local_8);
                if (_local_9 == null){
                    return (false);
                };
                _local_10 = _local_5.children();
                _local_11 = 0;
                while (_local_11 < _local_10.length()) {
                    _local_12 = _local_10[_local_11];
                    if (!this.processVisualizationElement(_local_9, _local_12)){
                        _local_9.dispose();
                        return (false);
                    };
                    _local_11++;
                };
                this._SafeStr_12602.add(String(_local_6), _local_9);
                this._sizes.push(_local_6);
                this._sizes.sort(Array.NUMERIC);
                _local_4++;
            };
            return (true);
        }
        protected function createSizeData(_arg_1:int, _arg_2:int, _arg_3:int):SizeData
        {
            var _local_4:SizeData;
            return (new SizeData(_arg_2, _arg_3));
        }
        protected function processVisualizationElement(_arg_1:SizeData, _arg_2:XML):Boolean
        {
            if ((((_arg_1 == null)) || ((_arg_2 == null)))){
                return (false);
            };
            switch (String(_arg_2.name())){
                case "layers":
                    if (!_arg_1.defineLayers(_arg_2)){
                        return (false);
                    };
                    break;
                case "directions":
                    if (!_arg_1.defineDirections(_arg_2)){
                        return (false);
                    };
                    break;
                case "colors":
                    if (!_arg_1.defineColors(_arg_2)){
                        return (false);
                    };
                    break;
            };
            return (true);
        }
        public function getType():String
        {
            return (this._type);
        }
        private function getSizeIndex(_arg_1:int):int
        {
            var _local_3:int;
            var _local_2:int;
            if (_arg_1 > 0){
                _local_3 = 1;
                while (_local_3 < this._sizes.length) {
                    if (this._sizes[_local_3] > _arg_1){
                        if ((this._sizes[_local_3] / _arg_1) < (_arg_1 / this._sizes[(_local_3 - 1)])){
                            _local_2 = _local_3;
                        };
                        break;
                    };
                    _local_2 = _local_3;
                    _local_3++;
                };
            };
            return (_local_2);
        }
        public function getSize(_arg_1:int):int
        {
            if (_arg_1 == this._SafeStr_12606){
                return (this._size);
            };
            var _local_2:int = this.getSizeIndex(_arg_1);
            var _local_3:int = -1;
            if (_local_2 < this._sizes.length){
                _local_3 = this._sizes[_local_2];
            };
            this._SafeStr_12606 = _arg_1;
            this._size = _local_3;
            return (_local_3);
        }
        public function getLayerCount(_arg_1:int):int
        {
            var _local_2:SizeData = this.getSizeData(_arg_1);
            if (_local_2 != null){
                return (_local_2.layerCount);
            };
            return (0);
        }
        public function getDirectionValue(_arg_1:int, _arg_2:int):int
        {
            var _local_3:SizeData = this.getSizeData(_arg_1);
            if (_local_3 != null){
                return (_local_3.getDirectionValue(_arg_2));
            };
            return (0);
        }
        public function getTag(_arg_1:int, _arg_2:int, _arg_3:int):String
        {
            var _local_4:SizeData = this.getSizeData(_arg_1);
            if (_local_4 != null){
                return (_local_4.getTag(_arg_2, _arg_3));
            };
            return (LayerData.);
        }
        public function getInk(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            var _local_4:SizeData = this.getSizeData(_arg_1);
            if (_local_4 != null){
                return (_local_4.getInk(_arg_2, _arg_3));
            };
            return (LayerData._SafeStr_12548);
        }
        public function getAlpha(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            var _local_4:SizeData = this.getSizeData(_arg_1);
            if (_local_4 != null){
                return (_local_4.getAlpha(_arg_2, _arg_3));
            };
            return (LayerData._SafeStr_12550);
        }
        public function getColor(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            var _local_4:SizeData = this.getSizeData(_arg_1);
            if (_local_4 != null){
                return (_local_4.getColor(_arg_2, _arg_3));
            };
            return (ColorData._SafeStr_4861);
        }
        public function getIgnoreMouse(_arg_1:int, _arg_2:int, _arg_3:int):Boolean
        {
            var _local_4:SizeData = this.getSizeData(_arg_1);
            if (_local_4 != null){
                return (_local_4.getIgnoreMouse(_arg_2, _arg_3));
            };
            return (LayerData._SafeStr_12552);
        }
        public function getXOffset(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            var _local_4:SizeData = this.getSizeData(_arg_1);
            if (_local_4 != null){
                return (_local_4.getXOffset(_arg_2, _arg_3));
            };
            return (LayerData._SafeStr_12554);
        }
        public function getYOffset(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            var _local_4:SizeData = this.getSizeData(_arg_1);
            if (_local_4 != null){
                return (_local_4.getYOffset(_arg_2, _arg_3));
            };
            return (LayerData._SafeStr_12556);
        }
        public function getZOffset(_arg_1:int, _arg_2:int, _arg_3:int):Number
        {
            var _local_4:SizeData = this.getSizeData(_arg_1);
            if (_local_4 != null){
                return (_local_4.getZOffset(_arg_2, _arg_3));
            };
            return (LayerData._SafeStr_4401);
        }
        protected function getSizeData(_arg_1:int):SizeData
        {
            if (_arg_1 == this._SafeStr_12604){
                return (this._sizeData);
            };
            var _local_2:int = this.getSizeIndex(_arg_1);
            if (_local_2 < this._sizes.length){
                this._sizeData = (this._SafeStr_12602.getValue(String(this._sizes[_local_2])) as SizeData);
            }
            else {
                this._sizeData = null;
            };
            this._SafeStr_12604 = _arg_1;
            return (this._sizeData);
        }

    }
}//package com.sulake.habbo.room.object.visualization.furniture

// _SafeStr_12526 = "_-Hb" (String#22917, DoABC#2)
// defineLayers = "_-vv" (String#24524, DoABC#2)
// defineDirections = "_-21H" (String#19064, DoABC#2)
// defineColors = "_-06Z" (String#14308, DoABC#2)
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
// _SafeStr_12602 = "_-z2" (String#24652, DoABC#2)
// _sizeData = "_-0ze" (String#16414, DoABC#2)
// _SafeStr_12604 = "_-1lv" (String#18371, DoABC#2)
// _size = "_-iJ" (String#2164, DoABC#2)
// _SafeStr_12606 = "_-2ZZ" (String#20422, DoABC#2)
// defineVisualizations = "_-2W8" (String#20287, DoABC#2)
// getSizeIndex = "_-0Wx" (String#1494, DoABC#2)
// IRoomObjectVisualizationData = "_-26A" (String#6167, DoABC#2)
// FurnitureVisualizationData = "_-0d0" (String#4371, DoABC#2)
// SizeData = "_-07b" (String#3713, DoABC#2)
// ColorData = "_-1Hv" (String#5204, DoABC#2)
// getLayerCount = "_-0wW" (String#16290, DoABC#2)
// _SafeStr_4401 = "_-1Tp" (String#17658, DoABC#2)
// getZOffset = "_-1iZ" (String#18230, DoABC#2)
// getSize = "_-1GK" (String#5174, DoABC#2)
// _SafeStr_4405 = "_-0gZ" (String#15695, DoABC#2)
// getDirectionValue = "_-0Fe" (String#14670, DoABC#2)
// getTag = "_-01m" (String#14120, DoABC#2)
// createSizeData = "_-1G0" (String#1647, DoABC#2)
// getSizeData = "_-2ZC" (String#20406, DoABC#2)
// _SafeStr_4861 = "_-0CJ" (String#582, DoABC#2)
// getColor = "_-07L" (String#1406, DoABC#2)


