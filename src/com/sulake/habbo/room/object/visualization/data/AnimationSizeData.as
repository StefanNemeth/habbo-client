
package com.sulake.habbo.room.object.visualization.data
{
    import com.sulake.core.utils.Map;
    import com.sulake.room.utils.XMLValidator;

    public class AnimationSizeData extends SizeData 
    {

        private var _animations:Map = null;
        private var _SafeStr_12582:Array;

        public function AnimationSizeData(_arg_1:int, _arg_2:int)
        {
            this._SafeStr_12582 = [];
            super(_arg_1, _arg_2);
            this._animations = new Map();
        }
        override public function dispose():void
        {
            var _local_1:int;
            var _local_2:AnimationData;
            super.dispose();
            if (this._animations != null){
                _local_1 = 0;
                while (_local_1 < this._animations.length) {
                    _local_2 = (this._animations.getWithIndex(_local_1) as AnimationData);
                    if (_local_2 != null){
                        _local_2.dispose();
                    };
                    _local_1++;
                };
                this._animations.dispose();
                this._animations = null;
            };
        }
        public function defineAnimations(_arg_1:XML):Boolean
        {
            var _local_5:XML;
            var _local_6:int;
            var _local_7:Boolean;
            var _local_8:String;
            var _local_9:AnimationData;
            var _local_10:int;
            var _local_11:int;
            var _local_12:Array;
            var _local_13:Array;
            var _local_14:String;
            var _local_15:int;
            if (_arg_1 == null){
                return (true);
            };
            var _local_2:Array = ["id"];
            var _local_3:XMLList = _arg_1.animation;
            var _local_4:int;
            while (_local_4 < _local_3.length()) {
                _local_5 = _local_3[_local_4];
                if (!XMLValidator.checkRequiredAttributes(_local_5, _local_2)){
                    return (false);
                };
                _local_6 = int(_local_5.@id);
                _local_7 = false;
                _local_8 = _local_5.@transitionTo;
                if (_local_8.length > 0){
                    _local_10 = int(_local_8);
                    _local_6 = AnimationData.getTransitionToAnimationId(_local_10);
                    _local_7 = true;
                };
                _local_8 = _local_5.@transitionFrom;
                if (_local_8.length > 0){
                    _local_11 = int(_local_8);
                    _local_6 = AnimationData._SafeStr_12507(_local_11);
                    _local_7 = true;
                };
                _local_9 = this.createAnimationData();
                if (!_local_9.initialize(_local_5)){
                    _local_9.dispose();
                    return (false);
                };
                _local_8 = _local_5.@immediateChangeFrom;
                if (_local_8.length > 0){
                    _local_12 = _local_8.split(",");
                    _local_13 = [];
                    for each (_local_14 in _local_12) {
                        _local_15 = int(_local_14);
                        if (_local_13.indexOf(_local_15) < 0){
                            _local_13.push(_local_15);
                        };
                    };
                    _local_9.setImmediateChanges(_local_13);
                };
                this._animations.add(_local_6, _local_9);
                if (!_local_7){
                    this._SafeStr_12582.push(_local_6);
                };
                _local_4++;
            };
            return (true);
        }
        protected function createAnimationData():AnimationData
        {
            return (new AnimationData());
        }
        public function hasAnimation(_arg_1:int):Boolean
        {
            if (this._animations.getValue(_arg_1) != null){
                return (true);
            };
            return (false);
        }
        public function getAnimationCount():int
        {
            return (this._SafeStr_12582.length);
        }
        public function getAnimationId(_arg_1:int):int
        {
            var _local_2:int = this.getAnimationCount();
            if ((((_arg_1 >= 0)) && ((_local_2 > 0)))){
                return (this._SafeStr_12582[(_arg_1 % _local_2)]);
            };
            return (0);
        }
        public function isImmediateChange(_arg_1:int, _arg_2:int):Boolean
        {
            var _local_3:AnimationData = (this._animations.getValue(_arg_1) as AnimationData);
            if (_local_3 != null){
                return (_local_3.isImmediateChange(_arg_2));
            };
            return (false);
        }
        public function getStartFrame(_arg_1:int, _arg_2:int):int
        {
            var _local_3:AnimationData = (this._animations.getValue(_arg_1) as AnimationData);
            if (_local_3 != null){
                return (_local_3.getStartFrame(_arg_2));
            };
            return (0);
        }
        public function getFrame(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):AnimationFrame
        {
            var _local_6:AnimationFrame;
            var _local_5:AnimationData = (this._animations.getValue(_arg_1) as AnimationData);
            if (_local_5 != null){
                return (_local_5.getFrame(_arg_2, _arg_3, _arg_4));
            };
            return (null);
        }
        public function getFrameFromSequence(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:int):AnimationFrame
        {
            var _local_8:AnimationFrame;
            var _local_7:AnimationData = (this._animations.getValue(_arg_1) as AnimationData);
            if (_local_7 != null){
                return (_local_7.getFrameFromSequence(_arg_2, _arg_3, _arg_4, _arg_5, _arg_6));
            };
            return (null);
        }

    }
}//package com.sulake.habbo.room.object.visualization.data

// getTransitionToAnimationId = "_-1pZ" (String#18529, DoABC#2)
// _SafeStr_12507 = "null" (String#706, DoABC#2)
// setImmediateChanges = "_-34u" (String#21692, DoABC#2)
// isImmediateChange = "_-1rn" (String#18623, DoABC#2)
// getStartFrame = "_-3L-" (String#22323, DoABC#2)
// getFrameFromSequence = "_-1rq" (String#18624, DoABC#2)
// _SafeStr_12582 = "_-2Q0" (String#20042, DoABC#2)
// defineAnimations = "_-SX" (String#23347, DoABC#2)
// createAnimationData = "_-0QQ" (String#15078, DoABC#2)
// hasAnimation = "_-3Au" (String#21915, DoABC#2)
// getAnimationCount = "_-2J6" (String#19771, DoABC#2)
// AnimationData = "_-vF" (String#948, DoABC#2)
// SizeData = "_-07b" (String#3713, DoABC#2)
// AnimationFrame = "_-to" (String#8764, DoABC#2)
// AnimationSizeData = "_-0PM" (String#4079, DoABC#2)
// getAnimationId = "_-1nQ" (String#1759, DoABC#2)
// getFrame = "_-3Jk" (String#923, DoABC#2)
// _animations = "_-3JT" (String#7694, DoABC#2)


