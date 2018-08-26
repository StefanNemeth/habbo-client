
package com.sulake.room.object.visualization
{
    import flash.display.BitmapData;
    import flash.geom.Point;
    import flash.display.BlendMode;

    public final class RoomObjectSprite implements IRoomObjectSprite 
    {

        private static var _SafeStr_5547:int = 0;

        private var _asset:BitmapData = null;
        private var _assetName:String = "";
        private var _visible:Boolean = true;
        private var _tag:String = "";
        private var _alpha:int = 0xFF;
        private var _color:int = 0xFFFFFF;
        private var _blendMode:String;
        private var _flipH:Boolean = false;
        private var _flipV:Boolean = false;
        private var _offset:Point;
        private var _width:int = 0;
        private var _height:int = 0;
        private var _depth:Number = 0;
        private var _varyingDepth:Boolean = false;
        private var _capturesMouse:Boolean = true;
        private var _clickHandling:Boolean = false;
        private var _updateID:int = 0;
        private var _instanceId:int = 0;
        private var _filters:Array = null;

        public function RoomObjectSprite()
        {
            this._blendMode = BlendMode.NORMAL;
            this._offset = new Point(0, 0);
            super();
            this._instanceId = _SafeStr_5547++;
        }
        public function dispose():void
        {
            this._asset = null;
            this._width = 0;
            this._height = 0;
        }
        public function get asset():BitmapData
        {
            return (this._asset);
        }
        public function get assetName():String
        {
            return (this._assetName);
        }
        public function get visible():Boolean
        {
            return (this._visible);
        }
        public function get tag():String
        {
            return (this._tag);
        }
        public function get alpha():int
        {
            return (this._alpha);
        }
        public function get color():int
        {
            return (this._color);
        }
        public function get blendMode():String
        {
            return (this._blendMode);
        }
        public function get flipV():Boolean
        {
            return (this._flipV);
        }
        public function get flipH():Boolean
        {
            return (this._flipH);
        }
        public function get offsetX():int
        {
            return (this._offset.x);
        }
        public function get offsetY():int
        {
            return (this._offset.y);
        }
        public function get width():int
        {
            return (this._width);
        }
        public function get height():int
        {
            return (this._height);
        }
        public function get relativeDepth():Number
        {
            return (this._depth);
        }
        public function get varyingDepth():Boolean
        {
            return (this._varyingDepth);
        }
        public function get capturesMouse():Boolean
        {
            return (this._capturesMouse);
        }
        public function get clickHandling():Boolean
        {
            return (this._clickHandling);
        }
        public function get instanceId():int
        {
            return (this._instanceId);
        }
        public function get updateId():int
        {
            return (this._updateID);
        }
        public function get filters():Array
        {
            return (this._filters);
        }
        public function set asset(_arg_1:BitmapData):void
        {
            if (_arg_1 != null){
                this._width = _arg_1.width;
                this._height = _arg_1.height;
            };
            this._asset = _arg_1;
            this._updateID++;
        }
        public function set assetName(_arg_1:String):void
        {
            this._assetName = _arg_1;
            this._updateID++;
        }
        public function set visible(_arg_1:Boolean):void
        {
            this._visible = _arg_1;
            this._updateID++;
        }
        public function set tag(_arg_1:String):void
        {
            this._tag = _arg_1;
            this._updateID++;
        }
        public function set alpha(_arg_1:int):void
        {
            _arg_1 = (_arg_1 & 0xFF);
            this._alpha = _arg_1;
            this._updateID++;
        }
        public function set color(_arg_1:int):void
        {
            _arg_1 = (_arg_1 & 0xFFFFFF);
            this._color = _arg_1;
            this._updateID++;
        }
        public function set blendMode(_arg_1:String):void
        {
            this._blendMode = _arg_1;
            this._updateID++;
        }
        public function set filters(_arg_1:Array):void
        {
            this._filters = _arg_1;
            this._updateID++;
        }
        public function set flipH(_arg_1:Boolean):void
        {
            this._flipH = _arg_1;
            this._updateID++;
        }
        public function set flipV(_arg_1:Boolean):void
        {
            this._flipV = _arg_1;
            this._updateID++;
        }
        public function set offsetX(_arg_1:int):void
        {
            this._offset.x = _arg_1;
            this._updateID++;
        }
        public function set offsetY(_arg_1:int):void
        {
            this._offset.y = _arg_1;
            this._updateID++;
        }
        public function set relativeDepth(_arg_1:Number):void
        {
            this._depth = _arg_1;
            this._updateID++;
        }
        public function set varyingDepth(_arg_1:Boolean):void
        {
            this._varyingDepth = _arg_1;
            this._updateID++;
        }
        public function set capturesMouse(_arg_1:Boolean):void
        {
            this._capturesMouse = _arg_1;
            this._updateID++;
        }
        public function set clickHandling(_arg_1:Boolean):void
        {
            this._clickHandling = _arg_1;
            this._updateID++;
        }

    }
}//package com.sulake.room.object.visualization

// IRoomObjectSprite = "_-0di" (String#4386, DoABC#2)
// RoomObjectSprite = "_-3D1" (String#7574, DoABC#2)
// _tag = "_-1Gy" (String#601, DoABC#2)
// _width = "_-0Uq" (String#92, DoABC#2)
// _blendMode = "_-KX" (String#8094, DoABC#2)
// _asset = "_-1S7" (String#442, DoABC#2)
// updateId = "_-0TD" (String#1478, DoABC#2)
// _alpha = "_-0SY" (String#1474, DoABC#2)
// _flipH = "_-1nk" (String#863, DoABC#2)
// _flipV = "_-1eo" (String#858, DoABC#2)
// _SafeStr_5547 = "_-2iI" (String#1928, DoABC#2)
// _instanceId = "_-1cJ" (String#854, DoABC#2)
// varyingDepth = "_-11d" (String#4909, DoABC#2)
// clickHandling = "_-2fU" (String#6858, DoABC#2)
// instanceId = "_-044" (String#3649, DoABC#2)
// _assetName = "_-33u" (String#910, DoABC#2)
// _visible = "_-1SE" (String#363, DoABC#2)
// _depth = "_-XX" (String#935, DoABC#2)
// _varyingDepth = "_-1g2" (String#5664, DoABC#2)
// _capturesMouse = "_-0Hc" (String#14742, DoABC#2)
// _clickHandling = "_-13Y" (String#1613, DoABC#2)
// _filters = "_-pE" (String#24242, DoABC#2)


