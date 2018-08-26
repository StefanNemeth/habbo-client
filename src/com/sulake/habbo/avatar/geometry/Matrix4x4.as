
package com.sulake.habbo.avatar.geometry
{
    public class Matrix4x4 
    {

        public static const _SafeStr_7016:Matrix4x4 = new (Matrix4x4)(1, 0, 0, 0, 1, 0, 0, 0, 1);
        private static const _SafeStr_7017:Number = 1E-18;

        private var _data:Array;

        public function Matrix4x4(_arg_1:Number=0, _arg_2:Number=0, _arg_3:Number=0, _arg_4:Number=0, _arg_5:Number=0, _arg_6:Number=0, _arg_7:Number=0, _arg_8:Number=0, _arg_9:Number=0)
        {
            this._data = [_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9];
        }
        public static function Matrix4x4(_arg_1:Number):Matrix4x4
        {
            var _local_2:Number = ((_arg_1 * Math.PI) / 180);
            var _local_3:Number = Math.cos(_local_2);
            var _local_4:Number = Math.sin(_local_2);
            return (new (Matrix4x4)(1, 0, 0, 0, _local_3, -(_local_4), 0, _local_4, _local_3));
        }
        public static function Matrix4x4(_arg_1:Number):Matrix4x4
        {
            var _local_2:Number = ((_arg_1 * Math.PI) / 180);
            var _local_3:Number = Math.cos(_local_2);
            var _local_4:Number = Math.sin(_local_2);
            return (new (Matrix4x4)(_local_3, 0, _local_4, 0, 1, 0, -(_local_4), 0, _local_3));
        }
        public static function Matrix4x4(_arg_1:Number):Matrix4x4
        {
            var _local_2:Number = ((_arg_1 * Math.PI) / 180);
            var _local_3:Number = Math.cos(_local_2);
            var _local_4:Number = Math.sin(_local_2);
            return (new (Matrix4x4)(_local_3, -(_local_4), 0, _local_4, _local_3, 0, 0, 0, 1));
        }

        public function identity():Matrix4x4
        {
            this._data = [1, 0, 0, 0, 1, 0, 0, 0, 1];
            return (this);
        }
        public function vectorMultiplication(_arg_1:Vector3D):Vector3D
        {
            var _local_2:Number = (((_arg_1.x * this._data[0]) + (_arg_1.y * this._data[3])) + (_arg_1.z * this._data[6]));
            var _local_3:Number = (((_arg_1.x * this._data[1]) + (_arg_1.y * this._data[4])) + (_arg_1.z * this._data[7]));
            var _local_4:Number = (((_arg_1.x * this._data[2]) + (_arg_1.y * this._data[5])) + (_arg_1.z * this._data[8]));
            return (new Vector3D(_local_2, _local_3, _local_4));
        }
        public function multiply(_arg_1:Matrix4x4):Matrix4x4
        {
            var _local_2:Number = (((this._data[0] * _arg_1.data[0]) + (this._data[1] * _arg_1.data[3])) + (this._data[2] * _arg_1.data[6]));
            var _local_3:Number = (((this._data[0] * _arg_1.data[1]) + (this._data[1] * _arg_1.data[4])) + (this._data[2] * _arg_1.data[7]));
            var _local_4:Number = (((this._data[0] * _arg_1.data[2]) + (this._data[1] * _arg_1.data[5])) + (this._data[2] * _arg_1.data[8]));
            var _local_5:Number = (((this._data[3] * _arg_1.data[0]) + (this._data[4] * _arg_1.data[3])) + (this._data[5] * _arg_1.data[6]));
            var _local_6:Number = (((this._data[3] * _arg_1.data[1]) + (this._data[4] * _arg_1.data[4])) + (this._data[5] * _arg_1.data[7]));
            var _local_7:Number = (((this._data[3] * _arg_1.data[2]) + (this._data[4] * _arg_1.data[5])) + (this._data[5] * _arg_1.data[8]));
            var _local_8:Number = (((this._data[6] * _arg_1.data[0]) + (this._data[7] * _arg_1.data[3])) + (this._data[8] * _arg_1.data[6]));
            var _local_9:Number = (((this._data[6] * _arg_1.data[1]) + (this._data[7] * _arg_1.data[4])) + (this._data[8] * _arg_1.data[7]));
            var _local_10:Number = (((this._data[6] * _arg_1.data[2]) + (this._data[7] * _arg_1.data[5])) + (this._data[8] * _arg_1.data[8]));
            return (new Matrix4x4(_local_2, _local_3, _local_4, _local_5, _local_6, _local_7, _local_8, _local_9, _local_10));
        }
        public function scalarMultiply(_arg_1:Number):void
        {
            var _local_2:int;
            while (_local_2 < this._data.length) {
                this._data[_local_2] = (this._data[_local_2] * _arg_1);
                _local_2++;
            };
        }
        public function rotateX(_arg_1:Number):Matrix4x4
        {
            var _local_2:Number = ((_arg_1 * Math.PI) / 180);
            var _local_3:Number = Math.cos(_local_2);
            var _local_4:Number = Math.sin(_local_2);
            var _local_5:Matrix4x4 = new Matrix4x4(1, 0, 0, 0, _local_3, -(_local_4), 0, _local_4, _local_3);
            return (_local_5.multiply(this));
        }
        public function rotateY(_arg_1:Number):Matrix4x4
        {
            var _local_2:Number = ((_arg_1 * Math.PI) / 180);
            var _local_3:Number = Math.cos(_local_2);
            var _local_4:Number = Math.sin(_local_2);
            var _local_5:Matrix4x4 = new Matrix4x4(_local_3, 0, _local_4, 0, 1, 0, -(_local_4), 0, _local_3);
            return (_local_5.multiply(this));
        }
        public function rotateZ(_arg_1:Number):Matrix4x4
        {
            var _local_2:Number = ((_arg_1 * Math.PI) / 180);
            var _local_3:Number = Math.cos(_local_2);
            var _local_4:Number = Math.sin(_local_2);
            var _local_5:Matrix4x4 = new Matrix4x4(_local_3, -(_local_4), 0, _local_4, _local_3, 0, 0, 0, 1);
            return (_local_5.multiply(this));
        }
        public function skew():void
        {
        }
        public function transpose():Matrix4x4
        {
            return (new Matrix4x4(this._data[0], this._data[3], this._data[6], this._data[1], this._data[4], this._data[7], this._data[2], this._data[5], this._data[8]));
        }
        public function equals(_arg_1:Matrix4x4):Boolean
        {
            return (false);
        }
        public function get data():Array
        {
            return (this._data);
        }

    }
}//package com.sulake.habbo.avatar.geometry

// multiply = "_-1H4" (String#17155, DoABC#2)
// vectorMultiplication = "_-34X" (String#21679, DoABC#2)
// Matrix4x4 = "_-249" (String#19182, DoABC#2)
// _SafeStr_7016 = "_-0Jd" (String#14827, DoABC#2)
// _SafeStr_7017 = "_-nG" (String#24163, DoABC#2)
// Matrix4x4 = "_-6B" (String#22473, DoABC#2)
// Matrix4x4 = "_-0wf" (String#16298, DoABC#2)
// scalarMultiply = "_-1pb" (String#18530, DoABC#2)
// rotateX = "_-0zP" (String#16404, DoABC#2)
// rotateY = "_-21T" (String#19072, DoABC#2)
// rotateZ = "_-0nx" (String#15975, DoABC#2)
// skew = "_-Fp" (String#22844, DoABC#2)
// transpose = "_-pl" (String#24263, DoABC#2)
// equals = "_-1fP" (String#18113, DoABC#2)


