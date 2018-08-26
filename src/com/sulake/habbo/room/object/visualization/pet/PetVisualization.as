
package com.sulake.habbo.room.object.visualization.pet
{
    import com.sulake.room.object.visualization.RoomObjectSpriteVisualization;
    import com.sulake.habbo.avatar.IPetImageListener;
    import com.sulake.core.utils.Map;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.habbo.avatar.IAvatarImage;
    import flash.display.BitmapData;
    import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.room.object.IRoomObjectModel;
    import com.sulake.habbo.avatar.enum.AvatarAction;
    import com.sulake.habbo.avatar.enum.AvatarSetType;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.utils.IRoomGeometry;
    import com.sulake.room.object.visualization.IRoomObjectSprite;
    import com.sulake.habbo.avatar.animation.ISpriteDataContainer;
    import com.sulake.habbo.avatar.animation.IAnimationLayerData;
    import flash.display.BlendMode;

    public class PetVisualization extends RoomObjectSpriteVisualization implements IPetImageListener 
    {

        private static const _SafeStr_4415:int = 2;
        private static const _SafeStr_4416:Array = [0, 0, 0];

        private const _SafeStr_4417:int = 3;
        private const _SafeStr_4418:int = 0;
        private const _SafeStr_4419:int = 1;
        private const _SafeStr_4420:int = 2;
        private const _SafeStr_4421:int = 3;

        private var _SafeStr_4422:PetVisualizationData = null;
        private var _SafeStr_4423:Map;
        private var _SafeStr_4424:int = 0;
        private var _SafeStr_4425:int = 0;
        private var _SafeStr_4426:Boolean;
        private var _figure:String;
        private var _SafeStr_4427:int = 0;
        private var _updateTimes:Array;
        private var _SafeStr_4428:BitmapDataAsset;
        private var _SafeStr_4350:ExperienceData;
        private var _disposed:Boolean = false;
        private var _SafeStr_4430:Boolean = false;
        private var _geometryUpdateId:int = -1;
        private var _SafeStr_4432:IAvatarImage = null;
        private var _SafeStr_4346:String = "";
        private var _SafeStr_4433:String = "";
        private var _isSleeping:Boolean = false;
        private var _SafeStr_4434:Boolean = false;
        private var _SafeStr_4435:Boolean = false;
        private var _SafeStr_4436:Boolean = false;
        private var _SafeStr_4437:Boolean = false;
        private var _gesture:String = "";
        private var _SafeStr_4351:int = 0;
        private var _experience:int = 0;
        private var _SafeStr_4438:Number = NaN;
        private var _SafeStr_4439:int = -1;
        private var _SafeStr_4440:int = -1;

        public function PetVisualization()
        {
            this._updateTimes = new Array();
            this._SafeStr_4423 = new Map();
            this._SafeStr_4426 = false;
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        override public function dispose():void
        {
            var _local_1:Array;
            var _local_2:String;
            var _local_3:IAvatarImage;
            super.dispose();
            if (this._SafeStr_4423 != null){
                _local_1 = this._SafeStr_4423.getKeys();
                for each (_local_2 in _local_1) {
                    _local_3 = (this._SafeStr_4423.getValue(_local_2) as IAvatarImage);
                    _local_3.dispose();
                };
            };
            this._SafeStr_4423.dispose();
            if (this._SafeStr_4350){
                this._SafeStr_4350.dispose();
            };
            this._SafeStr_4350 = null;
            this._SafeStr_4422 = null;
            this._disposed = true;
        }
        override public function initialize(_arg_1:IRoomObjectVisualizationData):Boolean
        {
            this._SafeStr_4422 = (_arg_1 as PetVisualizationData);
            createSprites(this._SafeStr_4421);
            var _local_2:BitmapData = ((this._SafeStr_4422.AvatarVisualizationData("pet_experience_bubble_png") as BitmapDataAsset).content as BitmapData);
            this._SafeStr_4350 = new ExperienceData(_local_2.clone());
            return (true);
        }
        private function updateModel(_arg_1:IRoomObjectModel, _arg_2:Number):Boolean
        {
            var _local_3:String;
            if (_arg_1.getUpdateID() != _SafeStr_4365){
                this._isSleeping = (_arg_1.getNumber(RoomObjectVariableEnum._SafeStr_4374) > 0);
                this._gesture = _arg_1.getString(RoomObjectVariableEnum._SafeStr_4367);
                this._SafeStr_4346 = _arg_1.getString(RoomObjectVariableEnum._SafeStr_4366);
                this._SafeStr_4433 = _arg_1.getString(RoomObjectVariableEnum._SafeStr_4442);
                this._SafeStr_4438 = _arg_1.getNumber(RoomObjectVariableEnum._SafeStr_4375);
                this._SafeStr_4351 = _arg_1.getNumber(RoomObjectVariableEnum.AVATAR_EXPERIENCE_TIMESTAMP);
                this._experience = _arg_1.getNumber(RoomObjectVariableEnum._SafeStr_4376);
                this.validateActions();
                _local_3 = _arg_1.getString(RoomObjectVariableEnum._SafeStr_4443);
                if (this._figure != _local_3){
                    this._figure = _local_3;
                    this.resetAvatarImages();
                };
                _SafeStr_4365 = _arg_1.getUpdateID();
                return (true);
            };
            return (false);
        }
        private function resetAvatarImages():void
        {
            var _local_1:IAvatarImage;
            for each (_local_1 in this._SafeStr_4423) {
                if (_local_1){
                    _local_1.dispose();
                };
            };
            this._SafeStr_4423.reset();
            this._SafeStr_4432 = null;
        }
        private function validateActions():void
        {
            var _local_1:int;
            this._SafeStr_4437 = false;
            switch (this._SafeStr_4346){
                case AvatarAction._SafeStr_4445:
                case AvatarAction._SafeStr_4446:
                case AvatarAction._SafeStr_4447:
                case AvatarAction._SafeStr_4448:
                case AvatarAction._SafeStr_4449:
                case AvatarAction._SafeStr_4450:
                case AvatarAction._SafeStr_4451:
                case AvatarAction._SafeStr_4452:
                case AvatarAction._SafeStr_4453:
                    this._SafeStr_4437 = true;
                    break;
            };
            this._SafeStr_4435 = false;
            this._SafeStr_4436 = false;
            if (this._SafeStr_4346 == "lay"){
                this._SafeStr_4436 = true;
                _local_1 = int(this._SafeStr_4433);
                if (_local_1 < 0){
                    this._SafeStr_4435 = true;
                };
            };
        }
        private function updateObject(_arg_1:IRoomObject, _arg_2:IRoomGeometry, _arg_3:Boolean=false):Boolean
        {
            var _local_4:int;
            var _local_5:int;
            if (((((_arg_3) || (!((_SafeStr_4455 == _arg_1.getUpdateID()))))) || (!((this._geometryUpdateId == _arg_2.updateId))))){
                _local_4 = (_arg_1.getDirection().x - _arg_2.direction.x);
                _local_4 = (((_local_4 % 360) + 360) % 360);
                _local_5 = this._SafeStr_4438;
                if (isNaN(this._SafeStr_4438)){
                    _local_5 = _local_4;
                }
                else {
                    _local_5 = (_local_5 - _arg_2.direction.x);
                    _local_5 = (((_local_5 % 360) + 360) % 360);
                };
                if (((!((_local_4 == this._SafeStr_4439))) || (_arg_3))){
                    this._SafeStr_4439 = _local_4;
                    _local_4 = (_local_4 - (135 - 22.5));
                    _local_4 = ((_local_4 + 360) % 360);
                    this._SafeStr_4432.setDirectionAngle(AvatarSetType._SafeStr_4457, _local_4);
                };
                if (((!((_local_5 == this._SafeStr_4440))) || (_arg_3))){
                    this._SafeStr_4440 = _local_5;
                    _local_5 = (_local_5 - (135 - 22.5));
                    _local_5 = ((_local_5 + 360) % 360);
                    this._SafeStr_4432.setDirectionAngle(AvatarSetType._SafeStr_4458, _local_5);
                };
                _SafeStr_4455 = _arg_1.getUpdateID();
                this._geometryUpdateId = _arg_2.updateId;
                return (true);
            };
            return (false);
        }
        private function getAvatarImage(_arg_1:Number):IAvatarImage
        {
            var _local_2:String = ("avatarImage" + _arg_1.toString());
            var _local_3:IAvatarImage = (this._SafeStr_4423.getValue(_local_2) as IAvatarImage);
            if (_local_3 == null){
                _local_3 = this._SafeStr_4422.AvatarVisualizationData(this._figure, _arg_1, this);
                if (_local_3 != null){
                    this._SafeStr_4423.add(_local_2, _local_3);
                };
            };
            return (_local_3);
        }
        private function updateShadow(_arg_1:Number):void
        {
            var _local_2:IRoomObjectSprite = getSprite(this._SafeStr_4419);
            this._SafeStr_4428 = null;
            _local_2 = getSprite(this._SafeStr_4419);
            var _local_3:int;
            var _local_4:int;
            if (_arg_1 < 48){
                this._SafeStr_4428 = this._SafeStr_4432.getAsset("sh_std_sd_1_0_0");
                _local_3 = -8;
                _local_4 = -3;
            }
            else {
                this._SafeStr_4428 = this._SafeStr_4432.getAsset("h_std_sd_1_0_0");
                _local_3 = -17;
                _local_4 = -7;
            };
            if (this._SafeStr_4428){
                _local_2.asset = (this._SafeStr_4428.content as BitmapData);
                _local_2.offsetX = _local_3;
                _local_2.offsetY = _local_4;
                _local_2.alpha = 50;
                _local_2.relativeDepth = 0.005;
            }
            else {
                _local_2.asset = null;
            };
        }
        override public function update(_arg_1:IRoomGeometry, _arg_2:int, _arg_3:Boolean, _arg_4:Boolean):void
        {
            var _local_13:int;
            var _local_14:IRoomObjectSprite;
            var _local_15:Array;
            var _local_16:int;
            var _local_17:int;
            var _local_18:ISpriteDataContainer;
            var _local_19:BitmapData;
            var _local_20:IAnimationLayerData;
            var _local_21:int;
            var _local_22:int;
            var _local_23:int;
            var _local_24:int;
            var _local_25:int;
            var _local_26:String;
            var _local_27:BitmapDataAsset;
            var _local_5:IRoomObject = object;
            if (_local_5 == null){
                return;
            };
            if (_arg_1 == null){
                return;
            };
            if (this._SafeStr_4422 == null){
                return;
            };
            var _local_6:IRoomObjectModel = _local_5.getModel();
            if (this._SafeStr_4430){
                this._SafeStr_4430 = false;
                this._SafeStr_4424 = 0;
                this._SafeStr_4427 = 1;
                this.resetAvatarImages();
            };
            var _local_7:Number = _arg_1.scale;
            var _local_8:Boolean;
            var _local_9:Boolean;
            var _local_10:Boolean = this.updateModel(_local_6, _local_7);
            if (((((_local_10) || (!((_local_7 == _SafeStr_4369))))) || ((this._SafeStr_4432 == null)))){
                if (_local_7 != _SafeStr_4369){
                    _SafeStr_4369 = _local_7;
                    _local_8 = true;
                };
                if (((_local_8) || ((this._SafeStr_4432 == null)))){
                    this._SafeStr_4432 = this.getAvatarImage(_local_7);
                };
                if (this._SafeStr_4432 == null){
                    return;
                };
                if (_local_8){
                    this.updateShadow(_local_7);
                };
                _local_9 = this.updateObject(_local_5, _arg_1, true);
                this.updateActions(this._SafeStr_4432);
            }
            else {
                _local_9 = this.updateObject(_local_5, _arg_1);
            };
            var _local_11:Boolean = ((((_local_9) || (_local_10))) || (_local_8));
            var _local_12:Boolean = ((((this._SafeStr_4426) || ((this._SafeStr_4427 > 0)))) || (this._SafeStr_4437));
            this._SafeStr_4350.alpha = 0;
            if (this._SafeStr_4351 > 0){
                _local_13 = (_arg_2 - this._SafeStr_4351);
                if (_local_13 < AvatarAction._SafeStr_4342){
                    this._SafeStr_4350.alpha = int((Math.sin(((_local_13 / AvatarAction._SafeStr_4342) * Math.PI)) * 0xFF));
                    this._SafeStr_4350.setExperience(this._experience);
                    this._SafeStr_4427 = this._SafeStr_4417;
                }
                else {
                    this._SafeStr_4351 = 0;
                };
                _local_14 = getSprite(this._SafeStr_4420);
                if (_local_14 != null){
                    if (this._SafeStr_4350.alpha > 0){
                        _local_14.asset = this._SafeStr_4350.image;
                        _local_14.offsetX = -20;
                        _local_14.offsetY = -80;
                        _local_14.alpha = this._SafeStr_4350.alpha;
                        _local_14.visible = true;
                    }
                    else {
                        _local_14.asset = null;
                        _local_14.visible = false;
                    };
                };
            };
            if (((_local_11) || (_local_12))){
                increaseUpdateId();
                this._SafeStr_4427--;
                this._SafeStr_4425++;
                this._SafeStr_4424--;
                if ((((this._SafeStr_4424 <= 0)) || (_local_8))){
                    this._SafeStr_4432.updateAnimationByFrames(1);
                    this._SafeStr_4424 = _SafeStr_4415;
                }
                else {
                    return;
                };
                this._SafeStr_4426 = this._SafeStr_4432.isAnimating();
                _local_15 = this._SafeStr_4432.getCanvasOffsets();
                if ((((_local_15 == null)) || ((_local_15.length < 3)))){
                    _local_15 = _SafeStr_4416;
                };
                _local_16 = 0;
                if (object.getLocation().z > 0){
                    _local_16 = Math.min((_local_7 / 2.75), 0);
                };
                _local_14 = getSprite(this._SafeStr_4418);
                if (_local_14){
                    _local_19 = this._SafeStr_4432.TwinkleImages(AvatarSetType._SafeStr_4457, false);
                    if (_local_19 != null){
                        _local_14.asset = _local_19;
                    };
                    if (_local_7 < 48){
                        _local_14.offsetX = ((-32 / 2) + _local_15[0]);
                        _local_14.offsetY = (((-(_local_14.asset.height) + (32 / 4)) + _local_15[1]) + _local_16);
                    }
                    else {
                        _local_14.offsetX = ((-64 / 2) + _local_15[0]);
                        _local_14.offsetY = (((-(_local_14.asset.height) + (64 / 4)) + _local_15[1]) + _local_16);
                    };
                };
                _local_17 = this._SafeStr_4421;
                for each (_local_18 in this._SafeStr_4432.getSprites()) {
                    _local_14 = getSprite(_local_17);
                    if (_local_14 != null){
                        _local_20 = this._SafeStr_4432.getLayerData(_local_18);
                        _local_21 = 0;
                        _local_22 = _local_18.ISpriteDataContainer(this._SafeStr_4432.getDirection());
                        _local_23 = _local_18.ISpriteDataContainer(this._SafeStr_4432.getDirection());
                        _local_24 = _local_18.ISpriteDataContainer(this._SafeStr_4432.getDirection());
                        _local_25 = 0;
                        if (_local_18.hasDirections){
                            _local_25 = this._SafeStr_4432.getDirection();
                        };
                        if (_local_20 != null){
                            _local_21 = _local_20.animationFrame;
                            _local_22 = (_local_22 + _local_20.dx);
                            _local_23 = (_local_23 + _local_20.dy);
                            _local_25 = (_local_25 + _local_20.directionOffset);
                        };
                        if (_local_7 < 48){
                            _local_22 = (_local_22 / 2);
                            _local_23 = (_local_23 / 2);
                        };
                        if (_local_25 < 0){
                            _local_25 = (_local_25 + 8);
                        };
                        if (_local_25 > 7){
                            _local_25 = (_local_25 - 8);
                        };
                        _local_26 = ((((((this._SafeStr_4432.getScale() + "_") + _local_18.member) + "_") + _local_25) + "_") + _local_21);
                        _local_27 = this._SafeStr_4432.getAsset(_local_26);
                        if (_local_27 != null){
                            _local_14.asset = (_local_27.content as BitmapData);
                            _local_14.offsetX = (((-1 * _local_27.offset.x) - (_local_7 / 2)) + _local_22);
                            _local_14.offsetY = ((-1 * _local_27.offset.y) + _local_23);
                            _local_14.relativeDepth = (-0.01 - ((0.1 * _local_17) * _local_24));
                            if (_local_18.ink == 33){
                                _local_14.blendMode = BlendMode.ADD;
                            }
                            else {
                                _local_14.blendMode = BlendMode.NORMAL;
                            };
                            _local_17++;
                        };
                    };
                };
            };
        }
        private function updateActions(_arg_1:IAvatarImage):void
        {
            if (_arg_1 == null){
                return;
            };
            _arg_1.IAvatarImage();
            _arg_1.IAvatarImage(AvatarAction._SafeStr_4478, this._SafeStr_4346, this._SafeStr_4433);
            if (((!((this._gesture == null))) && (!((this._gesture == ""))))){
                _arg_1.IAvatarImage(AvatarAction._SafeStr_4479, this._gesture);
            };
            if (((this._isSleeping) || (this._SafeStr_4434))){
                _arg_1.IAvatarImage(AvatarAction._SafeStr_4480);
            };
            _arg_1.IAvatarImage();
            var _local_2:int = (_arg_1.getSprites().length + this._SafeStr_4421);
            if (_local_2 != spriteCount){
                createSprites(_local_2);
            };
        }
        public function imageReady():void
        {
            this._SafeStr_4430 = true;
        }
        public function petImageReady(_arg_1:String):void
        {
            this.resetAvatarImages();
        }

    }
}//package com.sulake.habbo.room.object.visualization.pet

// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// RoomObjectVariableEnum = "_-1MH" (String#17370, DoABC#2)
// IRoomObjectVisualizationData = "_-26A" (String#6167, DoABC#2)
// IRoomObjectModel = "_-253" (String#6141, DoABC#2)
// PetVisualizationData = "_-l7" (String#8627, DoABC#2)
// RoomObjectSpriteVisualization = "_-01y" (String#3602, DoABC#2)
// PetVisualization = "_-0i2" (String#4467, DoABC#2)
// IRoomGeometry = "_-0z9" (String#4829, DoABC#2)
// IAnimationLayerData = "_-14E" (String#4961, DoABC#2)
// ISpriteDataContainer = "_-2J5" (String#6422, DoABC#2)
// IRoomObjectSprite = "_-0di" (String#4386, DoABC#2)
// ExperienceData = "_-2yt" (String#21423, DoABC#2)
// _figure = "_-20u" (String#75, DoABC#2)
// AvatarVisualizationData = "_-1el" (String#18089, DoABC#2)
// AvatarVisualizationData = "_-0Zg" (String#15430, DoABC#2)
// _SafeStr_4342 = "_-1gJ" (String#5669, DoABC#2)
// _SafeStr_4346 = "_-KR" (String#2089, DoABC#2)
// _gesture = "_-2tH" (String#452, DoABC#2)
// _isSleeping = "_-2EU" (String#882, DoABC#2)
// _SafeStr_4350 = "_-3IK" (String#7674, DoABC#2)
// _SafeStr_4351 = "_-1OS" (String#5322, DoABC#2)
// _experience = "_-0Rh" (String#434, DoABC#2)
// updateModel = "_-1CW" (String#441, DoABC#2)
// getUpdateID = "_-Ga" (String#932, DoABC#2)
// _SafeStr_4365 = "_-2rK" (String#21130, DoABC#2)
// _SafeStr_4366 = "_-2r-" (String#21121, DoABC#2)
// _SafeStr_4367 = "_-3At" (String#21914, DoABC#2)
// _SafeStr_4369 = "_-bP" (String#23689, DoABC#2)
// validateActions = "_-269" (String#1810, DoABC#2)
// _SafeStr_4374 = "_-GG" (String#22862, DoABC#2)
// _SafeStr_4375 = "_-0Jq" (String#14835, DoABC#2)
// _SafeStr_4376 = "_-0Bp" (String#14520, DoABC#2)
// setExperience = "_-lr" (String#24104, DoABC#2)
// getSprite = "_-sN" (String#2210, DoABC#2)
// spriteCount = "_-2A7" (String#6252, DoABC#2)
// _SafeStr_4415 = "_-1VA" (String#5458, DoABC#2)
// _SafeStr_4416 = "_-0qw" (String#4660, DoABC#2)
// _SafeStr_4417 = "_-SU" (String#23346, DoABC#2)
// _SafeStr_4418 = "_-2gg" (String#6883, DoABC#2)
// _SafeStr_4419 = "_-0-r" (String#3561, DoABC#2)
// _SafeStr_4420 = "_-38E" (String#7477, DoABC#2)
// _SafeStr_4421 = "_-C7" (String#7914, DoABC#2)
// _SafeStr_4422 = "_-2Y6" (String#6730, DoABC#2)
// _SafeStr_4423 = "_-01x" (String#3601, DoABC#2)
// _SafeStr_4424 = "_-03i" (String#3640, DoABC#2)
// _SafeStr_4425 = "_-vA" (String#643, DoABC#2)
// _SafeStr_4426 = "_-0wK" (String#594, DoABC#2)
// _SafeStr_4427 = "_-uP" (String#8770, DoABC#2)
// _SafeStr_4428 = "_-0XV" (String#4258, DoABC#2)
// _disposed = "_-6m" (String#31, DoABC#2)
// _SafeStr_4430 = "_-06J" (String#14299, DoABC#2)
// _geometryUpdateId = "_-2yN" (String#370, DoABC#2)
// _SafeStr_4432 = "_-0DF" (String#3814, DoABC#2)
// _SafeStr_4433 = "_-K6" (String#8085, DoABC#2)
// _SafeStr_4434 = "_-1Xu" (String#5517, DoABC#2)
// _SafeStr_4435 = "_-02N" (String#3614, DoABC#2)
// _SafeStr_4436 = "_-wP" (String#8808, DoABC#2)
// _SafeStr_4437 = "_-0IS" (String#14778, DoABC#2)
// _SafeStr_4438 = "_-2N-" (String#6500, DoABC#2)
// _SafeStr_4439 = "_-1Ve" (String#5467, DoABC#2)
// _SafeStr_4440 = "_-17Q" (String#5024, DoABC#2)
// createSprites = "_-1Im" (String#17226, DoABC#2)
// _SafeStr_4442 = "_-0Mv" (String#14951, DoABC#2)
// _SafeStr_4443 = "_-2Lr" (String#19878, DoABC#2)
// resetAvatarImages = "_-07F" (String#14335, DoABC#2)
// _SafeStr_4445 = "_-bp" (String#23706, DoABC#2)
// _SafeStr_4446 = "_-0id" (String#15777, DoABC#2)
// _SafeStr_4447 = "_-2et" (String#20640, DoABC#2)
// _SafeStr_4448 = "_-0XY" (String#15337, DoABC#2)
// _SafeStr_4449 = "_-1yw" (String#18923, DoABC#2)
// _SafeStr_4450 = "_-0kC" (String#15839, DoABC#2)
// _SafeStr_4451 = "_-2qq" (String#21115, DoABC#2)
// _SafeStr_4452 = "_-0HK" (String#14733, DoABC#2)
// _SafeStr_4453 = "_-aY" (String#23655, DoABC#2)
// updateId = "_-0TD" (String#1478, DoABC#2)
// _SafeStr_4455 = "_-0tm" (String#16194, DoABC#2)
// setDirectionAngle = "_-0-V" (String#3555, DoABC#2)
// _SafeStr_4457 = "_-2mY" (String#20943, DoABC#2)
// _SafeStr_4458 = "_-327" (String#21586, DoABC#2)
// getAvatarImage = "_-1KI" (String#5249, DoABC#2)
// updateShadow = "_-2iq" (String#6928, DoABC#2)
// updateActions = "_-2p4" (String#900, DoABC#2)
// increaseUpdateId = "_-vd" (String#24514, DoABC#2)
// updateAnimationByFrames = "_-05f" (String#3680, DoABC#2)
// isAnimating = "_-1hz" (String#5707, DoABC#2)
// getCanvasOffsets = "_-0gi" (String#4439, DoABC#2)
// TwinkleImages = "_-eg" (String#2150, DoABC#2)
// getSprites = "_-3Go" (String#7642, DoABC#2)
// getLayerData = "_-0Qg" (String#1470, DoABC#2)
// ISpriteDataContainer = "_-1Oo" (String#5331, DoABC#2)
// ISpriteDataContainer = "_-31k" (String#7340, DoABC#2)
// ISpriteDataContainer = "_-3HQ" (String#7657, DoABC#2)
// hasDirections = "_-1RM" (String#5383, DoABC#2)
// animationFrame = "_-gS" (String#8520, DoABC#2)
// directionOffset = "_-25H" (String#6148, DoABC#2)
// getScale = "_-1EW" (String#5151, DoABC#2)
// IAvatarImage = "_-2j7" (String#6936, DoABC#2)
// IAvatarImage = "_-1hS" (String#5696, DoABC#2)
// _SafeStr_4478 = "_-0c6" (String#15518, DoABC#2)
// _SafeStr_4479 = "_-Dm" (String#22761, DoABC#2)
// _SafeStr_4480 = "_-1Sn" (String#17614, DoABC#2)
// IAvatarImage = "_-1gH" (String#5667, DoABC#2)
// petImageReady = "_-WW" (String#8332, DoABC#2)


