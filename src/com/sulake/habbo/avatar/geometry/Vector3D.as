
package com.sulake.habbo.avatar.geometry
{
    public class Vector3D 
    {

        private var _x:Number;
        private var _y:Number;
        private var _z:Number;

        public function Vector3D(_arg_1:Number=0, _arg_2:Number=0, _arg_3:Number=0)
        {
            this._x = _arg_1;
            this._y = _arg_2;
            this._z = _arg_3;
        }
        public static function dot(_arg_1:Vector3D, _arg_2:Vector3D):Number
        {
            return ((((_arg_1.x * _arg_2.x) + (_arg_1.y * _arg_2.y)) + (_arg_1.z * _arg_2.z)));
        }
        public static function cross(_arg_1:Vector3D, _arg_2:Vector3D):Vector3D
        {
            var _local_3:Vector3D = new (Vector3D)();
            _local_3.x = ((_arg_1.y * _arg_2.z) - (_arg_1.z * _arg_2.y));
            _local_3.y = ((_arg_1.z * _arg_2.x) - (_arg_1.x * _arg_2.z));
            _local_3.z = ((_arg_1.x * _arg_2.y) - (_arg_1.y * _arg_2.x));
            return (_local_3);
        }
        public static function subtract(_arg_1:Vector3D, _arg_2:Vector3D):Vector3D
        {
            return (new (Vector3D)((_arg_1.x - _arg_2.x), (_arg_1.y - _arg_2.y), (_arg_1.z - _arg_2.z)));
        }

        public function dot(_arg_1:Vector3D):Number
        {
            return ((((this._x * _arg_1.x) + (this._y * _arg_1.y)) + (this._z * _arg_1.z)));
        }
        public function cross(_arg_1:Vector3D):Vector3D
        {
            var _local_2:Vector3D = new Vector3D();
            _local_2.x = ((this._y * _arg_1.z) - (this._z * _arg_1.y));
            _local_2.y = ((this._z * _arg_1.x) - (this._x * _arg_1.z));
            _local_2.z = ((this._x * _arg_1.y) - (this._y * _arg_1.x));
            return (_local_2);
        }
        public function subtract(_arg_1:Vector3D):void
        {
            this._x = (this._x - _arg_1.x);
            this._y = (this._y - _arg_1.y);
            this._z = (this._z - _arg_1.z);
        }
        public function add(_arg_1:Vector3D):void
        {
            this._x = (this._x + _arg_1.x);
            this._y = (this._y + _arg_1.y);
            this._z = (this._z + _arg_1.z);
        }
        public function normalize():void
        {
            var _local_1:Number = (1 / this.length());
            this._x = (this._x * _local_1);
            this._y = (this._y * _local_1);
            this._z = (this._z * _local_1);
        }
        public function length():Number
        {
            return (Math.sqrt((((this._x * this._x) + (this._y * this._y)) + (this._z * this._z))));
        }
        public function toString():String
        {
            return ((((((("Vector3D: (" + this._x) + ",") + this._y) + ",") + this._z) + ")"));
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
        public function set x(_arg_1:Number):void
        {
            this._x = _arg_1;
        }
        public function set y(_arg_1:Number):void
        {
            this._y = _arg_1;
        }
        public function set z(_arg_1:Number):void
        {
            this._z = _arg_1;
        }

    }
}//package com.sulake.habbo.avatar.geometry

// _y = "_-02f" (String#64, DoABC#2)
// _z = "_-0kf" (String#215, DoABC#2)
// dot = "_-2xd" (String#21379, DoABC#2)
// cross = "_-0Gb" (String#14704, DoABC#2)


