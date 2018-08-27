
package com.sulake.room.object.visualization
{
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.object.visualization.utils.IGraphicAssetCollection;
    import com.sulake.room.utils.IRoomGeometry;
    import flash.display.BitmapData;
    import flash.geom.ColorTransform;
    import flash.geom.Matrix;
    import flash.geom.Rectangle;
    import flash.display.BlendMode;
    import flash.geom.Point;
    import com.sulake.core.assets.IAsset;

    public class RoomObjectSpriteVisualization implements IRoomObjectSpriteVisualization 
    {

        private static var _SafeStr_5547:int = 0;

        private var _sprites:Array;
        private var _object:IRoomObject;
        private var _assetCollection:IGraphicAssetCollection;
        protected var _SafeStr_4455:int = -1;
        protected var _SafeStr_4365:int = -1;
        protected var _SafeStr_4369:int = -1;
        private var _instanceId:int = 0;
        private var _updateID:int = 0;

        public function RoomObjectSpriteVisualization()
        {
            this._instanceId = _SafeStr_5547++;
            this._sprites = [];
            this._object = null;
            this._assetCollection = null;
        }
        public function dispose():void
        {
            var _local_1:RoomObjectSprite;
            if (this._sprites != null){
                while (this._sprites.length > 0) {
                    _local_1 = (this._sprites[0] as RoomObjectSprite);
                    if (_local_1 != null){
                        _local_1.dispose();
                    };
                    this._sprites.pop();
                };
                this._sprites = null;
            };
            this._object = null;
            this.assetCollection = null;
        }
        public function set assetCollection(_arg_1:IGraphicAssetCollection):void
        {
            if (this._assetCollection != null){
                this._assetCollection.removeReference();
            };
            this._assetCollection = _arg_1;
            if (this._assetCollection != null){
                this._assetCollection.addReference();
            };
        }
        public function get assetCollection():IGraphicAssetCollection
        {
            return (this._assetCollection);
        }
        public function getUpdateID():int
        {
            return (this._updateID);
        }
        public function getInstanceId():int
        {
            return (this._instanceId);
        }
        protected function createSprites(_arg_1:int):void
        {
            var _local_2:RoomObjectSprite;
            while (this._sprites.length > _arg_1) {
                _local_2 = (this._sprites[(this._sprites.length - 1)] as RoomObjectSprite);
                if (_local_2 != null){
                    _local_2.dispose();
                };
                this._sprites.pop();
            };
            while (this._sprites.length < _arg_1) {
                _local_2 = new RoomObjectSprite();
                this._sprites.push(_local_2);
            };
        }
        public function get spriteCount():int
        {
            return (this._sprites.length);
        }
        public function getSprite(_arg_1:int):IRoomObjectSprite
        {
            if ((((_arg_1 >= 0)) && ((_arg_1 < this._sprites.length)))){
                return (this._sprites[_arg_1]);
            };
            return (null);
        }
        public function get object():IRoomObject
        {
            return (this._object);
        }
        public function set object(_arg_1:IRoomObject):void
        {
            this._object = _arg_1;
        }
        public function update(_arg_1:IRoomGeometry, _arg_2:int, _arg_3:Boolean, _arg_4:Boolean):void
        {
        }
        protected function increaseUpdateId():void
        {
            this._updateID++;
        }
        protected function reset():void
        {
            this._SafeStr_4455 = 0xFFFFFFFF;
            this._SafeStr_4365 = 0xFFFFFFFF;
            this._SafeStr_4369 = -1;
        }
        public function initialize(_arg_1:IRoomObjectVisualizationData):Boolean
        {
            return (false);
        }
        public function get image():BitmapData
        {
            return (this.getImage(0));
        }
        public function getImage(_arg_1:int):BitmapData
        {
            var _local_9:Number;
            var _local_10:Number;
            var _local_11:Number;
            var _local_12:int;
            var _local_13:int;
            var _local_14:int;
            var _local_15:int;
            var _local_16:ColorTransform;
            var _local_17:Matrix;
            var _local_2:Rectangle = this.boundingRectangle;
            if ((_local_2.width * _local_2.height) == 0){
                return (null);
            };
            var _local_3:int = this.spriteCount;
            var _local_4:IRoomObjectSprite;
            var _local_5:Array = [];
            var _local_6:int;
            var _local_7:BitmapData;
            _local_6 = 0;
            while (_local_6 < _local_3) {
                _local_4 = this.getSprite(_local_6);
                if (((!((_local_4 == null))) && (_local_4.visible))){
                    _local_7 = _local_4.asset;
                    if (_local_7 != null){
                        _local_5.push(_local_4);
                    };
                };
                _local_6++;
            };
            _local_5.sortOn("relativeDepth", (Array.DESCENDING | Array.NUMERIC));
            var _local_8:BitmapData = new BitmapData(_local_2.width, _local_2.height, true, _arg_1);
            _local_6 = 0;
            while (_local_6 < _local_5.length) {
                _local_4 = (_local_5[_local_6] as IRoomObjectSprite);
                _local_7 = _local_4.asset;
                if (_local_7 != null){
                    _local_12 = _local_4.color;
                    _local_13 = (_local_12 >> 16);
                    _local_14 = ((_local_12 >> 8) & 0xFF);
                    _local_15 = (_local_12 & 0xFF);
                    _local_16 = null;
                    if ((((((_local_13 < 0xFF)) || ((_local_14 < 0xFF)))) || ((_local_15 < 0xFF)))){
                        _local_9 = (_local_13 / 0xFF);
                        _local_10 = (_local_14 / 0xFF);
                        _local_11 = (_local_15 / 0xFF);
                        _local_16 = new ColorTransform(_local_9, _local_10, _local_11, (_local_4.alpha / 0xFF));
                    }
                    else {
                        if (_local_4.alpha < 0xFF){
                            _local_16 = new ColorTransform(1, 1, 1, (_local_4.alpha / 0xFF));
                        };
                    };
                    if (_arg_1 == 0){
                        if (_local_4.blendMode == BlendMode.ADD){
                            if (_local_16 == null){
                                _local_16 = new ColorTransform(1, 1, 1, 0);
                            }
                            else {
                                _local_16.alphaMultiplier = 0;
                            };
                        };
                    };
                    _local_17 = new Matrix();
                    if (_local_4.flipH){
                        _local_17.scale(-1, 1);
                        _local_17.translate(_local_7.width, 0);
                    };
                    if (_local_4.flipV){
                        _local_17.scale(1, -1);
                        _local_17.translate(0, _local_7.height);
                    };
                    _local_17.translate((_local_4.offsetX - _local_2.left), (_local_4.offsetY - _local_2.top));
                    _local_8.draw(_local_7, _local_17, _local_16, _local_4.blendMode, null, false);
                };
                _local_6++;
            };
            return (_local_8);
        }
        public function get boundingRectangle():Rectangle
        {
            var _local_7:Point;
            var _local_1:int = this.spriteCount;
            var _local_2:IRoomObjectSprite;
            var _local_3:Rectangle = new Rectangle();
            var _local_4:int;
            var _local_5:IAsset;
            var _local_6:BitmapData;
            _local_4 = 0;
            while (_local_4 < _local_1) {
                _local_2 = this.getSprite(_local_4);
                if (((!((_local_2 == null))) && (_local_2.visible))){
                    _local_6 = _local_2.asset;
                    if (_local_6 != null){
                        _local_7 = new Point(_local_2.offsetX, _local_2.offsetY);
                        if (_local_4 == 0){
                            _local_3.left = _local_7.x;
                            _local_3.top = _local_7.y;
                            _local_3.right = (_local_7.x + _local_2.width);
                            _local_3.bottom = (_local_7.y + _local_2.height);
                        }
                        else {
                            if (_local_7.x < _local_3.left){
                                _local_3.left = _local_7.x;
                            };
                            if (_local_7.y < _local_3.top){
                                _local_3.top = _local_7.y;
                            };
                            if ((_local_7.x + _local_2.width) > _local_3.right){
                                _local_3.right = (_local_7.x + _local_2.width);
                            };
                            if ((_local_7.y + _local_2.height) > _local_3.bottom){
                                _local_3.bottom = (_local_7.y + _local_2.height);
                            };
                        };
                    };
                };
                _local_4++;
            };
            return (_local_3);
        }

    }
}//package com.sulake.room.object.visualization

// IRoomObjectVisualizationData = "_-26A" (String#6167, DoABC#2)
// IGraphicAssetCollection = "_-24o" (String#6134, DoABC#2)
// IRoomObjectSpriteVisualization = "_-2Xc" (String#6715, DoABC#2)
// RoomObjectSpriteVisualization = "_-01y" (String#3602, DoABC#2)
// IRoomGeometry = "_-0z9" (String#4829, DoABC#2)
// IRoomObjectSprite = "_-0di" (String#4386, DoABC#2)
// RoomObjectSprite = "_-3D1" (String#7574, DoABC#2)
// getUpdateID = "_-Ga" (String#932, DoABC#2)
// _SafeStr_4365 = "_-2rK" (String#21130, DoABC#2)
// _SafeStr_4369 = "_-bP" (String#23689, DoABC#2)
// getSprite = "_-sN" (String#2210, DoABC#2)
// spriteCount = "_-2A7" (String#6252, DoABC#2)
// createSprites = "_-1Im" (String#17226, DoABC#2)
// _SafeStr_4455 = "_-0tm" (String#16194, DoABC#2)
// increaseUpdateId = "_-vd" (String#24514, DoABC#2)
// getImage = "_-eg" (String#2150, DoABC#2)
// boundingRectangle = "_-0m7" (String#4552, DoABC#2)
// _SafeStr_5547 = "_-2iI" (String#1928, DoABC#2)
// _sprites = "_-2vJ" (String#455, DoABC#2)
// _object = "_-ZQ" (String#8406, DoABC#2)
// _assetCollection = "_-2PR" (String#888, DoABC#2)
// _instanceId = "_-1cJ" (String#854, DoABC#2)
// addReference = "_-2F" (String#6343, DoABC#2)


