
package com.sulake.habbo.avatar
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.avatar.enum.AvatarSetType;
    import com.sulake.habbo.avatar.actions.IActiveActionData;
    import com.sulake.habbo.avatar.alias.AssetAliasCollection;
    import com.sulake.habbo.avatar.cache.AvatarImageCache;
    import com.sulake.habbo.avatar.animation.IAvatarDataContainer;
    import flash.display.BitmapData;
    import com.sulake.habbo.avatar.enum.AvatarScaleType;
    import com.sulake.habbo.avatar.actions.ActiveActionData;
    import com.sulake.habbo.avatar.enum.AvatarAction;
    import com.sulake.habbo.avatar.structure.figure.IPartColor;
    import com.sulake.habbo.avatar.pets.IPetData;
    import com.sulake.habbo.avatar.enum.AvatarDirectionAngle;
    import com.sulake.habbo.avatar.animation.ISpriteDataContainer;
    import com.sulake.habbo.avatar.animation.IAnimationLayerData;
    import flash.geom.Point;
    import com.sulake.habbo.avatar.cache.AvatarImageBodyPartCache;
    import com.sulake.habbo.avatar.structure.AvatarCanvas;
    import flash.geom.Rectangle;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.habbo.avatar.animation.Animation;
    import flash.utils.getTimer;
    import flash.filters.ColorMatrixFilter;
    import com.sulake.habbo.avatar.structure.figure.IFigurePartSet;
    import com.sulake.habbo.avatar.structure.figure.FigurePart;
    import com.sulake.habbo.avatar.structure.figure.ISetType;

    public class PetImage implements IAvatarImage, IDisposable 
    {

        private static const CHANNELS_EQUAL:String = "CHANNELS_EQUAL";
        private static const CHANNELS_UNIQUE:String = "CHANNELS_UNIQUE";
        private static const CHANNELS_RED:String = "CHANNELS_RED";
        private static const CHANNELS_GREEN:String = "CHANNELS_GREEN";
        private static const CHANNELS_BLUE:String = "CHANNELS_BLUE";
        private static const CHANNELS_SATURATED:String = "CHANNELS_SATURATED";
        private static const _SafeStr_10074:String = "Default";
        private static const _SafeStr_10075:int = 2;
        private static const _SafeStr_10076:String = AvatarSetType._SafeStr_4457;//"full"

        protected var _structure:AvatarStructure;
        protected var _scale:String;
        protected var _direction:int;
        protected var _SafeStr_10078:IActiveActionData;
        protected var _disposed:Boolean;
        private var _defaultAction:IActiveActionData;
        private var _assets:AssetAliasCollection;
        private var _cache:AvatarImageCache;
        private var _frameCounter:int = 0;
        private var _directionOffset:int = 0;
        private var _figure:AvatarFigureContainer;
        private var _SafeStr_10079:Boolean;
        private var _sprites:Array;
        private var _avatarSpriteData:IAvatarDataContainer;
        private var _SafeStr_5141:Array;
        private var _image:BitmapData;
        private var _SafeStr_4426:Boolean;
        private var _canvasOffsets:Array;
        private var _SafeStr_10081:Boolean = false;
        private var _subType:int = 0;
        private var _petType:int;
        private var _breed:int;
        private var _SafeStr_10083:Array;
        private var _SafeStr_10084:String;
        private var _SafeStr_10085:String;
        private var _SafeStr_10086:int;
        private var _SafeStr_10087:int;

        public function PetImage(_arg_1:AvatarStructure, _arg_2:AssetAliasCollection, _arg_3:String, _arg_4:String)
        {
            this._SafeStr_5141 = [];
            this._canvasOffsets = new Array();
            super();
            this._SafeStr_10079 = true;
            this._structure = _arg_1;
            this._assets = _arg_2;
            this._scale = _arg_4;
            if (this._scale == null){
                this._scale = AvatarScaleType._SafeStr_4336;
            };
            if ((((_arg_3 == null)) || ((_arg_3 == "")))){
                _arg_3 = "phd-1-5.pbd-1-5.ptl-1-5";
                Logger.log("Using default pet figure");
            };
            this._figure = new AvatarFigureContainer(_arg_3);
            var _local_5:int = this._figure.getPartSetId("pbd");
            this.solvePetAvatarTypeAndBreed(_local_5);
            this._subType = this._petType;
            this._cache = new AvatarImageCache(this._structure, this, this._assets, this._scale);
            this.setDirection(_SafeStr_10076, _SafeStr_10075);
            this._SafeStr_5141 = new Array();
            this._defaultAction = new ActiveActionData(AvatarAction._SafeStr_10001);
            this._defaultAction.definition = this._structure.getActionDefinition(_SafeStr_10074);
            this.resetActions();
        }
        public function dispose():void
        {
            var _local_1:AvatarImageCache;
            if (!this._disposed){
                this._structure = null;
                this._assets = null;
                this._cache = null;
                this._SafeStr_10078 = null;
                this._figure = null;
                this._avatarSpriteData = null;
                this._SafeStr_5141 = null;
                if (this._image){
                    this._image.dispose();
                };
                _local_1 = this.getCache();
                if (_local_1){
                    _local_1.dispose();
                    _local_1 = null;
                };
                this._image = null;
                this._canvasOffsets = null;
                this._disposed = true;
            };
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function getFigure():IAvatarFigureContainer
        {
            return (this._figure);
        }
        public function getScale():String
        {
            return (this._scale);
        }
        public function getSubType():int
        {
            return (this._subType);
        }
        public function getPartColor(_arg_1:String):IPartColor
        {
            return (this._structure.getPartColor(this._figure, _arg_1));
        }
        public function setDirection(_arg_1:String, _arg_2:int):void
        {
            var _local_3:IPetData;
            _arg_2 = (_arg_2 + this._directionOffset);
            if (_arg_2 < AvatarDirectionAngle._SafeStr_9982){
                _arg_2 = (AvatarDirectionAngle._SafeStr_9983 + (_arg_2 + 1));
            };
            if (_arg_2 > AvatarDirectionAngle._SafeStr_9983){
                _arg_2 = (_arg_2 - (AvatarDirectionAngle._SafeStr_9983 + 1));
            };
            if (_arg_1 == AvatarSetType._SafeStr_4458){
                if ((((((this._direction == 6)) || ((this._direction == 0)))) && ((_arg_2 == 7)))){
                    _arg_2 = this._direction;
                };
                _local_3 = this._structure.renderManager.petDataManager.getPetData(this._subType);
                if (_local_3 != null){
                    if (_local_3.disableHeadTurn){
                        _arg_2 = this._direction;
                    };
                };
            };
            if (this._structure.isMainAvatarSet(_arg_1)){
                this._direction = _arg_2;
            };
            this.getCache().setDirection(_arg_1, _arg_2);
            this._SafeStr_10079 = true;
        }
        public function setDirectionAngle(_arg_1:String, _arg_2:int):void
        {
            var _local_3:int;
            _local_3 = (_arg_2 / 45);
            this.setDirection(_arg_1, _local_3);
        }
        public function getSprites():Array
        {
            return (this._sprites);
        }
        public function getCanvasOffsets():Array
        {
            return (this._canvasOffsets);
        }
        public function getLayerData(_arg_1:ISpriteDataContainer):IAnimationLayerData
        {
            return (this._structure.getBodyPartData(_arg_1.animation.id, this._frameCounter, _arg_1.id));
        }
        public function updateAnimationByFrames(_arg_1:int=1):void
        {
            this._frameCounter = (this._frameCounter + _arg_1);
            this._SafeStr_10079 = true;
        }
        public function getImage(_arg_1:String, _arg_2:Boolean):BitmapData
        {
            var _local_8:String;
            var _local_9:AvatarImageBodyPartContainer;
            var _local_10:BitmapData;
            var _local_11:Point;
            var _local_12:AvatarImageBodyPartCache;
            var _local_13:IActiveActionData;
            var _local_14:String;
            var _local_15:Array;
            var _local_16:Boolean;
            var _local_17:int;
            var _local_18:AvatarImagePartContainer;
            var _local_19:int;
            var _local_20:int;
            var _local_21:int;
            var _local_22:Point;
            var _local_23:BitmapData;
            if (!this._SafeStr_10079){
                return (this._image);
            };
            if (this._SafeStr_10078 == null){
                return (null);
            };
            if (!this._SafeStr_10081){
                this.endActionAppends();
            };
            var _local_3:AvatarImageCache = this.getCache();
            var _local_4:AvatarCanvas = this._structure.getCanvas(this._scale, this._SafeStr_10078.definition.geometryType);
            if ((((this._image == null)) || (((!((_local_4 == null))) && (((!((this._image.width == _local_4.width))) || (!((this._image.height == _local_4.height))))))))){
                _local_4 = this._structure.getCanvas(this._scale, this._SafeStr_10078.definition.geometryType);
                if (_local_4 == null){
                    return (null);
                };
                this._image = new BitmapData(_local_4.width, _local_4.height, true, 0xFFFFFF);
            };
            var _local_5:Array = this._structure.getBodyParts(_arg_1, this._SafeStr_10078.definition.geometryType, this._direction);
            this._image.lock();
            this._image.fillRect(this._image.rect, 0xFFFFFF);
            var _local_6:Point = _local_4.offset;
            if (_local_6 == null){
                _local_6 = new Point(0, 0);
            };
            var _local_7:int = (_local_5.length - 1);
            while (_local_7 >= 0) {
                _local_8 = _local_5[_local_7];
                _local_9 = _local_3.getImageContainer(_local_8, this._frameCounter);
                if (((((_local_9) && (_local_9.image))) && (_local_9.regPoint))){
                    _local_10 = _local_9.image;
                    _local_11 = _local_9.regPoint.clone();
                    _local_12 = this.getCache().getBodyPartCache(_local_8);
                    _local_13 = _local_12.getAction();
                    _local_14 = _local_13.definition.assetPartDefinition;
                    _local_15 = this._structure.getParts(_local_8, this._figure, _local_13, "pet", _local_12.getDirection(), []);
                    _local_16 = (this._subType < 3);
                    _local_17 = ((_local_16) ? 32 : 67);
                    if (this._scale == AvatarScaleType._SafeStr_4337){
                        _local_17 = ((_local_16) ? 6 : 31);
                    };
                    if (_local_15.length > 0){
                        _local_18 = _local_15[0];
                        _local_19 = _local_18.getFrameIndex(this._frameCounter);
                        _local_20 = this._direction;
                        _local_21 = 1;
                        switch (this._direction){
                            case 4:
                                _local_20 = 2;
                                _local_21 = -1;
                                break;
                            case 5:
                                _local_20 = 1;
                                _local_21 = -1;
                                break;
                            case 6:
                                _local_20 = 0;
                                _local_21 = -1;
                                break;
                        };
                        _local_22 = this._structure.getPartActionOffset(this.getSubType(), this._scale, _local_8, _local_14, _local_19, _local_20);
                        if (_local_22 != null){
                            _local_11.x = (_local_11.x + (_local_22.x * _local_21));
                            _local_11.y = (_local_11.y + _local_22.y);
                            if ((((this._direction == 7)) && ((_local_12.getDirection() == 6)))){
                                _local_11.offset((-1 * _local_17), 0);
                            }
                            else {
                                if ((((this._direction == 4)) && ((_local_12.getDirection() == 3)))){
                                    _local_11.offset(_local_17, 0);
                                }
                                else {
                                    if ((((this._direction == 3)) && ((_local_12.getDirection() == 4)))){
                                        _local_11.offset((-1 * _local_17), 0);
                                    }
                                    else {
                                        if ((((this._direction == 6)) && ((_local_12.getDirection() == 7)))){
                                            _local_11.offset(_local_17, 0);
                                        };
                                    };
                                };
                            };
                        };
                    };
                    this._image.copyPixels(_local_10, _local_10.rect, _local_11.add(_local_6), null, null, true);
                };
                _local_7--;
            };
            this._image.unlock();
            this._SafeStr_10079 = false;
            if (this._avatarSpriteData != null){
                if (this._avatarSpriteData.paletteIsGrayscale){
                    _local_23 = this.convertToGrayscale(this._image);
                    if (this._image){
                        this._image.dispose();
                    };
                    this._image = _local_23;
                    this._image.paletteMap(this._image, this._image.rect, new Point(0, 0), this._avatarSpriteData.reds, [], []);
                }
                else {
                    this._image.copyChannel(this._image, this._image.rect, new Point(0, 0), 2, 8);
                };
            };
            if (((this._image) && (_arg_2))){
                return (this._image.clone());
            };
            return (this._image);
        }
        public function getCroppedImage(_arg_1:String):BitmapData
        {
            var _local_6:Rectangle;
            var _local_9:String;
            var _local_10:AvatarImageBodyPartContainer;
            var _local_11:BitmapData;
            var _local_12:Point;
            var _local_13:AvatarImageBodyPartCache;
            var _local_14:IActiveActionData;
            var _local_15:String;
            var _local_16:Array;
            var _local_17:int;
            var _local_18:Rectangle;
            var _local_19:AvatarImagePartContainer;
            var _local_20:int;
            var _local_21:int;
            var _local_22:int;
            var _local_23:Point;
            if (this._SafeStr_10078 == null){
                return (null);
            };
            var _local_2:AvatarImageCache = this.getCache();
            var _local_3:AvatarCanvas = this._structure.getCanvas(this._scale, this._SafeStr_10078.definition.geometryType);
            if (_local_3 == null){
                return (null);
            };
            var _local_4:BitmapData = new BitmapData(_local_3.width, _local_3.height, true, 0xFFFFFF);
            var _local_5:Array = this._structure.getBodyParts(_arg_1, this._SafeStr_10078.definition.geometryType, this._direction);
            var _local_7:int = (_local_5.length - 1);
            while (_local_7 >= 0) {
                _local_9 = _local_5[_local_7];
                _local_10 = _local_2.getImageContainer(_local_9, this._frameCounter);
                if (_local_10 != null){
                    _local_11 = _local_10.image;
                    if (_local_11 == null){
                        _local_4.dispose();
                        return (null);
                    };
                    _local_12 = _local_10.regPoint.clone();
                    _local_13 = this.getCache().getBodyPartCache(_local_9);
                    _local_14 = _local_13.getAction();
                    _local_15 = _local_14.definition.assetPartDefinition;
                    _local_16 = this._structure.getParts(_local_9, this._figure, _local_14, "pet", _local_13.getDirection(), []);
                    _local_17 = 32;
                    if (this._scale == AvatarScaleType._SafeStr_4337){
                        _local_17 = 6;
                    };
                    if (_local_16.length > 0){
                        _local_19 = _local_16[0];
                        _local_20 = _local_19.getFrameIndex(this._frameCounter);
                        _local_21 = this._direction;
                        _local_22 = 1;
                        switch (this._direction){
                            case 4:
                                _local_21 = 2;
                                _local_22 = -1;
                                break;
                            case 5:
                                _local_21 = 1;
                                _local_22 = -1;
                                break;
                            case 6:
                                _local_21 = 0;
                                _local_22 = -1;
                                break;
                        };
                        _local_23 = this._structure.getPartActionOffset(this.getSubType(), this._scale, _local_9, _local_15, _local_20, _local_21);
                        if (_local_23 != null){
                            _local_12.x = (_local_12.x + (_local_23.x * _local_22));
                            _local_12.y = (_local_12.y + _local_23.y);
                            if ((((this._direction == 7)) && ((_local_13.getDirection() == 6)))){
                                _local_12.offset((-1 * _local_17), 0);
                            }
                            else {
                                if ((((this._direction == 4)) && ((_local_13.getDirection() == 3)))){
                                    _local_12.offset(_local_17, 0);
                                }
                                else {
                                    if ((((this._direction == 3)) && ((_local_13.getDirection() == 4)))){
                                        _local_12.offset((-1 * _local_17), 0);
                                    }
                                    else {
                                        if ((((this._direction == 6)) && ((_local_13.getDirection() == 7)))){
                                            _local_12.offset(_local_17, 0);
                                        };
                                    };
                                };
                            };
                        };
                    };
                    _local_4.copyPixels(_local_11, _local_11.rect, _local_12, null, null, true);
                    _local_18 = new Rectangle(_local_12.x, _local_12.y, _local_11.width, _local_11.height);
                    if (_local_6 == null){
                        _local_6 = _local_18;
                    }
                    else {
                        _local_6 = _local_6.union(_local_18);
                    };
                };
                _local_7--;
            };
            if (_local_6 == null){
                _local_6 = new Rectangle(0, 0, 1, 1);
            };
            var _local_8:BitmapData = new BitmapData(_local_6.width, _local_6.height, true, 0xFFFFFF);
            _local_8.copyPixels(_local_4, _local_6, new Point(0, 0), null, null, true);
            _local_4.dispose();
            return (_local_8);
        }
        public function getAsset(_arg_1:String):BitmapDataAsset
        {
            return ((this._assets.getAssetByName(_arg_1) as BitmapDataAsset));
        }
        public function getDirection():int
        {
            return (this._direction);
        }
        public function initActionAppends():void
        {
            this._SafeStr_5141 = new Array();
            this._SafeStr_10081 = false;
            this._SafeStr_10085 = "";
        }
        public function endActionAppends():void
        {
            this.sortActions();
            this.resetActions();
            this.setActionsToParts();
        }
        public function appendAction(_arg_1:String, ... _args):Boolean
        {
            var _local_3:String;
            this._SafeStr_10081 = false;
            if (((!((_args == null))) && ((_args.length > 0)))){
                _local_3 = _args[0];
            };
            this._SafeStr_10085 = ((this._SafeStr_10085 + _arg_1) + _local_3);
            switch (_arg_1){
                case AvatarAction._SafeStr_4478:
                    switch (_local_3){
                        case "wav":
                            this.addActionData("wave");
                            break;
                        case AvatarAction._SafeStr_10003:
                        case AvatarAction._SafeStr_4445:
                        case AvatarAction._SafeStr_10002:
                        case AvatarAction._SafeStr_10001:
                        case AvatarAction._SafeStr_4446:
                        case AvatarAction._SafeStr_4447:
                        case AvatarAction._SafeStr_10004:
                        case AvatarAction._SafeStr_10005:
                        case AvatarAction._SafeStr_10006:
                        case AvatarAction._SafeStr_4448:
                        case AvatarAction._SafeStr_4449:
                        case AvatarAction._SafeStr_10007:
                        case AvatarAction._SafeStr_10008:
                        case AvatarAction._SafeStr_4450:
                        case AvatarAction._SafeStr_4451:
                            this.addActionData(_local_3);
                            break;
                        default:
                            this.errorThis(("appendAction() >> UNKNOWN POSTURE TYPE: " + _local_3));
                    };
                    break;
                case AvatarAction._SafeStr_4479:
                    switch (_local_3){
                        case AvatarAction._SafeStr_9992:
                        case AvatarAction._SafeStr_9994:
                        case AvatarAction._SafeStr_9991:
                        case AvatarAction._SafeStr_9993:
                        case AvatarAction._SafeStr_9995:
                        case AvatarAction._SafeStr_9996:
                        case AvatarAction._SafeStr_9997:
                        case AvatarAction._SafeStr_9998:
                        case AvatarAction._SafeStr_9999:
                        case AvatarAction._SafeStr_10000:
                            this.addActionData(_local_3);
                            break;
                        default:
                            this.errorThis(("appendAction() >> UNKNOWN GESTURE TYPE: " + _local_3));
                    };
                    break;
                case AvatarAction._SafeStr_4452:
                case AvatarAction._SafeStr_4453:
                case AvatarAction._SafeStr_6564:
                case AvatarAction._SafeStr_4480:
                    this.addActionData(_arg_1, _local_3);
                    break;
                default:
                    this.errorThis(("appendAction() >> UNKNOWN ACTION TYPE: " + _arg_1));
            };
            return (true);
        }
        private function addActionData(_arg_1:String, _arg_2:String=""):void
        {
            var _local_3:ActiveActionData;
            if (this._SafeStr_5141 == null){
                this._SafeStr_5141 = new Array();
            };
            var _local_4:int;
            while (_local_4 < this._SafeStr_5141.length) {
                _local_3 = this._SafeStr_5141[_local_4];
                if ((((_local_3.actionType == _arg_1)) && ((_local_3.actionParameter == _arg_2)))){
                    return;
                };
                _local_4++;
            };
            this._SafeStr_5141.push(new ActiveActionData(_arg_1, _arg_2));
        }
        public function isAnimating():Boolean
        {
            return (this._SafeStr_4426);
        }
        private function resetActions():Boolean
        {
            this._SafeStr_4426 = false;
            this._sprites = [];
            this._avatarSpriteData = null;
            this._directionOffset = 0;
            this._SafeStr_10078 = this._defaultAction;
            this._SafeStr_10078.definition = this._defaultAction.definition;
            this.setActionToParts(this._defaultAction);
            this.getCache().resetBodyPartCache(this._defaultAction);
            return (true);
        }
        private function sortActions():void
        {
            this._SafeStr_10081 = true;
            if (this._SafeStr_10084 == this._SafeStr_10085){
                return;
            };
            this._SafeStr_10084 = this._SafeStr_10085;
            this._SafeStr_10083 = this._structure.sortActions(this._SafeStr_5141);
            if (this._SafeStr_10083 == null){
                this._canvasOffsets = new Array(0, 0, 0);
            }
            else {
                this._canvasOffsets = this._structure.getCanvasOffsets(this._SafeStr_10083, this._scale, this._direction);
            };
        }
        private function setActionsToParts():void
        {
            var _local_1:ActiveActionData;
            var _local_2:Animation;
            for each (_local_1 in this._SafeStr_10083) {
                if (!((!(_local_1)) || (!(_local_1.definition)))){
                    if (((_local_1.definition.isAnimation) && ((_local_1.actionParameter == "")))){
                        _local_1.actionParameter = "1";
                    };
                    this.setActionToParts(_local_1);
                    if (_local_1.definition.isAnimation){
                        this._SafeStr_4426 = true;
                        _local_2 = this._structure.getAnimation(((_local_1.definition.state + ".") + _local_1.actionParameter));
                        if (_local_2 != null){
                            this._sprites = this._sprites.concat(_local_2.spriteData);
                            if (_local_2.hasDirectionData()){
                                this._directionOffset = _local_2.directionData.offset;
                            };
                            if (_local_2.hasAvatarData()){
                                this._avatarSpriteData = _local_2.avatarData;
                            };
                        };
                    };
                    if (_local_1.actionType == AvatarAction._SafeStr_7966){
                        this._SafeStr_4426 = true;
                    };
                    if (_local_1.actionType == AvatarAction._SafeStr_4453){
                        this._SafeStr_4426 = true;
                    };
                    if (_local_1.actionType == AvatarAction._SafeStr_4452){
                        this._SafeStr_4426 = true;
                    };
                };
            };
        }
        private function getCache():AvatarImageCache
        {
            if (this._cache == null){
                this._cache = new AvatarImageCache(this._structure, this, this._assets, this._scale);
            };
            return (this._cache);
        }
        private function setActionToParts(_arg_1:IActiveActionData):void
        {
            if (_arg_1 == null){
                return;
            };
            if (_arg_1.definition.assetPartDefinition == ""){
                return;
            };
            if (_arg_1.definition.isMain){
                this._SafeStr_10078 = _arg_1;
                this.getCache().setGeometryType(_arg_1.definition.geometryType);
            };
            this.getCache().setAction(_arg_1, getTimer());
            this._SafeStr_10079 = true;
        }
        public function get avatarSpriteData():IAvatarDataContainer
        {
            return (this._avatarSpriteData);
        }
        private function convertToGrayscale(_arg_1:BitmapData, _arg_2:String="CHANNELS_EQUAL"):BitmapData
        {
            var _local_3:Number = 0.33;
            var _local_4:Number = 0.33;
            var _local_5:Number = 0.33;
            var _local_6:Number = 1;
            switch (_arg_2){
                case "CHANNELS_UNIQUE":
                    _local_3 = 0.3;
                    _local_4 = 0.59;
                    _local_5 = 0.11;
                    break;
                case "CHANNELS_RED":
                    _local_3 = 1;
                    _local_4 = 0;
                    _local_5 = 0;
                    break;
                case "CHANNELS_GREEN":
                    _local_3 = 0;
                    _local_4 = 1;
                    _local_5 = 0;
                    break;
                case "CHANNELS_BLUE":
                    _local_3 = 0;
                    _local_4 = 0;
                    _local_5 = 1;
                    break;
                case "CHANNELS_DESATURATED":
                    _local_3 = 0.3086;
                    _local_4 = 0.6094;
                    _local_5 = 0.082;
                    break;
            };
            var _local_7:Array = [_local_3, _local_4, _local_5, 0, 0, _local_3, _local_4, _local_5, 0, 0, _local_3, _local_4, _local_5, 0, 0, 0, 0, 0, 1, 0];
            var _local_8:ColorMatrixFilter = new ColorMatrixFilter(_local_7);
            var _local_9:BitmapData = new BitmapData(_arg_1.width, _arg_1.height, _arg_1.transparent, 0xFFFFFFFF);
            _local_9.copyPixels(_arg_1, _arg_1.rect, new Point(0, 0), null, null, false);
            _local_9.applyFilter(_local_9, _local_9.rect, new Point(0, 0), _local_8);
            return (_local_9);
        }
        private function errorThis(_arg_1:String):void
        {
            Logger.log(("[PetImageError] " + _arg_1));
        }
        private function logThis(_arg_1:String):void
        {
        }
        private function solvePetAvatarTypeAndBreed(_arg_1:int):void
        {
            var _local_3:IFigurePartSet;
            var _local_4:FigurePart;
            this._petType = 0;
            this._breed = 0;
            var _local_2:ISetType = this._structure.figureData.getSetType("pbd");
            if (_local_2 != null){
                _local_3 = _local_2.getPartSet(_arg_1);
                if (_local_3 != null){
                    for each (_local_4 in _local_3.parts) {
                        if (_local_4.type == "pbd"){
                            this._petType = _local_4.id;
                            this._breed = _local_4.breed;
                            break;
                        };
                    };
                };
            };
        }
        public function get petType():int
        {
            return (this._petType);
        }
        public function get petBreed():int
        {
            return (this._breed);
        }
        public function isPlaceholder():Boolean
        {
            return (false);
        }
        public function forceActionUpdate():void
        {
        }

    }
}//package com.sulake.habbo.avatar

// _SafeStr_10000 = "_-3a" (String#22357, DoABC#2)
// _SafeStr_10001 = "_-Cl" (String#22715, DoABC#2)
// _SafeStr_10002 = "_-16w" (String#16732, DoABC#2)
// _SafeStr_10003 = "_-2r3" (String#21122, DoABC#2)
// _SafeStr_10004 = "_-vL" (String#24503, DoABC#2)
// _SafeStr_10005 = "_-3KQ" (String#22301, DoABC#2)
// _SafeStr_10006 = "_-3EB" (String#22042, DoABC#2)
// _SafeStr_10007 = "_-Da" (String#22753, DoABC#2)
// _SafeStr_10008 = "_-2j5" (String#20810, DoABC#2)
// disableHeadTurn = "_-0aA" (String#4304, DoABC#2)
// getSetType = "_-0CE" (String#3795, DoABC#2)
// _SafeStr_10074 = "_-2ex" (String#6851, DoABC#2)
// _SafeStr_10075 = "_-LW" (String#8114, DoABC#2)
// _SafeStr_10076 = "_-2I4" (String#6405, DoABC#2)
// _direction = "_-2jr" (String#6951, DoABC#2)
// _SafeStr_10078 = "_-0hg" (String#4461, DoABC#2)
// _SafeStr_10079 = "_-6O" (String#7791, DoABC#2)
// _avatarSpriteData = "_-1aN" (String#5566, DoABC#2)
// _SafeStr_10081 = "_-1ty" (String#5919, DoABC#2)
// _subType = "_-0W2" (String#15278, DoABC#2)
// _SafeStr_10083 = "_-uc" (String#24475, DoABC#2)
// _SafeStr_10084 = "_-5f" (String#7776, DoABC#2)
// _SafeStr_10085 = "_-020" (String#3604, DoABC#2)
// _SafeStr_10086 = "_-2wW" (String#7214, DoABC#2)
// _SafeStr_10087 = "_-00p" (String#3579, DoABC#2)
// solvePetAvatarTypeAndBreed = "_-20D" (String#19020, DoABC#2)
// resetActions = "_-213" (String#6068, DoABC#2)
// getCache = "_-CE" (String#7919, DoABC#2)
// getSubType = "_-0Cx" (String#3807, DoABC#2)
// getBodyPartData = "_-0FK" (String#14657, DoABC#2)
// regPoint = "_-UQ" (String#23428, DoABC#2)
// getPartActionOffset = "_-0tW" (String#16180, DoABC#2)
// convertToGrayscale = "_-0ev" (String#4407, DoABC#2)
// setActionsToParts = "_-0L7" (String#3981, DoABC#2)
// addActionData = "_-TE" (String#8272, DoABC#2)
// errorThis = "_-1oM" (String#5827, DoABC#2)
// setActionToParts = "_-cI" (String#8461, DoABC#2)
// avatarSpriteData = "_-13z" (String#4955, DoABC#2)
// logThis = "_-mY" (String#8654, DoABC#2)
// petBreed = "_-2bx" (String#6794, DoABC#2)
// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// AvatarScaleType = "_-2lF" (String#20893, DoABC#2)
// IAvatarFigureContainer = "_-2-D" (String#6034, DoABC#2)
// PetImage = "_-0in" (String#4477, DoABC#2)
// IFigurePartSet = "_-5Y" (String#7773, DoABC#2)
// AvatarFigureContainer = "_-04P" (String#14219, DoABC#2)
// ISetType = "_-Gf" (String#8011, DoABC#2)
// AvatarStructure = "_-2PN" (String#6550, DoABC#2)
// Animation = "_-2Eu" (String#1841, DoABC#2)
// IAnimationLayerData = "_-14E" (String#4961, DoABC#2)
// ISpriteDataContainer = "_-2J5" (String#6422, DoABC#2)
// IAvatarDataContainer = "_-2OR" (String#6528, DoABC#2)
// IPartColor = "_-1dO" (String#5620, DoABC#2)
// IPetData = "_-0mZ" (String#4560, DoABC#2)
// IActiveActionData = "_-1An" (String#5087, DoABC#2)
// ActiveActionData = "_-22B" (String#6089, DoABC#2)
// AvatarImagePartContainer = "_-39w" (String#7510, DoABC#2)
// AvatarImageBodyPartContainer = "_-Mm" (String#8137, DoABC#2)
// AvatarImageCache = "_-0Nd" (String#4034, DoABC#2)
// AvatarDirectionAngle = "_-22R" (String#6097, DoABC#2)
// FigurePart = "_-2tY" (String#7149, DoABC#2)
// AvatarCanvas = "_-1UP" (String#5441, DoABC#2)
// AvatarImageBodyPartCache = "_-2Jz" (String#6441, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// _breed = "_-0BH" (String#297, DoABC#2)
// _figure = "_-20u" (String#75, DoABC#2)
// _SafeStr_4336 = "_-1wM" (String#18815, DoABC#2)
// _SafeStr_4337 = "_-1dF" (String#18025, DoABC#2)
// _SafeStr_4426 = "_-0wK" (String#594, DoABC#2)
// _disposed = "_-6m" (String#31, DoABC#2)
// _SafeStr_4445 = "_-bp" (String#23706, DoABC#2)
// _SafeStr_4446 = "_-0id" (String#15777, DoABC#2)
// _SafeStr_4447 = "_-2et" (String#20640, DoABC#2)
// _SafeStr_4448 = "_-0XY" (String#15337, DoABC#2)
// _SafeStr_4449 = "_-1yw" (String#18923, DoABC#2)
// _SafeStr_4450 = "_-0kC" (String#15839, DoABC#2)
// _SafeStr_4451 = "_-2qq" (String#21115, DoABC#2)
// _SafeStr_4452 = "_-0HK" (String#14733, DoABC#2)
// _SafeStr_4453 = "_-aY" (String#23655, DoABC#2)
// setDirectionAngle = "_-0-V" (String#3555, DoABC#2)
// _SafeStr_4457 = "_-2mY" (String#20943, DoABC#2)
// _SafeStr_4458 = "_-327" (String#21586, DoABC#2)
// updateAnimationByFrames = "_-05f" (String#3680, DoABC#2)
// isAnimating = "_-1hz" (String#5707, DoABC#2)
// getCanvasOffsets = "_-0gi" (String#4439, DoABC#2)
// getImage = "_-eg" (String#2150, DoABC#2)
// getSprites = "_-3Go" (String#7642, DoABC#2)
// getLayerData = "_-0Qg" (String#1470, DoABC#2)
// getScale = "_-1EW" (String#5151, DoABC#2)
// initActionAppends = "_-2j7" (String#6936, DoABC#2)
// appendAction = "_-1hS" (String#5696, DoABC#2)
// _SafeStr_4478 = "_-0c6" (String#15518, DoABC#2)
// _SafeStr_4479 = "_-Dm" (String#22761, DoABC#2)
// _SafeStr_4480 = "_-1Sn" (String#17614, DoABC#2)
// endActionAppends = "_-1gH" (String#5667, DoABC#2)
// _image = "_-35u" (String#78, DoABC#2)
// _petType = "_-0zB" (String#439, DoABC#2)
// petType = "_-0GK" (String#3877, DoABC#2)
// _SafeStr_5141 = "_-32J" (String#626, DoABC#2)
// actionParameter = "_-2Oa" (String#6531, DoABC#2)
// getCroppedImage = "_-2Ez" (String#6342, DoABC#2)
// _sprites = "_-2vJ" (String#455, DoABC#2)
// forceActionUpdate = "_-0qX" (String#4650, DoABC#2)
// isPlaceholder = "_-128" (String#4919, DoABC#2)
// _SafeStr_6564 = "_-1eZ" (String#18081, DoABC#2)
// getParts = "_-3DP" (String#7583, DoABC#2)
// isMainAvatarSet = "_-n8" (String#24160, DoABC#2)
// isMain = "_-00N" (String#3570, DoABC#2)
// getPartSet = "_-72" (String#7807, DoABC#2)
// getPetData = "_-2Tw" (String#6646, DoABC#2)
// petDataManager = "_-0y0" (String#4809, DoABC#2)
// getPartColor = "_-2yW" (String#7250, DoABC#2)
// _cache = "_-Fe" (String#636, DoABC#2)
// resetBodyPartCache = "_-1Hz" (String#5206, DoABC#2)
// setAction = "_-1lS" (String#18350, DoABC#2)
// getBodyPartCache = "_-35l" (String#21721, DoABC#2)
// setGeometryType = "_-2p6" (String#21045, DoABC#2)
// getImageContainer = "_-3EQ" (String#22052, DoABC#2)
// getAction = "_-e3" (String#23805, DoABC#2)
// isAnimation = "_-1QB" (String#5356, DoABC#2)
// getAnimation = "_-35m" (String#7425, DoABC#2)
// getFigure = "_-0KG" (String#3958, DoABC#2)
// assetPartDefinition = "_-1ID" (String#5210, DoABC#2)
// _SafeStr_7966 = "_-q1" (String#24274, DoABC#2)
// getFrameIndex = "_-38K" (String#21816, DoABC#2)
// renderManager = "_-2KA" (String#19812, DoABC#2)
// getActionDefinition = "_-1Yl" (String#17839, DoABC#2)
// hasAvatarData = "_-0wo" (String#4786, DoABC#2)
// hasDirectionData = "_-1O5" (String#5312, DoABC#2)
// spriteData = "_-2BE" (String#6273, DoABC#2)
// avatarData = "_-0Ip" (String#14793, DoABC#2)
// directionData = "_-0qL" (String#16063, DoABC#2)
// paletteIsGrayscale = "_-2B6" (String#6269, DoABC#2)
// _directionOffset = "_-0Rv" (String#1472, DoABC#2)
// _frameCounter = "_-2HG" (String#884, DoABC#2)
// _canvasOffsets = "_-16y" (String#1623, DoABC#2)
// _defaultAction = "_-1ni" (String#862, DoABC#2)
// sortActions = "_-OU" (String#2099, DoABC#2)
// _SafeStr_9982 = "_-Q6" (String#23254, DoABC#2)
// _SafeStr_9983 = "_-1rj" (String#18619, DoABC#2)
// _SafeStr_9991 = "_-1nY" (String#18442, DoABC#2)
// _SafeStr_9992 = "_-0D" (String#14569, DoABC#2)
// _SafeStr_9993 = "_-2ny" (String#20998, DoABC#2)
// _SafeStr_9994 = "_-1FU" (String#17094, DoABC#2)
// _SafeStr_9995 = "_-0xM" (String#16326, DoABC#2)
// _SafeStr_9996 = "_-xK" (String#24582, DoABC#2)
// _SafeStr_9997 = "_-09J" (String#14421, DoABC#2)
// _SafeStr_9998 = "_-2hU" (String#20752, DoABC#2)
// _SafeStr_9999 = "_-33t" (String#21655, DoABC#2)


