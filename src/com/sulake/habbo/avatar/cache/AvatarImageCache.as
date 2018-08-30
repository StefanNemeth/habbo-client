
package com.sulake.habbo.avatar.cache
{
    import com.sulake.habbo.avatar.AvatarStructure;
    import com.sulake.habbo.avatar.IAvatarImage;
    import com.sulake.habbo.avatar.alias.AssetAliasCollection;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.avatar.structure.AvatarCanvas;
    import com.sulake.habbo.avatar.actions.IActiveActionData;
    import com.sulake.habbo.avatar.AvatarImageBodyPartContainer;
    import com.sulake.habbo.avatar.AvatarImagePartContainer;
    import flash.geom.Point;
    import flash.display.BitmapData;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.utils.ByteArray;
    import com.sulake.habbo.avatar.palette.PaletteMap;
    import flash.utils.getTimer;
    import com.sulake.habbo.avatar.enum.GeometryType;
    import com.sulake.habbo.avatar.animation.Animation;
    import com.sulake.habbo.avatar.animation.AnimationLayerData;
    import flash.utils.Dictionary;
    import com.sulake.habbo.avatar.enum.AvatarScaleType;
    import flash.geom.ColorTransform;
    import com.sulake.habbo.avatar.enum.AvatarDirectionAngle;
    import com.sulake.habbo.avatar.enum.AvatarAction;
    import com.sulake.habbo.avatar.enum.AvatarBodyPartType;
    import flash.geom.Rectangle;

    public class AvatarImageCache 
    {

        private static const _SafeStr_7919:int = 60000;

        private var _structure:AvatarStructure;
        private var _avatar:IAvatarImage;
        private var _assets:AssetAliasCollection;
        private var _scale:String;
        private var _cache:Map;
        private var _canvas:AvatarCanvas;
        private var _disposed:Boolean;
        private var _bodyPartCache:AvatarImageBodyPartCache;
        private var _SafeStr_7921:IActiveActionData;
        private var _imageContainer:AvatarImageBodyPartContainer;
        private var _bodyPartId:String;
        private var _SafeStr_7924:AvatarImagePartContainer;
        private var _SafeStr_7925:Point;
        private var _geometryType:String;
        private var _SafeStr_7927:BitmapData;
        private var _SafeStr_7928:String;
        private var _partType:String;
        private var _partId:String;
        private var _frame:int;
        private var _asset:BitmapDataAsset;
        private var _SafeStr_7931:BitmapData;
        private var _SafeStr_7932:ByteArray;
        private var _SafeStr_7933:ImageData;
        private var _SafeStr_7934:PaletteMap;
        private var _SafeStr_7935:Array;
        private var _SafeStr_7936:Point;

        public function AvatarImageCache(_arg_1:AvatarStructure, _arg_2:IAvatarImage, _arg_3:AssetAliasCollection, _arg_4:String)
        {
            this._SafeStr_7935 = new Array();
            super();
            this._structure = _arg_1;
            this._avatar = _arg_2;
            this._assets = _arg_3;
            this._scale = _arg_4;
            this._cache = new Map();
        }
        public function dispose():void
        {
            var _local_1:AvatarImageBodyPartCache;
            var _local_2:Array;
            var _local_3:String;
            if (this._disposed){
                return;
            };
            this._structure = null;
            this._avatar = null;
            this._assets = null;
            if (this._cache != null){
                _local_2 = this._cache.getKeys();
                for each (_local_3 in _local_2) {
                    _local_1 = (this._cache.getValue(_local_3) as AvatarImageBodyPartCache);
                    if (_local_1 != null){
                        _local_1.dispose();
                    };
                };
                this._cache.dispose();
                this._cache = null;
            };
            this._canvas = null;
            this._asset = null;
            this._SafeStr_7931 = null;
            if (this._SafeStr_7927){
                this._SafeStr_7927.dispose();
            };
            this._SafeStr_7927 = null;
            this._disposed = true;
        }
        public function disposeInactiveActions(_arg_1:int=60000):void
        {
            var _local_3:AvatarImageBodyPartCache;
            var _local_5:String;
            var _local_2:int = getTimer();
            var _local_4:Array = this._cache.getKeys();
            for each (_local_5 in _local_4) {
                _local_3 = (this._cache.getValue(_local_5) as AvatarImageBodyPartCache);
                if (_local_3 != null){
                    _local_3.disposeActions(_arg_1, _local_2);
                };
            };
        }
        public function resetBodyPartCache(_arg_1:IActiveActionData):void
        {
            var _local_2:AvatarImageBodyPartCache;
            var _local_4:String;
            var _local_3:Array = this._cache.getKeys();
            for each (_local_4 in _local_3) {
                _local_2 = (this._cache.getValue(_local_4) as AvatarImageBodyPartCache);
                if (_local_2 != null){
                    _local_2.setAction(_arg_1, 0);
                };
            };
        }
        public function setDirection(_arg_1:String, _arg_2:int):void
        {
            var _local_4:AvatarImageBodyPartCache;
            var _local_5:String;
            var _local_3:Array = this._structure.getBodyPartsUnordered(_arg_1);
            for each (_local_5 in _local_3) {
                _local_4 = this.getBodyPartCache(_local_5);
                if (_local_4 != null){
                    _local_4.setDirection(_arg_2);
                };
            };
        }
        public function setAction(_arg_1:IActiveActionData, _arg_2:int):void
        {
            var _local_4:String;
            var _local_5:AvatarImageBodyPartCache;
            var _local_3:Array = this._structure.getActiveBodyPartIds(_arg_1);
            for each (_local_4 in _local_3) {
                _local_5 = this.getBodyPartCache(_local_4);
                if (_local_5 != null){
                    _local_5.setAction(_arg_1, _arg_2);
                };
            };
        }
        public function setGeometryType(_arg_1:String):void
        {
            if (this._geometryType == _arg_1){
                return;
            };
            if ((((((this._geometryType == GeometryType._SafeStr_7945)) && ((_arg_1 == GeometryType._SafeStr_7946)))) || ((((this._geometryType == GeometryType._SafeStr_7946)) && ((_arg_1 == GeometryType._SafeStr_7945)))))){
                this._geometryType = _arg_1;
                this._canvas = null;
                return;
            };
            this.disposeInactiveActions(0);
            this._geometryType = _arg_1;
            this._canvas = null;
        }
        public function getImageContainer(_arg_1:String, _arg_2:int):AvatarImageBodyPartContainer
        {
            var _local_11:int;
            var _local_12:Animation;
            var _local_13:int;
            var _local_14:AnimationLayerData;
            var _local_15:Array;
            var _local_16:Array;
            this._bodyPartCache = this.getBodyPartCache(_arg_1);
            if (this._bodyPartCache == null){
                this._bodyPartCache = new AvatarImageBodyPartCache();
                this._cache.add(_arg_1, this._bodyPartCache);
            };
            var _local_3:int = this._bodyPartCache.getDirection();
            var _local_4:int = _arg_2;
            this._SafeStr_7921 = this._bodyPartCache.getAction();
            var _local_5:IActiveActionData = this._SafeStr_7921;
            var _local_6:Array = [];
            var _local_7:Dictionary = new Dictionary();
            var _local_8:Point = new Point();
            if (!((!(this._SafeStr_7921)) || (!(this._SafeStr_7921.definition)))){
                if (this._SafeStr_7921.definition.isAnimation){
                    _local_11 = _local_3;
                    _local_12 = this._structure.getAnimation(((this._SafeStr_7921.definition.state + ".") + this._SafeStr_7921.actionParameter));
                    _local_13 = (_arg_2 - this._SafeStr_7921.startFrame);
                    if (_local_12 != null){
                        _local_14 = _local_12.getLayerData(_local_13, _arg_1, this._SafeStr_7921.overridingAction);
                        if (_local_14 != null){
                            _local_11 = (_local_3 + _local_14.directionOffset);
                            if (_local_14.directionOffset < 0){
                                if (_local_11 < 0){
                                    _local_11 = (8 + _local_11);
                                }
                                else {
                                    if (_local_11 > 7){
                                        _local_11 = (8 - _local_11);
                                    };
                                };
                            }
                            else {
                                if (_local_11 < 0){
                                    _local_11 = (_local_11 + 8);
                                }
                                else {
                                    if (_local_11 > 7){
                                        _local_11 = (_local_11 - 8);
                                    };
                                };
                            };
                            if (this._scale == AvatarScaleType._SafeStr_4336){
                                _local_8.x = _local_14.dx;
                                _local_8.y = _local_14.dy;
                            }
                            else {
                                _local_8.x = (_local_14.dx / 2);
                                _local_8.y = (_local_14.dy / 2);
                            };
                            _local_4 = _local_14.animationFrame;
                            if (_local_14.action != null){
                                this._SafeStr_7921 = _local_14.action;
                            };
                            if (_local_14.type == AnimationLayerData._SafeStr_7953){
                                if (_local_14.action != null){
                                    _local_5 = _local_14.action;
                                };
                                _local_3 = _local_11;
                            }
                            else {
                                if (_local_14.type == AnimationLayerData._SafeStr_7954){
                                    _local_3 = _local_11;
                                };
                            };
                            _local_7 = _local_14.items;
                        };
                        _local_6 = _local_12.removeData;
                    };
                };
            };
            var _local_9:AvatarImageActionCache = this._bodyPartCache.getActionCache(_local_5);
            if (_local_9 == null){
                _local_9 = new AvatarImageActionCache();
                this._bodyPartCache.updateActionCache(_local_5, _local_9);
            };
            var _local_10:AvatarImageDirectionCache = _local_9.getDirectionCache(_local_3);
            if (_local_10 == null){
                _local_15 = this._structure.getParts(_arg_1, this._avatar.getFigure(), _local_5, this._geometryType, _local_3, _local_6, _local_7);
                _local_10 = new AvatarImageDirectionCache(_local_15);
                _local_9.updateDirectionCache(_local_3, _local_10);
            };
            this._imageContainer = _local_10.getImageContainer(_local_4);
            if (this._imageContainer == null){
                _local_16 = _local_10.getPartList();
                this._imageContainer = this.renderBodyPart(_local_3, _local_16, _local_4, this._SafeStr_7921);
                if (this._imageContainer != null){
                    _local_10.updateImageContainer(this._imageContainer, _local_4);
                }
                else {
                    return (null);
                };
            };
            this._imageContainer.offset = _local_8;
            return (this._imageContainer);
        }
        public function getBodyPartCache(_arg_1:String):AvatarImageBodyPartCache
        {
            var _local_2:AvatarImageBodyPartCache = (this._cache.getValue(_arg_1) as AvatarImageBodyPartCache);
            if (_local_2 == null){
                _local_2 = new AvatarImageBodyPartCache();
                this._cache.add(_arg_1, _local_2);
            };
            return (_local_2);
        }
        private function renderBodyPart(_arg_1:int, _arg_2:Array, _arg_3:int, _arg_4:IActiveActionData):AvatarImageBodyPartContainer
        {
            var _local_7:Boolean;
            var _local_8:int;
            var _local_15:ImageData;
            var _local_16:Number;
            var _local_17:ColorTransform;
            var _local_18:ColorTransform;
            if (_arg_2 == null){
                return (null);
            };
            if (_arg_2.length == 0){
                return (null);
            };
            if (!this._canvas){
                this._canvas = this._structure.getCanvas(this._scale, this._geometryType);
                if (!this._canvas){
                    return (null);
                };
                this._SafeStr_7925 = new Point(0, (this._canvas.height - int((this._canvas.width / 4))));
            };
            var _local_5:int = _arg_1;
            var _local_6:Boolean = AvatarDirectionAngle._SafeStr_7964[_arg_1];
            var _local_9:String = _arg_4.definition.assetPartDefinition;
            var _local_10:String = _arg_4.definition.state;
            var _local_11:Boolean = (((_local_10 == AvatarAction._SafeStr_7967)) || ((_local_10 == AvatarAction._SafeStr_7966)));
            var _local_12:int = (_arg_2.length - 1);
            _local_8 = _local_12;
            while (_local_8 >= 0) {
                this._SafeStr_7924 = (_arg_2[_local_8] as AvatarImagePartContainer);
                if (!(((_arg_1 == 7)) && ((((this._SafeStr_7924._SafeStr_7968 == "fc")) || ((this._SafeStr_7924._SafeStr_7968 == "ey")))))){
                    this._bodyPartId = this._SafeStr_7924.bodyPartId;
                    this._partType = this._SafeStr_7924._SafeStr_7968;
                    this._partId = this._SafeStr_7924.partId;
                    this._frame = this._SafeStr_7924.getFrameIndex(_arg_3);
                    _local_5 = _arg_1;
                    _local_7 = false;
                    if (_local_6){
                        if ((((_local_9 == "wav")) && ((((((((this._partType == "lh")) || ((this._partType == "ls")))) || ((this._partType == "lc")))) || ((this._partType == "lhs")))))){
                            _local_7 = true;
                        }
                        else {
                            if ((((_local_9 == "drk")) && ((((((((this._partType == "rh")) || ((this._partType == "rs")))) || ((this._partType == "rc")))) || ((this._partType == "rhs")))))){
                                _local_7 = true;
                            }
                            else {
                                if ((((_local_9 == "crr")) && ((this._partType == "rhs")))){
                                    _local_7 = true;
                                }
                                else {
                                    if (this._partType == "ri"){
                                        _local_7 = true;
                                    }
                                    else {
                                        if (this._partType == "cp"){
                                            _local_7 = true;
                                        }
                                        else {
                                            if (_arg_1 == 4){
                                                _local_5 = 2;
                                            }
                                            else {
                                                if (_arg_1 == 5){
                                                    _local_5 = 1;
                                                }
                                                else {
                                                    if (_arg_1 == 6){
                                                        _local_5 = 0;
                                                    };
                                                };
                                            };
                                            if (this._SafeStr_7924.flippedPartType != this._partType){
                                                this._partType = this._SafeStr_7924.flippedPartType;
                                            };
                                        };
                                    };
                                };
                            };
                        };
                    };
                    this._SafeStr_7928 = ((((((((((this._scale + "_") + this._SafeStr_7924.action.assetPartDefinition) + "_") + this._partType) + "_") + this._partId) + "_") + _local_5) + "_") + this._frame);
                    this._asset = (this._assets.getAssetByName(this._SafeStr_7928) as BitmapDataAsset);
                    if (this._asset == null){
                        this._SafeStr_7928 = (((((((this._scale + "_std_") + this._partType) + "_") + this._partId) + "_") + _local_5) + "_0");
                        this._asset = (this._assets.getAssetByName(this._SafeStr_7928) as BitmapDataAsset);
                    };
                    if (!((!(this._asset)) || (!(this._asset.content)))){
                        if (this._SafeStr_7924.paletteMapId > -1){
                            this._SafeStr_7934 = this._structure.renderManager.paletteManager.getPalette(this._SafeStr_7924.paletteMapId);
                            if (this._SafeStr_7934 != null){
                                this._SafeStr_7931 = (this._asset.content as BitmapData);
                                this._SafeStr_7927 = new BitmapData(this._SafeStr_7931.width, this._SafeStr_7931.height);
                                this._SafeStr_7932 = this._SafeStr_7934.colorize(this._SafeStr_7931.getPixels(this._SafeStr_7931.rect));
                                this._SafeStr_7927.setPixels(this._SafeStr_7927.rect, this._SafeStr_7932);
                            }
                            else {
                                this._SafeStr_7927 = (this._asset.content as BitmapData).clone();
                            };
                        }
                        else {
                            this._SafeStr_7927 = (this._asset.content as BitmapData).clone();
                        };
                        if (this._SafeStr_7927 == null){
                            return (null);
                        };
                        if (((((_local_11) && ((((((this._bodyPartId == AvatarBodyPartType._SafeStr_7388)) || ((this._bodyPartId == AvatarBodyPartType._SafeStr_7977)))) || ((this._bodyPartId == AvatarBodyPartType._SafeStr_7976)))))) && (!((this._SafeStr_7924.color == null))))){
                            _local_16 = 0.7;
                            _local_17 = this._SafeStr_7924.color.colorTransform;
                            _local_18 = new ColorTransform((_local_17.redMultiplier * _local_16), ((_local_17.greenMultiplier * _local_16) + 0.3), ((_local_17.blueMultiplier * _local_16) + 0.3), _local_17.alphaMultiplier, 0, 0, 20);
                            this._SafeStr_7927.colorTransform(this._SafeStr_7927.rect, _local_18);
                        }
                        else {
                            if (((this._SafeStr_7924.isColorable) && (!((this._SafeStr_7924.color == null))))){
                                this._SafeStr_7927.colorTransform(this._SafeStr_7927.rect, this._SafeStr_7924.color.colorTransform);
                            };
                        };
                        if (this._SafeStr_7924.isBlendable){
                            this._SafeStr_7927.colorTransform(this._SafeStr_7927.rect, this._SafeStr_7924.blendTransform);
                        };
                        this._SafeStr_7936 = this._asset.offset.clone();
                        if (_local_7){
                            if (this._scale == AvatarScaleType._SafeStr_4336){
                                this._SafeStr_7936.x = (this._SafeStr_7936.x + 65);
                            }
                            else {
                                this._SafeStr_7936.x = (this._SafeStr_7936.x + 31);
                            };
                        };
                        this._SafeStr_7933 = new ImageData(this._SafeStr_7927, this._SafeStr_7936, _local_7);
                        this._SafeStr_7935.push(this._SafeStr_7933);
                    };
                };
                _local_8--;
            };
            if (this._SafeStr_7935.length == 0){
                return (null);
            };
            var _local_13:ImageData = this.createUnionImage(this._SafeStr_7935, _local_6);
            var _local_14:Point = new Point((-1 * _local_13.regpoint.x), (this._SafeStr_7925.y - _local_13.regpoint.y));
            if (_local_6){
                if (this._scale == AvatarScaleType._SafeStr_4336){
                    _local_14.x = (_local_14.x + 67);
                }
                else {
                    _local_14.x = (_local_14.x + 31);
                };
            };
            _local_8 = (this._SafeStr_7935.length - 1);
            while (_local_8 >= 0) {
                _local_15 = this._SafeStr_7935.pop();
                if (_local_15){
                    _local_15.dispose();
                };
                _local_8--;
            };
            return (new AvatarImageBodyPartContainer(_local_13.bitmap, _local_14));
        }
        private function createUnionImage(_arg_1:Array, _arg_2:Boolean):ImageData
        {
            var _local_4:ImageData;
            var _local_5:Point;
            var _local_6:BitmapData;
            var _local_7:Point;
            var _local_3:Rectangle = new Rectangle();
            for each (_local_4 in _arg_1) {
                _local_3 = _local_3.union(_local_4.offsetRect);
            };
            _local_5 = new Point(-(_local_3.left), -(_local_3.top));
            _local_6 = new BitmapData(_local_3.width, _local_3.height, true, 0xFFFFFF);
            for each (_local_4 in _arg_1) {
                _local_7 = _local_5.subtract(_local_4.regpoint);
                _local_6.copyPixels(_local_4.bitmap, _local_4.bitmap.rect, _local_7, null, null, true);
            };
            return (new ImageData(_local_6, _local_5, _arg_2));
        }
        private function debugInfo(_arg_1:String):void
        {
            Logger.log(("[AvatarImagecache] " + _arg_1));
        }

    }
}//package com.sulake.habbo.avatar.cache

// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// AvatarScaleType = "_-2lF" (String#20893, DoABC#2)
// AvatarStructure = "_-2PN" (String#6550, DoABC#2)
// Animation = "_-2Eu" (String#1841, DoABC#2)
// IActiveActionData = "_-1An" (String#5087, DoABC#2)
// AvatarImagePartContainer = "_-39w" (String#7510, DoABC#2)
// AvatarImageBodyPartContainer = "_-Mm" (String#8137, DoABC#2)
// AvatarImageCache = "_-0Nd" (String#4034, DoABC#2)
// AvatarDirectionAngle = "_-22R" (String#6097, DoABC#2)
// AvatarCanvas = "_-1UP" (String#5441, DoABC#2)
// AvatarImageBodyPartCache = "_-2Jz" (String#6441, DoABC#2)
// PaletteMap = "_-2DD" (String#6308, DoABC#2)
// AnimationLayerData = "_-3DH" (String#919, DoABC#2)
// AvatarImageDirectionCache = "_-Qp" (String#8223, DoABC#2)
// ImageData = "_-1z4" (String#6017, DoABC#2)
// GeometryType = "_-1WS" (String#5479, DoABC#2)
// AvatarBodyPartType = "_-FF" (String#7975, DoABC#2)
// AvatarImageActionCache = "_-wn" (String#8822, DoABC#2)
// _avatar = "_-0GT" (String#3883, DoABC#2)
// _asset = "_-1S7" (String#442, DoABC#2)
// _SafeStr_4336 = "_-1wM" (String#18815, DoABC#2)
// getLayerData = "_-0Qg" (String#1470, DoABC#2)
// animationFrame = "_-gS" (String#8520, DoABC#2)
// directionOffset = "_-25H" (String#6148, DoABC#2)
// _canvas = "_-0Xp" (String#588, DoABC#2)
// actionParameter = "_-2Oa" (String#6531, DoABC#2)
// getParts = "_-3DP" (String#7583, DoABC#2)
// isColorable = "_-0df" (String#4384, DoABC#2)
// _SafeStr_7388 = "_-0YE" (String#15366, DoABC#2)
// _SafeStr_7919 = "_-3KT" (String#22303, DoABC#2)
// _cache = "_-Fe" (String#636, DoABC#2)
// _SafeStr_7921 = "_-2bn" (String#20514, DoABC#2)
// _imageContainer = "_-3AP" (String#2014, DoABC#2)
// _bodyPartId = "_-Ys" (String#8390, DoABC#2)
// _SafeStr_7924 = "_-kj" (String#24058, DoABC#2)
// _SafeStr_7925 = "_-0Yt" (String#15397, DoABC#2)
// _geometryType = "_-2pF" (String#7065, DoABC#2)
// _SafeStr_7927 = "_-2pY" (String#21060, DoABC#2)
// _SafeStr_7928 = "_-2MT" (String#19905, DoABC#2)
// _partType = "_-0tU" (String#4717, DoABC#2)
// _partId = "_-4y" (String#7763, DoABC#2)
// _SafeStr_7931 = "_-0EQ" (String#14624, DoABC#2)
// _SafeStr_7932 = "_-2OE" (String#19975, DoABC#2)
// _SafeStr_7933 = "_-1-" (String#16428, DoABC#2)
// _SafeStr_7934 = "_-0Q3" (String#4095, DoABC#2)
// _SafeStr_7935 = "_-1Uh" (String#17692, DoABC#2)
// _SafeStr_7936 = "_-0w5" (String#16276, DoABC#2)
// disposeInactiveActions = "_-2TG" (String#20174, DoABC#2)
// disposeActions = "_-04s" (String#14236, DoABC#2)
// resetBodyPartCache = "_-1Hz" (String#5206, DoABC#2)
// setAction = "_-1lS" (String#18350, DoABC#2)
// getBodyPartsUnordered = "_-1Eq" (String#17063, DoABC#2)
// getBodyPartCache = "_-35l" (String#21721, DoABC#2)
// getActiveBodyPartIds = "_-1Mf" (String#17387, DoABC#2)
// setGeometryType = "_-2p6" (String#21045, DoABC#2)
// _SafeStr_7945 = "_-37f" (String#21793, DoABC#2)
// _SafeStr_7946 = "_-14R" (String#16633, DoABC#2)
// getImageContainer = "_-3EQ" (String#22052, DoABC#2)
// getAction = "_-e3" (String#23805, DoABC#2)
// isAnimation = "_-1QB" (String#5356, DoABC#2)
// getAnimation = "_-35m" (String#7425, DoABC#2)
// startFrame = "_-1Rg" (String#5390, DoABC#2)
// overridingAction = "_-3Dz" (String#7595, DoABC#2)
// _SafeStr_7953 = "_-2oY" (String#21026, DoABC#2)
// _SafeStr_7954 = "_-dN" (String#23775, DoABC#2)
// removeData = "_-09h" (String#3752, DoABC#2)
// getActionCache = "_-1EO" (String#17042, DoABC#2)
// updateActionCache = "_-1rM" (String#18598, DoABC#2)
// getDirectionCache = "_-K0" (String#23006, DoABC#2)
// getFigure = "_-0KG" (String#3958, DoABC#2)
// updateDirectionCache = "_-0ew" (String#15624, DoABC#2)
// getPartList = "_-0Rg" (String#15127, DoABC#2)
// renderBodyPart = "_-2iz" (String#20805, DoABC#2)
// updateImageContainer = "_-0ya" (String#16377, DoABC#2)
// _SafeStr_7964 = "_-1Cu" (String#16978, DoABC#2)
// assetPartDefinition = "_-1ID" (String#5210, DoABC#2)
// _SafeStr_7966 = "_-q1" (String#24274, DoABC#2)
// _SafeStr_7967 = "_-2fy" (String#20690, DoABC#2)
// _SafeStr_7968 = "include" (String#45700, DoABC#2)
// bodyPartId = "_-219" (String#19057, DoABC#2)
// partId = "_-0hk" (String#15738, DoABC#2)
// getFrameIndex = "_-38K" (String#21816, DoABC#2)
// flippedPartType = "_-39x" (String#21882, DoABC#2)
// paletteMapId = "_-0GZ" (String#14702, DoABC#2)
// paletteManager = "_-0SL" (String#15148, DoABC#2)
// renderManager = "_-2KA" (String#19812, DoABC#2)
// _SafeStr_7976 = "_-Ce" (String#22710, DoABC#2)
// _SafeStr_7977 = "_-1t" (String#18677, DoABC#2)
// isBlendable = "_-2Ao" (String#19434, DoABC#2)
// blendTransform = "_-qp" (String#24308, DoABC#2)
// createUnionImage = "_-2U0" (String#20199, DoABC#2)
// regpoint = "_-3Dc" (String#22018, DoABC#2)
// offsetRect = "_-2sG" (String#21169, DoABC#2)
// debugInfo = "_-3g" (String#924, DoABC#2)


