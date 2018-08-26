
package com.sulake.habbo.room.object.visualization.avatar
{
    import com.sulake.room.object.visualization.RoomObjectSpriteVisualization;
    import com.sulake.habbo.avatar.IAvatarImageListener;
    import com.sulake.core.utils.Map;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.habbo.avatar.IAvatarImage;
    import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.room.object.IRoomObjectModel;
    import com.sulake.room.object.visualization.IRoomObjectSprite;
    import com.sulake.habbo.avatar.enum.AvatarSetType;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.utils.IRoomGeometry;
    import flash.display.BitmapData;
    import com.sulake.habbo.avatar.animation.ISpriteDataContainer;
    import com.sulake.habbo.avatar.animation.IAnimationLayerData;
    import flash.display.BlendMode;
    import com.sulake.habbo.avatar.enum.AvatarAction;

    public class AvatarVisualization extends RoomObjectSpriteVisualization implements IAvatarImageListener 
    {

        private static const _SafeStr_6528:String = "avatar";
        private static const _SafeStr_6529:Number = -0.01;
        private static const _SafeStr_6530:Number = -0.409;
        private static const _SafeStr_4415:int = 2;
        private static const _SafeStr_4416:Array = [0, 0, 0];
        private static const _SafeStr_6531:int = 3;

        private const _SafeStr_4418:int = 0;
        private const _SafeStr_4419:int = 1;
        private const _SafeStr_4420:int = 2;
        private const _SafeStr_6532:int = 3;
        private const _SafeStr_4421:int = 4;

        private var _SafeStr_4422:AvatarVisualizationData = null;
        private var _SafeStr_4423:Map;
        private var _SafeStr_6533:Map;
        private var _SafeStr_4424:int = 0;
        private var _SafeStr_4426:Boolean;
        private var _figure:String;
        private var _gender:String;
        private var _SafeStr_4427:int = 0;
        private var _SafeStr_4428:BitmapDataAsset;
        private var _SafeStr_6534:BitmapDataAsset;
        private var _SafeStr_4438:int = -1;
        private var _SafeStr_4439:int = -1;
        private var _SafeStr_4440:int = -1;
        private var _geometryUpdateId:int = -1;
        private var _SafeStr_4346:String = "";
        private var _SafeStr_4433:String = "";
        private var _SafeStr_6535:Boolean = false;
        private var _isWaving:Boolean = false;
        private var _isSleeping:Boolean = false;
        private var _SafeStr_4434:Boolean = false;
        private var _isTyping:Boolean = false;
        private var _gesture:int = 0;
        private var _danceStyle:int = 0;
        private var _signType:int = 0;
        private var _effectType:int = 0;
        private var _SafeStr_6538:int = 0;
        private var _SafeStr_6539:int = 0;
        private var _SafeStr_6540:int = 0;
        private var _SafeStr_4436:Boolean = false;
        private var _SafeStr_4435:Boolean = false;
        private var _SafeStr_6541:int = 0;
        private var _SafeStr_6542:int = 0;
        private var _SafeStr_6543:Boolean = false;
        private var _SafeStr_6544:int = 0;
        private var _SafeStr_4432:IAvatarImage = null;
        private var _disposed:Boolean;

        public function AvatarVisualization()
        {
            this._SafeStr_4423 = new Map();
            this._SafeStr_6533 = new Map();
            this._SafeStr_4426 = false;
        }
        override public function dispose():void
        {
            if (this._SafeStr_4423 != null){
                this.resetImages();
                this._SafeStr_4423.dispose();
                this._SafeStr_6533.dispose();
                this._SafeStr_4423 = null;
            };
            this._SafeStr_4422 = null;
            this._SafeStr_4428 = null;
            this._SafeStr_6534 = null;
            super.dispose();
            this._disposed = true;
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        override public function initialize(_arg_1:IRoomObjectVisualizationData):Boolean
        {
            this._SafeStr_4422 = (_arg_1 as AvatarVisualizationData);
            createSprites(this._SafeStr_4421);
            return (true);
        }
        private function updateModel(_arg_1:IRoomObjectModel, _arg_2:Number, _arg_3:Boolean):Boolean
        {
            var _local_4:Boolean;
            var _local_5:Boolean;
            var _local_6:int;
            var _local_7:String;
            var _local_8:String;
            if (_arg_1.getUpdateID() != _SafeStr_4365){
                _local_4 = false;
                _local_5 = false;
                _local_6 = 0;
                _local_7 = "";
                _local_5 = (((_arg_1.getNumber(RoomObjectVariableEnum._SafeStr_6545) > 0)) && (_arg_3));
                if (_local_5 != this._SafeStr_6535){
                    this._SafeStr_6535 = _local_5;
                    _local_4 = true;
                };
                _local_5 = (_arg_1.getNumber(RoomObjectVariableEnum._SafeStr_6546) > 0);
                if (_local_5 != this._isWaving){
                    this._isWaving = _local_5;
                    _local_4 = true;
                };
                _local_5 = (_arg_1.getNumber(RoomObjectVariableEnum._SafeStr_4374) > 0);
                if (_local_5 != this._isSleeping){
                    this._isSleeping = _local_5;
                    _local_4 = true;
                };
                _local_5 = (((_arg_1.getNumber(RoomObjectVariableEnum._SafeStr_6547) > 0)) && (_arg_3));
                if (_local_5 != this._SafeStr_4434){
                    this._SafeStr_4434 = _local_5;
                    _local_4 = true;
                };
                _local_5 = (_arg_1.getNumber(RoomObjectVariableEnum._SafeStr_6548) > 0);
                if (_local_5 != this._isTyping){
                    this._isTyping = _local_5;
                    _local_4 = true;
                    this.updateTypingBubble(_arg_2);
                };
                _local_6 = _arg_1.getNumber(RoomObjectVariableEnum._SafeStr_4367);
                if (_local_6 != this._gesture){
                    this._gesture = _local_6;
                    _local_4 = true;
                };
                _local_7 = _arg_1.getString(RoomObjectVariableEnum._SafeStr_4366);
                if (_local_7 != this._SafeStr_4346){
                    this._SafeStr_4346 = _local_7;
                    _local_4 = true;
                };
                _local_7 = _arg_1.getString(RoomObjectVariableEnum._SafeStr_4442);
                if (_local_7 != this._SafeStr_4433){
                    this._SafeStr_4433 = _local_7;
                    _local_4 = true;
                };
                _local_6 = _arg_1.getNumber(RoomObjectVariableEnum._SafeStr_6550);
                if (_local_6 != this._danceStyle){
                    this._danceStyle = _local_6;
                    _local_4 = true;
                };
                _local_6 = _arg_1.getNumber(RoomObjectVariableEnum._SafeStr_6551);
                if (_local_6 != this._effectType){
                    this._effectType = _local_6;
                    _local_4 = true;
                };
                _local_6 = _arg_1.getNumber(RoomObjectVariableEnum._SafeStr_6552);
                if (_local_6 != this._SafeStr_6538){
                    this._SafeStr_6538 = _local_6;
                    _local_4 = true;
                };
                _local_6 = _arg_1.getNumber(RoomObjectVariableEnum._SafeStr_6553);
                if (_local_6 != this._SafeStr_6539){
                    this._SafeStr_6539 = _local_6;
                    _local_4 = true;
                };
                _local_6 = _arg_1.getNumber(RoomObjectVariableEnum._SafeStr_4375);
                if (_local_6 != this._SafeStr_4438){
                    this._SafeStr_4438 = _local_6;
                    _local_4 = true;
                };
                if ((((this._SafeStr_6538 > 0)) && ((_arg_1.getNumber(RoomObjectVariableEnum._SafeStr_6553) > 0)))){
                    if (this._SafeStr_6539 != this._SafeStr_6538){
                        this._SafeStr_6539 = this._SafeStr_6538;
                        _local_4 = true;
                    };
                }
                else {
                    if (this._SafeStr_6539 != 0){
                        this._SafeStr_6539 = 0;
                        _local_4 = true;
                    };
                };
                _local_6 = _arg_1.getNumber(RoomObjectVariableEnum._SafeStr_6554);
                if (_local_6 != this._SafeStr_6541){
                    this._SafeStr_6541 = _local_6;
                    _local_4 = true;
                    this.updateNumberBubble(_arg_2);
                };
                this.validateActions(_arg_2);
                _local_7 = _arg_1.getString(RoomObjectVariableEnum.AVATAR_GENDER);
                if (_local_7 != this._gender){
                    this._gender = _local_7;
                    _local_4 = true;
                };
                _local_8 = _arg_1.getString(RoomObjectVariableEnum._SafeStr_4443);
                if (this.updateFigure(_local_8)){
                    _local_4 = true;
                };
                _local_6 = _arg_1.getNumber(RoomObjectVariableEnum._SafeStr_6556);
                if (_local_6 != this._signType){
                    _local_4 = true;
                };
                _SafeStr_4365 = _arg_1.getUpdateID();
                return (_local_4);
            };
            return (false);
        }
        private function updateFigure(_arg_1:String):Boolean
        {
            if (this._figure != _arg_1){
                this._figure = _arg_1;
                this.resetImages();
                return (true);
            };
            return (false);
        }
        private function resetImages():void
        {
            var _local_1:IAvatarImage;
            var _local_2:IRoomObjectSprite;
            for each (_local_1 in this._SafeStr_4423) {
                if (_local_1){
                    _local_1.dispose();
                };
            };
            for each (_local_1 in this._SafeStr_6533) {
                if (_local_1){
                    _local_1.dispose();
                };
            };
            this._SafeStr_4423.reset();
            this._SafeStr_6533.reset();
            this._SafeStr_4432 = null;
            _local_2 = getSprite(this._SafeStr_4418);
            if (_local_2 != null){
                _local_2.asset = null;
                _local_2.alpha = 0xFF;
            };
        }
        private function validateActions(_arg_1:Number):void
        {
            var _local_2:int;
            if (_arg_1 < 48){
                this._SafeStr_4434 = false;
            };
            if ((((this._SafeStr_4346 == "sit")) || ((this._SafeStr_4346 == "lay")))){
                this._SafeStr_6540 = (_arg_1 / 2);
            }
            else {
                this._SafeStr_6540 = 0;
            };
            this._SafeStr_4435 = false;
            this._SafeStr_4436 = false;
            if (this._SafeStr_4346 == "lay"){
                this._SafeStr_4436 = true;
                _local_2 = int(this._SafeStr_4433);
                if (_local_2 < 0){
                    this._SafeStr_4435 = true;
                };
            };
        }
        private function getAvatarImage(_arg_1:Number, _arg_2:int):IAvatarImage
        {
            var _local_3:IAvatarImage;
            var _local_5:IAvatarImage;
            var _local_4:String = ("avatarImage" + _arg_1.toString());
            if (_arg_2 == 0){
                _local_3 = (this._SafeStr_4423.getValue(_local_4) as IAvatarImage);
            }
            else {
                _local_4 = (_local_4 + ("-" + _arg_2));
                _local_3 = (this._SafeStr_6533.getValue(_local_4) as IAvatarImage);
                if (_local_3){
                    _local_3.IAvatarImage();
                };
            };
            if (_local_3 == null){
                _local_3 = this._SafeStr_4422.AvatarVisualizationData(this._figure, _arg_1, this._gender, this);
                if (_local_3 != null){
                    if (_arg_2 == 0){
                        this._SafeStr_4423.add(_local_4, _local_3);
                    }
                    else {
                        if (this._SafeStr_6533.length >= _SafeStr_6531){
                            _local_5 = this._SafeStr_6533.remove(this._SafeStr_6533.getKey(0));
                            if (_local_5){
                                _local_5.dispose();
                            };
                        };
                        this._SafeStr_6533.add(_local_4, _local_3);
                    };
                };
            };
            return (_local_3);
        }
        private function updateObject(_arg_1:IRoomObject, _arg_2:IRoomGeometry, _arg_3:Boolean, _arg_4:Boolean=false):Boolean
        {
            var _local_5:Boolean;
            var _local_6:int;
            var _local_7:int;
            if (((((_arg_4) || (!((_SafeStr_4455 == _arg_1.getUpdateID()))))) || (!((this._geometryUpdateId == _arg_2.updateId))))){
                _local_5 = _arg_3;
                _local_6 = (_arg_1.getDirection().x - _arg_2.direction.x);
                _local_6 = (((_local_6 % 360) + 360) % 360);
                _local_7 = this._SafeStr_4438;
                if (this._SafeStr_4346 == "float"){
                    _local_7 = _local_6;
                }
                else {
                    _local_7 = (_local_7 - _arg_2.direction.x);
                };
                _local_7 = (((_local_7 % 360) + 360) % 360);
                if (((!((_local_6 == this._SafeStr_4439))) || (_arg_4))){
                    _local_5 = true;
                    this._SafeStr_4439 = _local_6;
                    _local_6 = (_local_6 - (135 - 22.5));
                    _local_6 = ((_local_6 + 360) % 360);
                    this._SafeStr_4432.setDirectionAngle(AvatarSetType._SafeStr_4457, _local_6);
                };
                if (((!((_local_7 == this._SafeStr_4440))) || (_arg_4))){
                    _local_5 = true;
                    this._SafeStr_4440 = _local_7;
                    if (this._SafeStr_4440 != this._SafeStr_4439){
                        _local_7 = (_local_7 - (135 - 22.5));
                        _local_7 = ((_local_7 + 360) % 360);
                        this._SafeStr_4432.setDirectionAngle(AvatarSetType._SafeStr_4458, _local_7);
                    };
                };
                _SafeStr_4455 = _arg_1.getUpdateID();
                this._geometryUpdateId = _arg_2.updateId;
                return (_local_5);
            };
            return (false);
        }
        private function updateShadow(_arg_1:Number):void
        {
            var _local_3:int;
            var _local_4:int;
            var _local_2:IRoomObjectSprite = getSprite(this._SafeStr_4419);
            this._SafeStr_4428 = null;
            if ((((this._SafeStr_4346 == "mv")) || ((this._SafeStr_4346 == "std")))){
                _local_2.visible = true;
                if ((((this._SafeStr_4428 == null)) || (!((_arg_1 == _SafeStr_4369))))){
                    _local_3 = 0;
                    _local_4 = 0;
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
                    if (this._SafeStr_4428 != null){
                        _local_2.asset = (this._SafeStr_4428.content as BitmapData);
                        _local_2.offsetX = _local_3;
                        _local_2.offsetY = _local_4;
                        _local_2.alpha = 50;
                        _local_2.relativeDepth = 1;
                    }
                    else {
                        _local_2.visible = false;
                    };
                };
            }
            else {
                this._SafeStr_4428 = null;
                _local_2.visible = false;
            };
        }
        private function updateTypingBubble(_arg_1:Number):void
        {
            var _local_3:int;
            var _local_4:int;
            var _local_5:int;
            this._SafeStr_6534 = null;
            var _local_2:IRoomObjectSprite = getSprite(this._SafeStr_4420);
            if (this._isTyping){
                _local_2.visible = true;
                _local_5 = 64;
                if (_arg_1 < 48){
                    this._SafeStr_6534 = (this._SafeStr_4422.AvatarVisualizationData("user_typing_small_png") as BitmapDataAsset);
                    _local_3 = 3;
                    _local_4 = -42;
                    _local_5 = 32;
                }
                else {
                    this._SafeStr_6534 = (this._SafeStr_4422.AvatarVisualizationData("user_typing_png") as BitmapDataAsset);
                    _local_3 = 14;
                    _local_4 = -83;
                };
                if (this._SafeStr_4346 == "sit"){
                    _local_4 = (_local_4 + (_local_5 / 2));
                }
                else {
                    if (this._SafeStr_4346 == "lay"){
                        _local_4 = (_local_4 + _local_5);
                    };
                };
                if (this._SafeStr_6534 != null){
                    _local_2.asset = (this._SafeStr_6534.content as BitmapData);
                    _local_2.offsetX = _local_3;
                    _local_2.offsetY = _local_4;
                    _local_2.relativeDepth = (-0.02 + 0);
                };
            }
            else {
                _local_2.visible = false;
            };
        }
        private function updateNumberBubble(_arg_1:Number):void
        {
            var _local_4:int;
            var _local_5:int;
            var _local_6:int;
            var _local_2:BitmapDataAsset;
            var _local_3:IRoomObjectSprite = getSprite(this._SafeStr_6532);
            if (this._SafeStr_6541 > 0){
                _local_6 = 64;
                if (_arg_1 < 48){
                    _local_2 = (this._SafeStr_4422.AvatarVisualizationData((("number_" + this._SafeStr_6541) + "_small_png")) as BitmapDataAsset);
                    _local_4 = -6;
                    _local_5 = -52;
                    _local_6 = 32;
                }
                else {
                    _local_2 = (this._SafeStr_4422.AvatarVisualizationData((("number_" + this._SafeStr_6541) + "_png")) as BitmapDataAsset);
                    _local_4 = -8;
                    _local_5 = -105;
                };
                if (this._SafeStr_4346 == "sit"){
                    _local_5 = (_local_5 + (_local_6 / 2));
                }
                else {
                    if (this._SafeStr_4346 == "lay"){
                        _local_5 = (_local_5 + _local_6);
                    };
                };
                if (_local_2 != null){
                    _local_3.visible = true;
                    _local_3.asset = (_local_2.content as BitmapData);
                    _local_3.offsetX = _local_4;
                    _local_3.offsetY = _local_5;
                    _local_3.relativeDepth = -0.01;
                    this._SafeStr_6542 = 1;
                    this._SafeStr_6543 = true;
                    this._SafeStr_6544 = 0;
                    _local_3.alpha = 0;
                }
                else {
                    _local_3.visible = false;
                };
            }
            else {
                if (_local_3.visible){
                    this._SafeStr_6542 = -1;
                };
            };
        }
        private function animateNumberBubble(_arg_1:int):Boolean
        {
            var _local_5:int;
            var _local_2:IRoomObjectSprite = getSprite(this._SafeStr_6532);
            var _local_3:int = _local_2.alpha;
            var _local_4:Boolean;
            if (this._SafeStr_6543){
                this._SafeStr_6544++;
                if (this._SafeStr_6544 < 10){
                    return (false);
                };
                if (this._SafeStr_6542 < 0){
                    if (_arg_1 < 48){
                        _local_2.offsetY = (_local_2.offsetY - 2);
                    }
                    else {
                        _local_2.offsetY = (_local_2.offsetY - 4);
                    };
                }
                else {
                    _local_5 = 4;
                    if (_arg_1 < 48){
                        _local_5 = 8;
                    };
                    if ((this._SafeStr_6544 % _local_5) == 0){
                        _local_2.offsetY--;
                        _local_4 = true;
                    };
                };
            };
            if (this._SafeStr_6542 > 0){
                if (_local_3 < 0xFF){
                    _local_3 = (_local_3 + 32);
                };
                if (_local_3 >= 0xFF){
                    _local_3 = 0xFF;
                    this._SafeStr_6542 = 0;
                };
                _local_2.alpha = _local_3;
                return (true);
            };
            if (this._SafeStr_6542 < 0){
                if (_local_3 >= 0){
                    _local_3 = (_local_3 - 32);
                };
                if (_local_3 <= 0){
                    this._SafeStr_6542 = 0;
                    this._SafeStr_6543 = false;
                    _local_3 = 0;
                    _local_2.visible = false;
                };
                _local_2.alpha = _local_3;
                return (true);
            };
            return (_local_4);
        }
        override public function update(_arg_1:IRoomGeometry, _arg_2:int, _arg_3:Boolean, _arg_4:Boolean):void
        {
            var _local_16:IRoomObjectSprite;
            var _local_17:IRoomObjectSprite;
            var _local_18:Array;
            var _local_19:int;
            var _local_20:ISpriteDataContainer;
            var _local_21:BitmapData;
            var _local_22:IAnimationLayerData;
            var _local_23:int;
            var _local_24:int;
            var _local_25:IAnimationLayerData;
            var _local_26:int;
            var _local_27:int;
            var _local_28:int;
            var _local_29:int;
            var _local_30:int;
            var _local_31:String;
            var _local_32:BitmapDataAsset;
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
            var _local_7:Number = _arg_1.scale;
            var _local_8:Boolean;
            var _local_9:Boolean;
            var _local_10:Boolean;
            var _local_11:int = this._effectType;
            var _local_12:Boolean;
            var _local_13:Boolean = this.updateModel(_local_6, _local_7, _arg_3);
            if (this.animateNumberBubble(_local_7)){
                increaseUpdateId();
            };
            if (((((_local_13) || (!((_local_7 == _SafeStr_4369))))) || ((this._SafeStr_4432 == null)))){
                if (_local_7 != _SafeStr_4369){
                    _local_9 = true;
                    this.validateActions(_local_7);
                };
                if (_local_11 != this._effectType){
                    _local_12 = true;
                };
                if (((((_local_9) || ((this._SafeStr_4432 == null)))) || (_local_12))){
                    this._SafeStr_4432 = this.getAvatarImage(_local_7, this._effectType);
                    if (this._SafeStr_4432 == null){
                        return;
                    };
                    _local_8 = true;
                    _local_16 = getSprite(this._SafeStr_4418);
                    if (((((_local_16) && (this._SafeStr_4432))) && (this._SafeStr_4432.IAvatarImage()))){
                        _local_16.alpha = 150;
                    }
                    else {
                        if (_local_16){
                            _local_16.alpha = 0xFF;
                        };
                    };
                };
                if (this._SafeStr_4432 == null){
                    return;
                };
                this.updateShadow(_local_7);
                if (_local_9){
                    this.updateTypingBubble(_local_7);
                    this.updateNumberBubble(_local_7);
                };
                _local_10 = this.updateObject(_local_5, _arg_1, _arg_3, true);
                this.updateActions(this._SafeStr_4432);
                _SafeStr_4369 = _local_7;
            }
            else {
                _local_10 = this.updateObject(_local_5, _arg_1, _arg_3);
            };
            var _local_14:Boolean = ((((_local_10) || (_local_13))) || (_local_9));
            var _local_15:Boolean = ((((this._SafeStr_4426) || ((this._SafeStr_4427 > 0)))) && (_arg_3));
            if (_local_14){
                this._SafeStr_4427 = _SafeStr_4415;
            };
            if (((_local_14) || (_local_15))){
                increaseUpdateId();
                this._SafeStr_4427--;
                this._SafeStr_4424--;
                if ((((((((this._SafeStr_4424 <= 0)) || (_local_9))) || (_local_13))) || (_local_8))){
                    this._SafeStr_4432.updateAnimationByFrames(1);
                    this._SafeStr_4424 = _SafeStr_4415;
                }
                else {
                    return;
                };
                _local_18 = this._SafeStr_4432.getCanvasOffsets();
                if ((((_local_18 == null)) || ((_local_18.length < 3)))){
                    _local_18 = _SafeStr_4416;
                };
                _local_17 = getSprite(this._SafeStr_4418);
                if (_local_17 != null){
                    _local_21 = this._SafeStr_4432.TwinkleImages(AvatarSetType._SafeStr_4457, false);
                    if (_local_21 != null){
                        _local_17.asset = _local_21;
                    };
                    if (_local_17.asset){
                        _local_17.offsetX = (((-1 * _local_7) / 2) + _local_18[0]);
                        _local_17.offsetY = (((-(_local_17.asset.height) + (_local_7 / 4)) + _local_18[1]) + this._SafeStr_6540);
                    };
                    if (this._SafeStr_4436){
                        if (this._SafeStr_4435){
                            _local_17.relativeDepth = -0.5;
                        }
                        else {
                            _local_17.relativeDepth = (_SafeStr_6530 + _local_18[2]);
                        };
                    }
                    else {
                        _local_17.relativeDepth = (_SafeStr_6529 + _local_18[2]);
                    };
                };
                _local_17 = getSprite(this._SafeStr_4420);
                if (((!((_local_17 == null))) && (_local_17.visible))){
                    if (!this._SafeStr_4436){
                        _local_17.relativeDepth = ((_SafeStr_6529 - 0.01) + _local_18[2]);
                    }
                    else {
                        _local_17.relativeDepth = ((_SafeStr_6530 - 0.01) + _local_18[2]);
                    };
                };
                this._SafeStr_4426 = this._SafeStr_4432.isAnimating();
                _local_19 = this._SafeStr_4421;
                for each (_local_20 in this._SafeStr_4432.getSprites()) {
                    if (_local_20.id == _SafeStr_6528){
                        _local_17 = getSprite(this._SafeStr_4418);
                        _local_22 = this._SafeStr_4432.getLayerData(_local_20);
                        _local_23 = _local_20.ISpriteDataContainer(this._SafeStr_4432.getDirection());
                        _local_24 = _local_20.ISpriteDataContainer(this._SafeStr_4432.getDirection());
                        if (_local_22 != null){
                            _local_23 = (_local_23 + _local_22.dx);
                            _local_24 = (_local_24 + _local_22.dy);
                        };
                        if (_local_7 < 48){
                            _local_23 = (_local_23 / 2);
                            _local_24 = (_local_24 / 2);
                        };
                        _local_17.offsetX = (_local_17.offsetX + _local_23);
                        _local_17.offsetY = (_local_17.offsetY + _local_24);
                    }
                    else {
                        _local_17 = getSprite(_local_19);
                        if (_local_17 != null){
                            _local_17.capturesMouse = false;
                            _local_17.visible = true;
                            _local_25 = this._SafeStr_4432.getLayerData(_local_20);
                            _local_26 = 0;
                            _local_27 = _local_20.ISpriteDataContainer(this._SafeStr_4432.getDirection());
                            _local_28 = _local_20.ISpriteDataContainer(this._SafeStr_4432.getDirection());
                            _local_29 = _local_20.ISpriteDataContainer(this._SafeStr_4432.getDirection());
                            _local_30 = 0;
                            if (_local_20.hasDirections){
                                _local_30 = this._SafeStr_4432.getDirection();
                            };
                            if (_local_25 != null){
                                _local_26 = _local_25.animationFrame;
                                _local_27 = (_local_27 + _local_25.dx);
                                _local_28 = (_local_28 + _local_25.dy);
                                _local_30 = (_local_30 + _local_25.directionOffset);
                            };
                            if (_local_7 < 48){
                                _local_27 = (_local_27 / 2);
                                _local_28 = (_local_28 / 2);
                            };
                            if (_local_30 < 0){
                                _local_30 = (_local_30 + 8);
                            }
                            else {
                                if (_local_30 > 7){
                                    _local_30 = (_local_30 - 8);
                                };
                            };
                            _local_31 = ((((((this._SafeStr_4432.getScale() + "_") + _local_20.member) + "_") + _local_30) + "_") + _local_26);
                            _local_32 = this._SafeStr_4432.getAsset(_local_31);
                            if (_local_32 == null) continue;
                            _local_17.asset = (_local_32.content as BitmapData);
                            _local_17.offsetX = ((-(_local_32.offset.x) - (_local_7 / 2)) + _local_27);
                            _local_17.offsetY = ((-(_local_32.offset.y) + _local_28) + this._SafeStr_6540);
                            if (this._SafeStr_4436){
                                _local_17.relativeDepth = (_SafeStr_6530 - ((0.001 * spriteCount) * _local_29));
                            }
                            else {
                                _local_17.relativeDepth = (_SafeStr_6529 - ((0.001 * spriteCount) * _local_29));
                            };
                            if (_local_20.ink == 33){
                                _local_17.blendMode = BlendMode.ADD;
                            }
                            else {
                                _local_17.blendMode = BlendMode.NORMAL;
                            };
                        };
                        _local_19++;
                    };
                };
            };
        }
        private function updateActions(_arg_1:IAvatarImage):void
        {
            var _local_3:ISpriteDataContainer;
            if (_arg_1 == null){
                return;
            };
            _arg_1.IAvatarImage();
            _arg_1.IAvatarImage(AvatarAction._SafeStr_4478, this._SafeStr_4346, this._SafeStr_4433);
            if (this._gesture > 0){
                _arg_1.IAvatarImage(AvatarAction._SafeStr_4479, AvatarAction._SafeStr_6560[this._gesture]);
            };
            if (this._danceStyle > 0){
                _arg_1.IAvatarImage(AvatarAction.RSDE_DANCE, this._danceStyle);
            };
            if (this._signType > 0){
                _arg_1.IAvatarImage(AvatarAction._SafeStr_6561, this._signType);
            };
            if (this._SafeStr_6538 > 0){
                _arg_1.IAvatarImage(AvatarAction._SafeStr_6562, this._SafeStr_6538);
            };
            if (this._SafeStr_6539 > 0){
                _arg_1.IAvatarImage(AvatarAction._SafeStr_6563, this._SafeStr_6539);
            };
            if (this._SafeStr_6535){
                _arg_1.IAvatarImage(AvatarAction._SafeStr_4452);
            };
            if (((this._isSleeping) || (this._SafeStr_4434))){
                _arg_1.IAvatarImage(AvatarAction._SafeStr_4480);
            };
            if (this._isWaving){
                _arg_1.IAvatarImage(AvatarAction._SafeStr_4453);
            };
            if (this._effectType > 0){
                _arg_1.IAvatarImage(AvatarAction._SafeStr_6564, this._effectType);
            };
            _arg_1.IAvatarImage();
            this._SafeStr_4426 = _arg_1.isAnimating();
            var _local_2:int = this._SafeStr_4421;
            for each (_local_3 in this._SafeStr_4432.getSprites()) {
                if (_local_3.id != _SafeStr_6528){
                    _local_2++;
                };
            };
            if (_local_2 != spriteCount){
                createSprites(_local_2);
            };
        }
        public function avatarImageReady(_arg_1:String):void
        {
            this.resetImages();
        }

    }
}//package com.sulake.habbo.room.object.visualization.avatar

// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// RoomObjectVariableEnum = "_-1MH" (String#17370, DoABC#2)
// IRoomObjectVisualizationData = "_-26A" (String#6167, DoABC#2)
// IRoomObjectModel = "_-253" (String#6141, DoABC#2)
// RoomObjectSpriteVisualization = "_-01y" (String#3602, DoABC#2)
// AvatarVisualizationData = "_-1dS" (String#5621, DoABC#2)
// AvatarVisualization = "_-2SE" (String#6613, DoABC#2)
// IRoomGeometry = "_-0z9" (String#4829, DoABC#2)
// IAnimationLayerData = "_-14E" (String#4961, DoABC#2)
// ISpriteDataContainer = "_-2J5" (String#6422, DoABC#2)
// IRoomObjectSprite = "_-0di" (String#4386, DoABC#2)
// _gender = "_-a0" (String#95, DoABC#2)
// _effectType = "_-37b" (String#7460, DoABC#2)
// _isTyping = "_-2z6" (String#624, DoABC#2)
// _figure = "_-20u" (String#75, DoABC#2)
// AvatarVisualizationData = "_-1el" (String#18089, DoABC#2)
// AvatarVisualizationData = "_-0Zg" (String#15430, DoABC#2)
// _SafeStr_4346 = "_-KR" (String#2089, DoABC#2)
// _gesture = "_-2tH" (String#452, DoABC#2)
// _isSleeping = "_-2EU" (String#882, DoABC#2)
// updateModel = "_-1CW" (String#441, DoABC#2)
// getUpdateID = "_-Ga" (String#932, DoABC#2)
// _SafeStr_4365 = "_-2rK" (String#21130, DoABC#2)
// _SafeStr_4366 = "_-2r-" (String#21121, DoABC#2)
// _SafeStr_4367 = "_-3At" (String#21914, DoABC#2)
// _SafeStr_4369 = "_-bP" (String#23689, DoABC#2)
// validateActions = "_-269" (String#1810, DoABC#2)
// _SafeStr_4374 = "_-GG" (String#22862, DoABC#2)
// _SafeStr_4375 = "_-0Jq" (String#14835, DoABC#2)
// getSprite = "_-sN" (String#2210, DoABC#2)
// spriteCount = "_-2A7" (String#6252, DoABC#2)
// _SafeStr_4415 = "_-1VA" (String#5458, DoABC#2)
// _SafeStr_4416 = "_-0qw" (String#4660, DoABC#2)
// _SafeStr_4418 = "_-2gg" (String#6883, DoABC#2)
// _SafeStr_4419 = "_-0-r" (String#3561, DoABC#2)
// _SafeStr_4420 = "_-38E" (String#7477, DoABC#2)
// _SafeStr_4421 = "_-C7" (String#7914, DoABC#2)
// _SafeStr_4422 = "_-2Y6" (String#6730, DoABC#2)
// _SafeStr_4423 = "_-01x" (String#3601, DoABC#2)
// _SafeStr_4424 = "_-03i" (String#3640, DoABC#2)
// _SafeStr_4426 = "_-0wK" (String#594, DoABC#2)
// _SafeStr_4427 = "_-uP" (String#8770, DoABC#2)
// _SafeStr_4428 = "_-0XV" (String#4258, DoABC#2)
// _disposed = "_-6m" (String#31, DoABC#2)
// _geometryUpdateId = "_-2yN" (String#370, DoABC#2)
// _SafeStr_4432 = "_-0DF" (String#3814, DoABC#2)
// _SafeStr_4433 = "_-K6" (String#8085, DoABC#2)
// _SafeStr_4434 = "_-1Xu" (String#5517, DoABC#2)
// _SafeStr_4435 = "_-02N" (String#3614, DoABC#2)
// _SafeStr_4436 = "_-wP" (String#8808, DoABC#2)
// _SafeStr_4438 = "_-2N-" (String#6500, DoABC#2)
// _SafeStr_4439 = "_-1Ve" (String#5467, DoABC#2)
// _SafeStr_4440 = "_-17Q" (String#5024, DoABC#2)
// createSprites = "_-1Im" (String#17226, DoABC#2)
// _SafeStr_4442 = "_-0Mv" (String#14951, DoABC#2)
// _SafeStr_4443 = "_-2Lr" (String#19878, DoABC#2)
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
// RSDE_DANCE = "_-0-n" (String#14045, DoABC#2)
// avatarImageReady = "_-i" (String#8553, DoABC#2)
// updateFigure = "_-15u" (String#1619, DoABC#2)
// _SafeStr_6528 = "_-0SN" (String#15150, DoABC#2)
// _SafeStr_6529 = "_-3BM" (String#21938, DoABC#2)
// _SafeStr_6530 = "_-2bE" (String#20498, DoABC#2)
// _SafeStr_6531 = "_-Yd" (String#23584, DoABC#2)
// _SafeStr_6532 = "_-1WV" (String#17759, DoABC#2)
// _SafeStr_6533 = "_-1UE" (String#17676, DoABC#2)
// _SafeStr_6534 = "_-TB" (String#23372, DoABC#2)
// _SafeStr_6535 = "_-1oH" (String#18470, DoABC#2)
// _isWaving = "_-0lR" (String#1542, DoABC#2)
// _signType = "_-5W" (String#7771, DoABC#2)
// _SafeStr_6538 = "_-Gu" (String#22887, DoABC#2)
// _SafeStr_6539 = "_-22m" (String#19123, DoABC#2)
// _SafeStr_6540 = "_-1oz" (String#18500, DoABC#2)
// _SafeStr_6541 = "_-1zz" (String#18967, DoABC#2)
// _SafeStr_6542 = "_-2LP" (String#19863, DoABC#2)
// _SafeStr_6543 = "_-0lw" (String#15894, DoABC#2)
// _SafeStr_6544 = "_-0k3" (String#15833, DoABC#2)
// _SafeStr_6545 = "_-2IW" (String#19747, DoABC#2)
// _SafeStr_6546 = "_-n1" (String#24155, DoABC#2)
// _SafeStr_6547 = "_-ZI" (String#23609, DoABC#2)
// _SafeStr_6548 = "_-09g" (String#14434, DoABC#2)
// updateTypingBubble = "_-0Ar" (String#14482, DoABC#2)
// _SafeStr_6550 = "_-aD" (String#23641, DoABC#2)
// _SafeStr_6551 = "_-If" (String#22952, DoABC#2)
// _SafeStr_6552 = "_-0ig" (String#15779, DoABC#2)
// _SafeStr_6553 = "_-2wB" (String#21318, DoABC#2)
// _SafeStr_6554 = "_-4J" (String#22390, DoABC#2)
// updateNumberBubble = "_-0Fj" (String#14672, DoABC#2)
// _SafeStr_6556 = "_-02t" (String#14155, DoABC#2)
// IAvatarImage = "_-0qX" (String#4650, DoABC#2)
// animateNumberBubble = "_-39J" (String#21858, DoABC#2)
// IAvatarImage = "_-128" (String#4919, DoABC#2)
// _SafeStr_6560 = "_-Xg" (String#23548, DoABC#2)
// _SafeStr_6561 = "_-Ne" (String#23151, DoABC#2)
// _SafeStr_6562 = "_-R2" (String#23284, DoABC#2)
// _SafeStr_6563 = "_-07B" (String#14332, DoABC#2)
// _SafeStr_6564 = "_-1eZ" (String#18081, DoABC#2)
// IAvatarImageListener = "_-06N" (String#3688, DoABC#2)


