
package com.sulake.habbo.room.object.visualization.pet
{
    import com.sulake.habbo.room.object.visualization.furniture.AnimatedFurnitureVisualization;
    import com.sulake.habbo.room.object.visualization.data.AnimationStateData;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.display.BitmapData;
    import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
    import com.sulake.room.utils.IRoomGeometry;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.object.IRoomObjectModel;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.room.object.visualization.IRoomObjectSprite;
    import com.sulake.habbo.room.object.visualization.data.AnimationData;
    import com.sulake.habbo.room.object.visualization.data.AnimationFrame;
    import com.sulake.room.object.visualization.utils.IGraphicAsset;
    import com.sulake.habbo.room.object.visualization.data.LayerData;
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureVisualizationData;
    import com.sulake.habbo.room.object.visualization.data.DirectionData;

    public class AnimatedPetVisualization extends AnimatedFurnitureVisualization 
    {

        private static const _SafeStr_4340:String = "head";
        private static const _SafeStr_4341:int = 1;
        private static const _SafeStr_4342:int = 1000;
        private static const _SafeStr_4343:String = "pet_experience_bubble_png";
        private static const _SafeStr_4344:int = 0;
        private static const _SafeStr_4345:int = 1;
        private static const ANIMATION_INDEX_COUNT:int = 2;

        private var _SafeStr_4346:String = "";
        private var _gesture:String = "";
        private var _isSleeping:Boolean = false;
        private var _SafeStr_4349:int = 0;
        private var _SafeStr_4350:ExperienceData;
        private var _SafeStr_4351:int = 0;
        private var _experience:int = 0;
        private var _animationData:AnimatedPetVisualizationData = null;
        private var _SafeStr_4353:String = "";
        private var _SafeStr_4354:int = -1;
        private var _SafeStr_4355:Array;
        private var _animationOver:Boolean = false;
        private var _SafeStr_4357:Array;
        private var _SafeStr_4358:int = -1;

        public function AnimatedPetVisualization()
        {
            this._SafeStr_4355 = [];
            this._SafeStr_4357 = [];
            super();
            while (this._SafeStr_4355.length < ANIMATION_INDEX_COUNT) {
                this._SafeStr_4355.push(new AnimationStateData());
            };
        }
        override public function dispose():void
        {
            var _local_1:int;
            var _local_2:AnimationStateData;
            super.dispose();
            if (this._SafeStr_4355 != null){
                _local_1 = 0;
                while (_local_1 < this._SafeStr_4355.length) {
                    _local_2 = (this._SafeStr_4355[_local_1] as AnimationStateData);
                    if (_local_2 != null){
                        _local_2.dispose();
                    };
                    _local_1++;
                };
                this._SafeStr_4355 = null;
            };
            if (this._SafeStr_4350){
                this._SafeStr_4350.dispose();
                this._SafeStr_4350 = null;
            };
        }
        override protected function getAnimationId(_arg_1:AnimationStateData):int
        {
            return (_arg_1.animationId);
        }
        override public function initialize(_arg_1:IRoomObjectVisualizationData):Boolean
        {
            var _local_3:BitmapDataAsset;
            if (!(_arg_1 is AnimatedPetVisualizationData)){
                return (false);
            };
            this._animationData = (_arg_1 as AnimatedPetVisualizationData);
            var _local_2:BitmapData;
            if (this._animationData.commonAssets != null){
                _local_3 = (this._animationData.commonAssets.getAssetByName(_SafeStr_4343) as BitmapDataAsset);
                if (_local_3 != null){
                    _local_2 = (_local_3.content as BitmapData).clone();
                    this._SafeStr_4350 = new ExperienceData(_local_2);
                };
            };
            if (super.initialize(_arg_1)){
                return (true);
            };
            return (false);
        }
        override public function update(_arg_1:IRoomGeometry, _arg_2:int, _arg_3:Boolean, _arg_4:Boolean):void
        {
            super.update(_arg_1, _arg_2, _arg_3, _arg_4);
            this.updateExperienceBubble(_arg_2);
        }
        override protected function updateAnimation(_arg_1:Number):int
        {
            var _local_3:int;
            var _local_2:IRoomObject = object;
            if (_local_2 != null){
                _local_3 = _local_2.getDirection().x;
                if (_local_3 != this._SafeStr_4358){
                    this._SafeStr_4358 = _local_3;
                    this.resetAllAnimationFrames();
                };
            };
            return (super.updateAnimation(_arg_1));
        }
        override protected function updateModel(_arg_1:Number):Boolean
        {
            var _local_4:String;
            var _local_5:String;
            var _local_6:Number;
            var _local_7:Number;
            var _local_8:Number;
            var _local_9:int;
            var _local_10:int;
            var _local_11:int;
            var _local_2:IRoomObject = object;
            if (_local_2 == null){
                return (false);
            };
            var _local_3:IRoomObjectModel = _local_2.getModel();
            if (_local_3 == null){
                return (false);
            };
            if (_local_3.getUpdateID() != _SafeStr_4365){
                _local_4 = _local_3.getString(RoomObjectVariableEnum._SafeStr_4366);
                _local_5 = _local_3.getString(RoomObjectVariableEnum._SafeStr_4367);
                _local_6 = _local_3.getNumber(RoomObjectVariableEnum._SafeStr_4366);
                if (!isNaN(_local_6)){
                    _local_10 = this._animationData.getPostureCount(_SafeStr_4369);
                    if (_local_10 > 0){
                        _local_4 = this._animationData.getPostureForAnimation(_SafeStr_4369, (_local_6 % _local_10));
                        _local_5 = null;
                    };
                };
                _local_7 = _local_3.getNumber(RoomObjectVariableEnum._SafeStr_4367);
                if (!isNaN(_local_7)){
                    _local_11 = this._animationData.getGestureCount(_SafeStr_4369);
                    if (_local_11 > 0){
                        _local_5 = this._animationData.getGestureForAnimation(_SafeStr_4369, (_local_7 % _local_11));
                    };
                };
                this.validateActions(_local_4, _local_5);
                this._isSleeping = (_local_3.getNumber(RoomObjectVariableEnum._SafeStr_4374) > 0);
                _local_8 = _local_3.getNumber(RoomObjectVariableEnum._SafeStr_4375);
                if (!isNaN(_local_8)){
                    this._SafeStr_4349 = _local_8;
                }
                else {
                    this._SafeStr_4349 = direction;
                };
                this._SafeStr_4351 = _local_3.getNumber(RoomObjectVariableEnum.AVATAR_EXPERIENCE_TIMESTAMP);
                this._experience = _local_3.getNumber(RoomObjectVariableEnum._SafeStr_4376);
                _local_9 = _local_3.getNumber(RoomObjectVariableEnum._SafeStr_4377);
                if (_local_9 != this._SafeStr_4354){
                    this._SafeStr_4354 = _local_9;
                    this._SafeStr_4353 = this._SafeStr_4354.toString();
                };
                _SafeStr_4365 = _local_3.getUpdateID();
                return (true);
            };
            return (false);
        }
        private function updateExperienceBubble(_arg_1:int):void
        {
            var _local_2:int;
            var _local_3:IRoomObjectSprite;
            if (this._SafeStr_4350 != null){
                this._SafeStr_4350.alpha = 0;
                if (this._SafeStr_4351 > 0){
                    _local_2 = (_arg_1 - this._SafeStr_4351);
                    if (_local_2 < _SafeStr_4342){
                        this._SafeStr_4350.alpha = int((Math.sin(((_local_2 / _SafeStr_4342) * Math.PI)) * 0xFF));
                        this._SafeStr_4350.setExperience(this._experience);
                    }
                    else {
                        this._SafeStr_4351 = 0;
                    };
                    _local_3 = getSprite((spriteCount - 1));
                    if (_local_3 != null){
                        if (this._SafeStr_4350.alpha > 0){
                            _local_3.asset = this._SafeStr_4350.image;
                            _local_3.offsetX = -20;
                            _local_3.offsetY = -80;
                            _local_3.alpha = this._SafeStr_4350.alpha;
                            _local_3.visible = true;
                        }
                        else {
                            _local_3.asset = null;
                            _local_3.visible = false;
                        };
                    };
                };
            };
        }
        private function validateActions(_arg_1:String, _arg_2:String):void
        {
            var _local_3:int;
            if (_arg_1 != this._SafeStr_4346){
                this._SafeStr_4346 = _arg_1;
                _local_3 = this._animationData.getAnimationForPosture(_SafeStr_4369, _arg_1);
                this.setAnimationForIndex(_SafeStr_4344, _local_3);
            };
            if (_arg_2 != this._gesture){
                this._gesture = _arg_2;
                _local_3 = this._animationData.getAnimationForGesture(_SafeStr_4369, _arg_2);
                this.setAnimationForIndex(_SafeStr_4345, _local_3);
            };
        }
        override protected function updateLayerCount(_arg_1:int):void
        {
            super.updateLayerCount(_arg_1);
            this._SafeStr_4357 = [];
        }
        override protected function getAdditionalSpriteCount():int
        {
            return ((super.getAdditionalSpriteCount() + _SafeStr_4341));
        }
        override protected function setAnimation(_arg_1:int):void
        {
        }
        private function getAnimationStateData(_arg_1:int):AnimationStateData
        {
            var _local_2:AnimationStateData;
            if ((((_arg_1 >= 0)) && ((_arg_1 < this._SafeStr_4355.length)))){
                return (this._SafeStr_4355[_arg_1]);
            };
            return (null);
        }
        private function setAnimationForIndex(_arg_1:int, _arg_2:int):void
        {
            var _local_3:AnimationStateData = this.getAnimationStateData(_arg_1);
            if (_local_3 != null){
                if (setSubAnimation(_local_3, _arg_2)){
                    this._animationOver = false;
                };
            };
        }
        override protected function resetAllAnimationFrames():void
        {
            var _local_2:AnimationStateData;
            this._animationOver = false;
            var _local_1:int = (this._SafeStr_4355.length - 1);
            while (_local_1 >= 0) {
                _local_2 = this._SafeStr_4355[_local_1];
                if (_local_2 != null){
                    _local_2.setLayerCount(layerCount);
                };
                _local_1--;
            };
        }
        override protected function updateAnimations(_arg_1:Number):int
        {
            var _local_5:AnimationStateData;
            var _local_6:int;
            if (this._animationOver){
                return (0);
            };
            var _local_2:Boolean = true;
            var _local_3:int;
            var _local_4:int;
            while (_local_4 < this._SafeStr_4355.length) {
                _local_5 = this._SafeStr_4355[_local_4];
                if (_local_5 != null){
                    if (!_local_5.animationOver){
                        _local_6 = updateFramesForAnimation(_local_5, _arg_1);
                        _local_3 = (_local_3 | _local_6);
                        if (!_local_5.animationOver){
                            _local_2 = false;
                        }
                        else {
                            if (((AnimationData.isTransitionFromAnimation(_local_5.animationId)) || (AnimationData.isTransitionToAnimation(_local_5.animationId)))){
                                this.setAnimationForIndex(_local_4, _local_5.animationAfterTransitionId);
                                _local_2 = false;
                            };
                        };
                    };
                };
                _local_4++;
            };
            this._animationOver = _local_2;
            return (_local_3);
        }
        override protected function getFrameNumber(_arg_1:int, _arg_2:int):int
        {
            var _local_4:AnimationStateData;
            var _local_5:AnimationFrame;
            var _local_3:int = (this._SafeStr_4355.length - 1);
            while (_local_3 >= 0) {
                _local_4 = this._SafeStr_4355[_local_3];
                if (_local_4 != null){
                    _local_5 = _local_4.getFrame(_arg_2);
                    if (_local_5 != null){
                        return (_local_5.id);
                    };
                };
                _local_3--;
            };
            return (super.getFrameNumber(_arg_1, _arg_2));
        }
        override protected function getSpriteXOffset(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            var _local_6:AnimationStateData;
            var _local_7:AnimationFrame;
            var _local_4:int = super.getSpriteXOffset(_arg_1, _arg_2, _arg_3);
            var _local_5:int = (this._SafeStr_4355.length - 1);
            while (_local_5 >= 0) {
                _local_6 = this._SafeStr_4355[_local_5];
                if (_local_6 != null){
                    _local_7 = _local_6.getFrame(_arg_3);
                    if (_local_7 != null){
                        _local_4 = (_local_4 + _local_7.x);
                    };
                };
                _local_5--;
            };
            return (_local_4);
        }
        override protected function getSpriteYOffset(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            var _local_6:AnimationStateData;
            var _local_7:AnimationFrame;
            var _local_4:int = super.getSpriteYOffset(_arg_1, _arg_2, _arg_3);
            var _local_5:int = (this._SafeStr_4355.length - 1);
            while (_local_5 >= 0) {
                _local_6 = this._SafeStr_4355[_local_5];
                if (_local_6 != null){
                    _local_7 = _local_6.getFrame(_arg_3);
                    if (_local_7 != null){
                        _local_4 = (_local_4 + _local_7.y);
                    };
                };
                _local_5--;
            };
            return (_local_4);
        }
        override protected function getAsset(_arg_1:String):IGraphicAsset
        {
            var _local_2:IGraphicAsset;
            if (assetCollection != null){
                return (assetCollection.getAssetWithPalette(_arg_1, this._SafeStr_4353));
            };
            return (null);
        }
        override protected function getSpriteZOffset(_arg_1:int, _arg_2:int, _arg_3:int):Number
        {
            if (this._animationData == null){
                return (LayerData._SafeStr_4401);
            };
            return (this._animationData.getZOffset(_arg_1, this.getDirection(_arg_1, _arg_3), _arg_3));
        }
        override protected function getSpriteAssetName(_arg_1:int, _arg_2:int):String
        {
            var _local_4:int;
            var _local_5:String;
            var _local_3:int = spriteCount;
            if (_arg_2 < (_local_3 - _SafeStr_4341)){
                _local_4 = getSize(_arg_1);
                if (_arg_2 < (_local_3 - (1 + _SafeStr_4341))){
                    if (_arg_2 >= FurnitureVisualizationData._SafeStr_4405.length){
                        return (null);
                    };
                    _local_5 = FurnitureVisualizationData._SafeStr_4405[_arg_2];
                    if (_local_4 == 1){
                        return (((type + "_icon_") + _local_5));
                    };
                    return (((((((((type + "_") + _local_4) + "_") + _local_5) + "_") + this.getDirection(_arg_1, _arg_2)) + "_") + this.getFrameNumber(_local_4, _arg_2)));
                };
                return ((((((type + "_") + _local_4) + "_sd_") + this.getDirection(_arg_1, _arg_2)) + "_0"));
            };
            return (null);
        }
        private function getDirection(_arg_1:int, _arg_2:int):int
        {
            if (this.isHeadSprite(_arg_2)){
                return (this._animationData.getDirectionValue(_arg_1, this._SafeStr_4349));
            };
            return (direction);
        }
        private function isHeadSprite(_arg_1:int):Boolean
        {
            if (this._SafeStr_4357[_arg_1] == null){
                if (this._animationData.getTag(_SafeStr_4369, DirectionData.USE_DEFAULT_DIRECTION, _arg_1) == _SafeStr_4340){
                    this._SafeStr_4357[_arg_1] = true;
                }
                else {
                    this._SafeStr_4357[_arg_1] = false;
                };
            };
            return (this._SafeStr_4357[_arg_1]);
        }

    }
}//package com.sulake.habbo.room.object.visualization.pet

// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// RoomObjectVariableEnum = "_-1MH" (String#17370, DoABC#2)
// IRoomObjectVisualizationData = "_-26A" (String#6167, DoABC#2)
// IRoomObjectModel = "_-253" (String#6141, DoABC#2)
// FurnitureVisualizationData = "_-0d0" (String#4371, DoABC#2)
// AnimatedFurnitureVisualization = "_-0y2" (String#4811, DoABC#2)
// AnimatedPetVisualization = "_-4Y" (String#7757, DoABC#2)
// AnimatedPetVisualizationData = "_-1K9" (String#5246, DoABC#2)
// IRoomGeometry = "_-0z9" (String#4829, DoABC#2)
// AnimationData = "_-vF" (String#948, DoABC#2)
// IGraphicAsset = "_-1HF" (String#5195, DoABC#2)
// IRoomObjectSprite = "_-0di" (String#4386, DoABC#2)
// AnimationFrame = "_-to" (String#8764, DoABC#2)
// AnimationStateData = "_-0iP" (String#15768, DoABC#2)
// ExperienceData = "_-2yt" (String#21423, DoABC#2)
// _SafeStr_4340 = "_-jD" (String#24008, DoABC#2)
// _SafeStr_4341 = "_-F-" (String#22813, DoABC#2)
// _SafeStr_4342 = "_-1gJ" (String#5669, DoABC#2)
// _SafeStr_4343 = "_-2yI" (String#21405, DoABC#2)
// _SafeStr_4344 = "_-2fg" (String#20679, DoABC#2)
// _SafeStr_4345 = "_-Ia" (String#22951, DoABC#2)
// _SafeStr_4346 = "_-KR" (String#2089, DoABC#2)
// _gesture = "_-2tH" (String#452, DoABC#2)
// _isSleeping = "_-2EU" (String#882, DoABC#2)
// _SafeStr_4349 = "_-Ra" (String#8239, DoABC#2)
// _SafeStr_4350 = "_-3IK" (String#7674, DoABC#2)
// _SafeStr_4351 = "_-1OS" (String#5322, DoABC#2)
// _experience = "_-0Rh" (String#434, DoABC#2)
// _SafeStr_4353 = "_-1Fu" (String#17111, DoABC#2)
// _SafeStr_4354 = "_-3-g" (String#21488, DoABC#2)
// _SafeStr_4355 = "_-1ok" (String#18487, DoABC#2)
// _animationOver = "_-0x7" (String#4793, DoABC#2)
// _SafeStr_4357 = "_-2bR" (String#20503, DoABC#2)
// _SafeStr_4358 = "_-2c7" (String#20528, DoABC#2)
// getAnimationId = "_-1nQ" (String#1759, DoABC#2)
// updateExperienceBubble = "_-00C" (String#14062, DoABC#2)
// updateAnimation = "_-XZ" (String#166, DoABC#2)
// resetAllAnimationFrames = "_-2Jx" (String#6439, DoABC#2)
// updateModel = "_-1CW" (String#441, DoABC#2)
// getUpdateID = "_-Ga" (String#932, DoABC#2)
// _SafeStr_4365 = "_-2rK" (String#21130, DoABC#2)
// _SafeStr_4366 = "_-2r-" (String#21121, DoABC#2)
// _SafeStr_4367 = "_-3At" (String#21914, DoABC#2)
// getPostureCount = "_-2h5" (String#20731, DoABC#2)
// _SafeStr_4369 = "_-bP" (String#23689, DoABC#2)
// getPostureForAnimation = "_-13g" (String#16605, DoABC#2)
// getGestureCount = "_-1PV" (String#17489, DoABC#2)
// getGestureForAnimation = "_-1sX" (String#18655, DoABC#2)
// validateActions = "_-269" (String#1810, DoABC#2)
// _SafeStr_4374 = "_-GG" (String#22862, DoABC#2)
// _SafeStr_4375 = "_-0Jq" (String#14835, DoABC#2)
// _SafeStr_4376 = "_-0Bp" (String#14520, DoABC#2)
// _SafeStr_4377 = "_-cz" (String#23755, DoABC#2)
// setExperience = "_-lr" (String#24104, DoABC#2)
// getSprite = "_-sN" (String#2210, DoABC#2)
// spriteCount = "_-2A7" (String#6252, DoABC#2)
// getAnimationForPosture = "_-1vg" (String#18783, DoABC#2)
// setAnimationForIndex = "_-1qg" (String#18571, DoABC#2)
// getAnimationForGesture = "_-R3" (String#23285, DoABC#2)
// updateLayerCount = "_-2P8" (String#6547, DoABC#2)
// getAdditionalSpriteCount = "_-XK" (String#8355, DoABC#2)
// setAnimation = "_-ON" (String#252, DoABC#2)
// getAnimationStateData = "_-2CM" (String#19498, DoABC#2)
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
// getSpriteZOffset = "_-25C" (String#614, DoABC#2)
// _SafeStr_4401 = "_-1Tp" (String#17658, DoABC#2)
// getZOffset = "_-1iZ" (String#18230, DoABC#2)
// getSpriteAssetName = "_-0c-" (String#590, DoABC#2)
// getSize = "_-1GK" (String#5174, DoABC#2)
// _SafeStr_4405 = "_-0gZ" (String#15695, DoABC#2)
// isHeadSprite = "_-UA" (String#23413, DoABC#2)
// getDirectionValue = "_-0Fe" (String#14670, DoABC#2)
// getTag = "_-01m" (String#14120, DoABC#2)


