
package com.sulake.habbo.room.object.visualization.data
{
    import com.sulake.core.utils.Map;
    import com.sulake.room.utils.XMLValidator;

    public class AnimationData 
    {

        public static const _SafeStr_12501:int = 0;
        private static const TRANSITION_TO_ANIMATION_OFFSET:int = 1000000;
        private static const TRANSITION_FROM_ANIMATION_OFFSET:int = 2000000;

        private var _SafeStr_12502:Map = null;
        private var _frameCount:int = -1;
        private var _SafeStr_12504:Boolean = false;
        private var _SafeStr_12505:Array = null;

        public function AnimationData()
        {
            this._SafeStr_12502 = new Map();
        }
        public static function getTransitionToAnimationId(_arg_1:int):int
        {
            return ((TRANSITION_TO_ANIMATION_OFFSET + _arg_1));
        }
        public static function _SafeStr_12507(_arg_1:int):int
        {
            return ((TRANSITION_FROM_ANIMATION_OFFSET + _arg_1));
        }
        public static function isTransitionToAnimation(_arg_1:int):Boolean
        {
            return ((((_arg_1 >= TRANSITION_TO_ANIMATION_OFFSET)) && ((_arg_1 < TRANSITION_FROM_ANIMATION_OFFSET))));
        }
        public static function isTransitionFromAnimation(_arg_1:int):Boolean
        {
            return ((_arg_1 >= TRANSITION_FROM_ANIMATION_OFFSET));
        }

        public function dispose():void
        {
            var _local_1:int;
            var _local_2:AnimationLayerData;
            if (this._SafeStr_12502 != null){
                _local_1 = 0;
                while (_local_1 < this._SafeStr_12502.length) {
                    _local_2 = (this._SafeStr_12502.getWithIndex(_local_1) as AnimationLayerData);
                    if (_local_2 != null){
                        _local_2.dispose();
                    };
                    _local_1++;
                };
                this._SafeStr_12502.dispose();
                this._SafeStr_12502 = null;
            };
            this._SafeStr_12505 = null;
        }
        public function setImmediateChanges(_arg_1:Array):void
        {
            this._SafeStr_12505 = _arg_1;
        }
        public function isImmediateChange(_arg_1:int):Boolean
        {
            if (((!((this._SafeStr_12505 == null))) && ((this._SafeStr_12505.indexOf(_arg_1) >= 0)))){
                return (true);
            };
            return (false);
        }
        public function getStartFrame(_arg_1:int):int
        {
            if (!this._SafeStr_12504){
                return (0);
            };
            return ((Math.random() * this._frameCount));
        }
        public function initialize(_arg_1:XML):Boolean
        {
            var _local_5:XML;
            var _local_6:int;
            var _local_7:int;
            var _local_8:int;
            var _local_9:Boolean;
            var _local_10:String;
            var _local_11:String;
            this._SafeStr_12504 = false;
            if (int(_arg_1.@randomStart) != 0){
                this._SafeStr_12504 = true;
            };
            var _local_2:Array = ["id"];
            var _local_3:XMLList = _arg_1.animationLayer;
            var _local_4:int;
            while (_local_4 < _local_3.length()) {
                _local_5 = _local_3[_local_4];
                if (!XMLValidator.checkRequiredAttributes(_local_5, _local_2)){
                    return (false);
                };
                _local_6 = int(_local_5.@id);
                _local_7 = 1;
                _local_8 = 1;
                _local_9 = false;
                _local_10 = _local_5.@loopCount;
                if (_local_10.length > 0){
                    _local_7 = int(_local_10);
                };
                _local_11 = _local_5.@frameRepeat;
                if (_local_11.length > 0){
                    _local_8 = int(_local_11);
                };
                _local_9 = !((int(_local_5.@random) == 0));
                if (!this.addLayer(_local_6, _local_7, _local_8, _local_9, _local_5)){
                    return (false);
                };
                _local_4++;
            };
            return (true);
        }
        private function addLayer(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:Boolean, _arg_5:XML):Boolean
        {
            var _local_11:XML;
            var _local_12:int;
            var _local_13:Boolean;
            var _local_14:String;
            var _local_15:AnimationFrameSequenceData;
            var _local_16:XMLList;
            var _local_17:int;
            var _local_18:XML;
            var _local_19:int;
            var _local_20:int;
            var _local_21:int;
            var _local_22:int;
            var _local_23:int;
            var _local_24:DirectionalOffsetData;
            var _local_6:AnimationLayerData = new AnimationLayerData(_arg_2, _arg_3, _arg_4);
            var _local_7:Array = ["id"];
            var _local_8:XMLList = _arg_5.frameSequence;
            var _local_9:int;
            while (_local_9 < _local_8.length()) {
                _local_11 = _local_8[_local_9];
                _local_12 = 1;
                _local_13 = false;
                _local_14 = _local_11.@loopCount;
                if (_local_14.length > 0){
                    _local_12 = int(_local_14);
                };
                if (int(_local_11.@random) != 0){
                    _local_13 = true;
                };
                _local_15 = _local_6.addFrameSequence(_local_12, _local_13);
                _local_16 = _local_11.frame;
                _local_17 = 0;
                while (_local_17 < _local_16.length()) {
                    _local_18 = _local_16[_local_17];
                    if (!XMLValidator.checkRequiredAttributes(_local_18, _local_7)){
                        _local_6.dispose();
                        return (false);
                    };
                    _local_19 = int(_local_18.@id);
                    _local_20 = int(_local_18.@x);
                    _local_21 = int(_local_18.@y);
                    _local_22 = int(_local_18.@randomX);
                    _local_23 = int(_local_18.@randomY);
                    _local_24 = this.readDirectionalOffsets(_local_18);
                    _local_15.addFrame(_local_19, _local_20, _local_21, _local_22, _local_23, _local_24);
                    _local_17++;
                };
                _local_15.initialize();
                _local_9++;
            };
            _local_6.calculateLength();
            this._SafeStr_12502.add(_arg_1, _local_6);
            var _local_10:int = _local_6.frameCount;
            if (_local_10 > this._frameCount){
                this._frameCount = _local_10;
            };
            return (true);
        }
        private function readDirectionalOffsets(_arg_1:XML):DirectionalOffsetData
        {
            var _local_4:Array;
            var _local_5:XML;
            var _local_6:XMLList;
            var _local_7:int;
            var _local_8:XML;
            var _local_9:int;
            var _local_10:int;
            var _local_11:int;
            var _local_2:DirectionalOffsetData;
            var _local_3:XMLList = _arg_1.offsets;
            if (_local_3.length() > 0){
                _local_4 = ["direction"];
                _local_5 = _local_3[0];
                _local_6 = _local_5.offset;
                _local_7 = 0;
                while (_local_7 < _local_6.length()) {
                    _local_8 = _local_6[_local_7];
                    if (XMLValidator.checkRequiredAttributes(_local_8, _local_4)){
                        _local_9 = int(_local_8.@direction);
                        _local_10 = int(_local_8.@x);
                        _local_11 = int(_local_8.@y);
                        if (_local_2 == null){
                            _local_2 = new DirectionalOffsetData();
                        };
                        _local_2.setOffset(_local_9, _local_10, _local_11);
                    };
                    _local_7++;
                };
            };
            return (_local_2);
        }
        public function getFrame(_arg_1:int, _arg_2:int, _arg_3:int):AnimationFrame
        {
            var _local_4:AnimationLayerData = (this._SafeStr_12502.getValue(_arg_2) as AnimationLayerData);
            if (_local_4 != null){
                return (_local_4.getFrame(_arg_1, _arg_3));
            };
            return (null);
        }
        public function getFrameFromSequence(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int):AnimationFrame
        {
            var _local_6:AnimationLayerData = (this._SafeStr_12502.getValue(_arg_2) as AnimationLayerData);
            if (_local_6 != null){
                return (_local_6.getFrameFromSequence(_arg_1, _arg_3, _arg_4, _arg_5));
            };
            return (null);
        }

    }
}//package com.sulake.habbo.room.object.visualization.data

// _SafeStr_12501 = "_-1Uz" (String#17704, DoABC#2)
// _SafeStr_12502 = "_-20V" (String#1798, DoABC#2)
// _frameCount = "_-LD" (String#8106, DoABC#2)
// _SafeStr_12504 = "_-1IV" (String#17213, DoABC#2)
// _SafeStr_12505 = "_-1Qx" (String#17546, DoABC#2)
// getTransitionToAnimationId = "_-1pZ" (String#18529, DoABC#2)
// _SafeStr_12507 = "null" (String#706, DoABC#2)
// setImmediateChanges = "_-34u" (String#21692, DoABC#2)
// isImmediateChange = "_-1rn" (String#18623, DoABC#2)
// getStartFrame = "_-3L-" (String#22323, DoABC#2)
// addLayer = "_-0In" (String#14792, DoABC#2)
// addFrameSequence = "_-XJ" (String#23535, DoABC#2)
// readDirectionalOffsets = "_-AX" (String#22636, DoABC#2)
// addFrame = "_-0Xl" (String#15346, DoABC#2)
// calculateLength = "_-2L8" (String#19853, DoABC#2)
// setOffset = "_-2O1" (String#19966, DoABC#2)
// getFrameFromSequence = "_-1rq" (String#18624, DoABC#2)
// AnimationData = "_-vF" (String#948, DoABC#2)
// AnimationLayerData = "_-3DH" (String#919, DoABC#2)
// AnimationFrame = "_-to" (String#8764, DoABC#2)
// DirectionalOffsetData = "_-0oK" (String#4599, DoABC#2)
// AnimationFrameSequenceData = "_-34t" (String#7406, DoABC#2)
// isTransitionToAnimation = "_-0bj" (String#15501, DoABC#2)
// isTransitionFromAnimation = "_-1Mz" (String#17399, DoABC#2)
// getFrame = "_-3Jk" (String#923, DoABC#2)
// frameCount = "_-0C7" (String#14533, DoABC#2)


