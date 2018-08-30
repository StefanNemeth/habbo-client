
package com.sulake.habbo.room.object.visualization.data
{
    import com.sulake.core.utils.Map;
    import com.sulake.room.utils.XMLValidator;

    public class SizeData 
    {

        public static const _SafeStr_12526:int = 1000;
        public static const _SafeStr_12527:int = 0;

        private var _layerCount:int = 0;
        private var _SafeStr_12529:int = 360;
        private var _SafeStr_12530:DirectionData = null;
        private var _SafeStr_12441:Map;
        private var _colors:Map;
        private var _directionData:DirectionData = null;
        private var _SafeStr_12532:int = -1;

        public function SizeData(_arg_1:int, _arg_2:int)
        {
            if (_arg_1 < 0){
                _arg_1 = 0;
            };
            if (_arg_1 > _SafeStr_12526){
                _arg_1 = _SafeStr_12526;
            };
            this._layerCount = _arg_1;
            if (_arg_2 < 1){
                _arg_2 = 1;
            };
            if (_arg_2 > 360){
                _arg_2 = 360;
            };
            this._SafeStr_12529 = _arg_2;
            this._SafeStr_12530 = new DirectionData(_arg_1);
            this._SafeStr_12441 = new Map();
            this._colors = new Map();
        }
        public function dispose():void
        {
            var _local_2:DirectionData;
            var _local_3:ColorData;
            if (this._SafeStr_12530 != null){
                this._SafeStr_12530.dispose();
                this._SafeStr_12530 = null;
            };
            var _local_1:int;
            if (this._SafeStr_12441 != null){
                _local_2 = null;
                _local_1 = 0;
                while (_local_1 < this._SafeStr_12441.length) {
                    _local_2 = (this._SafeStr_12441.getWithIndex(_local_1) as DirectionData);
                    if (_local_2 != null){
                        _local_2.dispose();
                    };
                    _local_1++;
                };
                this._SafeStr_12441.dispose();
                this._SafeStr_12441 = null;
            };
            this._directionData = null;
            if (this._colors != null){
                _local_3 = null;
                _local_1 = 0;
                while (_local_1 < this._colors.length) {
                    _local_3 = (this._colors.getWithIndex(_local_1) as ColorData);
                    if (_local_3 != null){
                        _local_3.dispose();
                    };
                    _local_1++;
                };
                this._colors.dispose();
                this._colors = null;
            };
        }
        public function get layerCount():int
        {
            return (this._layerCount);
        }
        public function defineLayers(_arg_1:XML):Boolean
        {
            if (_arg_1 == null){
                return (false);
            };
            var _local_2:XMLList = _arg_1.layer;
            return (this.defineDirection(this._SafeStr_12530, _local_2));
        }
        public function defineDirections(_arg_1:XML):Boolean
        {
            var _local_6:XML;
            var _local_7:int;
            var _local_8:XMLList;
            if (_arg_1 == null){
                return (false);
            };
            var _local_2:Array = ["id"];
            var _local_3:DirectionData;
            var _local_4:XMLList = _arg_1.direction;
            var _local_5:int;
            while (_local_5 < _local_4.length()) {
                _local_6 = _local_4[_local_5];
                if (!XMLValidator.checkRequiredAttributes(_local_6, _local_2)){
                    return (false);
                };
                _local_7 = int(_local_6.@id);
                _local_8 = _local_6.layer;
                if (this._SafeStr_12441.getValue(String(_local_7)) != null){
                    return (false);
                };
                _local_3 = new DirectionData(this.layerCount);
                _local_3.copyValues(this._SafeStr_12530);
                this.defineDirection(_local_3, _local_8);
                this._SafeStr_12441.add(String(_local_7), _local_3);
                this._SafeStr_12532 = -1;
                this._directionData = null;
                _local_5++;
            };
            return (true);
        }
        private function defineDirection(_arg_1:DirectionData, _arg_2:XMLList):Boolean
        {
            var _local_5:XML;
            var _local_6:int;
            var _local_7:String;
            var _local_8:String;
            var _local_9:int;
            var _local_10:int;
            if ((((_arg_1 == null)) || ((_arg_2 == null)))){
                return (false);
            };
            var _local_3:Array = ["id"];
            var _local_4:int;
            while (_local_4 < _arg_2.length()) {
                _local_5 = _arg_2[_local_4];
                if (!XMLValidator.checkRequiredAttributes(_local_5, _local_3)){
                    return (false);
                };
                _local_6 = int(_local_5.@id);
                if ((((_local_6 < 0)) || ((_local_6 >= this.layerCount)))){
                    return (false);
                };
                _local_7 = _local_5.@tag;
                if (_local_7.length > 0){
                    _arg_1.setTag(_local_6, _local_7);
                };
                _local_8 = _local_5.@ink;
                switch (_local_8){
                    case "ADD":
                        _arg_1.setInk(_local_6, LayerData._SafeStr_12537);
                        break;
                    case "SUBTRACT":
                        _arg_1.setInk(_local_6, LayerData._SafeStr_12538);
                        break;
                    case "DARKEN":
                        _arg_1.setInk(_local_6, LayerData.INK_DARKEN);
                        break;
                };
                _local_7 = _local_5.@alpha;
                if (_local_7.length > 0){
                    _arg_1.setAlpha(_local_6, int(_local_7));
                };
                _local_7 = _local_5.@ignoreMouse;
                if (_local_7.length > 0){
                    _local_9 = int(_local_7);
                    _arg_1.setIgnoreMouse(_local_6, !((_local_9 == 0)));
                };
                _local_7 = _local_5.@x;
                if (_local_7.length > 0){
                    _arg_1.setXOffset(_local_6, int(_local_7));
                };
                _local_7 = _local_5.@y;
                if (_local_7.length > 0){
                    _arg_1.setYOffset(_local_6, int(_local_7));
                };
                _local_7 = _local_5.@z;
                if (_local_7.length > 0){
                    _local_10 = int(_local_7);
                    _arg_1.setZOffset(_local_6, (Number(_local_10) / -1000));
                };
                _local_4++;
            };
            return (true);
        }
        public function defineColors(_arg_1:XML):Boolean
        {
            var _local_7:XML;
            var _local_8:String;
            var _local_9:XMLList;
            var _local_10:int;
            var _local_11:XML;
            var _local_12:int;
            var _local_13:int;
            if (_arg_1 == null){
                return (true);
            };
            var _local_2:ColorData;
            var _local_3:Array = ["id"];
            var _local_4:Array = ["id", "color"];
            var _local_5:XMLList = _arg_1.color;
            var _local_6:int;
            while (_local_6 < _local_5.length()) {
                _local_7 = _local_5[_local_6];
                if (!XMLValidator.checkRequiredAttributes(_local_7, _local_3)){
                    return (false);
                };
                _local_8 = _local_7.@id;
                if (this._colors.getValue(_local_8) != null){
                    return (false);
                };
                _local_2 = new ColorData(this.layerCount);
                _local_9 = _local_7.colorLayer;
                _local_10 = 0;
                while (_local_10 < _local_9.length()) {
                    _local_11 = _local_9[_local_10];
                    if (!XMLValidator.checkRequiredAttributes(_local_11, _local_4)){
                        _local_2.dispose();
                        return (false);
                    };
                    _local_12 = int(_local_11.@id);
                    _local_13 = parseInt(_local_11.@color, 16);
                    _local_2.setColor(_local_13, _local_12);
                    _local_10++;
                };
                if (_local_2 != null){
                    this._colors.add(_local_8, _local_2);
                };
                _local_6++;
            };
            return (true);
        }
        public function getDirectionValue(_arg_1:int):int
        {
            var _local_6:int;
            var _local_7:int;
            var _local_2:int = (((((_arg_1 % 360) + 360) + (this._SafeStr_12529 / 2)) % 360) / this._SafeStr_12529);
            if (this._SafeStr_12441.getValue(String(_local_2)) != null){
                return (_local_2);
            };
            _local_2 = (((_arg_1 % 360) + 360) % 360);
            var _local_3:int = -1;
            var _local_4:int = -1;
            var _local_5:int;
            while (_local_5 < this._SafeStr_12441.length) {
                _local_6 = (int(this._SafeStr_12441.getKey(_local_5)) * this._SafeStr_12529);
                _local_7 = (((_local_6 - _local_2) + 360) % 360);
                if (_local_7 > 180){
                    _local_7 = (360 - _local_7);
                };
                if ((((_local_7 < _local_3)) || ((_local_3 < 0)))){
                    _local_3 = _local_7;
                    _local_4 = _local_5;
                };
                _local_5++;
            };
            if (_local_4 >= 0){
                return (int(this._SafeStr_12441.getKey(_local_4)));
            };
            return (_SafeStr_12527);
        }
        private function getDirectionData(_arg_1:int):DirectionData
        {
            if (_arg_1 == this._SafeStr_12532){
                return (this._directionData);
            };
            var _local_2:DirectionData;
            _local_2 = (this._SafeStr_12441.getValue(String(_arg_1)) as DirectionData);
            if (_local_2 == null){
                _local_2 = this._SafeStr_12530;
            };
            this._SafeStr_12532 = _arg_1;
            this._directionData = _local_2;
            return (this._directionData);
        }
        public function getTag(_arg_1:int, _arg_2:int):String
        {
            var _local_3:DirectionData;
            _local_3 = this.getDirectionData(_arg_1);
            if (_local_3 != null){
                return (_local_3.getTag(_arg_2));
            };
            return (LayerData.);
        }
        public function getInk(_arg_1:int, _arg_2:int):int
        {
            var _local_3:DirectionData;
            _local_3 = this.getDirectionData(_arg_1);
            if (_local_3 != null){
                return (_local_3.getInk(_arg_2));
            };
            return (LayerData._SafeStr_12548);
        }
        public function getAlpha(_arg_1:int, _arg_2:int):int
        {
            var _local_3:DirectionData;
            _local_3 = this.getDirectionData(_arg_1);
            if (_local_3 != null){
                return (_local_3.getAlpha(_arg_2));
            };
            return (LayerData._SafeStr_12550);
        }
        public function getColor(_arg_1:int, _arg_2:int):uint
        {
            var _local_3:ColorData = (this._colors.getValue(String(_arg_2)) as ColorData);
            if (_local_3 != null){
                return (_local_3.getColor(_arg_1));
            };
            return (ColorData._SafeStr_4861);
        }
        public function getIgnoreMouse(_arg_1:int, _arg_2:int):Boolean
        {
            var _local_3:DirectionData;
            _local_3 = this.getDirectionData(_arg_1);
            if (_local_3 != null){
                return (_local_3.getIgnoreMouse(_arg_2));
            };
            return (LayerData._SafeStr_12552);
        }
        public function getXOffset(_arg_1:int, _arg_2:int):int
        {
            var _local_3:DirectionData;
            _local_3 = this.getDirectionData(_arg_1);
            if (_local_3 != null){
                return (_local_3.getXOffset(_arg_2));
            };
            return (LayerData._SafeStr_12554);
        }
        public function getYOffset(_arg_1:int, _arg_2:int):int
        {
            var _local_3:DirectionData;
            _local_3 = this.getDirectionData(_arg_1);
            if (_local_3 != null){
                return (_local_3.getYOffset(_arg_2));
            };
            return (LayerData._SafeStr_12556);
        }
        public function getZOffset(_arg_1:int, _arg_2:int):Number
        {
            var _local_3:DirectionData;
            _local_3 = this.getDirectionData(_arg_1);
            if (_local_3 != null){
                return (_local_3.getZOffset(_arg_2));
            };
            return (LayerData._SafeStr_4401);
        }

    }
}//package com.sulake.habbo.room.object.visualization.data

// setColor = "_-0-w" (String#3562, DoABC#2)
// _SafeStr_12441 = "_-0pY" (String#1556, DoABC#2)
// _SafeStr_12526 = "_-Hb" (String#22917, DoABC#2)
// _SafeStr_12527 = "_-34M" (String#21672, DoABC#2)
// _layerCount = "_-1NH" (String#850, DoABC#2)
// _SafeStr_12529 = "_-Dq" (String#22763, DoABC#2)
// _SafeStr_12530 = "_-0yj" (String#16381, DoABC#2)
// _directionData = "_-pI" (String#24244, DoABC#2)
// _SafeStr_12532 = "_-BY" (String#22673, DoABC#2)
// defineLayers = "_-vv" (String#24524, DoABC#2)
// defineDirection = "_-8j" (String#22570, DoABC#2)
// defineDirections = "_-21H" (String#19064, DoABC#2)
// setInk = "_-2Vh" (String#20268, DoABC#2)
// _SafeStr_12537 = "_-ZY" (String#23618, DoABC#2)
// _SafeStr_12538 = "_-1dV" (String#18034, DoABC#2)
// setAlpha = "_-30G" (String#21511, DoABC#2)
// setIgnoreMouse = "_-1js" (String#18279, DoABC#2)
// setXOffset = "_-1bw" (String#17968, DoABC#2)
// setYOffset = "_-GM" (String#22867, DoABC#2)
// setZOffset = "_-2R7" (String#20088, DoABC#2)
// defineColors = "_-06Z" (String#14308, DoABC#2)
// getDirectionData = "_-GI" (String#22864, DoABC#2)
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
// SizeData = "_-07b" (String#3713, DoABC#2)
// ColorData = "_-1Hv" (String#5204, DoABC#2)
// _SafeStr_4401 = "_-1Tp" (String#17658, DoABC#2)
// getZOffset = "_-1iZ" (String#18230, DoABC#2)
// getDirectionValue = "_-0Fe" (String#14670, DoABC#2)
// getTag = "_-01m" (String#14120, DoABC#2)
// _SafeStr_4861 = "_-0CJ" (String#582, DoABC#2)
// getColor = "_-07L" (String#1406, DoABC#2)
// setTag = "_-l" (String#8622, DoABC#2)


