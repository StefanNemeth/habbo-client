
package com.sulake.habbo.room.object.visualization.room.rasterizer.basic
{
    import flash.display.BitmapData;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.room.utils.IVector3d;
    import flash.geom.Point;

    public class PlaneMaterialCellColumn 
    {

        public static const _SafeStr_12869:int = 0;
        public static const _SafeStr_12868:int = 1;
        public static const _SafeStr_12861:int = 2;
        public static const _SafeStr_12862:int = 3;
        public static const _SafeStr_12863:int = 4;
        public static const _SafeStr_12864:int = 5;

        private var _SafeStr_12884:Array;
        private var _SafeStr_12885:int = 1;
        private var _width:int = 1;
        private var _SafeStr_12879:BitmapData;
        private var _cachedBitmapNormal:Vector3d = null;
        private var _SafeStr_12886:Boolean = false;
        private var _isStatic:Boolean = true;

        public function PlaneMaterialCellColumn(_arg_1:int, _arg_2:Array, _arg_3:int=1)
        {
            var _local_4:int;
            var _local_5:PlaneMaterialCell;
            this._SafeStr_12884 = [];
            super();
            if (_arg_1 < 1){
                _arg_1 = 1;
            };
            this._width = _arg_1;
            if (_arg_2 != null){
                _local_4 = 0;
                while (_local_4 < _arg_2.length) {
                    _local_5 = (_arg_2[_local_4] as PlaneMaterialCell);
                    if (_local_5 != null){
                        this._SafeStr_12884.push(_local_5);
                        if (!_local_5.isStatic){
                            this._isStatic = false;
                        };
                    };
                    _local_4++;
                };
            };
            this._SafeStr_12885 = _arg_3;
        }
        public function get isStatic():Boolean
        {
            return (this._isStatic);
        }
        public function dispose():void
        {
            var _local_1:int;
            var _local_2:PlaneMaterialCell;
            if (this._SafeStr_12884 != null){
                _local_1 = 0;
                while (_local_1 < this._SafeStr_12884.length) {
                    _local_2 = (this._SafeStr_12884[_local_1] as PlaneMaterialCell);
                    if (_local_2 != null){
                        _local_2.dispose();
                    };
                    _local_1++;
                };
                this._SafeStr_12884 = null;
            };
            if (this._SafeStr_12879 != null){
                this._SafeStr_12879.dispose();
                this._SafeStr_12879 = null;
            };
            if (this._cachedBitmapNormal != null){
                this._cachedBitmapNormal = null;
            };
        }
        public function clearCache():void
        {
            var _local_1:int;
            var _local_2:PlaneMaterialCell;
            if (!this._SafeStr_12886){
                return;
            };
            if (this._SafeStr_12879 != null){
                this._SafeStr_12879.dispose();
                this._SafeStr_12879 = null;
            };
            if (this._cachedBitmapNormal != null){
                this._cachedBitmapNormal.x = 0;
                this._cachedBitmapNormal.y = 0;
                this._cachedBitmapNormal.z = 0;
            };
            if (this._SafeStr_12884 != null){
                _local_1 = 0;
                while (_local_1 < this._SafeStr_12884.length) {
                    _local_2 = (this._SafeStr_12884[_local_1] as PlaneMaterialCell);
                    if (_local_2 != null){
                        _local_2.clearCache();
                    };
                    _local_1++;
                };
            };
            this._SafeStr_12886 = false;
        }
        public function render(_arg_1:int, _arg_2:IVector3d):BitmapData
        {
            var _local_3:int;
            if (this._SafeStr_12885 == _SafeStr_12869){
                _local_3 = this.getCellsHeight(this._SafeStr_12884, _arg_2);
                _arg_1 = _local_3;
            };
            if (this._cachedBitmapNormal == null){
                this._cachedBitmapNormal = new Vector3d();
            };
            if (this.isStatic){
                if (this._SafeStr_12879 != null){
                    if ((((this._SafeStr_12879.height == _arg_1)) && (Vector3d.isEqual(this._cachedBitmapNormal, _arg_2)))){
                        return (this._SafeStr_12879);
                    };
                    this._SafeStr_12879.dispose();
                    this._SafeStr_12879 = null;
                };
            }
            else {
                if (this._SafeStr_12879 != null){
                    if (this._SafeStr_12879.height == _arg_1){
                        this._SafeStr_12879.fillRect(this._SafeStr_12879.rect, 0xFFFFFF);
                    }
                    else {
                        this._SafeStr_12879.dispose();
                        this._SafeStr_12879 = null;
                    };
                };
            };
            this._SafeStr_12886 = true;
            if (this._SafeStr_12879 == null){
                this._SafeStr_12879 = new BitmapData(this._width, _arg_1, true, 0xFFFFFF);
            };
            this._cachedBitmapNormal.assign(_arg_2);
            if (this._SafeStr_12884.length == 0){
                return (this._SafeStr_12879);
            };
            switch (this._SafeStr_12885){
                case _SafeStr_12869:
                    this.renderRepeatNone(_arg_2);
                    break;
                case _SafeStr_12861:
                    this.renderRepeatBorders(_arg_2);
                    break;
                case _SafeStr_12862:
                    this.renderRepeatCenter(_arg_2);
                    break;
                case _SafeStr_12863:
                    this.renderRepeatFirst(_arg_2);
                    break;
                case _SafeStr_12864:
                    this.renderRepeatLast(_arg_2);
                    break;
                default:
                    this.renderRepeatAll(_arg_2);
            };
            return (this._SafeStr_12879);
        }
        private function getCellsHeight(_arg_1:Array, _arg_2:IVector3d):int
        {
            var _local_5:PlaneMaterialCell;
            var _local_6:int;
            if ((((_arg_1 == null)) || ((_arg_1.length == 0)))){
                return (0);
            };
            var _local_3:int;
            var _local_4:int;
            while (_local_4 < _arg_1.length) {
                _local_5 = (_arg_1[_local_4] as PlaneMaterialCell);
                if (_local_5 != null){
                    _local_6 = _local_5.getHeight(_arg_2);
                    _local_3 = (_local_3 + _local_6);
                };
                _local_4++;
            };
            return (_local_3);
        }
        private function renderCells(_arg_1:Array, _arg_2:int, _arg_3:Boolean, _arg_4:IVector3d):int
        {
            if ((((((_arg_1 == null)) || ((_arg_1.length == 0)))) || ((this._SafeStr_12879 == null)))){
                return (_arg_2);
            };
            var _local_5:PlaneMaterialCell;
            var _local_6:BitmapData;
            var _local_7:int;
            while (_local_7 < _arg_1.length) {
                if (_arg_3){
                    _local_5 = (_arg_1[_local_7] as PlaneMaterialCell);
                }
                else {
                    _local_5 = (_arg_1[((_arg_1.length - 1) - _local_7)] as PlaneMaterialCell);
                };
                if (_local_5 != null){
                    _local_6 = _local_5.render(_arg_4);
                    if (_local_6 != null){
                        if (!_arg_3){
                            _arg_2 = (_arg_2 - _local_6.height);
                        };
                        this._SafeStr_12879.copyPixels(_local_6, _local_6.rect, new Point(0, _arg_2), _local_6, null, true);
                        if (_arg_3){
                            _arg_2 = (_arg_2 + _local_6.height);
                        };
                        if (((((_arg_3) && ((_arg_2 >= this._SafeStr_12879.height)))) || (((!(_arg_3)) && ((_arg_2 <= 0)))))){
                            return (_arg_2);
                        };
                    };
                };
                _local_7++;
            };
            return (_arg_2);
        }
        private function renderRepeatNone(_arg_1:IVector3d):void
        {
            if ((((this._SafeStr_12884.length == 0)) || ((this._SafeStr_12879 == null)))){
                return;
            };
            this.renderCells(this._SafeStr_12884, 0, true, _arg_1);
        }
        private function renderRepeatAll(_arg_1:IVector3d):void
        {
            if ((((this._SafeStr_12884.length == 0)) || ((this._SafeStr_12879 == null)))){
                return;
            };
            var _local_2:int = this.getCellsHeight(this._SafeStr_12884, _arg_1);
            var _local_3:int;
            if (_local_2 > this._SafeStr_12879.height){
            };
            while (_local_3 < this._SafeStr_12879.height) {
                _local_3 = this.renderCells(this._SafeStr_12884, _local_3, true, _arg_1);
                if (_local_3 == 0){
                    return;
                };
            };
        }
        private function renderRepeatBorders(_arg_1:IVector3d):void
        {
            if ((((this._SafeStr_12884.length == 0)) || ((this._SafeStr_12879 == null)))){
                return;
            };
            var _local_2:PlaneMaterialCell;
            var _local_3:BitmapData;
            var _local_4:Array = [];
            var _local_5:int;
            var _local_6:int;
            var _local_7:int;
            _local_7 = 1;
            while (_local_7 < (this._SafeStr_12884.length - 1)) {
                _local_2 = (this._SafeStr_12884[_local_7] as PlaneMaterialCell);
                if (_local_2 != null){
                    _local_6 = _local_2.getHeight(_arg_1);
                    if (_local_6 > 0){
                        _local_5 = (_local_5 + _local_6);
                        _local_4.push(_local_2);
                    };
                };
                _local_7++;
            };
            if (this._SafeStr_12884.length == 1){
                _local_2 = (this._SafeStr_12884[0] as PlaneMaterialCell);
                if (_local_2 != null){
                    _local_6 = _local_2.getHeight(_arg_1);
                    if (_local_6 > 0){
                        _local_5 = (_local_5 + _local_6);
                        _local_4.push(_local_2);
                    };
                };
            };
            var _local_8 = ((this._SafeStr_12879.height - _local_5) >> 1);
            var _local_9:int = this.renderCells(_local_4, _local_8, true, _arg_1);
            _local_2 = (this._SafeStr_12884[0] as PlaneMaterialCell);
            if (_local_2 != null){
                _local_4 = [_local_2];
                while (_local_8 >= 0) {
                    _local_8 = this.renderCells(_local_4, _local_8, false, _arg_1);
                };
            };
            _local_2 = (this._SafeStr_12884[(this._SafeStr_12884.length - 1)] as PlaneMaterialCell);
            if (_local_2 != null){
                _local_4 = [_local_2];
                while (_local_9 < this._SafeStr_12879.height) {
                    _local_9 = this.renderCells(_local_4, _local_9, true, _arg_1);
                };
            };
        }
        private function renderRepeatCenter(_arg_1:IVector3d):void
        {
            var _local_13:int;
            var _local_14:int;
            var _local_15:int;
            var _local_16:Array;
            if ((((this._SafeStr_12884.length == 0)) || ((this._SafeStr_12879 == null)))){
                return;
            };
            var _local_2:PlaneMaterialCell;
            var _local_3:BitmapData;
            var _local_4:Array = [];
            var _local_5:Array = [];
            var _local_6:int;
            var _local_7:int;
            var _local_8:int;
            var _local_9:int;
            _local_9 = 0;
            while (_local_9 < (this._SafeStr_12884.length >> 1)) {
                _local_2 = (this._SafeStr_12884[_local_9] as PlaneMaterialCell);
                if (_local_2 != null){
                    _local_8 = _local_2.getHeight(_arg_1);
                    if (_local_8 > 0){
                        _local_6 = (_local_6 + _local_8);
                        _local_4.push(_local_2);
                    };
                };
                _local_9++;
            };
            _local_9 = ((this._SafeStr_12884.length >> 1) + 1);
            while (_local_9 < this._SafeStr_12884.length) {
                _local_2 = (this._SafeStr_12884[_local_9] as PlaneMaterialCell);
                if (_local_2 != null){
                    _local_8 = _local_2.getHeight(_arg_1);
                    if (_local_8 > 0){
                        _local_7 = (_local_7 + _local_8);
                        _local_5.push(_local_2);
                    };
                };
                _local_9++;
            };
            var _local_10:int;
            var _local_11:int;
            var _local_12:int = this._SafeStr_12879.height;
            if ((_local_6 + _local_7) > this._SafeStr_12879.height){
                _local_10 = ((_local_6 + _local_7) - this._SafeStr_12879.height);
                _local_11 = (_local_11 - (_local_10 >> 1));
                _local_12 = (_local_12 + (_local_10 - (_local_10 >> 1)));
            };
            if (_local_10 == 0){
                _local_2 = (this._SafeStr_12884[(this._SafeStr_12884.length >> 1)] as PlaneMaterialCell);
                if (_local_2 != null){
                    _local_8 = _local_2.getHeight(_arg_1);
                    if (_local_8 > 0){
                        _local_13 = (this._SafeStr_12879.height - (_local_6 + _local_7));
                        _local_14 = (Math.ceil((_local_13 / _local_8)) * _local_8);
                        _local_11 = (_local_6 - ((_local_14 - _local_13) >> 1));
                        _local_15 = (_local_11 + _local_14);
                        _local_16 = [_local_2];
                        while (_local_11 < _local_15) {
                            _local_11 = this.renderCells(_local_16, _local_11, true, _arg_1);
                        };
                    };
                };
            };
            _local_11 = 0;
            this.renderCells(_local_4, _local_11, true, _arg_1);
            this.renderCells(_local_5, _local_12, false, _arg_1);
        }
        private function renderRepeatFirst(_arg_1:IVector3d):void
        {
            var _local_4:Array;
            if ((((this._SafeStr_12884.length == 0)) || ((this._SafeStr_12879 == null)))){
                return;
            };
            var _local_2:PlaneMaterialCell;
            var _local_3:int = this._SafeStr_12879.height;
            _local_3 = this.renderCells(this._SafeStr_12884, _local_3, false, _arg_1);
            _local_2 = (this._SafeStr_12884[0] as PlaneMaterialCell);
            if (_local_2 != null){
                _local_4 = [_local_2];
                while (_local_3 >= 0) {
                    _local_3 = this.renderCells(_local_4, _local_3, false, _arg_1);
                };
            };
        }
        private function renderRepeatLast(_arg_1:IVector3d):void
        {
            var _local_4:Array;
            if ((((this._SafeStr_12884.length == 0)) || ((this._SafeStr_12879 == null)))){
                return;
            };
            var _local_2:PlaneMaterialCell;
            var _local_3:int;
            _local_3 = this.renderCells(this._SafeStr_12884, _local_3, true, _arg_1);
            _local_2 = (this._SafeStr_12884[(this._SafeStr_12884.length - 1)] as PlaneMaterialCell);
            if (_local_2 != null){
                _local_4 = [_local_2];
                while (_local_3 < this._SafeStr_12879.height) {
                    _local_3 = this.renderCells(_local_4, _local_3, true, _arg_1);
                };
            };
        }

    }
}//package com.sulake.habbo.room.object.visualization.room.rasterizer.basic

// _SafeStr_12861 = "_-2SP" (String#20134, DoABC#2)
// _SafeStr_12862 = "_-Cz" (String#22727, DoABC#2)
// _SafeStr_12863 = "_-04O" (String#14218, DoABC#2)
// _SafeStr_12864 = "_-0AL" (String#14461, DoABC#2)
// _SafeStr_12868 = "_-2X0" (String#20323, DoABC#2)
// _SafeStr_12869 = "_-0n6" (String#15943, DoABC#2)
// _SafeStr_12879 = "_-3BZ" (String#917, DoABC#2)
// getHeight = "_-27v" (String#19326, DoABC#2)
// _SafeStr_12884 = "_-00-" (String#14051, DoABC#2)
// _SafeStr_12885 = "_-2gh" (String#6884, DoABC#2)
// _SafeStr_12886 = "_-1qn" (String#868, DoABC#2)
// _isStatic = "_-3Ce" (String#7569, DoABC#2)
// getCellsHeight = "_-a8" (String#23637, DoABC#2)
// isEqual = "_-2hG" (String#20740, DoABC#2)
// renderRepeatNone = "_-0a3" (String#15443, DoABC#2)
// renderRepeatBorders = "_-1Np" (String#5308, DoABC#2)
// renderRepeatCenter = "_-0Uj" (String#4197, DoABC#2)
// renderRepeatFirst = "_-2el" (String#6846, DoABC#2)
// renderRepeatLast = "_-i0" (String#8554, DoABC#2)
// renderRepeatAll = "_-2wy" (String#7222, DoABC#2)
// renderCells = "_-2PO" (String#20018, DoABC#2)
// IVector3d = "_-hf" (String#8547, DoABC#2)
// Vector3d = "_-1Rb" (String#17568, DoABC#2)
// PlaneMaterialCell = "_-3G6" (String#7632, DoABC#2)
// PlaneMaterialCellColumn = "_-2SG" (String#6614, DoABC#2)
// _width = "_-0Uq" (String#92, DoABC#2)
// isStatic = "_-2HT" (String#19704, DoABC#2)


