
package com.sulake.habbo.avatar
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.avatar.enum.AvatarSetType;
    import com.sulake.habbo.avatar.actions.IActiveActionData;
    import com.sulake.habbo.avatar.alias.AssetAliasCollection;
    import com.sulake.habbo.avatar.cache.AvatarImageCache;
    import com.sulake.habbo.avatar.animation.IAvatarDataContainer;
    import flash.display.BitmapData;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.avatar.enum.AvatarScaleType;
    import com.sulake.habbo.avatar.actions.ActiveActionData;
    import com.sulake.habbo.avatar.enum.AvatarAction;
    import com.sulake.habbo.avatar.structure.figure.IPartColor;
    import com.sulake.habbo.avatar.enum.AvatarDirectionAngle;
    import com.sulake.habbo.avatar.animation.ISpriteDataContainer;
    import com.sulake.habbo.avatar.animation.IAnimationLayerData;
    import flash.geom.Point;
    import com.sulake.habbo.avatar.structure.AvatarCanvas;
    import flash.geom.Rectangle;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.habbo.avatar.actions.ActionDefinition;
    import com.sulake.habbo.avatar.actions.IActionDefinition;
    import com.sulake.habbo.avatar.animation.Animation;
    import flash.utils.getTimer;
    import flash.filters.ColorMatrixFilter;

    public class AvatarImage implements IAvatarImage, IDisposable 
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
        protected var _SafeStr_10077:int;
        protected var _SafeStr_4349:int;
        protected var _SafeStr_10078:IActiveActionData;
        protected var _disposed:Boolean;
        protected var _SafeStr_9904:Array;
        protected var _assets:AssetAliasCollection;
        protected var _SafeStr_7920:AvatarImageCache;
        protected var _figure:AvatarFigureContainer;
        protected var _avatarSpriteData:IAvatarDataContainer;
        protected var _SafeStr_5141:Array;
        protected var _image:BitmapData;
        private var _SafeStr_9918:IActiveActionData;
        private var _frameCounter:int = 0;
        private var _directionOffset:int = 0;
        private var _SafeStr_10079:Boolean;
        private var _sprites:Array;
        private var _SafeStr_4426:Boolean;
        private var _SafeStr_10081:Boolean = false;
        private var _SafeStr_10131:Array;
        private var _SafeStr_10084:String;
        private var _SafeStr_10085:String;
        private var _SafeStr_10132:Map;
        protected var _SafeStr_10133:Boolean = false;
        private var _SafeStr_10134:Boolean;
        private var _SafeStr_10135:int = -1;
        private var _SafeStr_10086:int;
        private var _SafeStr_10087:int;
        private var _SafeStr_10136:Array;
        private var _SafeStr_10137:int = -1;
        private var _SafeStr_10138:String = null;
        private var _SafeStr_10139:String = null;

        public function AvatarImage(_arg_1:AvatarStructure, _arg_2:AssetAliasCollection, _arg_3:AvatarFigureContainer, _arg_4:String)
        {
            this._SafeStr_9904 = new Array();
            this._SafeStr_5141 = [];
            this._SafeStr_10136 = [];
            super();
            this._SafeStr_10079 = true;
            this._structure = _arg_1;
            this._assets = _arg_2;
            this._scale = _arg_4;
            if (this._scale == null){
                this._scale = AvatarScaleType._SafeStr_4336;
            };
            if (_arg_3 == null){
                _arg_3 = new AvatarFigureContainer("hr-893-45.hd-180-2.ch-210-66.lg-270-82.sh-300-91.wa-2007-.ri-1-");
                Logger.log("Using default avatar figure");
            };
            this._figure = _arg_3;
            this._SafeStr_7920 = new AvatarImageCache(this._structure, this, this._assets, this._scale);
            this.setDirection(_SafeStr_10076, _SafeStr_10075);
            this._SafeStr_5141 = new Array();
            this._SafeStr_9918 = new ActiveActionData(AvatarAction._SafeStr_10001);
            this._SafeStr_9918.definition = this._structure.getActionDefinition(_SafeStr_10074);
            this.resetActions();
            this._SafeStr_10132 = new Map();
        }
        public function dispose():void
        {
            var _local_1:AvatarImageCache;
            var _local_2:BitmapData;
            if (!this._disposed){
                this._structure = null;
                this._assets = null;
                this._SafeStr_7920 = null;
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
                if (this._SafeStr_10132){
                    for each (_local_2 in this._SafeStr_10132) {
                        _local_2.dispose();
                    };
                    this._SafeStr_10132.dispose();
                    this._SafeStr_10132 = null;
                };
                this._image = null;
                this._SafeStr_9904 = null;
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
        public function getPartColor(_arg_1:String):IPartColor
        {
            return (this._structure.getPartColor(this._figure, _arg_1));
        }
        public function setDirection(_arg_1:String, _arg_2:int):void
        {
            _arg_2 = (_arg_2 + this._directionOffset);
            if (_arg_2 < AvatarDirectionAngle._SafeStr_9982){
                _arg_2 = (AvatarDirectionAngle._SafeStr_9983 + (_arg_2 + 1));
            };
            if (_arg_2 > AvatarDirectionAngle._SafeStr_9983){
                _arg_2 = (_arg_2 - (AvatarDirectionAngle._SafeStr_9983 + 1));
            };
            if (this._structure.isMainAvatarSet(_arg_1)){
                this._SafeStr_10077 = _arg_2;
            };
            if ((((_arg_1 == AvatarSetType._SafeStr_4458)) || ((_arg_1 == AvatarSetType._SafeStr_4457)))){
                if ((((_arg_1 == AvatarSetType._SafeStr_4458)) && (this.isHeadTurnPreventedByAction()))){
                    _arg_2 = this._SafeStr_10077;
                };
                this._SafeStr_4349 = _arg_2;
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
            return (this._SafeStr_9904);
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
        private function getFullImageCacheKey():String
        {
            var _local_1:IActiveActionData;
            var _local_2:int;
            if (!this._SafeStr_10134){
                return (null);
            };
            if ((((this._SafeStr_10131.length == 1)) && ((this._SafeStr_10077 == this._SafeStr_4349)))){
                return (((this._SafeStr_10077 + this._SafeStr_10085) + (this._frameCounter % 4)));
            };
            if (this._SafeStr_10131.length == 2){
                for each (_local_1 in this._SafeStr_10131) {
                    if ((((_local_1.actionType == "fx")) && ((((((((_local_1.actionParameter == "33")) || ((_local_1.actionParameter == "34")))) || ((_local_1.actionParameter == "35")))) || ((_local_1.actionParameter == "36")))))){
                        return (((this._SafeStr_10077 + this._SafeStr_10085) + 0));
                    };
                    if ((((_local_1.actionType == "fx")) && ((((_local_1.actionParameter == "38")) || ((_local_1.actionParameter == "39")))))){
                        _local_2 = (this._frameCounter % 11);
                        return (((((this._SafeStr_10077 + "_") + this._SafeStr_4349) + this._SafeStr_10085) + _local_2));
                    };
                };
            };
            return (null);
        }
        private function getBodyParts(_arg_1:String, _arg_2:String, _arg_3:int):Array
        {
            if (((((!((_arg_3 == this._SafeStr_10137))) || (!((_arg_2 == this._SafeStr_10138))))) || (!((_arg_1 == this._SafeStr_10139))))){
                this._SafeStr_10137 = _arg_3;
                this._SafeStr_10138 = _arg_2;
                this._SafeStr_10139 = _arg_1;
                this._SafeStr_10136 = this._structure.getBodyParts(_arg_1, _arg_2, _arg_3);
            };
            return (this._SafeStr_10136);
        }
        public function getImage(_arg_1:String, _arg_2:Boolean):BitmapData
        {
            var _local_8:String;
            var _local_9:AvatarImageBodyPartContainer;
            var _local_10:BitmapData;
            var _local_11:Point;
            var _local_13:BitmapData;
            if (!this._SafeStr_10079){
                return (this._image);
            };
            if (this._SafeStr_10078 == null){
                return (null);
            };
            if (!this._SafeStr_10081){
                this.endActionAppends();
            };
            var _local_3:String = this.getFullImageCacheKey();
            if (_local_3 != null){
                if (this.getFullImage(_local_3)){
                    this._SafeStr_10079 = false;
                    if (_arg_2){
                        return ((this.getFullImage(_local_3) as BitmapData).clone());
                    };
                    this._image = (this.getFullImage(_local_3) as BitmapData);
                    this._SafeStr_10133 = true;
                    return (this._image);
                };
            };
            var _local_4:AvatarImageCache = this.getCache();
            var _local_5:AvatarCanvas = this._structure.getCanvas(this._scale, this._SafeStr_10078.definition.geometryType);
            if (_local_5 == null){
                return (null);
            };
            if (((((this._SafeStr_10133) || ((this._image == null)))) || (((!((this._image.width == _local_5.width))) || (!((this._image.height == _local_5.height))))))){
                if (((!((this._image == null))) && (!(this._SafeStr_10133)))){
                    this._image.dispose();
                };
                this._image = new BitmapData(_local_5.width, _local_5.height, true, 0xFFFFFF);
                this._SafeStr_10133 = false;
            };
            var _local_6:Array = this.getBodyParts(_arg_1, this._SafeStr_10078.definition.geometryType, this._SafeStr_10077);
            this._image.lock();
            this._image.fillRect(this._image.rect, 0xFFFFFF);
            var _local_7:Point = _local_5.offset;
            if (_local_7 == null){
                _local_7 = new Point(0, 0);
            };
            var _local_12:int = (_local_6.length - 1);
            while (_local_12 >= 0) {
                _local_8 = _local_6[_local_12];
                _local_9 = _local_4.getImageContainer(_local_8, this._frameCounter);
                if (((((_local_9) && (_local_9.image))) && (_local_9.regPoint))){
                    _local_10 = _local_9.image;
                    _local_11 = _local_9.regPoint.clone();
                    this._image.copyPixels(_local_10, _local_10.rect, _local_11.add(_local_7), null, null, true);
                };
                _local_12--;
            };
            this._image.unlock();
            this._SafeStr_10079 = false;
            if (this._avatarSpriteData != null){
                if (this._avatarSpriteData.paletteIsGrayscale){
                    _local_13 = this.convertToGrayscale(this._image);
                    if (this._image){
                        this._image.dispose();
                    };
                    this._image = _local_13;
                    this._image.paletteMap(this._image, this._image.rect, new Point(0, 0), this._avatarSpriteData.reds, [], []);
                }
                else {
                    this._image.copyChannel(this._image, this._image.rect, new Point(0, 0), 2, 8);
                };
            };
            if (_local_3 != null){
                this.cacheFullImage(_local_3, this._image.clone());
            };
            if (((this._image) && (_arg_2))){
                return (this._image.clone());
            };
            return (this._image);
        }
        public function getCroppedImage(_arg_1:String):BitmapData
        {
            var _local_6:Rectangle;
            var _local_7:String;
            var _local_8:AvatarImageBodyPartContainer;
            var _local_9:BitmapData;
            var _local_10:Point;
            if (this._SafeStr_10078 == null){
                return (null);
            };
            var _local_2:AvatarImageCache = this.getCache();
            var _local_3:AvatarCanvas = this._structure.getCanvas(this._scale, this._SafeStr_10078.definition.geometryType);
            if (_local_3 == null){
                return (null);
            };
            var _local_4:BitmapData = new BitmapData(_local_3.width, _local_3.height, true, 0xFFFFFF);
            var _local_5:Array = this._structure.getBodyParts(_arg_1, this._SafeStr_10078.definition.geometryType, this._SafeStr_10077);
            var _local_11:Rectangle = new Rectangle();
            var _local_12:int = (_local_5.length - 1);
            while (_local_12 >= 0) {
                _local_7 = _local_5[_local_12];
                _local_8 = _local_2.getImageContainer(_local_7, this._frameCounter);
                if (_local_8 != null){
                    _local_9 = _local_8.image;
                    if (_local_9 == null){
                        _local_4.dispose();
                        return (null);
                    };
                    _local_10 = _local_8.regPoint.clone();
                    _local_4.copyPixels(_local_9, _local_9.rect, _local_10, null, null, true);
                    _local_11.x = _local_10.x;
                    _local_11.y = _local_10.y;
                    _local_11.width = _local_9.width;
                    _local_11.height = _local_9.height;
                    if (_local_6 == null){
                        _local_6 = _local_11;
                    }
                    else {
                        _local_6 = _local_6.union(_local_11);
                    };
                };
                _local_12--;
            };
            if (_local_6 == null){
                _local_6 = new Rectangle(0, 0, 1, 1);
            };
            var _local_13:BitmapData = new BitmapData(_local_6.width, _local_6.height, true, 0xFFFFFF);
            _local_13.copyPixels(_local_4, _local_6, new Point(0, 0), null, null, true);
            _local_4.dispose();
            return (_local_13);
        }
        protected function getFullImage(_arg_1:String):BitmapData
        {
            return (this._SafeStr_10132[_arg_1]);
        }
        protected function cacheFullImage(_arg_1:String, _arg_2:BitmapData):void
        {
            this._SafeStr_10132[_arg_1] = _arg_2;
        }
        public function getAsset(_arg_1:String):BitmapDataAsset
        {
            return ((this._assets.getAssetByName(_arg_1) as BitmapDataAsset));
        }
        public function getDirection():int
        {
            return (this._SafeStr_10077);
        }
        public function initActionAppends():void
        {
            this._SafeStr_5141 = new Array();
            this._SafeStr_10081 = false;
            this._SafeStr_10085 = "";
            this._SafeStr_10134 = false;
        }
        public function endActionAppends():void
        {
            if (this.sortActions()){
                this.resetActions();
                this.setActionsToParts();
            };
        }
        public function appendAction(_arg_1:String, ... _args):Boolean
        {
            var _local_3:String;
            var _local_4:ActionDefinition;
            this._SafeStr_10081 = false;
            if (((!((_args == null))) && ((_args.length > 0)))){
                _local_3 = _args[0];
            };
            switch (_arg_1){
                case AvatarAction._SafeStr_4478:
                    switch (_local_3){
                        case AvatarAction._SafeStr_10003:
                            if (this._SafeStr_10077 == 0){
                                this.setDirection(AvatarSetType._SafeStr_4457, 4);
                            }
                            else {
                                this.setDirection(AvatarSetType._SafeStr_4457, 2);
                            };
                        case AvatarAction._SafeStr_4445:
                            this._SafeStr_10134 = true;
                        case AvatarAction._SafeStr_10001:
                            this._SafeStr_10134 = true;
                        case AvatarAction._SafeStr_7967:
                        case AvatarAction._SafeStr_7966:
                        case AvatarAction._SafeStr_10002:
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
                            this.addActionData(_local_3);
                            break;
                        default:
                            this.errorThis(("appendAction() >> UNKNOWN GESTURE TYPE: " + _local_3));
                    };
                    break;
                case AvatarAction._SafeStr_6564:
                    if ((((((((((((_local_3 == "33")) || ((_local_3 == "34")))) || ((_local_3 == "35")))) || ((_local_3 == "36")))) || ((_local_3 == "38")))) || ((_local_3 == "39")))){
                        this._SafeStr_10134 = true;
                    };
                case AvatarAction.RSDE_DANCE:
                case AvatarAction._SafeStr_4452:
                case AvatarAction._SafeStr_4453:
                case AvatarAction._SafeStr_4480:
                case AvatarAction._SafeStr_6561:
                    this.addActionData(_arg_1, _local_3);
                    break;
                case AvatarAction._SafeStr_6562:
                case AvatarAction._SafeStr_6563:
                    _local_4 = this._structure.getActionDefinitionWithState(_arg_1);
                    if (_local_4 != null){
                        this.logThis(("appendAction:" + [_local_3, "->", _local_4.getParameterValue(_local_3)]));
                        _local_3 = _local_4.getParameterValue(_local_3);
                    };
                    this.addActionData(_arg_1, _local_3);
                    break;
                default:
                    this.errorThis(("appendAction() >> UNKNOWN ACTION TYPE: " + _arg_1));
            };
            return (true);
        }
        protected function addActionData(_arg_1:String, _arg_2:String=""):void
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
            this._SafeStr_5141.push(new ActiveActionData(_arg_1, _arg_2, this._frameCounter));
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
            this._structure.removeDynamicItems();
            this._SafeStr_10078 = this._SafeStr_9918;
            this._SafeStr_10078.definition = this._SafeStr_9918.definition;
            this.resetBodyPartCache(this._SafeStr_9918);
            return (true);
        }
        private function isHeadTurnPreventedByAction():Boolean
        {
            var _local_2:IActionDefinition;
            var _local_3:ActiveActionData;
            var _local_1:Boolean;
            if (this._SafeStr_10131 == null){
                return (false);
            };
            for each (_local_3 in this._SafeStr_10131) {
                _local_2 = this._structure.getActionDefinitionWithState(_local_3.actionType);
                if (((!((_local_2 == null))) && (_local_2.getPreventHeadTurn(_local_3.actionParameter)))){
                    _local_1 = true;
                };
            };
            return (_local_1);
        }
        private function sortActions():Boolean
        {
            var _local_2:Boolean;
            var _local_3:Boolean;
            var _local_4:ActiveActionData;
            var _local_5:int;
            var _local_6:AvatarImageCache;
            var _local_1:Boolean;
            this._SafeStr_10085 = "";
            this._SafeStr_10131 = this._structure.sortActions(this._SafeStr_5141);
            if (this._SafeStr_10131 == null){
                this._SafeStr_9904 = new Array(0, 0, 0);
                if (this._SafeStr_10084 != ""){
                    _local_1 = true;
                    this._SafeStr_10084 = "";
                };
            }
            else {
                this._SafeStr_9904 = this._structure.getCanvasOffsets(this._SafeStr_10131, this._scale, this._SafeStr_10077);
                for each (_local_4 in this._SafeStr_10131) {
                    this._SafeStr_10085 = (this._SafeStr_10085 + (_local_4.actionType + _local_4.actionParameter));
                    if (_local_4.actionType == AvatarAction._SafeStr_6564){
                        _local_5 = parseInt(_local_4.actionParameter);
                        if (this._SafeStr_10135 != _local_5){
                            _local_2 = true;
                        };
                        this._SafeStr_10135 = _local_5;
                        _local_3 = true;
                    };
                };
                if (!_local_3){
                    if (this._SafeStr_10135 > -1){
                        _local_2 = true;
                    };
                    this._SafeStr_10135 = -1;
                };
                if (_local_2){
                    _local_6 = this.getCache();
                    if (_local_6){
                        _local_6.disposeInactiveActions(0);
                    };
                };
                if (this._SafeStr_10084 != this._SafeStr_10085){
                    _local_1 = true;
                    this._SafeStr_10084 = this._SafeStr_10085;
                };
            };
            this._SafeStr_10081 = true;
            return (_local_1);
        }
        private function setActionsToParts():void
        {
            var _local_1:ActiveActionData;
            var _local_2:Animation;
            var _local_5:Array;
            var _local_6:String;
            if (this._SafeStr_10131 == null){
                return;
            };
            var _local_3:int = getTimer();
            var _local_4:Array = new Array();
            for each (_local_1 in this._SafeStr_10131) {
                _local_4.push(_local_1.actionType);
            };
            for each (_local_1 in this._SafeStr_10131) {
                if (((((_local_1) && (_local_1.definition))) && (_local_1.definition.isAnimation))){
                    _local_2 = this._structure.getAnimation(((_local_1.definition.state + ".") + _local_1.actionParameter));
                    if (((_local_2) && (_local_2.hasOverriddenActions()))){
                        _local_5 = _local_2.overriddenActionNames();
                        if (_local_5){
                            for each (_local_6 in _local_5) {
                                if (_local_4.indexOf(_local_6) >= 0){
                                    _local_1.overridingAction = _local_2.overridingAction(_local_6);
                                };
                            };
                        };
                    };
                };
            };
            for each (_local_1 in this._SafeStr_10131) {
                if (!((!(_local_1)) || (!(_local_1.definition)))){
                    if (((_local_1.definition.isAnimation) && ((_local_1.actionParameter == "")))){
                        _local_1.actionParameter = "1";
                    };
                    this.setActionToParts(_local_1, _local_3);
                    if (_local_1.definition.isAnimation){
                        this._SafeStr_4426 = _local_1.definition.isAnimated(_local_1.actionParameter);
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
                    if ((((((_local_1.actionType == AvatarAction._SafeStr_4452)) || ((_local_1.actionType == AvatarAction._SafeStr_4453)))) || ((_local_1.actionType == AvatarAction._SafeStr_7966)))){
                        this._SafeStr_4426 = true;
                    };
                };
            };
        }
        protected function getCache():AvatarImageCache
        {
            if (this._SafeStr_7920 == null){
                this._SafeStr_7920 = new AvatarImageCache(this._structure, this, this._assets, this._scale);
            };
            return (this._SafeStr_7920);
        }
        private function setActionToParts(_arg_1:IActiveActionData, _arg_2:int):void
        {
            if ((((_arg_1 == null)) || ((_arg_1.definition == null)))){
                return;
            };
            if (_arg_1.definition.assetPartDefinition == ""){
                return;
            };
            if (_arg_1.definition.isMain){
                this._SafeStr_10078 = _arg_1;
                this.getCache().setGeometryType(_arg_1.definition.geometryType);
            };
            this.getCache().setAction(_arg_1, _arg_2);
            this._SafeStr_10079 = true;
        }
        private function resetBodyPartCache(_arg_1:IActiveActionData):void
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
            this.getCache().resetBodyPartCache(_arg_1);
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
            Logger.log(("[AvatarImageError] " + _arg_1));
        }
        private function logThis(_arg_1:String):void
        {
        }
        public function getSubType():int
        {
            return (-1);
        }
        public function get petType():int
        {
            return (-1);
        }
        public function get petBreed():int
        {
            return (-1);
        }
        public function isPlaceholder():Boolean
        {
            return (false);
        }
        public function forceActionUpdate():void
        {
            this._SafeStr_10084 = "";
        }

    }
}//package com.sulake.habbo.avatar

// _SafeStr_10001 = "_-Cl" (String#22715, DoABC#2)
// _SafeStr_10002 = "_-16w" (String#16732, DoABC#2)
// _SafeStr_10003 = "_-2r3" (String#21122, DoABC#2)
// _SafeStr_10074 = "_-2ex" (String#6851, DoABC#2)
// _SafeStr_10075 = "_-LW" (String#8114, DoABC#2)
// _SafeStr_10076 = "_-2I4" (String#6405, DoABC#2)
// _SafeStr_10077 = "_-2jr" (String#6951, DoABC#2)
// _SafeStr_10078 = "_-0hg" (String#4461, DoABC#2)
// _SafeStr_10079 = "_-6O" (String#7791, DoABC#2)
// _avatarSpriteData = "_-1aN" (String#5566, DoABC#2)
// _SafeStr_10081 = "_-1ty" (String#5919, DoABC#2)
// _SafeStr_10084 = "_-5f" (String#7776, DoABC#2)
// _SafeStr_10085 = "_-020" (String#3604, DoABC#2)
// _SafeStr_10086 = "_-2wW" (String#7214, DoABC#2)
// _SafeStr_10087 = "_-00p" (String#3579, DoABC#2)
// resetActions = "_-213" (String#6068, DoABC#2)
// getCache = "_-CE" (String#7919, DoABC#2)
// getSubType = "_-0Cx" (String#3807, DoABC#2)
// getBodyPartData = "_-0FK" (String#14657, DoABC#2)
// regPoint = "_-UQ" (String#23428, DoABC#2)
// convertToGrayscale = "_-0ev" (String#4407, DoABC#2)
// setActionsToParts = "_-0L7" (String#3981, DoABC#2)
// addActionData = "_-TE" (String#8272, DoABC#2)
// errorThis = "_-1oM" (String#5827, DoABC#2)
// setActionToParts = "_-cI" (String#8461, DoABC#2)
// avatarSpriteData = "_-13z" (String#4955, DoABC#2)
// logThis = "_-mY" (String#8654, DoABC#2)
// petBreed = "_-2bx" (String#6794, DoABC#2)
// _SafeStr_10131 = "_-1rH" (String#18594, DoABC#2)
// _SafeStr_10132 = "_-0CY" (String#3801, DoABC#2)
// _SafeStr_10133 = "_-0-3" (String#14013, DoABC#2)
// _SafeStr_10134 = "_-2lZ" (String#20901, DoABC#2)
// _SafeStr_10135 = "_-14l" (String#16644, DoABC#2)
// _SafeStr_10136 = "_-2zy" (String#21459, DoABC#2)
// _SafeStr_10137 = "_-1Ba" (String#16922, DoABC#2)
// _SafeStr_10138 = "_-qx" (String#24313, DoABC#2)
// _SafeStr_10139 = "_-2EH" (String#19578, DoABC#2)
// isHeadTurnPreventedByAction = "_-1I9" (String#17199, DoABC#2)
// getFullImageCacheKey = "_-2ts" (String#21233, DoABC#2)
// getFullImage = "_-0Zd" (String#4291, DoABC#2)
// cacheFullImage = "_-04v" (String#3663, DoABC#2)
// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// AvatarScaleType = "_-2lF" (String#20893, DoABC#2)
// IAvatarFigureContainer = "_-2-D" (String#6034, DoABC#2)
// AvatarFigureContainer = "_-04P" (String#14219, DoABC#2)
// AvatarImage = "_-as" (String#8437, DoABC#2)
// AvatarStructure = "_-2PN" (String#6550, DoABC#2)
// Animation = "_-2Eu" (String#1841, DoABC#2)
// IAnimationLayerData = "_-14E" (String#4961, DoABC#2)
// ISpriteDataContainer = "_-2J5" (String#6422, DoABC#2)
// IAvatarDataContainer = "_-2OR" (String#6528, DoABC#2)
// IPartColor = "_-1dO" (String#5620, DoABC#2)
// ActionDefinition = "_-1nw" (String#864, DoABC#2)
// IActiveActionData = "_-1An" (String#5087, DoABC#2)
// ActiveActionData = "_-22B" (String#6089, DoABC#2)
// AvatarImageBodyPartContainer = "_-Mm" (String#8137, DoABC#2)
// AvatarImageCache = "_-0Nd" (String#4034, DoABC#2)
// AvatarDirectionAngle = "_-22R" (String#6097, DoABC#2)
// AvatarCanvas = "_-1UP" (String#5441, DoABC#2)
// IActionDefinition = "_-2ON" (String#6527, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// _figure = "_-20u" (String#75, DoABC#2)
// _SafeStr_4336 = "_-1wM" (String#18815, DoABC#2)
// _SafeStr_4349 = "_-Ra" (String#8239, DoABC#2)
// _SafeStr_4426 = "_-0wK" (String#594, DoABC#2)
// _disposed = "_-6m" (String#31, DoABC#2)
// _SafeStr_4445 = "_-bp" (String#23706, DoABC#2)
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
// RSDE_DANCE = "_-0-n" (String#14045, DoABC#2)
// petType = "_-0GK" (String#3877, DoABC#2)
// _SafeStr_5141 = "_-32J" (String#626, DoABC#2)
// actionParameter = "_-2Oa" (String#6531, DoABC#2)
// getCroppedImage = "_-2Ez" (String#6342, DoABC#2)
// _sprites = "_-2vJ" (String#455, DoABC#2)
// forceActionUpdate = "_-0qX" (String#4650, DoABC#2)
// isPlaceholder = "_-128" (String#4919, DoABC#2)
// _SafeStr_6561 = "_-Ne" (String#23151, DoABC#2)
// _SafeStr_6562 = "_-R2" (String#23284, DoABC#2)
// _SafeStr_6563 = "_-07B" (String#14332, DoABC#2)
// _SafeStr_6564 = "_-1eZ" (String#18081, DoABC#2)
// removeDynamicItems = "_-1W" (String#17742, DoABC#2)
// isMainAvatarSet = "_-n8" (String#24160, DoABC#2)
// isMain = "_-00N" (String#3570, DoABC#2)
// getPartColor = "_-2yW" (String#7250, DoABC#2)
// _SafeStr_7920 = "_-Fe" (String#636, DoABC#2)
// disposeInactiveActions = "_-2TG" (String#20174, DoABC#2)
// resetBodyPartCache = "_-1Hz" (String#5206, DoABC#2)
// setAction = "_-1lS" (String#18350, DoABC#2)
// setGeometryType = "_-2p6" (String#21045, DoABC#2)
// getImageContainer = "_-3EQ" (String#22052, DoABC#2)
// isAnimation = "_-1QB" (String#5356, DoABC#2)
// getAnimation = "_-35m" (String#7425, DoABC#2)
// overridingAction = "_-3Dz" (String#7595, DoABC#2)
// getFigure = "_-0KG" (String#3958, DoABC#2)
// assetPartDefinition = "_-1ID" (String#5210, DoABC#2)
// _SafeStr_7966 = "_-q1" (String#24274, DoABC#2)
// _SafeStr_7967 = "_-2fy" (String#20690, DoABC#2)
// getActionDefinition = "_-1Yl" (String#17839, DoABC#2)
// hasOverriddenActions = "_-1WW" (String#17760, DoABC#2)
// overriddenActionNames = "_-2OC" (String#19974, DoABC#2)
// hasAvatarData = "_-0wo" (String#4786, DoABC#2)
// hasDirectionData = "_-1O5" (String#5312, DoABC#2)
// spriteData = "_-2BE" (String#6273, DoABC#2)
// avatarData = "_-0Ip" (String#14793, DoABC#2)
// directionData = "_-0qL" (String#16063, DoABC#2)
// paletteIsGrayscale = "_-2B6" (String#6269, DoABC#2)
// _directionOffset = "_-0Rv" (String#1472, DoABC#2)
// _frameCounter = "_-2HG" (String#884, DoABC#2)
// isAnimated = "_-0q7" (String#4640, DoABC#2)
// _SafeStr_9904 = "_-16y" (String#1623, DoABC#2)
// getParameterValue = "_-1M2" (String#17360, DoABC#2)
// getPreventHeadTurn = "_-S-" (String#8246, DoABC#2)
// _SafeStr_9918 = "_-1ni" (String#862, DoABC#2)
// getActionDefinitionWithState = "_-K4" (String#23008, DoABC#2)
// sortActions = "_-OU" (String#2099, DoABC#2)
// _SafeStr_9982 = "_-Q6" (String#23254, DoABC#2)
// _SafeStr_9983 = "_-1rj" (String#18619, DoABC#2)
// _SafeStr_9991 = "_-1nY" (String#18442, DoABC#2)
// _SafeStr_9992 = "_-0D" (String#14569, DoABC#2)
// _SafeStr_9993 = "_-2ny" (String#20998, DoABC#2)
// _SafeStr_9994 = "_-1FU" (String#17094, DoABC#2)


