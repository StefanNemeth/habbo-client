
package com.sulake.habbo.room.utils
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.room.utils.IVector3d;

    public class LegacyWallGeometry implements IDisposable 
    {

        private static const _SafeStr_13142:String = "l";
        private static const DIRECTION_RIGHT:String = "r";

        private var _disposed:Boolean = false;
        private var _scale:int = 64;
        private var _heightMap:Array;
        private var _width:int = 0;
        private var _height:int = 0;
        private var _floorHeight:int = 0;

        public function LegacyWallGeometry()
        {
            this._heightMap = [];
            super();
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function get scale():int
        {
            return (this._scale);
        }
        public function set scale(_arg_1:int):void
        {
            this._scale = _arg_1;
        }
        public function dispose():void
        {
            this.reset();
            this._disposed = true;
        }
        public function initialize(_arg_1:int, _arg_2:int, _arg_3:int):void
        {
            var _local_5:Array;
            var _local_6:int;
            if ((((_arg_1 <= this._width)) && ((_arg_2 <= this._height)))){
                this._width = _arg_1;
                this._height = _arg_2;
                this._floorHeight = _arg_3;
                return;
            };
            this.reset();
            var _local_4:int;
            while (_local_4 < _arg_2) {
                _local_5 = [];
                this._heightMap.push(_local_5);
                _local_6 = 0;
                while (_local_6 < _arg_1) {
                    _local_5.push(0);
                    _local_6++;
                };
                _local_4++;
            };
            this._width = _arg_1;
            this._height = _arg_2;
            this._floorHeight = _arg_3;
        }
        private function reset():void
        {
            var _local_1:int;
            var _local_2:Array;
            if (this._heightMap != null){
                _local_1 = 0;
                while (_local_1 < this._heightMap.length) {
                    _local_2 = (this._heightMap[_local_1] as Array);
                    _local_1++;
                };
                this._heightMap = [];
            };
        }
        public function setTileHeight(_arg_1:int, _arg_2:int, _arg_3:Number):Boolean
        {
            if ((((((((_arg_1 < 0)) || ((_arg_1 >= this._width)))) || ((_arg_2 < 0)))) || ((_arg_2 >= this._height)))){
                return (false);
            };
            var _local_4:Array = (this._heightMap[_arg_2] as Array);
            if (_local_4 != null){
                _local_4[_arg_1] = _arg_3;
                return (true);
            };
            return (false);
        }
        public function getTileHeight(_arg_1:int, _arg_2:int):Number
        {
            if ((((((((_arg_1 < 0)) || ((_arg_1 >= this._width)))) || ((_arg_2 < 0)))) || ((_arg_2 >= this._height)))){
                return (0);
            };
            var _local_3:Array = (this._heightMap[_arg_2] as Array);
            if (_local_3 != null){
                return ((_local_3[_arg_1] as Number));
            };
            return (0);
        }
        public function getLocation(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:String):IVector3d
        {
            var _local_12:int;
            var _local_6:int;
            var _local_7:int;
            if ((((_arg_1 == 0)) && ((_arg_2 == 0)))){
                _arg_1 = this._width;
                _arg_2 = this._height;
                _local_12 = Math.round((this.scale / 10));
                if (_arg_5 == DIRECTION_RIGHT){
                    _local_7 = (this._width - 1);
                    while (_local_7 >= 0) {
                        _local_6 = 1;
                        while (_local_6 < this._height) {
                            if (this.getTileHeight(_local_7, _local_6) <= this._floorHeight){
                                if ((_local_6 - 1) < _arg_2){
                                    _arg_1 = _local_7;
                                    _arg_2 = (_local_6 - 1);
                                };
                                break;
                            };
                            _local_6++;
                        };
                        _local_7--;
                    };
                    _arg_4 = (_arg_4 + ((this.scale / 4) - (_local_12 / 2)));
                    _arg_3 = (_arg_3 + (this.scale / 2));
                }
                else {
                    _local_6 = (this._height - 1);
                    while (_local_6 >= 0) {
                        _local_7 = 1;
                        while (_local_7 < this._width) {
                            if (this.getTileHeight(_local_7, _local_6) <= this._floorHeight){
                                if ((_local_7 - 1) < _arg_1){
                                    _arg_1 = (_local_7 - 1);
                                    _arg_2 = _local_6;
                                };
                                break;
                            };
                            _local_7++;
                        };
                        _local_6--;
                    };
                    _arg_4 = (_arg_4 + ((this.scale / 4) - (_local_12 / 2)));
                    _arg_3 = (_arg_3 - _local_12);
                };
            };
            var _local_8:Number = Number(_arg_1);
            var _local_9:Number = Number(_arg_2);
            var _local_10:Number = this.getTileHeight(_arg_1, _arg_2);
            if (_arg_5 == DIRECTION_RIGHT){
                _local_8 = (_local_8 + ((_arg_3 / Number((this._scale / 2))) - 0.5));
                _local_9 = (_local_9 + 0.5);
                _local_10 = (_local_10 - ((_arg_4 - (_arg_3 / 2)) / Number((this._scale / 2))));
            }
            else {
                _local_9 = (_local_9 + ((((this._scale / 2) - _arg_3) / Number((this._scale / 2))) - 0.5));
                _local_8 = (_local_8 + 0.5);
                _local_10 = (_local_10 - ((_arg_4 - (((this._scale / 2) - _arg_3) / 2)) / Number((this._scale / 2))));
            };
            return (new Vector3d(_local_8, _local_9, _local_10));
        }
        public function getLocationOldFormat(_arg_1:Number, _arg_2:Number, _arg_3:String):IVector3d
        {
            var _local_4:int;
            var _local_5:int;
            var _local_6:Number = 0;
            var _local_7:Number = 0;
            _local_5 = Math.ceil(_arg_1);
            _local_6 = (_local_5 - _arg_1);
            var _local_8:int;
            var _local_9:int;
            var _local_10:int;
            var _local_11:int;
            var _local_12:Number = 0;
            _local_4 = 0;
            while (_local_4 < this._width) {
                if ((((_local_5 >= 0)) && ((_local_5 < this._height)))){
                    if (this.getTileHeight(_local_4, _local_5) <= this._floorHeight){
                        _local_8 = (_local_4 - 1);
                        _local_9 = _local_5;
                        _local_7 = _local_4;
                        _arg_3 = _SafeStr_13142;
                        break;
                    };
                    if (this.getTileHeight(_local_4, (_local_5 + 1)) <= this._floorHeight){
                        _local_8 = _local_4;
                        _local_9 = _local_5;
                        _local_7 = (_local_9 - _arg_1);
                        _arg_3 = DIRECTION_RIGHT;
                        break;
                    };
                };
                _local_5++;
                _local_4++;
            };
            _local_10 = ((this.scale / 2) * _local_6);
            var _local_13:Number = ((-(_local_7) * this.scale) / 2);
            _local_13 = (_local_13 + ((((-(_arg_2) * 18) / 32) * this.scale) / 2));
            _local_12 = this.getTileHeight(_local_8, _local_9);
            _local_11 = (((_local_12 * this.scale) / 2) + _local_13);
            if (_arg_3 == DIRECTION_RIGHT){
                _local_11 = (_local_11 + ((_local_6 * this.scale) / 4));
            }
            else {
                _local_11 = (_local_11 + (((1 - _local_6) * this.scale) / 4));
            };
            return (this.getLocation(_local_8, _local_9, _local_10, _local_11, _arg_3));
        }
        public function getOldLocation(_arg_1:IVector3d, _arg_2:Number):Array
        {
            if (_arg_1 == null){
                return (null);
            };
            var _local_3:Number = 0;
            var _local_4:Number = 0;
            var _local_5:Number = 0;
            var _local_6:Number = 0;
            var _local_7:String = "";
            var _local_8:Number = 0;
            if (_arg_2 == 90){
                _local_3 = Math.floor((_arg_1.x - 0.5));
                _local_4 = Math.floor((_arg_1.y + 0.5));
                _local_8 = this.getTileHeight(_local_3, _local_4);
                _local_5 = ((this._scale / 2) - (((_arg_1.y - _local_4) + 0.5) * Number((this._scale / 2))));
                _local_6 = (((_local_8 - _arg_1.z) * Number((this._scale / 2))) + (((this._scale / 2) - _local_5) / 2));
                _local_7 = _SafeStr_13142;
            }
            else {
                if (_arg_2 == 180){
                    _local_3 = Math.floor((_arg_1.x + 0.5));
                    _local_4 = Math.floor((_arg_1.y - 0.5));
                    _local_8 = this.getTileHeight(_local_3, _local_4);
                    _local_5 = (((_arg_1.x + 0.5) - _local_3) * Number((this._scale / 2)));
                    _local_6 = (((_local_8 - _arg_1.z) * Number((this._scale / 2))) + (_local_5 / 2));
                    _local_7 = DIRECTION_RIGHT;
                }
                else {
                    return (null);
                };
            };
            return ([_local_3, _local_4, _local_5, _local_6, _local_7]);
        }
        public function getOldLocationString(_arg_1:IVector3d, _arg_2:Number):String
        {
            var _local_3:Array = this.getOldLocation(_arg_1, _arg_2);
            if (_local_3 == null){
                return (null);
            };
            var _local_4:int = int(_local_3[0]);
            var _local_5:int = int(_local_3[1]);
            var _local_6:int = int(_local_3[2]);
            var _local_7:int = int(_local_3[3]);
            var _local_8:String = _local_3[4];
            return ((((((((((":w=" + _local_4) + ",") + _local_5) + " l=") + _local_6) + ",") + _local_7) + " ") + _local_8));
        }
        public function getDirection(_arg_1:String):Number
        {
            if (_arg_1 == DIRECTION_RIGHT){
                return (180);
            };
            return (90);
        }

    }
}//package com.sulake.habbo.room.utils

// IVector3d = "_-hf" (String#8547, DoABC#2)
// Vector3d = "_-1Rb" (String#17568, DoABC#2)
// _floorHeight = "_-1VK" (String#5462, DoABC#2)
// _SafeStr_13142 = "_-0Y1" (String#15358, DoABC#2)
// getLocationOldFormat = "_-1K8" (String#17279, DoABC#2)
// getOldLocation = "_-2KK" (String#19817, DoABC#2)
// getOldLocationString = "_-1DO" (String#16999, DoABC#2)
// LegacyWallGeometry = "_-2Nh" (String#6515, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// _width = "_-0Uq" (String#92, DoABC#2)
// getTileHeight = "_-0Kq" (String#14872, DoABC#2)
// _disposed = "_-6m" (String#31, DoABC#2)


