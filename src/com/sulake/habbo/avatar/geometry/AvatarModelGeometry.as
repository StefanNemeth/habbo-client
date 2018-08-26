
package com.sulake.habbo.avatar.geometry
{
    import flash.utils.Dictionary;
    import com.sulake.habbo.avatar.structure.AvatarCanvas;

    public class AvatarModelGeometry 
    {

        private var _SafeStr_6991:AvatarSet;
        private var _SafeStr_6992:Dictionary;
        private var _SafeStr_6993:Dictionary;
        private var _SafeStr_6994:Matrix4x4;
        private var _SafeStr_6995:Vector3D;
        private var _SafeStr_6996:Dictionary;

        public function AvatarModelGeometry(_arg_1:XML)
        {
            var _local_3:XML;
            var _local_4:XML;
            var _local_5:AvatarCanvas;
            var _local_6:XML;
            var _local_7:Dictionary;
            var _local_8:Dictionary;
            var _local_9:XML;
            var _local_10:GeometryBodyPart;
            var _local_11:Number;
            var _local_12:Number;
            var _local_13:Number;
            var _local_14:String;
            var _local_15:Dictionary;
            var _local_16:String;
            this._SafeStr_6995 = new Vector3D(0, 0, 10);
            super();
            this._SafeStr_6994 = new Matrix4x4();
            this._SafeStr_6992 = new Dictionary();
            this._SafeStr_6993 = new Dictionary();
            this._SafeStr_6991 = new AvatarSet(_arg_1.avatarset[0]);
            this._SafeStr_6996 = new Dictionary();
            var _local_2:XML = _arg_1.camera[0];
            if (_local_2 != null){
                _local_11 = parseFloat(_local_2.x.text());
                _local_12 = parseFloat(_local_2.y.text());
                _local_13 = parseFloat(_local_2.z.text());
                this._SafeStr_6995.x = _local_11;
                this._SafeStr_6995.y = _local_12;
                this._SafeStr_6995.z = _local_13;
            };
            for each (_local_3 in _arg_1.canvas) {
                _local_14 = String(_local_3.@scale);
                _local_15 = new Dictionary();
                for each (_local_4 in _local_3.geometry) {
                    _local_5 = new AvatarCanvas(_local_4);
                    _local_15[String(_local_4.@id)] = _local_5;
                };
                this._SafeStr_6996[_local_14] = _local_15;
            };
            for each (_local_6 in _arg_1.type) {
                _local_7 = new Dictionary();
                _local_8 = new Dictionary();
                for each (_local_9 in _local_6.bodypart) {
                    _local_10 = new GeometryBodyPart(_local_9);
                    _local_7[String(_local_9.@id)] = _local_10;
                    for each (_local_16 in _local_10.getPartIds()) {
                        _local_8[_local_16] = _local_10;
                    };
                };
                this._SafeStr_6992[String(_local_6.@id)] = _local_7;
                this._SafeStr_6993[String(_local_6.@id)] = _local_8;
            };
        }
        public function removeDynamicItems():void
        {
            var _local_1:Dictionary;
            var _local_2:GeometryBodyPart;
            for each (_local_1 in this._SafeStr_6992) {
                for each (_local_2 in _local_1) {
                    _local_2.removeDynamicParts();
                };
            };
        }
        public function getBodyPartIdsInAvatarSet(_arg_1:String):Array
        {
            var _local_2:Array = [];
            var _local_3:AvatarSet = this._SafeStr_6991.findAvatarSet(_arg_1);
            if (_local_3 != null){
                _local_2 = _local_3.getBodyParts();
            };
            return (_local_2);
        }
        public function isMainAvatarSet(_arg_1:String):Boolean
        {
            var _local_2:AvatarSet = this._SafeStr_6991.findAvatarSet(_arg_1);
            if (_local_2 != null){
                return (_local_2.isMain);
            };
            return (false);
        }
        public function getCanvas(_arg_1:String, _arg_2:String):AvatarCanvas
        {
            var _local_4:AvatarCanvas;
            var _local_3:Dictionary = this._SafeStr_6996[_arg_1];
            if (_local_3 != null){
                _local_4 = (_local_3[_arg_2] as AvatarCanvas);
            };
            return (_local_4);
        }
        private function typeExists(_arg_1:String):Boolean
        {
            return (!((this._SafeStr_6992[_arg_1] == null)));
        }
        private function hasBodyPart(_arg_1:String, _arg_2:String):Boolean
        {
            var _local_3:Dictionary;
            if (this.typeExists(_arg_1)){
                _local_3 = (this._SafeStr_6992[_arg_1] as Dictionary);
                return (!((_local_3[_arg_2] == null)));
            };
            return (false);
        }
        private function getBodyPartIDs(_arg_1:String):Array
        {
            var _local_4:String;
            var _local_2:Dictionary = this.getBodyPartsOfType(_arg_1);
            var _local_3:Array = new Array();
            for (_local_4 in this._SafeStr_6992) {
                _local_3.push(_local_4);
            };
            return (_local_3);
        }
        private function getBodyPartsOfType(_arg_1:String):Dictionary
        {
            if (this.typeExists(_arg_1)){
                return ((this._SafeStr_6992[_arg_1] as Dictionary));
            };
            return (new Dictionary());
        }
        public function getBodyPart(_arg_1:String, _arg_2:String):GeometryBodyPart
        {
            var _local_3:Dictionary = this.getBodyPartsOfType(_arg_1);
            return (_local_3[_arg_2]);
        }
        public function getBodyPartOfItem(_arg_1:String, _arg_2:String):GeometryBodyPart
        {
            var _local_4:GeometryBodyPart;
            var _local_5:Dictionary;
            var _local_3:Dictionary = this._SafeStr_6993[_arg_1];
            if (_local_3 != null){
                _local_4 = _local_3[_arg_2];
                if (_local_4 != null){
                    return (_local_4);
                };
                _local_5 = this.getBodyPartsOfType(_arg_1);
                for each (_local_4 in _local_5) {
                    if (_local_4.hasPart(_arg_2)){
                        return (_local_4);
                    };
                };
            };
            return (null);
        }
        private function getBodyPartsInAvatarSet(_arg_1:Dictionary, _arg_2:String):Array
        {
            var _local_5:GeometryBodyPart;
            var _local_6:String;
            var _local_3:Array = [];
            var _local_4:Array = this.getBodyPartIdsInAvatarSet(_arg_2);
            for each (_local_6 in _local_4) {
                _local_5 = _arg_1[_local_6];
                if (_local_5 != null){
                    _local_3.push(_local_5);
                };
            };
            return (_local_3);
        }
        public function getBodyPartsAtAngle(_arg_1:String, _arg_2:uint, _arg_3:String):Array
        {
            var _local_7:GeometryBodyPart;
            var _local_9:Number;
            var _local_10:Array;
            if (_arg_3 == null){
                Logger.log("[AvatarModelGeometry] ERROR: Geometry ID not found for action: ");
                return ([]);
            };
            var _local_4:Dictionary = this.getBodyPartsOfType(_arg_3);
            var _local_5:Array = this.getBodyPartsInAvatarSet(_local_4, _arg_1);
            var _local_6:Array = new Array();
            var _local_8:Array = new Array();
            this._SafeStr_6994 = Matrix4x4.Matrix4x4(_arg_2);
            for each (_local_7 in _local_5) {
                _local_7.applyTransform(this._SafeStr_6994);
                _local_9 = _local_7.getDistance(this._SafeStr_6995);
                _local_6.push([_local_9, _local_7]);
            };
            _local_6.sort(this.orderByDistance);
            for each (_local_10 in _local_6) {
                _local_7 = (_local_10[1] as GeometryBodyPart);
                _local_8.push(_local_7.id);
            };
            return (_local_8);
        }
        public function getParts(_arg_1:String, _arg_2:String, _arg_3:uint, _arg_4:Array):Array
        {
            var _local_5:GeometryBodyPart;
            if (this.hasBodyPart(_arg_1, _arg_2)){
                _local_5 = (this.getBodyPartsOfType(_arg_1)[_arg_2] as GeometryBodyPart);
                this._SafeStr_6994 = Matrix4x4.Matrix4x4(_arg_3);
                return (_local_5.getParts(this._SafeStr_6994, this._SafeStr_6995, _arg_4));
            };
            return ([]);
        }
        private function orderByDistance(_arg_1:Array, _arg_2:Array):Number
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

    }
}//package com.sulake.habbo.avatar.geometry

// AvatarCanvas = "_-1UP" (String#5441, DoABC#2)
// GeometryBodyPart = "_-0qP" (String#4646, DoABC#2)
// AvatarModelGeometry = "_-2q7" (String#7081, DoABC#2)
// AvatarSet = "_-2qw" (String#7095, DoABC#2)
// applyTransform = "_-eu" (String#23840, DoABC#2)
// getPartIds = "_-RQ" (String#23301, DoABC#2)
// removeDynamicParts = "_-Nk" (String#23155, DoABC#2)
// hasPart = "_-iD" (String#23972, DoABC#2)
// getParts = "_-3DP" (String#7583, DoABC#2)
// getDistance = "_-2xU" (String#21371, DoABC#2)
// _SafeStr_6991 = "_-2H0" (String#19685, DoABC#2)
// _SafeStr_6992 = "_-gV" (String#23912, DoABC#2)
// _SafeStr_6993 = "_-QX" (String#23269, DoABC#2)
// _SafeStr_6994 = "_-23g" (String#19162, DoABC#2)
// _SafeStr_6995 = "_-086" (String#14370, DoABC#2)
// _SafeStr_6996 = "_-1n9" (String#5800, DoABC#2)
// removeDynamicItems = "_-1W" (String#17742, DoABC#2)
// getBodyPartIdsInAvatarSet = "_-MG" (String#23095, DoABC#2)
// findAvatarSet = "_-Jm" (String#22997, DoABC#2)
// isMainAvatarSet = "_-n8" (String#24160, DoABC#2)
// isMain = "_-00N" (String#3570, DoABC#2)
// typeExists = "_-u0" (String#24450, DoABC#2)
// hasBodyPart = "_-07n" (String#14355, DoABC#2)
// getBodyPartIDs = "_-1a" (String#17891, DoABC#2)
// getBodyPartsOfType = "_-1aZ" (String#17917, DoABC#2)
// getBodyPart = "_-3Df" (String#22020, DoABC#2)
// getBodyPartOfItem = "_-0Ot" (String#15020, DoABC#2)
// getBodyPartsInAvatarSet = "_-3B-" (String#21921, DoABC#2)
// getBodyPartsAtAngle = "_-1fX" (String#18119, DoABC#2)
// Matrix4x4 = "_-249" (String#19182, DoABC#2)
// orderByDistance = "_-1uQ" (String#18733, DoABC#2)


