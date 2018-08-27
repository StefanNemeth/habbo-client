
package com.sulake.habbo.avatar.geometry
{
    import flash.utils.Dictionary;

    public class GeometryBodyPart extends Node3D 
    {

        private var _id:String;
        private var _parts:Dictionary;
        private var _radius:Number;
        private var _SafeStr_6978:Boolean = false;

        public function GeometryBodyPart(_arg_1:XML)
        {
            var _local_2:XML;
            var _local_3:GeometryItem;
            super(parseFloat(_arg_1.@x), parseFloat(_arg_1.@y), parseFloat(_arg_1.@z));
            this._radius = parseFloat(_arg_1.@radius);
            this._id = String(_arg_1.@id);
            this._parts = new Dictionary();
            for each (_local_2 in _arg_1..item) {
                _local_3 = new GeometryItem(_local_2);
                this._parts[String(_local_2.@id)] = _local_3;
            };
        }
        public function getDynamicParts():Array
        {
            var _local_2:GeometryItem;
            var _local_1:Array = [];
            if (this._SafeStr_6978){
                for each (_local_2 in this._parts) {
                    if (_local_2 != null){
                        if (_local_2.isDynamic){
                            _local_1.push(_local_2);
                        };
                    };
                };
            };
            return (_local_1);
        }
        public function getPartIds():Array
        {
            var _local_2:GeometryItem;
            var _local_1:Array = [];
            for each (_local_2 in this._parts) {
                if (_local_2 != null){
                    _local_1.push(_local_2.id);
                };
            };
            return (_local_1);
        }
        public function removeDynamicParts():Boolean
        {
            var _local_1:GeometryItem;
            if (this._SafeStr_6978){
                this._SafeStr_6978 = false;
                for each (_local_1 in this._parts) {
                    if (_local_1 != null){
                        if (_local_1.isDynamic){
                            this._parts[_local_1.id] = null;
                            _local_1 = null;
                        };
                    };
                };
            };
            return (true);
        }
        public function addPart(_arg_1:XML):Boolean
        {
            var _local_3:GeometryItem;
            var _local_2:String = String(_arg_1.@id);
            if (!this.hasPart(_local_2)){
                _local_3 = new GeometryItem(_arg_1, true);
                this._parts[_local_2] = _local_3;
                this._SafeStr_6978 = true;
                return (true);
            };
            return (false);
        }
        public function hasPart(_arg_1:String):Boolean
        {
            var _local_2:GeometryItem = this._parts[_arg_1];
            return (!((_local_2 == null)));
        }
        public function getParts(_arg_1:Matrix4x4, _arg_2:Vector3D, _arg_3:Array):Array
        {
            var _local_4:GeometryItem;
            var _local_7:Array;
            var _local_8:Number;
            var _local_5:Array = new Array();
            var _local_6:Array = new Array();
            for each (_local_4 in this._parts) {
                if (_local_4 != null){
                    if (_arg_3.indexOf(_local_4.id) == -1){
                    };
                    _local_4.applyTransform(_arg_1);
                    _local_8 = _local_4.getDistance(_arg_2);
                    _local_5.push([_local_8, _local_4]);
                };
            };
            _local_5.sort(this.orderParts);
            for each (_local_7 in _local_5) {
                _local_4 = (_local_7[1] as GeometryItem);
                _local_6.push(_local_4.id);
            };
            return (_local_6);
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
        private function orderParts(_arg_1:Array, _arg_2:Array):Number
        {
            var _local_3:Number = (_arg_1[0] as Number);
            var _local_4:Number = (_arg_2[0] as Number);
            if (_local_3 < _local_4){
                return (-1);
            };
            if (_local_3 > _local_4){
                return (1);
            };
            return (0);
        }
        public function get radius():Number
        {
            return (this._radius);
        }

    }
}//package com.sulake.habbo.avatar.geometry

// Node3D = "_-013" (String#3583, DoABC#2)
// GeometryBodyPart = "_-0qP" (String#4646, DoABC#2)
// GeometryItem = "_-H0" (String#8018, DoABC#2)
// transformedLocation = "_-T" (String#23364, DoABC#2)
// applyTransform = "_-eu" (String#23840, DoABC#2)
// _radius = "_-3Fr" (String#2031, DoABC#2)
// _SafeStr_6978 = "_-0IU" (String#14779, DoABC#2)
// getDynamicParts = "_-39y" (String#21883, DoABC#2)
// isDynamic = "_-Vf" (String#23479, DoABC#2)
// getPartIds = "_-RQ" (String#23301, DoABC#2)
// removeDynamicParts = "_-Nk" (String#23155, DoABC#2)
// addPart = "_-0lC" (String#15873, DoABC#2)
// hasPart = "_-iD" (String#23972, DoABC#2)
// getParts = "_-3DP" (String#7583, DoABC#2)
// getDistance = "_-2xU" (String#21371, DoABC#2)
// orderParts = "_-0y6" (String#16356, DoABC#2)


