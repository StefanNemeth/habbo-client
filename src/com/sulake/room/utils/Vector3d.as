
package com.sulake.room.utils
{
    public class Vector3d implements IVector3d 
    {

        private var _x:Number;
        private var _y:Number;
        private var _z:Number;
        private var _length:Number = NaN;

        public function Vector3d(_arg_1:Number=0, _arg_2:Number=0, _arg_3:Number=0)
        {
            this._x = _arg_1;
            this._y = _arg_2;
            this._z = _arg_3;
        }
        public static function sum(_arg_1:IVector3d, _arg_2:IVector3d):Vector3d
        {
            if ((((_arg_1 == null)) || ((_arg_2 == null)))){
                return (null);
            };
            return (new (Vector3d)((_arg_1.x + _arg_2.x), (_arg_1.y + _arg_2.y), (_arg_1.z + _arg_2.z)));
        }
        public static function dif(_arg_1:IVector3d, _arg_2:IVector3d):Vector3d
        {
            if ((((_arg_1 == null)) || ((_arg_2 == null)))){
                return (null);
            };
            return (new (Vector3d)((_arg_1.x - _arg_2.x), (_arg_1.y - _arg_2.y), (_arg_1.z - _arg_2.z)));
        }
        public static function product(_arg_1:IVector3d, _arg_2:Number):Vector3d
        {
            if (_arg_1 == null){
                return (null);
            };
            return (new (Vector3d)((_arg_1.x * _arg_2), (_arg_1.y * _arg_2), (_arg_1.z * _arg_2)));
        }
        public static function dotProduct(_arg_1:IVector3d, _arg_2:IVector3d):Number
        {
            if ((((_arg_1 == null)) || ((_arg_2 == null)))){
                return (0);
            };
            return ((((_arg_1.x * _arg_2.x) + (_arg_1.y * _arg_2.y)) + (_arg_1.z * _arg_2.z)));
        }
        public static function crossProduct(_arg_1:IVector3d, _arg_2:IVector3d):Vector3d
        {
            if ((((_arg_1 == null)) || ((_arg_2 == null)))){
                return (null);
            };
            return (new (Vector3d)(((_arg_1.y * _arg_2.z) - (_arg_1.z * _arg_2.y)), ((_arg_1.z * _arg_2.x) - (_arg_1.x * _arg_2.z)), ((_arg_1.x * _arg_2.y) - (_arg_1.y * _arg_2.x))));
        }
        public static function scalarProjection(_arg_1:IVector3d, _arg_2:IVector3d):Number
        {
            if ((((_arg_1 == null)) || ((_arg_2 == null)))){
                return (-1);
            };
            var _local_3:Number = _arg_2.length;
            if (_local_3 > 0){
                return (((((_arg_1.x * _arg_2.x) + (_arg_1.y * _arg_2.y)) + (_arg_1.z * _arg_2.z)) / _local_3));
            };
            return (-1);
        }
        public static function cosAngle(_arg_1:IVector3d, _arg_2:IVector3d):Number
        {
            if ((((_arg_1 == null)) || ((_arg_2 == null)))){
                return (0);
            };
            var _local_3:Number = (_arg_1.length * _arg_2.length);
            if (_local_3 == 0){
                return (0);
            };
            return ((Vector3d.dotProduct(_arg_1, _arg_2) / _local_3));
        }
        public static function isEqual(_arg_1:IVector3d, _arg_2:IVector3d):Boolean
        {
            if ((((_arg_1 == null)) || ((_arg_2 == null)))){
                return (false);
            };
            if ((((((_arg_1.x == _arg_2.x)) && ((_arg_1.y == _arg_2.y)))) && ((_arg_1.z == _arg_2.z)))){
                return (true);
            };
            return (false);
        }

        public function get x():Number
        {
            return (this._x);
        }
        public function get y():Number
        {
            return (this._y);
        }
        public function get z():Number
        {
            return (this._z);
        }
        public function get length():Number
        {
            if (isNaN(this._length)){
                this._length = Math.sqrt((((this._x * this._x) + (this._y * this._y)) + (this._z * this._z)));
            };
            return (this._length);
        }
        public function set x(_arg_1:Number):void
        {
            this._x = _arg_1;
            this._length = NaN;
        }
        public function set y(_arg_1:Number):void
        {
            this._y = _arg_1;
            this._length = NaN;
        }
        public function set z(_arg_1:Number):void
        {
            this._z = _arg_1;
            this._length = NaN;
        }
        public function negate():void
        {
            this._x = -(this._x);
            this._y = -(this._y);
            this._z = -(this._z);
        }
        public function add(_arg_1:IVector3d):void
        {
            if (_arg_1 == null){
                return;
            };
            this._x = (this._x + _arg_1.x);
            this._y = (this._y + _arg_1.y);
            this._z = (this._z + _arg_1.z);
            this._length = NaN;
        }
        public function sub(_arg_1:IVector3d):void
        {
            if (_arg_1 == null){
                return;
            };
            this._x = (this._x - _arg_1.x);
            this._y = (this._y - _arg_1.y);
            this._z = (this._z - _arg_1.z);
            this._length = NaN;
        }
        public function mul(_arg_1:Number):void
        {
            this._x = (this._x * _arg_1);
            this._y = (this._y * _arg_1);
            this._z = (this._z * _arg_1);
            this._length = NaN;
        }
        public function div(_arg_1:Number):void
        {
            if (_arg_1 != 0){
                this._x = (this._x / _arg_1);
                this._y = (this._y / _arg_1);
                this._z = (this._z / _arg_1);
                this._length = NaN;
            };
        }
        public function assign(_arg_1:IVector3d):void
        {
            if (_arg_1 == null){
                return;
            };
            this._x = _arg_1.x;
            this._y = _arg_1.y;
            this._z = _arg_1.z;
            this._length = NaN;
        }
        public function toString():String
        {
            return ((("(" + [this._x, this._y, this._z].join(",")) + ")"));
        }

    }
}//package com.sulake.room.utils

// dif = "_-wu" (String#24566, DoABC#2)
// crossProduct = "_-0hD" (String#15719, DoABC#2)
// isEqual = "_-2hG" (String#20740, DoABC#2)
// IVector3d = "_-hf" (String#8547, DoABC#2)
// Vector3d = "_-1Rb" (String#17568, DoABC#2)
// scalarProjection = "_-2p1" (String#21043, DoABC#2)
// div = "_-2-I" (String#18982, DoABC#2)
// _y = "_-02f" (String#64, DoABC#2)
// _z = "_-0kf" (String#215, DoABC#2)
// product = "_-Bd" (String#22675, DoABC#2)
// sub = "_-2e2" (String#20605, DoABC#2)
// mul = "_-tH" (String#24418, DoABC#2)
// negate = "_-Is" (String#22963, DoABC#2)


