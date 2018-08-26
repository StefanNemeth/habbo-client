
package com.sulake.habbo.avatar.geometry
{
    public class Node3D 
    {

        private var _location:Vector3D;
        private var _transformedLocation:Vector3D;
        private var _SafeStr_6973:Boolean = false;

        public function Node3D(_arg_1:Number, _arg_2:Number, _arg_3:Number)
        {
            this._transformedLocation = new Vector3D();
            super();
            this._location = new Vector3D(_arg_1, _arg_2, _arg_3);
            if (((((!((_arg_1 == 0))) || (!((_arg_2 == 0))))) || (!((_arg_3 == 0))))){
                this._SafeStr_6973 = true;
            };
        }
        public function get location():Vector3D
        {
            return (this._location);
        }
        public function get transformedLocation():Vector3D
        {
            return (this._transformedLocation);
        }
        public function applyTransform(_arg_1:Matrix4x4):void
        {
            if (this._SafeStr_6973){
                this._transformedLocation = _arg_1.vectorMultiplication(this._location);
            };
        }

    }
}//package com.sulake.habbo.avatar.geometry

// Node3D = "_-013" (String#3583, DoABC#2)
// _location = "_-245" (String#244, DoABC#2)
// _transformedLocation = "_-pX" (String#24254, DoABC#2)
// _SafeStr_6973 = "_-0Xy" (String#15353, DoABC#2)
// transformedLocation = "_-T" (String#23364, DoABC#2)
// applyTransform = "_-eu" (String#23840, DoABC#2)
// vectorMultiplication = "_-34X" (String#21679, DoABC#2)


