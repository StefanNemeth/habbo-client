
package com.sulake.habbo.room.object.visualization.room
{
    import flash.geom.Point;
    import com.sulake.room.utils.Vector3d;
    import flash.display.BitmapData;
    import com.sulake.habbo.room.object.visualization.room.rasterizer.IPlaneRasterizer;
    import com.sulake.habbo.room.object.visualization.room.mask.PlaneMaskManager;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.room.object.visualization.room.utils.PlaneBitmapData;
    import com.sulake.room.utils.IVector3d;
    import com.sulake.room.utils.IRoomGeometry;
    import com.sulake.habbo.room.object.visualization.room.utils.Randomizer;
    import flash.geom.Matrix;
    import flash.geom.Rectangle;
    import flash.display.BitmapDataChannel;
    import flash.display.BlendMode;

    public class RoomPlane 
    {

        private static const _SafeStr_12969:Point = new Point(0, 0);
        public static const _SafeStr_12937:int = 0;
        public static const _SafeStr_10277:int = 1;
        public static const _SafeStr_7291:int = 2;
        public static const TYPE_LANDSCAPE:int = 3;

        private var _disposed:Boolean = false;
        private var _SafeStr_12970:int = 0;
        private var _SafeStr_12792:Vector3d = null;
        private var _loc:Vector3d = null;
        private var _leftSide:Vector3d = null;
        private var _rightSide:Vector3d = null;
        private var _normal:Vector3d = null;
        private var _SafeStr_12971:Array;
        private var _geometryUpdateId:int = -1;
        private var _type:int = 0;
        private var _isVisible:Boolean = false;
        private var _bitmapData:BitmapData = null;
        private var _hasTexture:Boolean = true;
        private var _offset:Point = null;
        private var _relativeDepth:Number = 0;
        private var _color:uint = 0;
        private var _rasterizer:IPlaneRasterizer = null;
        private var _maskManager:PlaneMaskManager = null;
        private var _id:String = null;
        private var _SafeStr_12974:Number = 0;
        private var _SafeStr_12975:Number = 0;
        private var _SafeStr_12976:Number = 0;
        private var _SafeStr_12977:Number = 0;
        private var _SafeStr_12797:Map = null;
        private var _RoomPlane:PlaneBitmapData = null;
        private var _SafeStr_12979:Boolean = false;
        private var _SafeStr_12980:Array;
        private var _SafeStr_12981:Array;
        private var _SafeStr_12982:Boolean = false;
        private var _SafeStr_12707:BitmapData = null;
        private var _SafeStr_12983:BitmapData = null;
        private var _SafeStr_12984:Array;
        private var _SafeStr_12985:Array;
        private var _SafeStr_12800:Vector3d = null;
        private var _SafeStr_12801:Vector3d = null;
        private var _SafeStr_12802:Vector3d = null;
        private var _SafeStr_12803:Vector3d = null;
        private var _width:Number = 0;
        private var _height:Number = 0;
        private var _canBeVisible:Boolean = true;

        public function RoomPlane(_arg_1:IVector3d, _arg_2:IVector3d, _arg_3:IVector3d, _arg_4:IVector3d, _arg_5:int, _arg_6:Boolean, _arg_7:Array, _arg_8:int, _arg_9:Number=0, _arg_10:Number=0, _arg_11:Number=0, _arg_12:Number=0)
        {
            var _local_13:int;
            var _local_14:IVector3d;
            var _local_15:Vector3d;
            this._SafeStr_12971 = [];
            this._SafeStr_12980 = [];
            this._SafeStr_12981 = [];
            this._SafeStr_12984 = [];
            this._SafeStr_12985 = [];
            super();
            this._SafeStr_12970 = _arg_8;
            this._SafeStr_12792 = new Vector3d();
            this._SafeStr_12792.assign(_arg_1);
            this._loc = new Vector3d();
            this._loc.assign(_arg_2);
            this._leftSide = new Vector3d();
            this._leftSide.assign(_arg_3);
            this._rightSide = new Vector3d();
            this._rightSide.assign(_arg_4);
            this._normal = Vector3d.crossProduct(this._leftSide, this._rightSide);
            if (this._normal.length > 0){
                this._normal.mul((1 / this._normal.length));
            };
            if (_arg_7 != null){
                _local_13 = 0;
                while (_local_13 < _arg_7.length) {
                    _local_14 = (_arg_7[_local_13] as IVector3d);
                    if (_local_14 != null){
                        _local_15 = new Vector3d();
                        _local_15.assign(_local_14);
                        this._SafeStr_12971.push(_local_15);
                    };
                    _local_13++;
                };
            };
            this._offset = new Point();
            this._type = _arg_5;
            this._SafeStr_12797 = new Map();
            this._SafeStr_12800 = new Vector3d();
            this._SafeStr_12801 = new Vector3d();
            this._SafeStr_12802 = new Vector3d();
            this._SafeStr_12803 = new Vector3d();
            this._SafeStr_12974 = _arg_9;
            this._SafeStr_12975 = _arg_10;
            this._SafeStr_12976 = _arg_11;
            this._SafeStr_12977 = _arg_12;
            this._SafeStr_12979 = _arg_6;
        }
        public function set canBeVisible(_arg_1:Boolean):void
        {
            if (_arg_1 != this._canBeVisible){
                if (!this._canBeVisible){
                    this.RoomPlane();
                };
                this._canBeVisible = _arg_1;
            };
        }
        public function get canBeVisible():Boolean
        {
            return (this._canBeVisible);
        }
        public function get bitmapData():BitmapData
        {
            var bitmap:BitmapData;
            if (this.visible){
                if (this._bitmapData != null){
                    try {
                        bitmap = this._bitmapData.clone();
                    }
                    catch(e:Error) {
                    };
                };
            };
            return (bitmap);
        }
        public function get visible():Boolean
        {
            return (((this._isVisible) && (this._canBeVisible)));
        }
        public function get offset():Point
        {
            return (this._offset);
        }
        public function get relativeDepth():Number
        {
            return (this._relativeDepth);
        }
        public function get color():uint
        {
            return (this._color);
        }
        public function set color(_arg_1:uint):void
        {
            this._color = _arg_1;
        }
        public function get type():int
        {
            return (this._type);
        }
        public function get leftSide():IVector3d
        {
            return (this._leftSide);
        }
        public function get rightSide():IVector3d
        {
            return (this._rightSide);
        }
        public function get location():IVector3d
        {
            return (this._loc);
        }
        public function get normal():IVector3d
        {
            return (this._normal);
        }
        public function get hasTexture():Boolean
        {
            return (this._hasTexture);
        }
        public function set hasTexture(_arg_1:Boolean):void
        {
            this._hasTexture = _arg_1;
        }
        public function set rasterizer(_arg_1:IPlaneRasterizer):void
        {
            this._rasterizer = _arg_1;
        }
        public function set maskManager(_arg_1:PlaneMaskManager):void
        {
            this._maskManager = _arg_1;
        }
        public function set id(_arg_1:String):void
        {
            if (_arg_1 != this._id){
                this.RoomPlane();
                this._id = _arg_1;
            };
        }
        public function dispose():void
        {
            var _local_1:int;
            var _local_2:PlaneBitmapData;
            if (this._bitmapData != null){
                this._bitmapData.dispose();
                this._bitmapData = null;
            };
            if (this._SafeStr_12797 != null){
                _local_1 = 0;
                while (_local_1 < this._SafeStr_12797.length) {
                    _local_2 = (this._SafeStr_12797.getWithIndex(_local_1) as PlaneBitmapData);
                    if (_local_2 != null){
                        if (_local_2.bitmap != null){
                            _local_2.bitmap.dispose();
                        };
                        _local_2.dispose();
                    };
                    _local_1++;
                };
                this._SafeStr_12797.dispose();
                this._SafeStr_12797 = null;
            };
            this._RoomPlane = null;
            this._loc = null;
            this._SafeStr_12792 = null;
            this._leftSide = null;
            this._rightSide = null;
            this._normal = null;
            this._rasterizer = null;
            this._SafeStr_12800 = null;
            this._SafeStr_12801 = null;
            this._SafeStr_12802 = null;
            this._SafeStr_12803 = null;
            this._SafeStr_12980 = null;
            this._SafeStr_12981 = null;
            if (this._SafeStr_12707 != null){
                this._SafeStr_12707.dispose();
                this._SafeStr_12707 = null;
            };
            if (this._SafeStr_12983 != null){
                this._SafeStr_12983.dispose();
                this._SafeStr_12983 = null;
            };
            this._disposed = true;
        }
        public function RoomPlane(_arg_1:BitmapData):BitmapData
        {
            if (this.visible){
                if (((!((this._bitmapData == null))) && (!((_arg_1 == null))))){
                    if ((((this._bitmapData.width == _arg_1.width)) && ((this._bitmapData.height == _arg_1.height)))){
                        _arg_1.copyPixels(this._bitmapData, this._bitmapData.rect, _SafeStr_12969);
                        return (_arg_1);
                    };
                };
            };
            return (null);
        }
        private function RoomPlane(_arg_1:String, _arg_2:PlaneBitmapData):Boolean
        {
            var _local_3:PlaneBitmapData = (this._SafeStr_12797.remove(_arg_1) as PlaneBitmapData);
            if (_local_3 != null){
                if (((!((_arg_2 == null))) && (!((_arg_2.bitmap == _local_3.bitmap))))){
                    _local_3.bitmap.dispose();
                };
                _local_3.dispose();
            };
            this._RoomPlane = _arg_2;
            this._SafeStr_12797.add(_arg_1, _arg_2);
            return (true);
        }
        private function RoomPlane(_arg_1:BitmapData=null):void
        {
            var _local_2:int;
            var _local_3:PlaneBitmapData;
            if (this._SafeStr_12797 != null){
                _local_2 = 0;
                while (_local_2 < this._SafeStr_12797.length) {
                    _local_3 = (this._SafeStr_12797.getWithIndex(_local_2) as PlaneBitmapData);
                    if (_local_3 != null){
                        if (((!((_local_3.bitmap == null))) && (!((_local_3.bitmap == _arg_1))))){
                            _local_3.bitmap.dispose();
                        };
                        _local_3.dispose();
                    };
                    _local_2++;
                };
                this._SafeStr_12797.reset();
            };
            this._RoomPlane = null;
        }
        private function getTextureIdentifier(_arg_1:Number):String
        {
            if (this._rasterizer != null){
                return (this._rasterizer.getTextureIdentifier(_arg_1, this.normal));
            };
            return (String(_arg_1));
        }
        private function needsNewTexture(_arg_1:IRoomGeometry, _arg_2:int):Boolean
        {
            var _local_4:String;
            if (_arg_1 == null){
                return (false);
            };
            var _local_3:PlaneBitmapData = this._RoomPlane;
            if (_local_3 == null){
                _local_4 = this.getTextureIdentifier(_arg_1.scale);
                _local_3 = (this._SafeStr_12797.getValue(_local_4) as PlaneBitmapData);
            };
            this.updateMaskChangeStatus();
            if (((this._canBeVisible) && ((((((_local_3 == null)) || ((((_local_3.timeStamp >= 0)) && ((_arg_2 > _local_3.timeStamp)))))) || (this._SafeStr_12982))))){
                return (true);
            };
            return (false);
        }
        private function getTexture(_arg_1:IRoomGeometry, _arg_2:int):BitmapData
        {
            var _local_5:Number;
            var _local_6:Number;
            var _local_7:IVector3d;
            var _local_8:BitmapData;
            var _local_9:BitmapData;
            if (_arg_1 == null){
                return (null);
            };
            var _local_3:PlaneBitmapData;
            var _local_4:String;
            if (this.needsNewTexture(_arg_1, _arg_2)){
                _local_5 = (this._leftSide.length * _arg_1.scale);
                _local_6 = (this._rightSide.length * _arg_1.scale);
                _local_7 = _arg_1.RoomGeometry(this._normal);
                _local_4 = this.getTextureIdentifier(_arg_1.scale);
                if (this._RoomPlane != null){
                    _local_3 = this._RoomPlane;
                }
                else {
                    _local_3 = (this._SafeStr_12797.getValue(_local_4) as PlaneBitmapData);
                };
                _local_8 = null;
                if (_local_3 != null){
                    _local_8 = _local_3.bitmap;
                };
                if (this._rasterizer != null){
                    _local_3 = this._rasterizer.render(_local_8, this._id, _local_5, _local_6, _arg_1.scale, _local_7, this._hasTexture, this._SafeStr_12974, this._SafeStr_12975, this._SafeStr_12976, this._SafeStr_12977, _arg_2);
                    if (_local_3 != null){
                        if (((!((_local_8 == null))) && (!((_local_3.bitmap == _local_8))))){
                            _local_8.dispose();
                        };
                    };
                }
                else {
                    _local_9 = new BitmapData(_local_5, _local_6, true, (0xFF000000 | this._color));
                    _local_3 = new PlaneBitmapData(_local_9, -1);
                };
                if (_local_3 != null){
                    this.PlaneMaskManager(_local_3.bitmap, _arg_1);
                    this.RoomPlane(_local_4, _local_3);
                };
            }
            else {
                if (this._RoomPlane != null){
                    _local_3 = this._RoomPlane;
                }
                else {
                    _local_4 = this.getTextureIdentifier(_arg_1.scale);
                    _local_3 = (this._SafeStr_12797.getValue(_local_4) as PlaneBitmapData);
                };
            };
            if (_local_3 != null){
                this._RoomPlane = _local_3;
                return (_local_3.bitmap);
            };
            return (null);
        }
        private function addOutlines(_arg_1:PlaneBitmapData):void
        {
        }
        public function update(geometry:IRoomGeometry, timeSinceStartMs:int):Boolean
        {
            var cosAngle:Number;
            var i:int;
            var originPos:IVector3d;
            var originZ:Number;
            var relativeDepth:Number;
            var texture:BitmapData;
            if ((((geometry == null)) || (this._disposed))){
                return (false);
            };
            var geometryChanged:Boolean;
            if (this._geometryUpdateId != geometry.updateId){
                geometryChanged = true;
            };
            if (((!(geometryChanged)) || (!(this._canBeVisible)))){
                if (!this.visible){
                    return (false);
                };
            };
            if (geometryChanged){
                this._RoomPlane = null;
                cosAngle = 0;
                cosAngle = Vector3d.cosAngle(geometry.directionAxis, this.normal);
                if (cosAngle > -0.001){
                    if (this._isVisible){
                        this._isVisible = false;
                        return (true);
                    };
                    return (false);
                };
                i = 0;
                while (i < this._SafeStr_12971.length) {
                    cosAngle = Vector3d.cosAngle(geometry.directionAxis, this._SafeStr_12971[i]);
                    if (cosAngle > -0.001){
                        if (this._isVisible){
                            this._isVisible = false;
                            return (true);
                        };
                        return (false);
                    };
                    i = (i + 1);
                };
                this.updateCorners(geometry);
                originPos = geometry.RoomGeometry(this._SafeStr_12792);
                originZ = originPos.z;
                relativeDepth = Math.max((this._SafeStr_12800.z - originZ), (this._SafeStr_12801.z - originZ), (this._SafeStr_12802.z - originZ), (this._SafeStr_12803.z - originZ));
                if (this._type == TYPE_LANDSCAPE){
                    relativeDepth = (relativeDepth + 0.02);
                };
                this._relativeDepth = relativeDepth;
                this._isVisible = true;
                this._geometryUpdateId = geometry.updateId;
            };
            if (((geometryChanged) || (this.needsNewTexture(geometry, timeSinceStartMs)))){
                if ((((((this._bitmapData == null)) || (!((this._width == this._bitmapData.width))))) || (!((this._height == this._bitmapData.height))))){
                    if (this._bitmapData != null){
                        this._bitmapData.dispose();
                        this._bitmapData = null;
                        if ((((this._width < 1)) || ((this._height < 1)))){
                            return (true);
                        };
                    }
                    else {
                        if ((((this._width < 1)) || ((this._height < 1)))){
                            return (false);
                        };
                    };
                    try {
                        this._bitmapData = new BitmapData(this._width, this._height, true, 0xFFFFFF);
                    }
                    catch(e:Error) {
                        _bitmapData = null;
                    };
                    if (this._bitmapData == null){
                        return (false);
                    };
                    this._bitmapData.lock();
                }
                else {
                    this._bitmapData.lock();
                    this._bitmapData.fillRect(this._bitmapData.rect, 0xFFFFFF);
                };
                Randomizer.setSeed(this._SafeStr_12970);
                texture = this.getTexture(geometry, timeSinceStartMs);
                if (texture != null){
                    this.renderTexture(geometry, texture);
                };
                this._bitmapData.unlock();
                return (true);
            };
            return (false);
        }
        private function updateCorners(_arg_1:IRoomGeometry):void
        {
            this._SafeStr_12800.assign(_arg_1.RoomGeometry(this._loc));
            this._SafeStr_12801.assign(_arg_1.RoomGeometry(Vector3d.sum(this._loc, this._rightSide)));
            this._SafeStr_12802.assign(_arg_1.RoomGeometry(Vector3d.sum(Vector3d.sum(this._loc, this._leftSide), this._rightSide)));
            this._SafeStr_12803.assign(_arg_1.RoomGeometry(Vector3d.sum(this._loc, this._leftSide)));
            this._offset = _arg_1.RoomGeometry(this._SafeStr_12792);
            this._SafeStr_12800.x = Math.round(this._SafeStr_12800.x);
            this._SafeStr_12800.y = Math.round(this._SafeStr_12800.y);
            this._SafeStr_12801.x = Math.round(this._SafeStr_12801.x);
            this._SafeStr_12801.y = Math.round(this._SafeStr_12801.y);
            this._SafeStr_12802.x = Math.round(this._SafeStr_12802.x);
            this._SafeStr_12802.y = Math.round(this._SafeStr_12802.y);
            this._SafeStr_12803.x = Math.round(this._SafeStr_12803.x);
            this._SafeStr_12803.y = Math.round(this._SafeStr_12803.y);
            this._offset.x = Math.round(this._offset.x);
            this._offset.y = Math.round(this._offset.y);
            var _local_2:Number = Math.min(this._SafeStr_12800.x, this._SafeStr_12801.x, this._SafeStr_12802.x, this._SafeStr_12803.x);
            var _local_3:Number = Math.max(this._SafeStr_12800.x, this._SafeStr_12801.x, this._SafeStr_12802.x, this._SafeStr_12803.x);
            var _local_4:Number = Math.min(this._SafeStr_12800.y, this._SafeStr_12801.y, this._SafeStr_12802.y, this._SafeStr_12803.y);
            var _local_5:Number = Math.max(this._SafeStr_12800.y, this._SafeStr_12801.y, this._SafeStr_12802.y, this._SafeStr_12803.y);
            _local_3 = (_local_3 - _local_2);
            this._offset.x = (this._offset.x - _local_2);
            this._SafeStr_12800.x = (this._SafeStr_12800.x - _local_2);
            this._SafeStr_12801.x = (this._SafeStr_12801.x - _local_2);
            this._SafeStr_12802.x = (this._SafeStr_12802.x - _local_2);
            this._SafeStr_12803.x = (this._SafeStr_12803.x - _local_2);
            _local_5 = (_local_5 - _local_4);
            this._offset.y = (this._offset.y - _local_4);
            this._SafeStr_12800.y = (this._SafeStr_12800.y - _local_4);
            this._SafeStr_12801.y = (this._SafeStr_12801.y - _local_4);
            this._SafeStr_12802.y = (this._SafeStr_12802.y - _local_4);
            this._SafeStr_12803.y = (this._SafeStr_12803.y - _local_4);
            this._width = _local_3;
            this._height = _local_5;
        }
        private function renderTexture(_arg_1:IRoomGeometry, _arg_2:BitmapData):void
        {
            if ((((((((((((this._SafeStr_12800 == null)) || ((this._SafeStr_12801 == null)))) || ((this._SafeStr_12802 == null)))) || ((this._SafeStr_12803 == null)))) || ((_arg_2 == null)))) || ((this._bitmapData == null)))){
                return;
            };
            var _local_3:Number = (this._SafeStr_12803.x - this._SafeStr_12802.x);
            var _local_4:Number = (this._SafeStr_12803.y - this._SafeStr_12802.y);
            var _local_5:Number = (this._SafeStr_12801.x - this._SafeStr_12802.x);
            var _local_6:Number = (this._SafeStr_12801.y - this._SafeStr_12802.y);
            if ((((this._type == _SafeStr_10277)) || ((this._type == TYPE_LANDSCAPE)))){
                if (Math.abs((_local_5 - _arg_2.width)) <= 1){
                    _local_5 = _arg_2.width;
                };
                if (Math.abs((_local_6 - _arg_2.width)) <= 1){
                    _local_6 = _arg_2.width;
                };
                if (Math.abs((_local_3 - _arg_2.height)) <= 1){
                    _local_3 = _arg_2.height;
                };
                if (Math.abs((_local_4 - _arg_2.height)) <= 1){
                    _local_4 = _arg_2.height;
                };
            };
            var _local_7:Number = (_local_5 / _arg_2.width);
            var _local_8:Number = (_local_6 / _arg_2.width);
            var _local_9:Number = (_local_3 / _arg_2.height);
            var _local_10:Number = (_local_4 / _arg_2.height);
            var _local_11:Matrix = new Matrix();
            _local_11.a = _local_7;
            _local_11.b = _local_8;
            _local_11.c = _local_9;
            _local_11.d = _local_10;
            _local_11.translate(this._SafeStr_12802.x, this._SafeStr_12802.y);
            this.draw(_arg_2, _local_11);
        }
        private function draw(_arg_1:BitmapData, _arg_2:Matrix):void
        {
            var _local_3:int;
            var _local_4:int;
            var _local_5:Number;
            var _local_6:int;
            var _local_7:int;
            if (this._bitmapData != null){
                if ((((((((((((_arg_2.a == 1)) && ((_arg_2.d == 1)))) && ((_arg_2.c == 0)))) && (!((_arg_2.b == 0))))) && ((Math.abs(_arg_2.b) <= 1)))) && ((((this._type == _SafeStr_10277)) || ((this._type == TYPE_LANDSCAPE)))))){
                    _local_3 = 0;
                    _local_4 = 0;
                    _local_5 = 0;
                    _local_6 = 0;
                    if (_arg_2.b > 0){
                        _arg_2.ty++;
                    };
                    _local_7 = 0;
                    while (_local_3 < _arg_1.width) {
                        _local_3++;
                        _local_5 = (_local_5 + Math.abs(_arg_2.b));
                        if (_local_5 >= 1){
                            this._bitmapData.copyPixels(_arg_1, new Rectangle((_local_4 + _local_6), 0, (_local_3 - _local_4), _arg_1.height), new Point((_arg_2.tx + _local_4), (_arg_2.ty + _local_7)), null, null, true);
                            _local_4 = _local_3;
                            if (_arg_2.b > 0){
                                _local_7++;
                            }
                            else {
                                _local_7--;
                            };
                            _local_5 = 0;
                        };
                    };
                    if (_local_5 > 0){
                        this._bitmapData.copyPixels(_arg_1, new Rectangle(_local_4, 0, (_local_3 - _local_4), _arg_1.height), new Point((_arg_2.tx + _local_4), (_arg_2.ty + _local_7)), null, null, true);
                    };
                    return;
                };
                this._bitmapData.draw(_arg_1, _arg_2, null, null, null, false);
            };
        }
        public function resetBitmapMasks():void
        {
            if (this._SafeStr_12979){
                if (this._SafeStr_12980.length == 0){
                    return;
                };
                this._SafeStr_12982 = true;
                this._SafeStr_12980 = [];
            };
        }
        public function addBitmapMask(_arg_1:String, _arg_2:Number, _arg_3:Number):Boolean
        {
            var _local_4:RoomPlaneBitmapMask;
            var _local_5:int;
            if (this._SafeStr_12979){
                _local_4 = null;
                _local_5 = 0;
                while (_local_5 < this._SafeStr_12980.length) {
                    _local_4 = (this._SafeStr_12980[_local_5] as RoomPlaneBitmapMask);
                    if (_local_4 != null){
                        if ((((((_local_4.type == _arg_1)) && ((_local_4.leftSideLoc == _arg_2)))) && ((_local_4.rightSideLoc == _arg_3)))){
                            return (false);
                        };
                    };
                    _local_5++;
                };
                _local_4 = new RoomPlaneBitmapMask(_arg_1, _arg_2, _arg_3);
                this._SafeStr_12980.push(_local_4);
                this._SafeStr_12982 = true;
                return (true);
            };
            return (false);
        }
        public function resetRectangleMasks():void
        {
            if (this._SafeStr_12979){
                if (this._SafeStr_12981.length == 0){
                    return;
                };
                this._SafeStr_12982 = true;
                this._SafeStr_12981 = [];
            };
        }
        public function addRectangleMask(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number):Boolean
        {
            var _local_5:RoomPlaneRectangleMask;
            var _local_6:int;
            if (this._SafeStr_12979){
                _local_5 = null;
                _local_6 = 0;
                while (_local_6 < this._SafeStr_12981.length) {
                    _local_5 = (this._SafeStr_12981[_local_6] as RoomPlaneRectangleMask);
                    if (_local_5 != null){
                        if ((((((((_local_5.leftSideLoc == _arg_1)) && ((_local_5.rightSideLoc == _arg_2)))) && ((_local_5.leftSideLength == _arg_3)))) && ((_local_5.rightSideLength == _arg_4)))){
                            return (false);
                        };
                    };
                    _local_6++;
                };
                _local_5 = new RoomPlaneRectangleMask(_arg_1, _arg_2, _arg_3, _arg_4);
                this._SafeStr_12981.push(_local_5);
                this._SafeStr_12982 = true;
                return (true);
            };
            return (false);
        }
        private function updateMaskChangeStatus():void
        {
            var _local_6:Boolean;
            var _local_7:RoomPlaneBitmapMask;
            if (!this._SafeStr_12982){
                return;
            };
            var _local_1:int;
            var _local_2:int;
            var _local_3:Boolean = true;
            var _local_4:RoomPlaneBitmapMask;
            var _local_5:RoomPlaneRectangleMask;
            if (this._SafeStr_12980.length == this._SafeStr_12984.length){
                while (_local_1 < this._SafeStr_12980.length) {
                    _local_4 = (this._SafeStr_12980[_local_1] as RoomPlaneBitmapMask);
                    if (_local_4 != null){
                        _local_6 = false;
                        while (_local_2 < this._SafeStr_12984.length) {
                            _local_7 = (this._SafeStr_12984[_local_2] as RoomPlaneBitmapMask);
                            if (_local_7 != null){
                                if ((((((_local_7.type == _local_4.type)) && ((_local_7.leftSideLoc == _local_4.leftSideLoc)))) && ((_local_7.rightSideLoc == _local_4.rightSideLoc)))){
                                    _local_6 = true;
                                    break;
                                };
                            };
                            _local_2++;
                        };
                        if (!_local_6){
                            _local_3 = false;
                            break;
                        };
                    };
                    _local_1++;
                };
            }
            else {
                _local_3 = false;
            };
            if (this._SafeStr_12981.length > this._SafeStr_12985.length){
                _local_3 = false;
            };
            if (_local_3){
                this._SafeStr_12982 = false;
            };
        }
        private function PlaneMaskManager(_arg_1:BitmapData, _arg_2:IRoomGeometry):void
        {
            var _local_9:IVector3d;
            var _local_10:int;
            var _local_11:int;
            var _local_12:String;
            var _local_13:int;
            var _local_14:int;
            if (((((!(this._SafeStr_12979)) || ((((((this._SafeStr_12980.length == 0)) && ((this._SafeStr_12981.length == 0)))) && (!(this._SafeStr_12982)))))) || ((this._maskManager == null)))){
                return;
            };
            if ((((_arg_1 == null)) || ((_arg_2 == null)))){
                return;
            };
            var _local_3:RoomPlaneBitmapMask;
            var _local_4:RoomPlaneRectangleMask;
            var _local_5:int;
            var _local_6:int;
            this.updateMaskChangeStatus();
            var _local_7:Number = _arg_1.width;
            var _local_8:Number = _arg_1.height;
            if ((((((this._SafeStr_12707 == null)) || (!((this._SafeStr_12707.width == _local_7))))) || (!((this._SafeStr_12707.height == _local_8))))){
                if (this._SafeStr_12707 != null){
                    this._SafeStr_12707.dispose();
                    this._SafeStr_12707 = null;
                };
                this._SafeStr_12707 = new BitmapData(_local_7, _local_8, true, 0xFFFFFF);
                this._SafeStr_12982 = true;
            };
            if (this._SafeStr_12982){
                this._SafeStr_12984 = [];
                this._SafeStr_12985 = [];
                if (this._SafeStr_12707 != null){
                    this._SafeStr_12707.fillRect(this._SafeStr_12707.rect, 0xFFFFFF);
                };
                this.RoomPlane(_arg_1);
                _local_9 = _arg_2.RoomGeometry(this._normal);
                _local_10 = 0;
                _local_11 = 0;
                _local_5 = 0;
                while (_local_5 < this._SafeStr_12980.length) {
                    _local_3 = (this._SafeStr_12980[_local_5] as RoomPlaneBitmapMask);
                    if (_local_3 != null){
                        _local_10 = (this._SafeStr_12707.width - ((this._SafeStr_12707.width * _local_3.leftSideLoc) / this._leftSide.length));
                        _local_11 = (this._SafeStr_12707.height - ((this._SafeStr_12707.height * _local_3.rightSideLoc) / this._rightSide.length));
                        _local_12 = _local_3.type;
                        this._maskManager.PlaneMaskManager(this._SafeStr_12707, _local_12, _arg_2.scale, _local_9, _local_10, _local_11);
                        this._SafeStr_12984.push(new RoomPlaneBitmapMask(_local_12, _local_3.leftSideLoc, _local_3.rightSideLoc));
                    };
                    _local_5++;
                };
                _local_6 = 0;
                while (_local_6 < this._SafeStr_12981.length) {
                    _local_4 = (this._SafeStr_12981[_local_6] as RoomPlaneRectangleMask);
                    if (_local_4 != null){
                        _local_10 = (this._SafeStr_12707.width - ((this._SafeStr_12707.width * _local_4.leftSideLoc) / this._leftSide.length));
                        _local_11 = (this._SafeStr_12707.height - ((this._SafeStr_12707.height * _local_4.rightSideLoc) / this._rightSide.length));
                        _local_13 = ((this._SafeStr_12707.width * _local_4.leftSideLength) / this._leftSide.length);
                        _local_14 = ((this._SafeStr_12707.height * _local_4.rightSideLength) / this._rightSide.length);
                        this._SafeStr_12707.fillRect(new Rectangle((_local_10 - _local_13), (_local_11 - _local_14), _local_13, _local_14), 0xFF000000);
                        this._SafeStr_12985.push(new RoomPlaneRectangleMask(_local_4.leftSideLength, _local_4.rightSideLoc, _local_4.leftSideLength, _local_4.rightSideLength));
                    };
                    _local_6++;
                };
                this._SafeStr_12982 = false;
            };
            this.combineTextureMask(_arg_1, this._SafeStr_12707);
        }
        private function combineTextureMask(_arg_1:BitmapData, _arg_2:BitmapData):void
        {
            if ((((_arg_1 == null)) || ((_arg_2 == null)))){
                return;
            };
            if (((!((this._SafeStr_12983 == null))) && (((!((this._SafeStr_12983.width == _arg_1.width))) || (!((this._SafeStr_12983.height == _arg_1.height))))))){
                this._SafeStr_12983.dispose();
                this._SafeStr_12983 = null;
            };
            if (this._SafeStr_12983 == null){
                this._SafeStr_12983 = new BitmapData(_arg_1.width, _arg_1.height, true, 0xFFFFFFFF);
            };
            this._SafeStr_12983.copyChannel(_arg_1, _arg_1.rect, _SafeStr_12969, BitmapDataChannel.ALPHA, BitmapDataChannel.RED);
            this._SafeStr_12983.draw(_arg_2, null, null, BlendMode.DARKEN);
            _arg_1.copyChannel(this._SafeStr_12983, this._SafeStr_12983.rect, _SafeStr_12969, BitmapDataChannel.RED, BitmapDataChannel.ALPHA);
        }

    }
}//package com.sulake.habbo.room.object.visualization.room

// _SafeStr_10277 = "_-2s7" (String#21163, DoABC#2)
// _SafeStr_12707 = "_-15f" (String#4989, DoABC#2)
// crossProduct = "_-0hD" (String#15719, DoABC#2)
// _SafeStr_12792 = "_-0Rs" (String#4134, DoABC#2)
// _leftSide = "_-2Fc" (String#1844, DoABC#2)
// _rightSide = "_-0yh" (String#1588, DoABC#2)
// _SafeStr_12797 = "_-2x-" (String#1970, DoABC#2)
// _relativeDepth = "_-2ez" (String#6852, DoABC#2)
// _SafeStr_12800 = "_-0Uu" (String#4202, DoABC#2)
// _SafeStr_12801 = "_-QF" (String#8206, DoABC#2)
// _SafeStr_12802 = "_-2bw" (String#6793, DoABC#2)
// _SafeStr_12803 = "_-2iY" (String#6922, DoABC#2)
// leftSide = "_-3Gi" (String#22151, DoABC#2)
// rightSide = "_-kB" (String#24043, DoABC#2)
// RoomPlane = "_-0af" (String#4316, DoABC#2)
// RoomPlane = "_-0-U" (String#3554, DoABC#2)
// needsNewTexture = "_-17R" (String#5025, DoABC#2)
// getTexture = "_-2Aw" (String#1826, DoABC#2)
// RoomGeometry = "_-05e" (String#3679, DoABC#2)
// directionAxis = "_-3Gq" (String#7644, DoABC#2)
// updateCorners = "_-1c6" (String#5602, DoABC#2)
// RoomGeometry = "_-1QP" (String#5358, DoABC#2)
// renderTexture = "_-ux" (String#8783, DoABC#2)
// PlaneMaskManager = "_-1EK" (String#5149, DoABC#2)
// _maskManager = "_-2lS" (String#6990, DoABC#2)
// maskManager = "_-2sw" (String#21196, DoABC#2)
// _SafeStr_12937 = "_-Z1" (String#23602, DoABC#2)
// IVector3d = "_-hf" (String#8547, DoABC#2)
// hasTexture = "_-sP" (String#24377, DoABC#2)
// rasterizer = "_-1Bj" (String#16931, DoABC#2)
// Vector3d = "_-1Rb" (String#17568, DoABC#2)
// addRectangleMask = "_-1aF" (String#17905, DoABC#2)
// RoomPlane = "_-1Eg" (String#17056, DoABC#2)
// resetBitmapMasks = "_-1Ab" (String#16883, DoABC#2)
// addBitmapMask = "_-1GD" (String#17124, DoABC#2)
// _SafeStr_12969 = "_-0Bv" (String#1423, DoABC#2)
// _SafeStr_12970 = "_-17J" (String#16748, DoABC#2)
// _SafeStr_12971 = "_-1Kc" (String#5254, DoABC#2)
// _hasTexture = "_-1fK" (String#18110, DoABC#2)
// _rasterizer = "_-Bs" (String#22682, DoABC#2)
// _SafeStr_12974 = "_-1cd" (String#17995, DoABC#2)
// _SafeStr_12975 = "_-36v" (String#21762, DoABC#2)
// _SafeStr_12976 = "_-2v-" (String#21277, DoABC#2)
// _SafeStr_12977 = "_-0eK" (String#15599, DoABC#2)
// _RoomPlane = "_-0-T" (String#14031, DoABC#2)
// _SafeStr_12979 = "_-eK" (String#8490, DoABC#2)
// _SafeStr_12980 = "_-0yv" (String#16389, DoABC#2)
// _SafeStr_12981 = "_-1LR" (String#17330, DoABC#2)
// _SafeStr_12982 = "_-kK" (String#24047, DoABC#2)
// _SafeStr_12983 = "_-38Q" (String#21820, DoABC#2)
// _SafeStr_12984 = "_-fx" (String#23888, DoABC#2)
// _SafeStr_12985 = "_-0ZK" (String#15415, DoABC#2)
// _canBeVisible = "_-2XR" (String#20339, DoABC#2)
// updateMaskChangeStatus = "_-0Uo" (String#15235, DoABC#2)
// addOutlines = "_-0i" (String#15749, DoABC#2)
// rightSideLoc = "_-0jZ" (String#15810, DoABC#2)
// leftSideLoc = "_-38V" (String#21822, DoABC#2)
// resetRectangleMasks = "_-22h" (String#19119, DoABC#2)
// rightSideLength = "_-3HX" (String#22181, DoABC#2)
// leftSideLength = "_-bH" (String#23681, DoABC#2)
// combineTextureMask = "_-1zK" (String#18940, DoABC#2)
// IRoomGeometry = "_-0z9" (String#4829, DoABC#2)
// IPlaneRasterizer = "_-2El" (String#6336, DoABC#2)
// PlaneMaskManager = "_-Dt" (String#7949, DoABC#2)
// RoomPlane = "_-04m" (String#3662, DoABC#2)
// PlaneBitmapData = "_-2Mg" (String#6493, DoABC#2)
// Randomizer = "_-FS" (String#7982, DoABC#2)
// RoomPlaneRectangleMask = "_-1Qd" (String#5362, DoABC#2)
// RoomPlaneBitmapMask = "_-Nl" (String#8160, DoABC#2)
// _width = "_-0Uq" (String#92, DoABC#2)
// _geometryUpdateId = "_-2yN" (String#370, DoABC#2)
// updateId = "_-0TD" (String#1478, DoABC#2)
// setSeed = "_-2fM" (String#20662, DoABC#2)
// getTextureIdentifier = "_-0yx" (String#829, DoABC#2)
// RoomGeometry = "_-34h" (String#7403, DoABC#2)
// _loc = "_-0OE" (String#185, DoABC#2)
// mul = "_-tH" (String#24418, DoABC#2)
// _SafeStr_7291 = "_-00x" (String#1383, DoABC#2)


