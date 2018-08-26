
package com.sulake.habbo.room.object.visualization.furniture
{
    import com.sulake.room.utils.Vector3d;
    import flash.display.BitmapData;
    import com.sulake.core.utils.Map;
    import flash.geom.Point;
    import com.sulake.room.utils.IVector3d;
    import com.sulake.room.utils.IRoomGeometry;
    import flash.geom.Matrix;
    import flash.geom.Rectangle;

    public class FurniturePlane 
    {

        private var _geometryUpdateId:int = -1;
        private var _SafeStr_12788:Number = 0;
        private var _SafeStr_12789:Number = 0;
        private var _SafeStr_12790:Number = 0;
        private var _SafeStr_12791:Number = 0;
        private var _SafeStr_12792:Vector3d = null;
        private var _loc:Vector3d = null;
        private var _leftSide:Vector3d = null;
        private var _rightSide:Vector3d = null;
        private var _SafeStr_12795:Vector3d = null;
        private var _SafeStr_12796:Vector3d = null;
        private var _normal:Vector3d = null;
        private var _isVisible:Boolean = true;
        private var _bitmapData:BitmapData = null;
        private var _SafeStr_12797:Map = null;
        private var _offset:Point = null;
        private var _relativeDepth:Number = 0;
        private var _color:uint = 0;
        private var _SafeStr_12799:Boolean = false;
        private var _id:String = null;
        private var _SafeStr_12800:Vector3d = null;
        private var _SafeStr_12801:Vector3d = null;
        private var _SafeStr_12802:Vector3d = null;
        private var _SafeStr_12803:Vector3d = null;
        private var _width:Number = 0;
        private var _height:Number = 0;

        public function FurniturePlane(_arg_1:IVector3d, _arg_2:IVector3d, _arg_3:IVector3d)
        {
            this._SafeStr_12792 = new Vector3d();
            this._loc = new Vector3d();
            this._loc.assign(_arg_1);
            this._leftSide = new Vector3d();
            this._leftSide.assign(_arg_2);
            this._rightSide = new Vector3d();
            this._rightSide.assign(_arg_3);
            this._SafeStr_12795 = new Vector3d();
            this._SafeStr_12795.assign(_arg_2);
            this._SafeStr_12796 = new Vector3d();
            this._SafeStr_12796.assign(_arg_3);
            this._normal = Vector3d.crossProduct(this._leftSide, this._rightSide);
            if (this._normal.length > 0){
                this._normal.mul((1 / this._normal.length));
            };
            this._offset = new Point();
            this._SafeStr_12800 = new Vector3d();
            this._SafeStr_12801 = new Vector3d();
            this._SafeStr_12802 = new Vector3d();
            this._SafeStr_12803 = new Vector3d();
            this._SafeStr_12797 = new Map();
        }
        public function get bitmapData():BitmapData
        {
            if (this._isVisible){
                if (this._bitmapData != null){
                    return (this._bitmapData.clone());
                };
            };
            return (null);
        }
        public function get visible():Boolean
        {
            return (this._isVisible);
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
        public function dispose():void
        {
            var _local_1:int;
            var _local_2:BitmapData;
            if (this._bitmapData != null){
                this._bitmapData.dispose();
                this._bitmapData = null;
            };
            if (this._SafeStr_12797 != null){
                _local_1 = 0;
                while (_local_1 < this._SafeStr_12797.length) {
                    _local_2 = (this._SafeStr_12797.getWithIndex(_local_1) as BitmapData);
                    if (_local_2 != null){
                        _local_2.dispose();
                    };
                    _local_1++;
                };
                this._SafeStr_12797.dispose();
                this._SafeStr_12797 = null;
            };
            this._SafeStr_12792 = null;
            this._loc = null;
            this._leftSide = null;
            this._rightSide = null;
            this._SafeStr_12795 = null;
            this._SafeStr_12796 = null;
            this._normal = null;
            this._SafeStr_12800 = null;
            this._SafeStr_12801 = null;
            this._SafeStr_12802 = null;
            this._SafeStr_12803 = null;
        }
        public function FurniturePlane(_arg_1:Boolean):void
        {
            if (_arg_1 != this._SafeStr_12799){
                if (!_arg_1){
                    this._leftSide.assign(this._SafeStr_12795);
                    this._rightSide.assign(this._SafeStr_12796);
                }
                else {
                    this._leftSide.assign(this._SafeStr_12795);
                    this._leftSide.mul((this._SafeStr_12796.length / this._SafeStr_12795.length));
                    this._rightSide.assign(this._SafeStr_12796);
                    this._rightSide.mul((this._SafeStr_12795.length / this._SafeStr_12796.length));
                };
                this._geometryUpdateId = -1;
                this._SafeStr_12788 = (this._SafeStr_12788 - 1);
                this._SafeStr_12799 = _arg_1;
                this.RoomPlane();
            };
        }
        private function RoomPlane(_arg_1:String, _arg_2:BitmapData):Boolean
        {
            var _local_3:BitmapData = (this._SafeStr_12797.remove(_arg_1) as BitmapData);
            if (((!((_local_3 == null))) && (!((_arg_2 == _local_3))))){
                _local_3.dispose();
            };
            this._SafeStr_12797.add(_arg_1, _arg_2);
            return (true);
        }
        private function RoomPlane():void
        {
            var _local_1:int;
            var _local_2:BitmapData;
            if (this._SafeStr_12797 != null){
                _local_1 = 0;
                while (_local_1 < this._SafeStr_12797.length) {
                    _local_2 = (this._SafeStr_12797.getWithIndex(_local_1) as BitmapData);
                    if (_local_2 != null){
                        _local_2.dispose();
                    };
                    _local_1++;
                };
                this._SafeStr_12797.reset();
            };
        }
        private function getTextureIdentifier(_arg_1:IRoomGeometry):String
        {
            if (_arg_1 == null){
                return (null);
            };
            return (String(_arg_1.scale));
        }
        private function needsNewTexture(_arg_1:IRoomGeometry):Boolean
        {
            if (_arg_1 == null){
                return (false);
            };
            var _local_2:String = this.getTextureIdentifier(_arg_1);
            var _local_3:BitmapData = (this._SafeStr_12797.getValue(_local_2) as BitmapData);
            if ((((this._width > 0)) && ((this._height > 0)))){
                if (_local_3 == null){
                    return (true);
                };
            };
            return (false);
        }
        private function getTexture(_arg_1:IRoomGeometry, _arg_2:int):BitmapData
        {
            var _local_5:Number;
            var _local_6:Number;
            var _local_7:IVector3d;
            if (_arg_1 == null){
                return (null);
            };
            var _local_3:String = this.getTextureIdentifier(_arg_1);
            var _local_4:BitmapData;
            if (this.needsNewTexture(_arg_1)){
                _local_5 = (this._leftSide.length * _arg_1.scale);
                _local_6 = (this._rightSide.length * _arg_1.scale);
                if (_local_5 < 1){
                    _local_5 = 1;
                };
                if (_local_6 < 1){
                    _local_6 = 1;
                };
                _local_7 = _arg_1.RoomGeometry(this._normal);
                _local_4 = (this._SafeStr_12797.getValue(_local_3) as BitmapData);
                if (_local_4 == null){
                    _local_4 = new BitmapData(_local_5, _local_6, true, (0xFF000000 | this._color));
                    if (_local_4 != null){
                        this.RoomPlane(_local_3, _local_4);
                    };
                };
            }
            else {
                _local_4 = (this._SafeStr_12797.getValue(_local_3) as BitmapData);
            };
            if (_local_4 != null){
                return (_local_4);
            };
            return (null);
        }
        public function update(_arg_1:IRoomGeometry, _arg_2:int):Boolean
        {
            var _local_4:IVector3d;
            var _local_5:Number;
            var _local_6:IVector3d;
            var _local_7:Number;
            var _local_8:Number;
            var _local_9:BitmapData;
            if ((((((((((_arg_1 == null)) || ((((this._loc == null)) && (!((this._SafeStr_12792 == null))))))) || ((this._leftSide == null)))) || ((this._rightSide == null)))) || ((this._normal == null)))){
                return (false);
            };
            var _local_3:Boolean;
            if (_arg_1.updateId != this._geometryUpdateId){
                this._geometryUpdateId = _arg_1.updateId;
                _local_4 = _arg_1.direction;
                if (((!((_local_4 == null))) && (((((((!((_local_4.x == this._SafeStr_12788))) || (!((_local_4.y == this._SafeStr_12789))))) || (!((_local_4.z == this._SafeStr_12790))))) || (!((_arg_1.scale == this._SafeStr_12791))))))){
                    this._SafeStr_12788 = _local_4.x;
                    this._SafeStr_12789 = _local_4.y;
                    this._SafeStr_12790 = _local_4.z;
                    this._SafeStr_12791 = _arg_1.scale;
                    _local_3 = true;
                    _local_5 = 0;
                    _local_5 = Vector3d.cosAngle(_arg_1.directionAxis, this.normal);
                    if (_local_5 > -0.001){
                        if (this._isVisible){
                            this._isVisible = false;
                            return (true);
                        };
                        return (false);
                    };
                    this.updateCorners(_arg_1);
                    _local_6 = _arg_1.RoomGeometry(this._SafeStr_12792);
                    _local_7 = _local_6.z;
                    _local_8 = Math.max((this._SafeStr_12800.z - _local_7), (this._SafeStr_12801.z - _local_7), (this._SafeStr_12802.z - _local_7), (this._SafeStr_12803.z - _local_7));
                    this._relativeDepth = _local_8;
                    this._isVisible = true;
                };
            };
            if (((this.needsNewTexture(_arg_1)) || (_local_3))){
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
                    this._bitmapData = new BitmapData(this._width, this._height, true, 0xFFFFFF);
                    this._bitmapData.lock();
                }
                else {
                    this._bitmapData.lock();
                    this._bitmapData.fillRect(this._bitmapData.rect, 0xFFFFFF);
                };
                _local_9 = this.getTexture(_arg_1, _arg_2);
                if (_local_9 != null){
                    this.renderTexture(_arg_1, _local_9);
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
                if ((((((((((_arg_2.a == 1)) && ((_arg_2.d == 1)))) && ((_arg_2.c == 0)))) && (!((_arg_2.b == 0))))) && ((Math.abs(_arg_2.b) <= 1)))){
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

    }
}//package com.sulake.habbo.room.object.visualization.furniture

// crossProduct = "_-0hD" (String#15719, DoABC#2)
// FurniturePlane = "_-0yz" (String#16391, DoABC#2)
// _SafeStr_12788 = "_-1ta" (String#5913, DoABC#2)
// _SafeStr_12789 = "_-2si" (String#7133, DoABC#2)
// _SafeStr_12790 = "_-2kj" (String#6971, DoABC#2)
// _SafeStr_12791 = "_-36m" (String#7445, DoABC#2)
// _SafeStr_12792 = "_-0Rs" (String#4134, DoABC#2)
// _leftSide = "_-2Fc" (String#1844, DoABC#2)
// _rightSide = "_-0yh" (String#1588, DoABC#2)
// _SafeStr_12795 = "_-Qd" (String#23272, DoABC#2)
// _SafeStr_12796 = "_-25M" (String#19233, DoABC#2)
// _SafeStr_12797 = "_-2x-" (String#1970, DoABC#2)
// _relativeDepth = "_-2ez" (String#6852, DoABC#2)
// _SafeStr_12799 = "_-1-g" (String#16453, DoABC#2)
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
// IVector3d = "_-hf" (String#8547, DoABC#2)
// Vector3d = "_-1Rb" (String#17568, DoABC#2)
// IRoomGeometry = "_-0z9" (String#4829, DoABC#2)
// _width = "_-0Uq" (String#92, DoABC#2)
// _geometryUpdateId = "_-2yN" (String#370, DoABC#2)
// updateId = "_-0TD" (String#1478, DoABC#2)
// getTextureIdentifier = "_-0yx" (String#829, DoABC#2)
// RoomGeometry = "_-34h" (String#7403, DoABC#2)
// _loc = "_-0OE" (String#185, DoABC#2)
// mul = "_-tH" (String#24418, DoABC#2)


