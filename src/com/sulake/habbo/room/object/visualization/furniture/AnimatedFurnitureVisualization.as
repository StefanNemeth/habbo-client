
package com.sulake.habbo.room.object.visualization.furniture
{
    import com.sulake.habbo.room.object.visualization.data.AnimationStateData;
    import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.object.IRoomObjectModel;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.habbo.room.object.visualization.data.AnimationData;
    import com.sulake.habbo.room.object.visualization.data.AnimationFrame;

    public class AnimatedFurnitureVisualization extends FurnitureVisualization 
    {

        public static const _SafeStr_12638:int = 0;

        private var _animationData:AnimatedFurnitureVisualizationData = null;
        private var _state:int = -1;
        private var _SafeStr_12639:AnimationStateData;
        private var _SafeStr_12640:int = 0;
        private var _SafeStr_12641:Number = 0;
        private var _layerCount:int = 0;
        private var _SafeStr_12642:Boolean = false;

        public function AnimatedFurnitureVisualization()
        {
            this._SafeStr_12639 = new AnimationStateData();
        }
        protected function get layerCount():int
        {
            return (this._layerCount);
        }
        override protected function set direction(_arg_1:int):void
        {
            if (this.direction != _arg_1){
                super.direction = _arg_1;
                this._SafeStr_12642 = true;
            };
        }
        override public function dispose():void
        {
            super.dispose();
            this._animationData = null;
            if (this._SafeStr_12639 != null){
                this._SafeStr_12639.dispose();
                this._SafeStr_12639 = null;
            };
        }
        public function get animationId():int
        {
            return (this._SafeStr_12639.animationId);
        }
        protected function getAnimationId(_arg_1:AnimationStateData):int
        {
            var _local_2:int = this.animationId;
            if (((!((_local_2 == _SafeStr_12638))) && (this._animationData.hasAnimation(this._SafeStr_12641, _local_2)))){
                return (_local_2);
            };
            return (_SafeStr_12638);
        }
        override public function initialize(_arg_1:IRoomObjectVisualizationData):Boolean
        {
            if (!(_arg_1 is AnimatedFurnitureVisualizationData)){
                return (false);
            };
            this._animationData = (_arg_1 as AnimatedFurnitureVisualizationData);
            return (super.initialize(_arg_1));
        }
        override protected function updateObject(_arg_1:Number, _arg_2:Number):Boolean
        {
            var _local_3:IRoomObject;
            var _local_4:int;
            var _local_5:IRoomObjectModel;
            var _local_6:int;
            if (super.updateObject(_arg_1, _arg_2)){
                _local_3 = object;
                if (_local_3 == null){
                    return (false);
                };
                _local_4 = _local_3.getState(0);
                if (_local_4 != this._state){
                    this.setAnimation(_local_4);
                    this._state = _local_4;
                    _local_5 = _local_3.getModel();
                    if (_local_5 != null){
                        _local_6 = _local_5.getNumber(RoomObjectVariableEnum._SafeStr_12451);
                        this._SafeStr_12640 = _local_6;
                    };
                };
                return (true);
            };
            return (false);
        }
        override protected function updateModel(_arg_1:Number):Boolean
        {
            var _local_2:IRoomObject;
            var _local_3:IRoomObjectModel;
            var _local_4:Number;
            var _local_5:int;
            var _local_6:int;
            if (super.updateModel(_arg_1)){
                _local_2 = object;
                if (_local_2 != null){
                    _local_3 = _local_2.getModel();
                    if (_local_3 != null){
                        if (this.usesAnimationResetting()){
                            _local_5 = _local_3.getNumber(RoomObjectVariableEnum._SafeStr_12451);
                            if (_local_5 > this._SafeStr_12640){
                                this._SafeStr_12640 = _local_5;
                                this.setAnimation(this._state);
                            };
                        };
                        _local_4 = _local_3.getNumber(RoomObjectVariableEnum._SafeStr_12644);
                        if (!isNaN(_local_4)){
                            _local_6 = this._animationData.getAnimationId(this._SafeStr_12641, _local_4);
                            this.setAnimation(_local_6);
                        };
                    };
                };
                return (true);
            };
            return (false);
        }
        private function isPlayingTransition(_arg_1:AnimationStateData, _arg_2:int):Boolean
        {
            var _local_3:int = _arg_1.animationId;
            if (((AnimationData.isTransitionFromAnimation(_local_3)) || (AnimationData.isTransitionToAnimation(_local_3)))){
                if (_arg_2 == _arg_1.animationAfterTransitionId){
                    if (!_arg_1.animationOver){
                        return (true);
                    };
                };
            };
            return (false);
        }
        private function getCurrentState(_arg_1:AnimationStateData):int
        {
            var _local_2:int = _arg_1.animationId;
            if (((AnimationData.isTransitionFromAnimation(_local_2)) || (AnimationData.isTransitionToAnimation(_local_2)))){
                return (_arg_1.animationAfterTransitionId);
            };
            return (_local_2);
        }
        protected function setAnimation(_arg_1:int):void
        {
            if (this._animationData != null){
                this.setSubAnimation(this._SafeStr_12639, _arg_1, (this._state >= 0));
            };
        }
        protected function setSubAnimation(_arg_1:AnimationStateData, _arg_2:int, _arg_3:Boolean=true):Boolean
        {
            var _local_5:int;
            var _local_6:int;
            var _local_4:int = _arg_1.animationId;
            if (_arg_3){
                if (this.isPlayingTransition(_arg_1, _arg_2)){
                    return (false);
                };
                _local_5 = this.getCurrentState(_arg_1);
                if (_arg_2 != _local_5){
                    if (!this._animationData.isImmediateChange(this._SafeStr_12641, _arg_2, _local_5)){
                        _local_6 = AnimationData._SafeStr_12507(_local_5);
                        if (this._animationData.hasAnimation(this._SafeStr_12641, _local_6)){
                            _arg_1.animationAfterTransitionId = _arg_2;
                            _arg_2 = _local_6;
                        }
                        else {
                            _local_6 = AnimationData.getTransitionToAnimationId(_arg_2);
                            if (this._animationData.hasAnimation(this._SafeStr_12641, _local_6)){
                                _arg_1.animationAfterTransitionId = _arg_2;
                                _arg_2 = _local_6;
                            };
                        };
                    };
                }
                else {
                    if (AnimationData.isTransitionFromAnimation(_local_4)){
                        _local_6 = AnimationData.getTransitionToAnimationId(_arg_2);
                        if (this._animationData.hasAnimation(this._SafeStr_12641, _local_6)){
                            _arg_1.animationAfterTransitionId = _arg_2;
                            _arg_2 = _local_6;
                        };
                    }
                    else {
                        if (!AnimationData.isTransitionToAnimation(_local_4)){
                            if (this.usesAnimationResetting()){
                                _local_6 = AnimationData._SafeStr_12507(_local_5);
                                if (this._animationData.hasAnimation(this._SafeStr_12641, _local_6)){
                                    _arg_1.animationAfterTransitionId = _arg_2;
                                    _arg_2 = _local_6;
                                }
                                else {
                                    _local_6 = AnimationData.getTransitionToAnimationId(_arg_2);
                                    if (this._animationData.hasAnimation(this._SafeStr_12641, _local_6)){
                                        _arg_1.animationAfterTransitionId = _arg_2;
                                        _arg_2 = _local_6;
                                    };
                                };
                            };
                        };
                    };
                };
            };
            if (_local_4 != _arg_2){
                _arg_1.animationId = _arg_2;
                return (true);
            };
            return (false);
        }
        protected function getLastFramePlayed(_arg_1:int):Boolean
        {
            return (this._SafeStr_12639.getLastFramePlayed(_arg_1));
        }
        protected function resetAllAnimationFrames():void
        {
            if (this._SafeStr_12639 != null){
                this._SafeStr_12639.setLayerCount(this._layerCount);
            };
        }
        override protected function updateAnimation(_arg_1:Number):int
        {
            if (this._animationData == null){
                return (0);
            };
            if (_arg_1 != this._SafeStr_12641){
                this._SafeStr_12641 = _arg_1;
                this._layerCount = this._animationData.getLayerCount(_arg_1);
                this.resetAllAnimationFrames();
            };
            var _local_2:int = this.updateAnimations(_arg_1);
            this._SafeStr_12642 = false;
            return (_local_2);
        }
        protected function updateAnimations(_arg_1:Number):int
        {
            var _local_2:int;
            if (((!(this._SafeStr_12639.animationOver)) || (this._SafeStr_12642))){
                _local_2 = this.updateFramesForAnimation(this._SafeStr_12639, _arg_1);
                if (this._SafeStr_12639.animationOver){
                    if (((AnimationData.isTransitionFromAnimation(this._SafeStr_12639.animationId)) || (AnimationData.isTransitionToAnimation(this._SafeStr_12639.animationId)))){
                        this.setAnimation(this._SafeStr_12639.animationAfterTransitionId);
                        this._SafeStr_12639.animationOver = false;
                    };
                };
            };
            return (_local_2);
        }
        protected function updateFramesForAnimation(_arg_1:AnimationStateData, _arg_2:Number):int
        {
            var _local_9:Boolean;
            var _local_10:Boolean;
            var _local_11:AnimationFrame;
            var _local_12:int;
            if (((_arg_1.animationOver) && (!(this._SafeStr_12642)))){
                return (0);
            };
            var _local_3:int = _arg_1.frameCounter;
            var _local_4:int = this.getAnimationId(_arg_1);
            if (_local_3 == 0){
                _local_3 = this._animationData.getStartFrame(_arg_2, _local_4, direction);
            };
            var _local_5:int = 1;
            _local_3 = (_local_3 + _local_5);
            _arg_1.frameCounter = _local_3;
            var _local_6:int;
            _arg_1.animationOver = true;
            var _local_7 = (1 << (this._layerCount - 1));
            var _local_8:int = (this._layerCount - 1);
            while (_local_8 >= 0) {
                _local_9 = _arg_1.getAnimationPlayed(_local_8);
                if (((!(_local_9)) || (this._SafeStr_12642))){
                    _local_10 = _arg_1.getLastFramePlayed(_local_8);
                    _local_11 = _arg_1.getFrame(_local_8);
                    if (_local_11 != null){
                        if (((_local_11.isLastFrame) && ((_local_11.remainingFrameRepeats <= _local_5)))){
                            _local_10 = true;
                        };
                    };
                    if (((((this._SafeStr_12642) || ((_local_11 == null)))) || ((((_local_11.remainingFrameRepeats >= 0)) && (((_local_11.remainingFrameRepeats = (_local_11.remainingFrameRepeats - _local_5)) <= 0)))))){
                        _local_12 = AnimationFrame._SafeStr_12557;
                        if (_local_11 != null){
                            _local_12 = _local_11.activeSequence;
                        };
                        if (_local_12 == AnimationFrame._SafeStr_12557){
                            _local_11 = this._animationData.getFrame(_arg_2, _local_4, direction, _local_8, _local_3);
                        }
                        else {
                            _local_11 = this._animationData.getFrameFromSequence(_arg_2, _local_4, direction, _local_8, _local_12, (_local_11.activeSequenceOffset + _local_11.repeats), _local_3);
                        };
                        _arg_1.setFrame(_local_8, _local_11);
                        _local_6 = (_local_6 | _local_7);
                    };
                    if ((((_local_11 == null)) || ((_local_11.remainingFrameRepeats == AnimationFrame._SafeStr_12524)))){
                        _local_10 = true;
                        _local_9 = true;
                    }
                    else {
                        _arg_1.animationOver = false;
                    };
                    _arg_1.setLastFramePlayed(_local_8, _local_10);
                    _arg_1.setAnimationPlayed(_local_8, _local_9);
                };
                _local_7 = (_local_7 >> 1);
                _local_8--;
            };
            return (_local_6);
        }
        override protected function getFrameNumber(_arg_1:int, _arg_2:int):int
        {
            var _local_3:AnimationFrame = this._SafeStr_12639.getFrame(_arg_2);
            if (_local_3 != null){
                return (_local_3.id);
            };
            return (super.getFrameNumber(_arg_1, _arg_2));
        }
        override protected function getSpriteXOffset(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            var _local_4:int = super.getSpriteXOffset(_arg_1, _arg_2, _arg_3);
            var _local_5:AnimationFrame = this._SafeStr_12639.getFrame(_arg_3);
            if (_local_5 != null){
                _local_4 = (_local_4 + _local_5.x);
            };
            return (_local_4);
        }
        override protected function getSpriteYOffset(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            var _local_4:int = super.getSpriteYOffset(_arg_1, _arg_2, _arg_3);
            var _local_5:AnimationFrame = this._SafeStr_12639.getFrame(_arg_3);
            if (_local_5 != null){
                _local_4 = (_local_4 + _local_5.y);
            };
            return (_local_4);
        }
        protected function usesAnimationResetting():Boolean
        {
            return (false);
        }

    }
}//package com.sulake.habbo.room.object.visualization.furniture

// _SafeStr_12451 = "_-3Gs" (String#22157, DoABC#2)
// getTransitionToAnimationId = "_-1pZ" (String#18529, DoABC#2)
// _SafeStr_12507 = "null" (String#706, DoABC#2)
// isImmediateChange = "_-1rn" (String#18623, DoABC#2)
// getStartFrame = "_-3L-" (String#22323, DoABC#2)
// getFrameFromSequence = "_-1rq" (String#18624, DoABC#2)
// repeats = "_-0Lv" (String#14909, DoABC#2)
// _SafeStr_12524 = "_-35J" (String#21706, DoABC#2)
// _layerCount = "_-1NH" (String#850, DoABC#2)
// _SafeStr_12557 = "_-1Jn" (String#17267, DoABC#2)
// isLastFrame = "_-1oI" (String#18471, DoABC#2)
// remainingFrameRepeats = "_-3D8" (String#22000, DoABC#2)
// activeSequence = "_-1z1" (String#18929, DoABC#2)
// activeSequenceOffset = "_-2fA" (String#20653, DoABC#2)
// frameCounter = "_-0gP" (String#15689, DoABC#2)
// setFrame = "_-2nk" (String#20989, DoABC#2)
// getAnimationPlayed = "_-2hM" (String#20746, DoABC#2)
// setAnimationPlayed = "_-LJ" (String#23058, DoABC#2)
// getLastFramePlayed = "_-1ZL" (String#5550, DoABC#2)
// setLastFramePlayed = "_-bz" (String#23711, DoABC#2)
// hasAnimation = "_-3Au" (String#21915, DoABC#2)
// _SafeStr_12638 = "_-Pv" (String#23245, DoABC#2)
// _SafeStr_12639 = "_-1oj" (String#18486, DoABC#2)
// _SafeStr_12640 = "_-0fK" (String#15644, DoABC#2)
// _SafeStr_12641 = "_-0sF" (String#16133, DoABC#2)
// _SafeStr_12642 = "_-pw" (String#24270, DoABC#2)
// usesAnimationResetting = "_-1HJ" (String#1651, DoABC#2)
// _SafeStr_12644 = "_-Rd" (String#23309, DoABC#2)
// isPlayingTransition = "_-1HI" (String#17162, DoABC#2)
// getCurrentState = "_-1ef" (String#18085, DoABC#2)
// RoomObjectVariableEnum = "_-1MH" (String#17370, DoABC#2)
// IRoomObjectVisualizationData = "_-26A" (String#6167, DoABC#2)
// IRoomObjectModel = "_-253" (String#6141, DoABC#2)
// FurnitureVisualization = "_-1sy" (String#5900, DoABC#2)
// AnimatedFurnitureVisualization = "_-0y2" (String#4811, DoABC#2)
// AnimatedFurnitureVisualizationData = "_-nI" (String#8663, DoABC#2)
// AnimationData = "_-vF" (String#948, DoABC#2)
// AnimationFrame = "_-to" (String#8764, DoABC#2)
// AnimationStateData = "_-0iP" (String#15768, DoABC#2)
// getLayerCount = "_-0wW" (String#16290, DoABC#2)
// getAnimationId = "_-1nQ" (String#1759, DoABC#2)
// updateAnimation = "_-XZ" (String#166, DoABC#2)
// resetAllAnimationFrames = "_-2Jx" (String#6439, DoABC#2)
// updateModel = "_-1CW" (String#441, DoABC#2)
// setAnimation = "_-ON" (String#252, DoABC#2)
// setSubAnimation = "_-GK" (String#22866, DoABC#2)
// setLayerCount = "_-Io" (String#22960, DoABC#2)
// updateAnimations = "_-Pu" (String#8198, DoABC#2)
// animationOver = "_-2-o" (String#19005, DoABC#2)
// updateFramesForAnimation = "_-1jU" (String#18265, DoABC#2)
// isTransitionToAnimation = "_-0bj" (String#15501, DoABC#2)
// isTransitionFromAnimation = "_-1Mz" (String#17399, DoABC#2)
// animationAfterTransitionId = "_-0jC" (String#15800, DoABC#2)
// getFrameNumber = "_-0XM" (String#436, DoABC#2)
// getFrame = "_-3Jk" (String#923, DoABC#2)
// getSpriteXOffset = "_-03Y" (String#354, DoABC#2)
// getSpriteYOffset = "_-3IZ" (String#251, DoABC#2)


