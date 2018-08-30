
package com.sulake.habbo.room.object.visualization.pet
{
    import com.sulake.habbo.room.object.visualization.data.AnimationSizeData;
    import com.sulake.core.utils.Map;
    import com.sulake.room.utils.XMLValidator;
    import com.sulake.habbo.room.object.visualization.data.*;

    public class PetAnimationSizeData extends AnimationSizeData 
    {

        public static const _SafeStr_4414:int = -1;

        private var _SafeStr_4487:Map;
        private var _SafeStr_4488:Map;
        private var _postureForAnimation:String;

        public function PetAnimationSizeData(_arg_1:int, _arg_2:int)
        {
            this._SafeStr_4487 = new Map();
            this._SafeStr_4488 = new Map();
            super(_arg_1, _arg_2);
        }
        public function definePostures(_arg_1:XML):Boolean
        {
            var _local_5:XML;
            var _local_6:String;
            var _local_7:int;
            if (_arg_1 == null){
                return (false);
            };
            if (XMLValidator.checkRequiredAttributes(_arg_1, ["defaultPosture"])){
                this._postureForAnimation = _arg_1.@defaultPosture;
            }
            else {
                this._postureForAnimation = null;
            };
            var _local_2:Array = ["id", "animationId"];
            var _local_3:XMLList = _arg_1.posture;
            var _local_4:int;
            while (_local_4 < _local_3.length()) {
                _local_5 = _local_3[_local_4];
                if (!XMLValidator.checkRequiredAttributes(_local_5, _local_2)){
                    return (false);
                };
                _local_6 = String(_local_5.@id);
                _local_7 = int(_local_5.@animationId);
                this._SafeStr_4487.add(_local_6, _local_7);
                if (this._postureForAnimation == null){
                    this._postureForAnimation = _local_6;
                };
                _local_4++;
            };
            if (this._SafeStr_4487.getValue(this._postureForAnimation) == null){
                return (false);
            };
            return (true);
        }
        public function defineGestures(_arg_1:XML):Boolean
        {
            var _local_5:XML;
            var _local_6:String;
            var _local_7:int;
            if (_arg_1 == null){
                return (true);
            };
            var _local_2:Array = ["id", "animationId"];
            var _local_3:XMLList = _arg_1.gesture;
            var _local_4:int;
            while (_local_4 < _local_3.length()) {
                _local_5 = _local_3[_local_4];
                if (!XMLValidator.checkRequiredAttributes(_local_5, _local_2)){
                    return (false);
                };
                _local_6 = String(_local_5.@id);
                _local_7 = int(_local_5.@animationId);
                this._SafeStr_4488.add(_local_6, _local_7);
                _local_4++;
            };
            return (true);
        }
        public function getAnimationForPosture(_arg_1:String):int
        {
            if (this._SafeStr_4487.getValue(_arg_1) == null){
                _arg_1 = this._postureForAnimation;
            };
            return (this._SafeStr_4487.getValue(_arg_1));
        }
        public function getAnimationForGesture(_arg_1:String):int
        {
            if (this._SafeStr_4488.getValue(_arg_1) == null){
                return (_SafeStr_4414);
            };
            return (this._SafeStr_4488.getValue(_arg_1));
        }
        public function getPostureForAnimation(_arg_1:int):String
        {
            if ((((_arg_1 >= 0)) && ((_arg_1 < this._SafeStr_4487.length)))){
                return (this._SafeStr_4487.getKey(_arg_1));
            };
            return (this._postureForAnimation);
        }
        public function getGestureForAnimation(_arg_1:int):String
        {
            if ((((_arg_1 >= 0)) && ((_arg_1 < this._SafeStr_4488.length)))){
                return (this._SafeStr_4488.getKey(_arg_1));
            };
            return (null);
        }
        public function getPostureCount():int
        {
            return (this._SafeStr_4487.length);
        }
        public function getGestureCount():int
        {
            return (this._SafeStr_4488.length);
        }

    }
}//package com.sulake.habbo.room.object.visualization.pet

// AnimationSizeData = "_-0PM" (String#4079, DoABC#2)
// PetAnimationSizeData = "_-0FZ" (String#3861, DoABC#2)
// getPostureCount = "_-2h5" (String#20731, DoABC#2)
// getPostureForAnimation = "_-13g" (String#16605, DoABC#2)
// getGestureCount = "_-1PV" (String#17489, DoABC#2)
// getGestureForAnimation = "_-1sX" (String#18655, DoABC#2)
// getAnimationForPosture = "_-1vg" (String#18783, DoABC#2)
// getAnimationForGesture = "_-R3" (String#23285, DoABC#2)
// definePostures = "_-35z" (String#21728, DoABC#2)
// defineGestures = "_-2hp" (String#20766, DoABC#2)
// _SafeStr_4414 = "_-0MY" (String#14934, DoABC#2)
// _SafeStr_4487 = "_-vV" (String#24508, DoABC#2)
// _SafeStr_4488 = "_-0AM" (String#14462, DoABC#2)
// _postureForAnimation = "_-1mk" (String#18411, DoABC#2)


