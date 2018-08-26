
package com.sulake.habbo.room.object.visualization.room.rasterizer.basic
{
    import flash.display.BitmapData;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.room.utils.IVector3d;
    import flash.geom.Rectangle;
    import flash.geom.Point;
    import com.sulake.habbo.room.object.visualization.room.utils.Randomizer;

    public class PlaneMaterialCellMatrix 
    {

        public static const _SafeStr_12868:int = 1;
        public static const _SafeStr_12861:int = 2;
        public static const _SafeStr_12862:int = 3;
        public static const _SafeStr_12863:int = 4;
        public static const _SafeStr_12864:int = 5;
        public static const _SafeStr_12865:int = 6;
        public static const _SafeStr_12860:int = _SafeStr_12868;//1
        public static const _SafeStr_12841:Number = -1;
        public static const MAX_NORMAL_COORDINATE_VALUE:Number = 1;
        public static const _SafeStr_4863:int = 1;
        public static const _SafeStr_4862:int = 2;
        public static const ALIGN_DEFAULT:int = _SafeStr_4863;//1

        private var _SafeStr_12899:Array;
        private var _SafeStr_12885:int = 1;
        private var _align:int = 1;
        private var _PlaneMaterialCell:BitmapData;
        private var _cachedBitmapNormal:Vector3d = null;
        private var _SafeStr_12900:int = 0;
        private var _SafeStr_12886:Boolean = false;
        private var _isStatic:Boolean = true;
        private var _normalMinX:Number = -1;
        private var _normalMaxX:Number = 1;
        private var _normalMinY:Number = -1;
        private var _normalMaxY:Number = 1;

        public function PlaneMaterialCellMatrix(_arg_1:int, _arg_2:int=1, _arg_3:int=1, _arg_4:Number=-1, _arg_5:Number=1, _arg_6:Number=-1, _arg_7:Number=1)
        {
            this._SafeStr_12899 = [];
            super();
            if (_arg_1 < 1){
                _arg_1 = 1;
            };
            var _local_8:int;
            while (_local_8 < _arg_1) {
                this._SafeStr_12899.push(null);
                _local_8++;
            };
            this._SafeStr_12885 = _arg_2;
            this._align = _arg_3;
            this._normalMinX = _arg_4;
            this._normalMaxX = _arg_5;
            this._normalMinY = _arg_6;
            this._normalMaxY = _arg_7;
            if (this._SafeStr_12885 == _SafeStr_12865){
                this._isStatic = false;
            };
        }
        public function get normalMinX():Number
        {
            return (this._normalMinX);
        }
        public function get normalMaxX():Number
        {
            return (this._normalMaxX);
        }
        public function get normalMinY():Number
        {
            return (this._normalMinY);
        }
        public function get normalMaxY():Number
        {
            return (this._normalMaxY);
        }
        public function get isStatic():Boolean
        {
            return (this._isStatic);
        }
        public function dispose():void
        {
            if (this._PlaneMaterialCell != null){
                this._PlaneMaterialCell.dispose();
                this._PlaneMaterialCell = null;
            };
            if (this._cachedBitmapNormal != null){
                this._cachedBitmapNormal = null;
            };
        }
        public function clearCache():void
        {
            var _local_2:PlaneMaterialCellColumn;
            if (!this._SafeStr_12886){
                return;
            };
            if (this._PlaneMaterialCell != null){
                this._PlaneMaterialCell.dispose();
                this._PlaneMaterialCell = null;
            };
            if (this._cachedBitmapNormal != null){
                this._cachedBitmapNormal.x = 0;
                this._cachedBitmapNormal.y = 0;
                this._cachedBitmapNormal.z = 0;
            };
            this._SafeStr_12900 = 0;
            var _local_1:int;
            while (_local_1 < this._SafeStr_12899.length) {
                _local_2 = (this._SafeStr_12899[_local_1] as PlaneMaterialCellColumn);
                if (_local_2 != null){
                    _local_2.clearCache();
                };
                _local_1++;
            };
            this._SafeStr_12886 = false;
        }
        public function createColumn(_arg_1:int, _arg_2:int, _arg_3:Array, _arg_4:int=1):Boolean
        {
            if ((((_arg_1 < 0)) || ((_arg_1 >= this._SafeStr_12899.length)))){
                return (false);
            };
            var _local_5:PlaneMaterialCellColumn = new PlaneMaterialCellColumn(_arg_2, _arg_3, _arg_4);
            var _local_6:PlaneMaterialCellColumn = (this._SafeStr_12899[_arg_1] as PlaneMaterialCellColumn);
            if (_local_6 != null){
                _local_6.dispose();
            };
            this._SafeStr_12899[_arg_1] = _local_5;
            if (((!((_local_5 == null))) && (!(_local_5.isStatic)))){
                this._isStatic = false;
            };
            return (true);
        }
        public function render(_arg_1:BitmapData, _arg_2:int, _arg_3:int, _arg_4:IVector3d, _arg_5:Boolean, _arg_6:int, _arg_7:Boolean):BitmapData
        {
            var _local_11:PlaneMaterialCellColumn;
            var _local_12:BitmapData;
            if (_arg_2 < 1){
                _arg_2 = 1;
            };
            if (_arg_3 < 1){
                _arg_3 = 1;
            };
            if ((((((_arg_1 == null)) || (!((_arg_1.width == _arg_2))))) || (!((_arg_1.height == _arg_3))))){
                _arg_1 = null;
            };
            if (this._cachedBitmapNormal == null){
                this._cachedBitmapNormal = new Vector3d();
            };
            if (this.isStatic){
                if (this._PlaneMaterialCell != null){
                    if ((((((this._PlaneMaterialCell.width == _arg_2)) && ((this._PlaneMaterialCell.height == _arg_3)))) && (Vector3d.isEqual(this._cachedBitmapNormal, _arg_4)))){
                        if (_arg_1 != null){
                            this.copyCachedBitmapOnCanvas(_arg_1, this._SafeStr_12900, _arg_6, _arg_7);
                            return (_arg_1);
                        };
                        return (this._PlaneMaterialCell);
                    };
                    this._PlaneMaterialCell.dispose();
                    this._PlaneMaterialCell = null;
                };
            }
            else {
                if (this._PlaneMaterialCell != null){
                    if ((((this._PlaneMaterialCell.width == _arg_2)) && ((this._PlaneMaterialCell.height == _arg_3)))){
                        this._PlaneMaterialCell.fillRect(this._PlaneMaterialCell.rect, 0xFFFFFF);
                    }
                    else {
                        this._PlaneMaterialCell.dispose();
                        this._PlaneMaterialCell = null;
                    };
                };
            };
            this._SafeStr_12886 = true;
            this._cachedBitmapNormal.assign(_arg_4);
            if (!_arg_5){
                this._SafeStr_12900 = _arg_3;
                if (this._PlaneMaterialCell == null){
                    this._PlaneMaterialCell = new BitmapData(_arg_2, _arg_3, true, 0xFFFFFFFF);
                }
                else {
                    this._PlaneMaterialCell.fillRect(this._PlaneMaterialCell.rect, 0xFFFFFFFF);
                };
                if (_arg_1 != null){
                    this.copyCachedBitmapOnCanvas(_arg_1, _arg_3, _arg_6, _arg_7);
                    return (_arg_1);
                };
                return (this._PlaneMaterialCell);
            };
            if (this._PlaneMaterialCell == null){
                this._SafeStr_12900 = _arg_3;
                this._PlaneMaterialCell = new BitmapData(_arg_2, _arg_3, true, 0xFFFFFF);
            };
            var _local_8:Array = [];
            var _local_9:int;
            while (_local_9 < this._SafeStr_12899.length) {
                _local_11 = (this._SafeStr_12899[_local_9] as PlaneMaterialCellColumn);
                if (_local_11 != null){
                    _local_12 = _local_11.render(_arg_3, _arg_4);
                    if (_local_12 != null){
                        _local_8.push(_local_12);
                    };
                };
                _local_9++;
            };
            if (_local_8.length == 0){
                if (_arg_1 != null){
                    return (_arg_1);
                };
                return (this._PlaneMaterialCell);
            };
            var _local_10:int;
            switch (this._SafeStr_12885){
                case _SafeStr_12861:
                    _local_10 = this.renderRepeatBorders(this._PlaneMaterialCell, _local_8);
                    break;
                case _SafeStr_12862:
                    _local_10 = this.renderRepeatCenter(this._PlaneMaterialCell, _local_8);
                    break;
                case _SafeStr_12863:
                    _local_10 = this.renderRepeatFirst(this._PlaneMaterialCell, _local_8);
                    break;
                case _SafeStr_12864:
                    _local_10 = this.renderRepeatLast(this._PlaneMaterialCell, _local_8);
                    break;
                case _SafeStr_12865:
                    _local_10 = this.renderRepeatRandom(this._PlaneMaterialCell, _local_8);
                    break;
                default:
                    _local_10 = this.renderRepeatAll(this._PlaneMaterialCell, _local_8);
            };
            this._SafeStr_12900 = _local_10;
            if (_arg_1 != null){
                this.copyCachedBitmapOnCanvas(_arg_1, _local_10, _arg_6, _arg_7);
                return (_arg_1);
            };
            return (this._PlaneMaterialCell);
        }
        private function copyCachedBitmapOnCanvas(_arg_1:BitmapData, _arg_2:int, _arg_3:int, _arg_4:Boolean):void
        {
            if ((((((_arg_1 == null)) || ((this._PlaneMaterialCell == null)))) || ((_arg_1 == this._PlaneMaterialCell)))){
                return;
            };
            if (!_arg_4){
                _arg_3 = ((_arg_1.height - _arg_2) - _arg_3);
            };
            var _local_5:Rectangle;
            if (this._align == _SafeStr_4863){
                _local_5 = new Rectangle(0, 0, this._PlaneMaterialCell.width, this._SafeStr_12900);
            }
            else {
                _local_5 = new Rectangle(0, (this._PlaneMaterialCell.height - this._SafeStr_12900), this._PlaneMaterialCell.width, this._SafeStr_12900);
            };
            _arg_1.copyPixels(this._PlaneMaterialCell, _local_5, new Point(0, _arg_3), null, null, true);
        }
        private function getColumnsWidth(_arg_1:Array):int
        {
            var _local_4:BitmapData;
            if ((((_arg_1 == null)) || ((_arg_1.length == 0)))){
                return (0);
            };
            var _local_2:int;
            var _local_3:int;
            while (_local_3 < _arg_1.length) {
                _local_4 = (_arg_1[_local_3] as BitmapData);
                if (_local_4 != null){
                    _local_2 = (_local_2 + _local_4.width);
                };
                _local_3++;
            };
            return (_local_2);
        }
        private function renderColumns(_arg_1:BitmapData, _arg_2:Array, _arg_3:int, _arg_4:Boolean):Point
        {
            var _local_8:int;
            if ((((((_arg_2 == null)) || ((_arg_2.length == 0)))) || ((_arg_1 == null)))){
                return (new Point(_arg_3, 0));
            };
            var _local_5:int;
            var _local_6:BitmapData;
            var _local_7:int;
            while (_local_7 < _arg_2.length) {
                if (_arg_4){
                    _local_6 = (_arg_2[_local_7] as BitmapData);
                }
                else {
                    _local_6 = (_arg_2[((_arg_2.length - 1) - _local_7)] as BitmapData);
                };
                if (_local_6 != null){
                    if (!_arg_4){
                        _arg_3 = (_arg_3 - _local_6.width);
                    };
                    _local_8 = 0;
                    if (this._align == _SafeStr_4862){
                        _local_8 = (_arg_1.height - _local_6.height);
                    };
                    _arg_1.copyPixels(_local_6, _local_6.rect, new Point(_arg_3, _local_8), _local_6, null, true);
                    if (_local_6.height > _local_5){
                        _local_5 = _local_6.height;
                    };
                    if (_arg_4){
                        _arg_3 = (_arg_3 + _local_6.width);
                    };
                    if (((((_arg_4) && ((_arg_3 >= _arg_1.width)))) || (((!(_arg_4)) && ((_arg_3 <= 0)))))){
                        return (new Point(_arg_3, _local_5));
                    };
                };
                _local_7++;
            };
            return (new Point(_arg_3, _local_5));
        }
        private function renderRepeatAll(_arg_1:BitmapData, _arg_2:Array):int
        {
            var _local_6:Point;
            if ((((((_arg_2 == null)) || ((_arg_2.length == 0)))) || ((_arg_1 == null)))){
                return (0);
            };
            var _local_3:int;
            var _local_4:int = this.getColumnsWidth(_arg_2);
            var _local_5:int;
            if (_local_4 > _arg_1.width){
            };
            while (_local_5 < _arg_1.width) {
                _local_6 = this.renderColumns(_arg_1, _arg_2, _local_5, true);
                _local_5 = _local_6.x;
                if (_local_6.y > _local_3){
                    _local_3 = _local_6.y;
                };
                if (_local_6.x == 0){
                    return (_local_3);
                };
            };
            return (_local_3);
        }
        private function renderRepeatBorders(_arg_1:BitmapData, _arg_2:Array):int
        {
            if ((((((_arg_2 == null)) || ((_arg_2.length == 0)))) || ((_arg_1 == null)))){
                return (0);
            };
            var _local_3:int;
            var _local_4:BitmapData;
            var _local_5:Array = [];
            var _local_6:int;
            var _local_7:int;
            _local_7 = 1;
            while (_local_7 < (_arg_2.length - 1)) {
                _local_4 = (_arg_2[_local_7] as BitmapData);
                if (_local_4 != null){
                    _local_6 = (_local_6 + _local_4.width);
                    _local_5.push(_local_4);
                };
                _local_7++;
            };
            if (this._SafeStr_12899.length == 1){
                _local_4 = (this._SafeStr_12899[0] as BitmapData);
                if (_local_4 != null){
                    _local_6 = _local_4.width;
                    _local_5.push(_local_4);
                };
            };
            var _local_8 = ((_arg_1.width - _local_6) >> 1);
            var _local_9:Point;
            _local_9 = this.renderColumns(_arg_1, _local_5, _local_8, true);
            var _local_10:int = _local_9.x;
            if (_local_9.y > _local_3){
                _local_3 = _local_9.y;
            };
            _local_4 = (_arg_2[0] as BitmapData);
            if (_local_4 != null){
                _local_5 = [_local_4];
                while (_local_8 >= 0) {
                    _local_9 = this.renderColumns(_arg_1, _local_5, _local_8, false);
                    _local_8 = _local_9.x;
                    if (_local_9.y > _local_3){
                        _local_3 = _local_9.y;
                    };
                };
            };
            _local_4 = (_arg_2[(_arg_2.length - 1)] as BitmapData);
            if (_local_4 != null){
                _local_5 = [_local_4];
                while (_local_10 < _arg_1.height) {
                    _local_9 = this.renderColumns(_arg_1, _local_5, _local_10, true);
                    _local_10 = _local_9.x;
                    if (_local_9.y > _local_3){
                        _local_3 = _local_9.y;
                    };
                };
            };
            return (_local_3);
        }
        private function renderRepeatCenter(_arg_1:BitmapData, _arg_2:Array):int
        {
            var _local_14:int;
            var _local_15:int;
            var _local_16:int;
            var _local_17:int;
            var _local_18:Array;
            if ((((((_arg_2 == null)) || ((_arg_2.length == 0)))) || ((_arg_1 == null)))){
                return (0);
            };
            var _local_3:int;
            var _local_4:BitmapData;
            var _local_5:Array = [];
            var _local_6:Array = [];
            var _local_7:int;
            var _local_8:int;
            var _local_9:int;
            _local_9 = 0;
            while (_local_9 < (_arg_2.length >> 1)) {
                _local_4 = (_arg_2[_local_9] as BitmapData);
                if (_local_4 != null){
                    _local_7 = (_local_7 + _local_4.width);
                    _local_5.push(_local_4);
                };
                _local_9++;
            };
            _local_9 = ((_arg_2.length >> 1) + 1);
            while (_local_9 < _arg_2.length) {
                _local_4 = (_arg_2[_local_9] as BitmapData);
                if (_local_4 != null){
                    _local_8 = (_local_8 + _local_4.width);
                    _local_6.push(_local_4);
                };
                _local_9++;
            };
            var _local_10:Point;
            var _local_11:int;
            var _local_12:int;
            var _local_13:int = _arg_1.width;
            if ((_local_7 + _local_8) > _arg_1.width){
                _local_11 = ((_local_7 + _local_8) - _arg_1.width);
                _local_12 = (_local_12 - (_local_11 >> 1));
                _local_13 = (_local_13 + (_local_11 - (_local_11 >> 1)));
            };
            if (_local_11 == 0){
                _local_4 = (_arg_2[(_arg_2.length >> 1)] as BitmapData);
                if (_local_4 != null){
                    _local_14 = _local_4.width;
                    _local_15 = (_arg_1.width - (_local_7 + _local_8));
                    _local_16 = (Math.ceil((_local_15 / _local_14)) * _local_14);
                    _local_12 = (_local_7 - ((_local_16 - _local_15) >> 1));
                    _local_17 = (_local_12 + _local_16);
                    _local_18 = [_local_4];
                    while (_local_12 < _local_17) {
                        _local_10 = this.renderColumns(_arg_1, _local_18, _local_12, true);
                        _local_12 = _local_10.x;
                        if (_local_10.y > _local_3){
                            _local_3 = _local_10.y;
                        };
                    };
                };
            };
            _local_12 = 0;
            _local_10 = this.renderColumns(_arg_1, _local_5, _local_12, true);
            if (_local_10.y > _local_3){
                _local_3 = _local_10.y;
            };
            _local_10 = this.renderColumns(_arg_1, _local_6, _local_13, false);
            if (_local_10.y > _local_3){
                _local_3 = _local_10.y;
            };
            return (_local_3);
        }
        private function renderRepeatFirst(_arg_1:BitmapData, _arg_2:Array):int
        {
            var _local_7:Array;
            if ((((((_arg_2 == null)) || ((_arg_2.length == 0)))) || ((_arg_1 == null)))){
                return (0);
            };
            var _local_3:int;
            var _local_4:BitmapData;
            var _local_5:int = _arg_1.width;
            var _local_6:Point = this.renderColumns(_arg_1, _arg_2, _local_5, false);
            _local_5 = _local_6.x;
            if (_local_6.y > _local_3){
                _local_3 = _local_6.y;
            };
            _local_4 = (_arg_2[0] as BitmapData);
            if (_local_4 != null){
                _local_7 = [_local_4];
                while (_local_5 >= 0) {
                    _local_6 = this.renderColumns(_arg_1, _local_7, _local_5, false);
                    _local_5 = _local_6.x;
                    if (_local_6.y > _local_3){
                        _local_3 = _local_6.y;
                    };
                };
            };
            return (_local_3);
        }
        private function renderRepeatLast(_arg_1:BitmapData, _arg_2:Array):int
        {
            var _local_7:Array;
            if ((((((_arg_2 == null)) || ((_arg_2.length == 0)))) || ((_arg_1 == null)))){
                return (0);
            };
            var _local_3:int;
            var _local_4:BitmapData;
            var _local_5:int;
            var _local_6:Point = this.renderColumns(_arg_1, _arg_2, _local_5, true);
            _local_5 = _local_6.x;
            if (_local_6.y > _local_3){
                _local_3 = _local_6.y;
            };
            _local_4 = (_arg_2[(_arg_2.length - 1)] as BitmapData);
            if (_local_4 != null){
                _local_7 = [_local_4];
                while (_local_5 < _arg_1.width) {
                    _local_6 = this.renderColumns(_arg_1, _local_7, _local_5, true);
                    _local_5 = _local_6.x;
                    if (_local_6.y > _local_3){
                        _local_3 = _local_6.y;
                    };
                };
            };
            return (_local_3);
        }
        private function renderRepeatRandom(_arg_1:BitmapData, _arg_2:Array):int
        {
            var _local_6:Array;
            var _local_7:int;
            var _local_8:Array;
            var _local_9:Point;
            if ((((((_arg_2 == null)) || ((_arg_2.length == 0)))) || ((_arg_1 == null)))){
                return (0);
            };
            var _local_3:int;
            var _local_4:BitmapData;
            var _local_5:int;
            while (_local_5 < _arg_1.width) {
                _local_6 = Randomizer.Map(1, 0, (_arg_2.length * 17631));
                _local_7 = (_local_6[0] % _arg_2.length);
                _local_4 = (_arg_2[_local_7] as BitmapData);
                if (_local_4 != null){
                    _local_8 = [_local_4];
                    _local_9 = this.renderColumns(_arg_1, _local_8, _local_5, true);
                    _local_5 = _local_9.x;
                    if (_local_9.y > _local_3){
                        _local_3 = _local_9.y;
                    };
                }
                else {
                    return (_local_3);
                };
            };
            return (_local_3);
        }

    }
}//package com.sulake.habbo.room.object.visualization.room.rasterizer.basic

// _SafeStr_12841 = "_-TR" (String#23383, DoABC#2)
// _normalMinX = "_-pN" (String#2200, DoABC#2)
// _normalMinY = "_-0m-" (String#1544, DoABC#2)
// _normalMaxY = "_-2Ow" (String#1872, DoABC#2)
// _SafeStr_12860 = "_-38J" (String#21815, DoABC#2)
// _SafeStr_12861 = "_-2SP" (String#20134, DoABC#2)
// _SafeStr_12862 = "_-Cz" (String#22727, DoABC#2)
// _SafeStr_12863 = "_-04O" (String#14218, DoABC#2)
// _SafeStr_12864 = "_-0AL" (String#14461, DoABC#2)
// _SafeStr_12865 = "_-1Bd" (String#16925, DoABC#2)
// _SafeStr_12868 = "_-2X0" (String#20323, DoABC#2)
// createColumn = "_-0iO" (String#15767, DoABC#2)
// _PlaneMaterialCell = "_-3BZ" (String#917, DoABC#2)
// _SafeStr_12885 = "_-2gh" (String#6884, DoABC#2)
// _SafeStr_12886 = "_-1qn" (String#868, DoABC#2)
// _isStatic = "_-3Ce" (String#7569, DoABC#2)
// isEqual = "_-2hG" (String#20740, DoABC#2)
// renderRepeatBorders = "_-1Np" (String#5308, DoABC#2)
// renderRepeatCenter = "_-0Uj" (String#4197, DoABC#2)
// renderRepeatFirst = "_-2el" (String#6846, DoABC#2)
// renderRepeatLast = "_-i0" (String#8554, DoABC#2)
// renderRepeatAll = "_-2wy" (String#7222, DoABC#2)
// _SafeStr_12899 = "_-3BY" (String#21944, DoABC#2)
// _SafeStr_12900 = "_-0IP" (String#14776, DoABC#2)
// copyCachedBitmapOnCanvas = "_-0Yu" (String#15398, DoABC#2)
// renderRepeatRandom = "_-3Et" (String#22071, DoABC#2)
// getColumnsWidth = "_-CD" (String#22698, DoABC#2)
// renderColumns = "_-w6" (String#24533, DoABC#2)
// IVector3d = "_-hf" (String#8547, DoABC#2)
// Vector3d = "_-1Rb" (String#17568, DoABC#2)
// PlaneMaterialCellColumn = "_-2SG" (String#6614, DoABC#2)
// PlaneMaterialCellMatrix = "_-0Pa" (String#4083, DoABC#2)
// Randomizer = "_-FS" (String#7982, DoABC#2)
// _SafeStr_4862 = "_-3BX" (String#7541, DoABC#2)
// _SafeStr_4863 = "_-0Ny" (String#4045, DoABC#2)
// Map = "_-2U9" (String#20205, DoABC#2)
// isStatic = "_-2HT" (String#19704, DoABC#2)


