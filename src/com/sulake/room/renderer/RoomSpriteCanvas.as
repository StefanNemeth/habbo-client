
package com.sulake.room.renderer
{
    import flash.geom.Point;
    import com.sulake.room.utils.RoomGeometry;
    import flash.display.Sprite;
    import com.sulake.core.utils.Map;
    import com.sulake.room.renderer.cache.BitmapDataCache;
    import com.sulake.room.renderer.cache.RoomObjectCache;
    import flash.geom.ColorTransform;
    import flash.geom.Matrix;
    import flash.events.MouseEvent;
    import com.sulake.room.utils.Vector3d;
    import flash.display.DisplayObject;
    import com.sulake.room.utils.IRoomGeometry;
    import com.sulake.room.renderer.utils.ExtendedSprite;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.renderer.utils.SortableSprite;
    import flash.display.BitmapData;
    import com.sulake.room.object.visualization.IRoomObjectSpriteVisualization;
    import com.sulake.room.renderer.cache.RoomObjectCacheItem;
    import com.sulake.room.renderer.cache.RoomObjectLocationCacheItem;
    import com.sulake.room.renderer.cache.RoomObjectSortableSpriteCacheItem;
    import com.sulake.room.utils.IVector3d;
    import com.sulake.room.object.visualization.IRoomObjectSprite;
    import flash.geom.Rectangle;
    import flash.display.PixelSnapping;
    import com.sulake.room.renderer.utils.ExtendedBitmapData;
    import com.sulake.room.events.RoomSpriteMouseEvent;
    import com.sulake.room.renderer.utils.ObjectMouseData;
    import com.sulake.room.object.logic.IRoomObjectMouseHandler;
    import com.sulake.room.utils.*;

    public class RoomSpriteCanvas implements IRoomRenderingCanvas 
    {

        private static const _SafeStr_12969:Point = new Point(0, 0);
        private static const _SafeStr_14455:int = 50;
        private static const _SafeStr_14456:int = 50;
        private static const _SafeStr_14457:Number = 60;
        private static const _SafeStr_14458:Number = 50;
        private static const MAXIMUM_VALID_FRAME_UPDATE_INTERVAL:int = 1000;

        private var _container:IRoomSpriteCanvasContainer;
        private var _geometry:RoomGeometry;
        private var _SafeStr_14459:int = 0;
        private var _displayObject:Sprite;
        private var _SafeStr_14461:Sprite;
        private var _SafeStr_14462:Sprite;
        private var _SafeStr_14463:Map;
        private var _SafeStr_14464:Point;
        private var _SafeStr_14465:BitmapDataCache;
        private var _SafeStr_14466:RoomObjectCache;
        private var _SafeStr_14467:Array;
        private var _SafeStr_14468:Array;
        private var _mouseListener:IRoomRenderingCanvasMouseListener = null;
        private var _id:String = "";
        private var _SafeStr_14470:Map = null;
        private var _eventId:int = 0;
        private var _width:int;
        private var _height:int;
        private var _screenOffsetX:int;
        private var _screenOffsetY:int;
        private var _SafeStr_14475:int;
        private var _SafeStr_14476:int;
        private var _SafeStr_14477:int = -1;
        private var _SafeStr_14478:Number = -10000000;
        private var _SafeStr_14479:Number = -10000000;
        private var _SafeStr_14480:int = 0;
        private var _SafeStr_14481:Boolean = false;
        private var _SafeStr_12979:Boolean = false;
        private var _colorTransform:ColorTransform;
        private var _RoomSpriteCanvas:Matrix;
        private var _averageUpdateInterval:Number = 0;
        private var _SafeStr_13804:int = 0;
        private var _SafeStr_14483:Boolean = false;
        private var _SafeStr_14484:Boolean = false;
        private var _SafeStr_14485:int = 0;
        private var _SafeStr_14486:Boolean = false;
        private var _SafeStr_14487:Array;
        private var _SafeStr_14488:int = 0;
        private var _SafeStr_14489:Number = 0;
        private var _SafeStr_14490:int = 0;
        private var _SafeStr_14491:int = 0;

        public function RoomSpriteCanvas(_arg_1:IRoomSpriteCanvasContainer, _arg_2:String, _arg_3:int, _arg_4:int, _arg_5:int)
        {
            this._SafeStr_14463 = new Map();
            this._SafeStr_14464 = new Point();
            this._SafeStr_14467 = [];
            this._SafeStr_14468 = [];
            this._SafeStr_14487 = [];
            super();
            this._container = _arg_1;
            this._id = _arg_2;
            this._displayObject = new Sprite();
            this._displayObject.mouseEnabled = false;
            this._SafeStr_14462 = new Sprite();
            this._SafeStr_14462.name = "canvas";
            this._SafeStr_14462.mouseEnabled = false;
            this._displayObject.addChild(this._SafeStr_14462);
            this._SafeStr_14462.mouseEnabled = true;
            this._SafeStr_14462.doubleClickEnabled = true;
            this._SafeStr_14462.addEventListener(MouseEvent.CLICK, this.clickHandler);
            this._SafeStr_14462.addEventListener(MouseEvent.DOUBLE_CLICK, this.clickHandler);
            this._geometry = new RoomGeometry(_arg_5, new Vector3d(-135, 30, 0), new Vector3d(11, 11, 5), new Vector3d(-135, 0.5, 0));
            this._SafeStr_14465 = new BitmapDataCache(16, 32, 1);
            var _local_6:String;
            if (this._container != null){
                _local_6 = this._container.roomObjectVariableAccurateZ;
            };
            this._SafeStr_14470 = new Map();
            this._SafeStr_14466 = new RoomObjectCache(_local_6);
            this._colorTransform = new ColorTransform();
            this._RoomSpriteCanvas = new Matrix();
            this.initialize(_arg_3, _arg_4);
        }
        public function get width():int
        {
            return (this._width);
        }
        public function get height():int
        {
            return (this._height);
        }
        public function set screenOffsetX(_arg_1:int):void
        {
            this._SafeStr_14464.x = (this._SafeStr_14464.x - (_arg_1 - this._screenOffsetX));
            this._screenOffsetX = _arg_1;
        }
        public function set screenOffsetY(_arg_1:int):void
        {
            this._SafeStr_14464.y = (this._SafeStr_14464.y - (_arg_1 - this._screenOffsetY));
            this._screenOffsetY = _arg_1;
        }
        public function get screenOffsetX():int
        {
            return (this._screenOffsetX);
        }
        public function get screenOffsetY():int
        {
            return (this._screenOffsetY);
        }
        public function get displayObject():DisplayObject
        {
            return (this._displayObject);
        }
        public function get geometry():IRoomGeometry
        {
            return (this._geometry);
        }
        public function set mouseListener(_arg_1:IRoomRenderingCanvasMouseListener):void
        {
            this._mouseListener = _arg_1;
        }
        public function set useMask(_arg_1:Boolean):void
        {
            if (((_arg_1) && (!(this._SafeStr_12979)))){
                this._SafeStr_12979 = true;
                if (((!((this._SafeStr_14461 == null))) && (!(this._displayObject.contains(this._SafeStr_14461))))){
                    this._displayObject.addChild(this._SafeStr_14461);
                    this._SafeStr_14462.mask = this._SafeStr_14461;
                };
            }
            else {
                if (((!(_arg_1)) && (this._SafeStr_12979))){
                    this._SafeStr_12979 = false;
                    if (((!((this._SafeStr_14461 == null))) && (this._displayObject.contains(this._SafeStr_14461)))){
                        this._displayObject.removeChild(this._SafeStr_14461);
                        this._SafeStr_14462.mask = null;
                    };
                };
            };
        }
        public function dispose():void
        {
            this.cleanSprites(0, true);
            if (this._geometry != null){
                this._geometry.dispose();
                this._geometry = null;
            };
            if (this._SafeStr_14461 != null){
                this._SafeStr_14461 = null;
            };
            if (this._SafeStr_14465 != null){
                this._SafeStr_14465.dispose();
                this._SafeStr_14465 = null;
            };
            if (this._SafeStr_14466 != null){
                this._SafeStr_14466.dispose();
                this._SafeStr_14466 = null;
            };
            this._container = null;
            if (this._displayObject != null){
                while (this._displayObject.numChildren > 0) {
                    this._displayObject.removeChildAt(0);
                };
                this._displayObject = null;
            };
            this._SafeStr_14462 = null;
            this._SafeStr_14461 = null;
            this._SafeStr_14467 = [];
            if (this._SafeStr_14463 != null){
                this._SafeStr_14463.dispose();
                this._SafeStr_14463 = null;
            };
            var _local_1:int;
            if (this._SafeStr_14468 != null){
                _local_1 = 0;
                while (_local_1 < this._SafeStr_14468.length) {
                    this.cleanSprite((this._SafeStr_14468[_local_1] as ExtendedSprite), true);
                    _local_1++;
                };
                this._SafeStr_14468 = [];
            };
            if (this._SafeStr_14470 != null){
                this._SafeStr_14470.dispose();
                this._SafeStr_14470 = null;
            };
            this._mouseListener = null;
            this._colorTransform = null;
            this._RoomSpriteCanvas = null;
        }
        public function initialize(_arg_1:int, _arg_2:int):void
        {
            if (_arg_1 < 1){
                _arg_1 = 1;
            };
            if (_arg_2 < 1){
                _arg_2 = 1;
            };
            if (this._SafeStr_14461 != null){
                this._SafeStr_14461.graphics.clear();
            }
            else {
                this._SafeStr_14461 = new Sprite();
                this._SafeStr_14461.name = "mask";
                if (this._SafeStr_12979){
                    this._displayObject.addChild(this._SafeStr_14461);
                    this._SafeStr_14462.mask = this._SafeStr_14461;
                };
            };
            this._SafeStr_14461.graphics.beginFill(0);
            this._SafeStr_14461.graphics.drawRect(0, 0, _arg_1, _arg_2);
            this._width = _arg_1;
            this._height = _arg_2;
        }
        public function roomObjectRemoved(_arg_1:String):void
        {
            this._SafeStr_14466.removeObjectCache(_arg_1);
        }
        public function render(_arg_1:int):void
        {
            this._SafeStr_14484 = !(this._SafeStr_14484);
            var _local_2:int;
            if ((((this._container == null)) || ((this._geometry == null)))){
                return;
            };
            if (_arg_1 == this._SafeStr_14477){
                return;
            };
            this.calculateUpdateInterval(_arg_1);
            this._SafeStr_14465.compress();
            var _local_3:int = this._container.IRoomSpriteCanvasContainer();
            var _local_4:int;
            var _local_5:int;
            var _local_6:String = "";
            var _local_7:IRoomObject;
            var _local_8:Boolean;
            if (((!((this._width == this._SafeStr_14475))) || (!((this._height == this._SafeStr_14476))))){
                _local_8 = true;
            };
            if (((!((this._SafeStr_14462.x == this._screenOffsetX))) || (!((this._SafeStr_14462.y == this._screenOffsetY))))){
                this._SafeStr_14462.x = this._screenOffsetX;
                this._SafeStr_14462.y = this._screenOffsetY;
                _local_8 = true;
            };
            _local_4 = 0;
            while (_local_4 < _local_3) {
                _local_7 = this._container.IRoomSpriteCanvasContainer(_local_4);
                if (_local_7 != null){
                    _local_6 = this._container.IRoomSpriteCanvasContainer(_local_4);
                    _local_5 = (_local_5 + this.renderObject(_local_7, _local_6, _arg_1, _local_8, _local_5));
                };
                _local_4++;
            };
            this._SafeStr_14467.sortOn("z", (Array.DESCENDING | Array.NUMERIC));
            if (_local_5 < this._SafeStr_14467.length){
                this._SafeStr_14467.splice(_local_5);
            };
            var _local_9:SortableSprite;
            _local_4 = 0;
            while (_local_4 < _local_5) {
                _local_9 = (this._SafeStr_14467[_local_4] as SortableSprite);
                if (_local_9 != null){
                    this.updateSprite(_local_4, _local_9);
                };
                _local_4++;
            };
            this.cleanSprites(_local_5);
            this._SafeStr_14477 = _arg_1;
            this._SafeStr_14475 = this._width;
            this._SafeStr_14476 = this._height;
        }
        private function calculateUpdateInterval(_arg_1:int):void
        {
            var _local_2:int;
            var _local_3:Number;
            if (this._SafeStr_14477 > 0){
                _local_2 = (_arg_1 - this._SafeStr_14477);
                if (_local_2 > (_SafeStr_14457 * 3)){
                    Logger.log((("Really slow frame update " + _local_2) + "ms"));
                    this._SafeStr_14491 = _local_2;
                };
                if (_local_2 <= MAXIMUM_VALID_FRAME_UPDATE_INTERVAL){
                    this._SafeStr_13804++;
                    if (this._SafeStr_13804 == (_SafeStr_14455 + 1)){
                        this._averageUpdateInterval = _local_2;
                        this._SafeStr_14489 = this._SafeStr_14490;
                    }
                    else {
                        if (this._SafeStr_13804 > (_SafeStr_14455 + 1)){
                            _local_3 = Number((this._SafeStr_13804 - _SafeStr_14455));
                            this._averageUpdateInterval = (((this._averageUpdateInterval * (_local_3 - 1)) / _local_3) + (Number(_local_2) / _local_3));
                            this._SafeStr_14489 = (((this._SafeStr_14489 * (_local_3 - 1)) / _local_3) + (Number(this._SafeStr_14490) / _local_3));
                            if (this._SafeStr_13804 > (_SafeStr_14455 + _SafeStr_14456)){
                                this._SafeStr_13804 = _SafeStr_14455;
                                if (((!(this._SafeStr_14483)) && ((this._averageUpdateInterval > _SafeStr_14457)))){
                                    this._SafeStr_14483 = true;
                                    Logger.log("Room canvas updating really slow - now entering frame skipping mode...");
                                }
                                else {
                                    if (((this._SafeStr_14483) && ((this._averageUpdateInterval < _SafeStr_14458)))){
                                        this._SafeStr_14483 = false;
                                        Logger.log("Room canvas updating fast again - now entering normal frame mode...");
                                    };
                                };
                                this._SafeStr_14491 = 0;
                            };
                        };
                    };
                };
            };
        }
        private function renderObject(_arg_1:IRoomObject, _arg_2:String, _arg_3:int, _arg_4:Boolean, _arg_5:int):int
        {
            var _local_22:BitmapData;
            var _local_6:IRoomObjectSpriteVisualization = (_arg_1.getVisualization() as IRoomObjectSpriteVisualization);
            if (_local_6 == null){
                this._SafeStr_14466.removeObjectCache(_arg_2);
                return (0);
            };
            var _local_7:RoomObjectCacheItem = this._SafeStr_14466.getObjectCache(_arg_2);
            var _local_8:RoomObjectLocationCacheItem = _local_7.location;
            var _local_9:RoomObjectSortableSpriteCacheItem = _local_7.sprites;
            var _local_10:IVector3d = _local_8.getScreenLocation(_arg_1, this._geometry);
            if (_local_10 == null){
                this._SafeStr_14466.removeObjectCache(_arg_2);
                return (0);
            };
            _local_6.update(this._geometry, _arg_3, ((!(_local_9.isEmpty)) || (_arg_4)), ((this._SafeStr_14484) && (this._SafeStr_14483)));
            var _local_11:Boolean = _local_8.locationChanged;
            if (_local_11){
                _arg_4 = true;
            };
            if (((!(_local_9.ExtendedSprite(_local_6.getInstanceId(), _local_6.getUpdateID()))) && (!(_arg_4)))){
                return (_local_9.spriteCount);
            };
            var _local_12:int = _local_6.spriteCount;
            var _local_13:int = _local_10.x;
            var _local_14:int = _local_10.y;
            var _local_15:Number = _local_10.z;
            if (_local_13 > 0){
                _local_15 = (_local_15 + (_local_13 * 1.2E-7));
            }
            else {
                _local_15 = (_local_15 + (-(_local_13) * 1.2E-7));
            };
            _local_13 = (_local_13 + int((this._width / 2)));
            _local_14 = (_local_14 + int((this._height / 2)));
            var _local_16:int;
            var _local_17:SortableSprite;
            var _local_18:IRoomObjectSprite;
            var _local_19:int;
            var _local_20:int;
            var _local_21:int;
            while (_local_21 < _local_12) {
                _local_18 = _local_6.getSprite(_local_21);
                if (((!((_local_18 == null))) && (_local_18.visible))){
                    _local_22 = _local_18.asset;
                    if (_local_22 != null){
                        _local_19 = ((_local_13 + _local_18.offsetX) + this._screenOffsetX);
                        _local_20 = ((_local_14 + _local_18.offsetY) + this._screenOffsetY);
                        if (this.rectangleVisible(_local_19, _local_20, _local_22.width, _local_22.height)){
                            _local_17 = _local_9.getSprite(_local_16);
                            if (_local_17 == null){
                                _local_17 = new SortableSprite();
                                _local_9.addSprite(_local_17);
                                this._SafeStr_14467.push(_local_17);
                                _local_17.name = _arg_2;
                            };
                            _local_17.sprite = _local_18;
                            _local_17.x = (_local_19 - this._screenOffsetX);
                            _local_17.y = (_local_20 - this._screenOffsetY);
                            _local_17.z = ((_local_15 + _local_18.relativeDepth) + (3.7E-11 * _arg_5));
                            _local_16++;
                            _arg_5++;
                        };
                    };
                };
                _local_21++;
            };
            _local_9.setSpriteCount(_local_16);
            return (_local_16);
        }
        private function rectangleVisible(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):Boolean
        {
            if ((((((_arg_1 < this._width)) && (((_arg_1 + _arg_3) >= 0)))) && ((((_arg_2 < this._height)) && (((_arg_2 + _arg_4) >= 0)))))){
                if (!this._SafeStr_14486){
                    return (true);
                };
                return (this.rectangleVisibleWithExclusion(_arg_1, _arg_2, _arg_3, _arg_4));
            };
            return (false);
        }
        private function rectangleVisibleWithExclusion(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):Boolean
        {
            var _local_5:Rectangle;
            if (_arg_1 < 0){
                _arg_3 = (_arg_3 + _arg_1);
                _arg_1 = 0;
            };
            if (_arg_2 < 0){
                _arg_4 = (_arg_4 + _arg_2);
                _arg_2 = 0;
            };
            if ((_arg_1 + _arg_3) >= this._width){
                _arg_3 = (_arg_3 - ((this._width + 1) - (_arg_1 + _arg_3)));
            };
            if ((_arg_2 + _arg_4) >= this._height){
                _arg_4 = (_arg_4 - ((this._height + 1) - (_arg_2 + _arg_4)));
            };
            for each (_local_5 in this._SafeStr_14487) {
                if ((((((((_arg_1 >= _local_5.left)) && (((_arg_1 + _arg_3) < _local_5.right)))) && ((_arg_2 >= _local_5.top)))) && (((_arg_2 + _arg_4) < _local_5.bottom)))){
                    return (false);
                };
            };
            return (true);
        }
        private function getSprite(_arg_1:int):ExtendedSprite
        {
            if ((((_arg_1 < 0)) || ((_arg_1 >= this._SafeStr_14485)))){
                return (null);
            };
            return ((this._SafeStr_14462.getChildAt(_arg_1) as ExtendedSprite));
        }
        private function createSprite(_arg_1:SortableSprite, _arg_2:int=-1):void
        {
            var _local_3:ExtendedSprite;
            var _local_4:IRoomObjectSprite = _arg_1.sprite;
            if (this._SafeStr_14468.length > 0){
                _local_3 = (this._SafeStr_14468.pop() as ExtendedSprite);
            };
            if (_local_3 == null){
                _local_3 = new ExtendedSprite();
            };
            _local_3.x = _arg_1.x;
            _local_3.y = _arg_1.y;
            _local_3.identifier = _arg_1.name;
            _local_3.alpha = (_local_4.alpha / 0xFF);
            _local_3.tag = _local_4.tag;
            _local_3.blendMode = _local_4.blendMode;
            _local_3.filters = _local_4.filters;
            _local_3.varyingDepth = _local_4.varyingDepth;
            _local_3.clickHandling = _local_4.clickHandling;
            _local_3.smoothing = false;
            _local_3.pixelSnapping = PixelSnapping.ALWAYS;
            _local_3.bitmapData = this.getBitmapData(_local_4.asset, _local_4.assetName, _local_4.flipH, _local_4.flipV, _local_4.color);
            if (_local_4.capturesMouse){
                _local_3.alphaTolerance = 128;
            }
            else {
                _local_3.alphaTolerance = 0x0100;
            };
            if ((((_arg_2 < 0)) || ((_arg_2 >= this._SafeStr_14485)))){
                this._SafeStr_14462.addChild(_local_3);
                this._SafeStr_14485++;
            }
            else {
                this._SafeStr_14462.addChildAt(_local_3, _arg_2);
            };
            this._SafeStr_14488++;
        }
        private function updateSprite(_arg_1:int, _arg_2:SortableSprite):Boolean
        {
            var _local_5:Number;
            var _local_6:BitmapData;
            if (_arg_1 >= this._SafeStr_14485){
                this.createSprite(_arg_2);
                return (true);
            };
            var _local_3:IRoomObjectSprite = _arg_2.sprite;
            var _local_4:ExtendedSprite = this.getSprite(_arg_1);
            if (_local_4 != null){
                if (_local_4.varyingDepth != _local_3.varyingDepth){
                    if (((_local_4.varyingDepth) && (!(_local_3.varyingDepth)))){
                        this._SafeStr_14462.removeChildAt(_arg_1);
                        this._SafeStr_14468.push(_local_4);
                        return (this.updateSprite(_arg_1, _arg_2));
                    };
                    this.createSprite(_arg_2, _arg_1);
                    return (true);
                };
                if (_local_4.ExtendedSprite(_local_3.instanceId, _local_3.updateId)){
                    if (_local_3.capturesMouse){
                        _local_4.alphaTolerance = 128;
                    }
                    else {
                        _local_4.alphaTolerance = 0x0100;
                    };
                    _local_5 = (_local_3.alpha / 0xFF);
                    if (_local_4.alpha != _local_5){
                        _local_4.alpha = _local_5;
                    };
                    _local_4.identifier = _arg_2.name;
                    _local_4.tag = _local_3.tag;
                    _local_4.varyingDepth = _local_3.varyingDepth;
                    _local_4.blendMode = _local_3.blendMode;
                    _local_4.clickHandling = _local_3.clickHandling;
                    _local_4.filters = _local_3.filters;
                    _local_6 = this.getBitmapData(_local_3.asset, _local_3.assetName, _local_3.flipH, _local_3.flipV, _local_3.color);
                    if (_local_4.bitmapData != _local_6){
                        _local_4.bitmapData = _local_6;
                    };
                };
                if (_local_4.x != _arg_2.x){
                    _local_4.x = _arg_2.x;
                };
                if (_local_4.y != _arg_2.y){
                    _local_4.y = _arg_2.y;
                };
            }
            else {
                return (false);
            };
            return (true);
        }
        private function cleanSprites(_arg_1:int, _arg_2:Boolean=false):void
        {
            var _local_4:int;
            if (this._SafeStr_14462 == null){
                return;
            };
            if (_arg_1 < 0){
                _arg_1 = 0;
            };
            var _local_3:ExtendedSprite;
            if ((((_arg_1 < this._SafeStr_14488)) || ((this._SafeStr_14488 == 0)))){
                _local_4 = (this._SafeStr_14485 - 1);
                while (_local_4 >= _arg_1) {
                    _local_3 = this.getSprite(_local_4);
                    this.cleanSprite(_local_3, _arg_2);
                    _local_4--;
                };
            };
            this._SafeStr_14488 = _arg_1;
        }
        private function cleanSprite(_arg_1:ExtendedSprite, _arg_2:Boolean):void
        {
            if (_arg_1 != null){
                if (!_arg_2){
                    _arg_1.bitmapData = null;
                }
                else {
                    _arg_1.dispose();
                };
            };
        }
        private function getSortableSprite(_arg_1:int):SortableSprite
        {
            if ((((_arg_1 < 0)) || ((_arg_1 >= this._SafeStr_14467.length)))){
                return (null);
            };
            return ((this._SafeStr_14467[_arg_1] as SortableSprite));
        }
        private function getBitmapData(_arg_1:BitmapData, _arg_2:String, _arg_3:Boolean, _arg_4:Boolean, _arg_5:int):BitmapData
        {
            _arg_5 = (_arg_5 & 0xFFFFFF);
            if (((((!(_arg_3)) && (!(_arg_4)))) && ((_arg_5 == 0xFFFFFF)))){
                return (_arg_1);
            };
            var _local_6:ExtendedBitmapData;
            var _local_7:String = "";
            if (((((_arg_3) || (_arg_4))) && (!((_arg_5 == 0xFFFFFF))))){
                _local_7 = ((((_arg_2 + " ") + _arg_5) + ((_arg_3) ? " FH" : "")) + ((_arg_4) ? " FV" : ""));
                if (_arg_2.length > 0){
                    _local_6 = this._SafeStr_14465.getBitmapData(_local_7);
                };
                if (_local_6 == null){
                    _local_6 = this.getColoredBitmapData(_arg_1, _arg_2, _arg_5);
                    if (_local_6 != null){
                        _local_6 = this.getFlippedBitmapData(_local_6, _arg_2, true, _arg_3, _arg_4);
                        if (_arg_2.length > 0){
                            this._SafeStr_14465.addBitmapData(_local_7, _local_6);
                        };
                        return (_local_6);
                    };
                    _local_6 = this.getFlippedBitmapData(_arg_1, _arg_2, true, _arg_3, _arg_4);
                    if (_local_6 != null){
                        _local_6 = this.getColoredBitmapData(_local_6, "", _arg_5, true);
                        if (_arg_2.length > 0){
                            this._SafeStr_14465.addBitmapData(_local_7, _local_6);
                        };
                        return (_local_6);
                    };
                    _local_6 = this.getColoredBitmapData(_arg_1, _arg_2, _arg_5, true);
                    _local_6 = this.getFlippedBitmapData(_local_6, _arg_2, true, _arg_3, _arg_4);
                    if (_arg_2.length > 0){
                        this._SafeStr_14465.addBitmapData(_local_7, _local_6);
                    };
                };
            }
            else {
                if (((_arg_3) || (_arg_4))){
                    _local_6 = this.getFlippedBitmapData(_arg_1, _arg_2, true, _arg_3, _arg_4);
                }
                else {
                    if (_arg_5 != 0xFFFFFF){
                        _local_6 = this.getColoredBitmapData(_arg_1, _arg_2, _arg_5, true);
                    }
                    else {
                        return (_arg_1);
                    };
                };
            };
            return (_local_6);
        }
        private function getFlippedBitmapData(data:BitmapData, name:String, allowCreation:Boolean=false, flipH:Boolean=true, flipV:Boolean=false):ExtendedBitmapData
        {
            var cacheName:String = ((name + ((flipH) ? " FH" : "")) + ((flipV) ? " FV" : ""));
            var finalData:ExtendedBitmapData;
            if (name.length > 0){
                finalData = this._SafeStr_14465.getBitmapData(cacheName);
                if (!allowCreation){
                    return (finalData);
                };
            };
            if (finalData == null){
                try {
                    finalData = new ExtendedBitmapData(data.width, data.height, true, 0xFFFFFF);
                }
                catch(e:Error) {
                    finalData = new ExtendedBitmapData(1, 1, true, 0xFFFFFF);
                };
                this._RoomSpriteCanvas.identity();
                if (flipH){
                    this._RoomSpriteCanvas.scale(-1, 1);
                    this._RoomSpriteCanvas.translate(data.width, 0);
                };
                if (flipV){
                    this._RoomSpriteCanvas.scale(1, -1);
                    this._RoomSpriteCanvas.translate(0, data.height);
                };
                finalData.draw(data, this._RoomSpriteCanvas);
                if (name.length > 0){
                    this._SafeStr_14465.addBitmapData(cacheName, finalData);
                };
            };
            return (finalData);
        }
        private function getColoredBitmapData(data:BitmapData, name:String, color:int, allowCreation:Boolean=false):ExtendedBitmapData
        {
            var r:int;
            var g:int;
            var b:int;
            var tR:Number;
            var tG:Number;
            var tB:Number;
            var cacheName:String = ((name + " ") + color);
            var finalData:ExtendedBitmapData;
            if (name.length > 0){
                finalData = this._SafeStr_14465.getBitmapData(cacheName);
                if (!allowCreation){
                    return (finalData);
                };
            };
            if (finalData == null){
                r = ((color >> 16) & 0xFF);
                g = ((color >> 8) & 0xFF);
                b = (color & 0xFF);
                tR = (r / 0xFF);
                tG = (g / 0xFF);
                tB = (b / 0xFF);
                try {
                    finalData = new ExtendedBitmapData(data.width, data.height, true, 0xFFFFFF);
                    finalData.copyPixels(data, data.rect, _SafeStr_12969);
                }
                catch(e:Error) {
                    finalData = new ExtendedBitmapData(1, 1, true, 0xFFFFFF);
                };
                this._colorTransform.redMultiplier = tR;
                this._colorTransform.greenMultiplier = tG;
                this._colorTransform.blueMultiplier = tB;
                finalData.colorTransform(finalData.rect, this._colorTransform);
                if (name.length > 0){
                    this._SafeStr_14465.addBitmapData(cacheName, finalData);
                };
            };
            return (finalData);
        }
        private function getObjectId(_arg_1:ExtendedSprite):String
        {
            var _local_2:String;
            if (_arg_1 != null){
                return (_arg_1.identifier);
            };
            return ("");
        }
        public function handleMouseEvent(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:Boolean, _arg_5:Boolean, _arg_6:Boolean, _arg_7:Boolean):Boolean
        {
            _arg_1 = (_arg_1 - this._screenOffsetX);
            _arg_2 = (_arg_2 - this._screenOffsetY);
            this._SafeStr_14464.x = _arg_1;
            this._SafeStr_14464.y = _arg_2;
            if ((((this._SafeStr_14480 > 0)) && ((_arg_3 == MouseEvent.MOUSE_MOVE)))){
                return (this._SafeStr_14481);
            };
            this._SafeStr_14481 = this.checkMouseHits(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7);
            this._SafeStr_14480++;
            return (this._SafeStr_14481);
        }
        private function createMouseEvent(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:String, _arg_6:String, _arg_7:Boolean, _arg_8:Boolean, _arg_9:Boolean, _arg_10:Boolean):RoomSpriteMouseEvent
        {
            var _local_11:Number = (_arg_1 - (this._width / 2));
            var _local_12:Number = (_arg_2 - (this._height / 2));
            var _local_13:RoomSpriteMouseEvent;
            return (new RoomSpriteMouseEvent(_arg_5, ((this._id + "_") + this._eventId), this._id, _arg_6, _local_11, _local_12, _arg_3, _arg_4, _arg_8, _arg_7, _arg_9, _arg_10));
        }
        private function checkMouseClickHits(_arg_1:Number, _arg_2:Number, _arg_3:Boolean, _arg_4:Boolean=false, _arg_5:Boolean=false, _arg_6:Boolean=false, _arg_7:Boolean=false):Boolean
        {
            var _local_15:String;
            var _local_8:Boolean;
            var _local_9:String = "";
            var _local_10:ExtendedSprite;
            var _local_11:RoomSpriteMouseEvent;
            var _local_12:String = MouseEvent.CLICK;
            if (_arg_3){
                _local_12 = MouseEvent.DOUBLE_CLICK;
            };
            var _local_13:Array = [];
            var _local_14:int;
            _local_14 = (this._SafeStr_14488 - 1);
            while (_local_14 >= 0) {
                _local_10 = this.getSprite(_local_14);
                if (((!((_local_10 == null))) && (_local_10.clickHandling))){
                    if (_local_10.hitTest((_arg_1 - _local_10.x), (_arg_2 - _local_10.y))){
                        _local_9 = this.getObjectId(_local_10);
                        if (_local_13.indexOf(_local_9) < 0){
                            _local_15 = _local_10.tag;
                            _local_11 = this.createMouseEvent(_arg_1, _arg_2, (_arg_1 - _local_10.y), (_arg_2 - _local_10.y), _local_12, _local_15, _arg_4, _arg_5, _arg_6, _arg_7);
                            this.bufferMouseEvent(_local_11, _local_9);
                            _local_13.push(_local_9);
                        };
                    };
                    _local_8 = true;
                };
                _local_14--;
            };
            this.processMouseEvents();
            return (_local_8);
        }
        private function checkMouseHits(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:Boolean=false, _arg_5:Boolean=false, _arg_6:Boolean=false, _arg_7:Boolean=false):Boolean
        {
            var _local_16:String;
            var _local_17:String;
            var _local_18:int;
            var _local_8:Boolean;
            var _local_9:String = "";
            var _local_10:ExtendedSprite;
            var _local_11:RoomSpriteMouseEvent;
            var _local_12:Array = [];
            var _local_13:ObjectMouseData;
            var _local_14:int;
            _local_14 = (this._SafeStr_14488 - 1);
            while (_local_14 >= 0) {
                _local_10 = (this.getSprite(_local_14) as ExtendedSprite);
                if (((!((_local_10 == null))) && (_local_10.hitTestPoint((_arg_1 - _local_10.x), (_arg_2 - _local_10.y))))){
                    if (((!(_local_10.clickHandling)) || (((!((_arg_3 == MouseEvent.CLICK))) && (!((_arg_3 == MouseEvent.DOUBLE_CLICK))))))){
                        _local_9 = this.getObjectId(_local_10);
                        if (_local_12.indexOf(_local_9) < 0){
                            _local_16 = _local_10.tag;
                            _local_13 = (this._SafeStr_14463.getValue(_local_9) as ObjectMouseData);
                            if (_local_13 != null){
                                if (_local_13.spriteTag != _local_16){
                                    _local_11 = this.createMouseEvent(0, 0, 0, 0, MouseEvent.ROLL_OUT, _local_13.spriteTag, _arg_4, _arg_5, _arg_6, _arg_7);
                                    this.bufferMouseEvent(_local_11, _local_9);
                                };
                            };
                            if ((((_arg_3 == MouseEvent.MOUSE_MOVE)) && ((((_local_13 == null)) || (!((_local_13.spriteTag == _local_16))))))){
                                _local_11 = this.createMouseEvent(_arg_1, _arg_2, (_arg_1 - _local_10.x), (_arg_2 - _local_10.y), MouseEvent.ROLL_OVER, _local_16, _arg_4, _arg_5, _arg_6, _arg_7);
                            }
                            else {
                                _local_11 = this.createMouseEvent(_arg_1, _arg_2, (_arg_1 - _local_10.y), (_arg_2 - _local_10.y), _arg_3, _local_16, _arg_4, _arg_5, _arg_6, _arg_7);
                            };
                            if (_local_13 == null){
                                _local_13 = new ObjectMouseData();
                                _local_13.objectId = _local_9;
                                this._SafeStr_14463.add(_local_9, _local_13);
                            };
                            _local_13.spriteTag = _local_16;
                            if (((((!((_arg_3 == MouseEvent.MOUSE_MOVE))) || (!((_arg_1 == this._SafeStr_14478))))) || (!((_arg_2 == this._SafeStr_14479))))){
                                this.bufferMouseEvent(_local_11, _local_9);
                            };
                            _local_12.push(_local_9);
                        };
                        _local_8 = true;
                    };
                };
                _local_14--;
            };
            var _local_15:Array = this._SafeStr_14463.getKeys();
            _local_14 = 0;
            while (_local_14 < _local_15.length) {
                _local_17 = (_local_15[_local_14] as String);
                _local_18 = _local_12.indexOf(_local_17);
                if (_local_18 >= 0){
                    _local_15[_local_14] = null;
                };
                _local_14++;
            };
            _local_14 = 0;
            while (_local_14 < _local_15.length) {
                _local_9 = (_local_15[_local_14] as String);
                if (_local_9 != null){
                    _local_13 = (this._SafeStr_14463.remove(_local_9) as ObjectMouseData);
                    if (_local_13 != null){
                        _local_11 = this.createMouseEvent(0, 0, 0, 0, MouseEvent.ROLL_OUT, _local_13.spriteTag, _arg_4, _arg_5, _arg_6, _arg_7);
                        this.bufferMouseEvent(_local_11, _local_9);
                    };
                };
                _local_14++;
            };
            this.processMouseEvents();
            this._SafeStr_14478 = _arg_1;
            this._SafeStr_14479 = _arg_2;
            return (_local_8);
        }
        private function bufferMouseEvent(_arg_1:RoomSpriteMouseEvent, _arg_2:String):void
        {
            if (((!((this._SafeStr_14470 == null))) && (!((_arg_1 == null))))){
                this._SafeStr_14470.add(_arg_2, _arg_1);
            };
        }
        private function processMouseEvents():void
        {
            var _local_2:String;
            var _local_3:RoomSpriteMouseEvent;
            var _local_4:IRoomObject;
            var _local_5:IRoomObjectMouseHandler;
            if ((((this._container == null)) || ((this._SafeStr_14470 == null)))){
                return;
            };
            var _local_1:int;
            while (_local_1 < this._SafeStr_14470.length) {
                _local_2 = this._SafeStr_14470.getKey(_local_1);
                _local_3 = this._SafeStr_14470.getWithIndex(_local_1);
                if (((!((_local_2 == null))) && (!((_local_3 == null))))){
                    _local_4 = this._container.IRoomSpriteCanvasContainer(_local_2);
                    if (_local_4 != null){
                        if (this._mouseListener != null){
                            this._mouseListener.processRoomCanvasMouseEvent(_local_3, _local_4, this.geometry);
                        }
                        else {
                            _local_5 = _local_4.getMouseHandler();
                            if (_local_5 != null){
                                _local_5.mouseEvent(_local_3, this._geometry);
                            };
                        };
                    };
                };
                _local_1++;
            };
            this._SafeStr_14470.reset();
        }
        public function update():void
        {
            if (this._SafeStr_14480 == 0){
                this.checkMouseHits(this._SafeStr_14464.x, this._SafeStr_14464.y, MouseEvent.MOUSE_MOVE);
            };
            this._SafeStr_14480 = 0;
            this._eventId++;
        }
        private function clickHandler(_arg_1:MouseEvent):void
        {
            var _local_2:Boolean;
            if ((((_arg_1.type == MouseEvent.CLICK)) || ((_arg_1.type == MouseEvent.DOUBLE_CLICK)))){
                _local_2 = (_arg_1.type == MouseEvent.DOUBLE_CLICK);
                this.checkMouseClickHits(_arg_1.localX, _arg_1.localY, _local_2, _arg_1.altKey, _arg_1.ctrlKey, _arg_1.shiftKey, _arg_1.buttonDown);
            };
        }

    }
}//package com.sulake.room.renderer

// updateSprite = "_-2yQ" (String#1975, DoABC#2)
// IVector3d = "_-hf" (String#8547, DoABC#2)
// Vector3d = "_-1Rb" (String#17568, DoABC#2)
// _SafeStr_12969 = "_-0Bv" (String#1423, DoABC#2)
// _SafeStr_12979 = "_-eK" (String#8490, DoABC#2)
// processRoomCanvasMouseEvent = "_-02d" (String#3621, DoABC#2)
// getMouseHandler = "_-EC" (String#7957, DoABC#2)
// screenOffsetX = "_-08x" (String#3738, DoABC#2)
// screenOffsetY = "_-01t" (String#3600, DoABC#2)
// mouseListener = "_-2K" (String#6442, DoABC#2)
// useMask = "_-1iM" (String#5719, DoABC#2)
// handleMouseEvent = "_-Xa" (String#8360, DoABC#2)
// getVisualization = "_-1At" (String#5090, DoABC#2)
// _SafeStr_13804 = "_-AT" (String#7877, DoABC#2)
// _averageUpdateInterval = "_-de" (String#2145, DoABC#2)
// sprites = "_-hQ" (String#23946, DoABC#2)
// compress = "_-1hE" (String#18183, DoABC#2)
// getBitmapData = "_-oI" (String#8681, DoABC#2)
// addBitmapData = "_-0B3" (String#14490, DoABC#2)
// getObjectCache = "_-36e" (String#21752, DoABC#2)
// removeObjectCache = "_-xS" (String#24588, DoABC#2)
// locationChanged = "_-2d5" (String#20566, DoABC#2)
// getScreenLocation = "_-PG" (String#23217, DoABC#2)
// setSpriteCount = "_-2V2" (String#20240, DoABC#2)
// addSprite = "_-1FI" (String#17085, DoABC#2)
// ExtendedSprite = "_-2cQ" (String#20541, DoABC#2)
// alphaTolerance = "_-2KR" (String#19819, DoABC#2)
// IRoomSpriteCanvasContainer = "_-0EL" (String#3833, DoABC#2)
// roomObjectRemoved = "_-13B" (String#16587, DoABC#2)
// _SafeStr_14455 = "_-y1" (String#24615, DoABC#2)
// _SafeStr_14456 = "_-097" (String#14414, DoABC#2)
// _SafeStr_14457 = "_-007" (String#14058, DoABC#2)
// _SafeStr_14458 = "_-S6" (String#23328, DoABC#2)
// _SafeStr_14459 = "_-194" (String#16821, DoABC#2)
// _displayObject = "_-0oB" (String#15983, DoABC#2)
// _SafeStr_14461 = "_-353" (String#21698, DoABC#2)
// _SafeStr_14462 = "_-gh" (String#23918, DoABC#2)
// _SafeStr_14463 = "_-03s" (String#14197, DoABC#2)
// _SafeStr_14464 = "_-BE" (String#22663, DoABC#2)
// _SafeStr_14465 = "_-2wP" (String#21325, DoABC#2)
// _SafeStr_14466 = "_-0xv" (String#16350, DoABC#2)
// _SafeStr_14467 = "_-2Gy" (String#19681, DoABC#2)
// _SafeStr_14468 = "_-27s" (String#19324, DoABC#2)
// _mouseListener = "_-yX" (String#24636, DoABC#2)
// _SafeStr_14470 = "_-22C" (String#19099, DoABC#2)
// _width = "_-0Ck" (String#14559, DoABC#2)
// _height = "_-1a-" (String#17892, DoABC#2)
// _screenOffsetX = "_-2mQ" (String#20936, DoABC#2)
// _screenOffsetY = "_-hZ" (String#23950, DoABC#2)
// _SafeStr_14475 = "_-0bS" (String#15494, DoABC#2)
// _SafeStr_14476 = "_-1iA" (String#18217, DoABC#2)
// _SafeStr_14477 = "_-2mi" (String#20949, DoABC#2)
// _SafeStr_14478 = "_-LC" (String#23054, DoABC#2)
// _SafeStr_14479 = "_-2X5" (String#20327, DoABC#2)
// _SafeStr_14480 = "_-1s5" (String#18637, DoABC#2)
// _SafeStr_14481 = "_-1m6" (String#18384, DoABC#2)
// _RoomSpriteCanvas = "_-02U" (String#14142, DoABC#2)
// _SafeStr_14483 = "_-1gS" (String#18156, DoABC#2)
// _SafeStr_14484 = "_-b4" (String#23671, DoABC#2)
// _SafeStr_14485 = "_-Gg" (String#22876, DoABC#2)
// _SafeStr_14486 = "_-2cI" (String#20536, DoABC#2)
// _SafeStr_14487 = "_-Q4" (String#23253, DoABC#2)
// _SafeStr_14488 = "_-WQ" (String#23507, DoABC#2)
// _SafeStr_14489 = "_-3AI" (String#21894, DoABC#2)
// _SafeStr_14490 = "_-2ZT" (String#20417, DoABC#2)
// _SafeStr_14491 = "_-2cd" (String#20550, DoABC#2)
// cleanSprites = "_-02O" (String#14138, DoABC#2)
// calculateUpdateInterval = "_-32b" (String#21600, DoABC#2)
// renderObject = "_-1Ul" (String#17694, DoABC#2)
// rectangleVisible = "_-bM" (String#23686, DoABC#2)
// rectangleVisibleWithExclusion = "_-2SY" (String#20139, DoABC#2)
// createSprite = "_-2qs" (String#21117, DoABC#2)
// getSortableSprite = "_-1Wq" (String#17773, DoABC#2)
// getColoredBitmapData = "_-Tx" (String#23404, DoABC#2)
// getFlippedBitmapData = "_-0gu" (String#15705, DoABC#2)
// getObjectId = "_-Q1" (String#23252, DoABC#2)
// checkMouseHits = "_-1JN" (String#17251, DoABC#2)
// createMouseEvent = "_-0jf" (String#15813, DoABC#2)
// checkMouseClickHits = "_-1LN" (String#17328, DoABC#2)
// bufferMouseEvent = "_-Qm" (String#23276, DoABC#2)
// processMouseEvents = "_-yG" (String#24625, DoABC#2)
// IRoomObjectMouseHandler = "_-2xI" (String#7227, DoABC#2)
// IRoomSpriteCanvasContainer = "_-1jX" (String#5744, DoABC#2)
// IRoomObjectSpriteVisualization = "_-2Xc" (String#6715, DoABC#2)
// IRoomGeometry = "_-0z9" (String#4829, DoABC#2)
// IRoomRenderingCanvasMouseListener = "_-Qz" (String#8227, DoABC#2)
// RoomGeometry = "_-2l9" (String#20887, DoABC#2)
// IRoomRenderingCanvas = "_-22o" (String#6102, DoABC#2)
// RoomSpriteMouseEvent = "_-wc" (String#8815, DoABC#2)
// RoomSpriteCanvas = "_-4K" (String#7752, DoABC#2)
// IRoomObjectSprite = "_-0di" (String#4386, DoABC#2)
// RoomObjectCacheItem = "_-1Au" (String#5091, DoABC#2)
// BitmapDataCache = "_-zk" (String#8876, DoABC#2)
// RoomObjectCache = "_-0fT" (String#4414, DoABC#2)
// ExtendedSprite = "_-1mI" (String#5785, DoABC#2)
// RoomObjectLocationCacheItem = "_-2gl" (String#6886, DoABC#2)
// ObjectMouseData = "_-0sY" (String#4698, DoABC#2)
// SortableSprite = "_-0J3" (String#3936, DoABC#2)
// ExtendedBitmapData = "_-11w" (String#4915, DoABC#2)
// RoomObjectSortableSpriteCacheItem = "_-Sj" (String#8261, DoABC#2)
// _colorTransform = "_-0yf" (String#300, DoABC#2)
// getUpdateID = "_-Ga" (String#932, DoABC#2)
// getSprite = "_-sN" (String#2210, DoABC#2)
// spriteCount = "_-2A7" (String#6252, DoABC#2)
// updateId = "_-0TD" (String#1478, DoABC#2)
// clickHandler = "_-34y" (String#630, DoABC#2)
// IRoomSpriteCanvasContainer = "_-1qD" (String#866, DoABC#2)
// mouseEvent = "_-0Um" (String#4199, DoABC#2)
// spriteTag = "_-1jr" (String#18278, DoABC#2)
// varyingDepth = "_-11d" (String#4909, DoABC#2)
// clickHandling = "_-2fU" (String#6858, DoABC#2)
// instanceId = "_-044" (String#3649, DoABC#2)
// _eventId = "_-19k" (String#1626, DoABC#2)
// IRoomSpriteCanvasContainer = "_-1Hy" (String#1654, DoABC#2)
// IRoomSpriteCanvasContainer = "_-cJ" (String#2140, DoABC#2)
// isEmpty = "_-01T" (String#3592, DoABC#2)


