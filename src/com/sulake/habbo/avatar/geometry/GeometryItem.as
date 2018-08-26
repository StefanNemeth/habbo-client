
package com.sulake.habbo.avatar.geometry
{
    public class GeometryItem extends Node3D 
    {

        private var _id:String;
        private var _radius:Number;
        private var _normal:Vector3D;
        private var _isDoubleSided:Boolean = false;
        private var _isDynamic:Boolean = false;

        public function GeometryItem(_arg_1:XML, _arg_2:Boolean=false)
        {
            super(parseFloat(_arg_1.@x), parseFloat(_arg_1.@y), parseFloat(_arg_1.@z));
            this._id = String(_arg_1.@id);
            this._radius = parseFloat(_arg_1.@radius);
            this._normal = new Vector3D(parseFloat(_arg_1.@nx), parseFloat(_arg_1.@ny), parseFloat(_arg_1.@nz));
            this._isDoubleSided = (parseInt(_arg_1.@double) as Boolean);
            this._isDynamic = _arg_2;
        }
        public function getDistance(_arg_1:Vector3D):Number
        {
            var _local_2:Number = Math.abs(((_arg_1.z - this.transformedLocation.z) - this._radius));
            var _local_3:Number = Math.abs(((_arg_1.z - this.transformedLocation.z) + this._radius));
            return (Math.min(_local_2, _local_3));
        }
        public function get id():String
        {
            return (this._id);
        }
        public function get normal():Vector3D
        {
            return (this._normal);
        }
        public function get isDoubleSided():Boolean
        {
            return (this._isDoubleSided);
        }
        public function toString():String
        {
            return (((((this._id + ": ") + this.location) + " - ") + this.transformedLocation));
        }
        public function get isDynamic():Boolean
        {
            return (this._isDynamic);
        }

    }
}//package com.sulake.habbo.avatar.geometry

// Node3D = "_-013" (String#3583, DoABC#2)
// GeometryItem = "_-H0" (String#8018, DoABC#2)
// transformedLocation = "_-T" (String#23364, DoABC#2)
// _radius = "_-3Fr" (String#2031, DoABC#2)
// isDynamic = "_-Vf" (String#23479, DoABC#2)
// getDistance = "_-2xU" (String#21371, DoABC#2)
// _isDoubleSided = "_-He" (String#22918, DoABC#2)
// _isDynamic = "_-3C-" (String#21959, DoABC#2)
// isDoubleSided = "_-1Uj" (String#17693, DoABC#2)


