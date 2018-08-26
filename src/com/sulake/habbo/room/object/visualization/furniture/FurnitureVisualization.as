
package com.sulake.habbo.room.object.visualization.furniture
{
    import com.sulake.room.object.visualization.RoomObjectSpriteVisualization;
    import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
    import com.sulake.room.utils.IRoomGeometry;
    import com.sulake.room.object.visualization.utils.IGraphicAsset;
    import com.sulake.room.object.visualization.IRoomObjectSprite;
    import flash.display.BitmapData;
    import flash.display.BlendMode;
    import com.sulake.habbo.room.object.visualization.data.LayerData;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.object.IRoomObjectModel;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.habbo.room.object.visualization.data.ColorData;

    public class FurnitureVisualization extends RoomObjectSpriteVisualization 
    {

        protected static const _SafeStr_12609:Number = Math.sqrt(0.5);

        private var _direction:int;
        private var _SafeStr_12610:Number = NaN;
        private var _SafeStr_12611:int = -1;
        private var _alphaMultiplier:Number = 1;
        private var _clickUrl:String = null;
        private var _clickHandling:Boolean = false;
        private var _data:FurnitureVisualizationData = null;
        private var _type:String = "";
        private var _SafeStr_12612:Array;
        private var _SafeStr_12613:Array;
        private var _SafeStr_12614:Number = 0;
        private var _SafeStr_12615:int = -1;
        private var _SafeStr_12616:int = -1;
        private var _SafeStr_12617:Array;
        private var _SafeStr_12618:Array;
        private var _SafeStr_12619:Array;
        private var _SafeStr_12620:Array;
        private var _SafeStr_12621:Array;
        private var _SafeStr_12622:Array;
        private var _SafeStr_12623:Array;
        private var _SafeStr_12624:Array;
        private var _SafeStr_12625:Boolean = true;
        private var _layerCount:int = 0;
        private var _SafeStr_12626:int = -1;
        private var _SafeStr_12627:int = 0;
        private var _SafeStr_12628:Number = 0;

        public function FurnitureVisualization()
        {
            this._SafeStr_12612 = [];
            this._SafeStr_12613 = [];
            this._SafeStr_12617 = [];
            this._SafeStr_12618 = [];
            this._SafeStr_12619 = [];
            this._SafeStr_12620 = [];
            this._SafeStr_12621 = [];
            this._SafeStr_12622 = [];
            this._SafeStr_12623 = [];
            this._SafeStr_12624 = [];
            super();
            this.reset();
        }
        protected function set direction(_arg_1:int):void
        {
            this._direction = _arg_1;
        }
        protected function get direction():int
        {
            return (this._direction);
        }
        protected function get type():String
        {
            return (this._type);
        }
        override public function dispose():void
        {
            super.dispose();
            this._data = null;
            this._SafeStr_12612 = null;
            this._SafeStr_12613 = null;
            this._SafeStr_12617 = null;
            this._SafeStr_12618 = null;
            this._SafeStr_12619 = null;
            this._SafeStr_12620 = null;
            this._SafeStr_12621 = null;
            this._SafeStr_12622 = null;
            this._SafeStr_12623 = null;
            this._SafeStr_12624 = null;
        }
        override protected function reset():void
        {
            super.reset();
            this.direction = -1;
            this._data = null;
            this._SafeStr_12612 = [];
            this._SafeStr_12613 = [];
            this._SafeStr_12617 = [];
            this._SafeStr_12618 = [];
            this._SafeStr_12619 = [];
            this._SafeStr_12620 = [];
            this._SafeStr_12621 = [];
            this._SafeStr_12622 = [];
            this._SafeStr_12623 = [];
            this._SafeStr_12624 = [];
            this.createSprites(0);
        }
        override public function initialize(_arg_1:IRoomObjectVisualizationData):Boolean
        {
            this.reset();
            if ((((_arg_1 == null)) || (!((_arg_1 is FurnitureVisualizationData))))){
                return (false);
            };
            this._data = (_arg_1 as FurnitureVisualizationData);
            this._type = this._data.getType();
            return (true);
        }
        override public function update(_arg_1:IRoomGeometry, _arg_2:int, _arg_3:Boolean, _arg_4:Boolean):void
        {
            if (_arg_1 == null){
                return;
            };
            var _local_5:Boolean;
            var _local_6:Number = _arg_1.scale;
            if (this.updateObject(_local_6, _arg_1.direction.x)){
                _local_5 = true;
            };
            if (this.updateModel(_local_6)){
                _local_5 = true;
            };
            var _local_7:int;
            if (_arg_4){
                this._SafeStr_12627 = (this._SafeStr_12627 | this.updateAnimation(_local_6));
            }
            else {
                _local_7 = (this.updateAnimation(_local_6) | this._SafeStr_12627);
                this._SafeStr_12627 = 0;
            };
            if (((_local_5) || (!((_local_7 == 0))))){
                this.updateSprites(_local_6, _local_5, _local_7);
                _SafeStr_4369 = _local_6;
                increaseUpdateId();
            };
        }
        protected function updateSprites(_arg_1:int, _arg_2:Boolean, _arg_3:int):void
        {
            var _local_4:int;
            var _local_5:int;
            if (this._layerCount != spriteCount){
                createSprites(this._layerCount);
            };
            if (_arg_2){
                _local_4 = (spriteCount - 1);
                while (_local_4 >= 0) {
                    this.updateSprite(_arg_1, _local_4);
                    _local_4--;
                };
            }
            else {
                _local_5 = 0;
                while (_arg_3 > 0) {
                    if ((_arg_3 & 1)){
                        this.updateSprite(_arg_1, _local_5);
                    };
                    _local_5++;
                    _arg_3 = (_arg_3 >> 1);
                };
            };
            this._SafeStr_12625 = false;
        }
        private function updateSprite(_arg_1:int, _arg_2:int):void
        {
            var _local_5:IGraphicAsset;
            var _local_6:Number;
            var _local_7:int;
            var _local_3:String = this.getSpriteAssetName(_arg_1, _arg_2);
            var _local_4:IRoomObjectSprite = getSprite(_arg_2);
            if (((!((_local_4 == null))) && (!((_local_3 == null))))){
                _local_5 = this.getAsset(_local_3);
                if (((!((_local_5 == null))) && (!((_local_5.asset == null))))){
                    _local_4.visible = true;
                    _local_4.asset = (_local_5.asset.content as BitmapData);
                    _local_4.flipH = _local_5.flipH;
                    _local_4.flipV = _local_5.flipV;
                    _local_6 = 0;
                    if (_arg_2 != this._SafeStr_12626){
                        _local_4.tag = this.FurnitureVisualization(_arg_1, this._direction, _arg_2);
                        _local_4.alpha = this.FurnitureVisualization(_arg_1, this._direction, _arg_2);
                        _local_4.color = this.getSpriteColor(_arg_1, _arg_2, this._SafeStr_12611);
                        _local_4.offsetX = (_local_5.offsetX + this.getSpriteXOffset(_arg_1, this._direction, _arg_2));
                        _local_4.offsetY = (_local_5.offsetY + this.getSpriteYOffset(_arg_1, this._direction, _arg_2));
                        _local_4.capturesMouse = this.FurnitureVisualization(_arg_1, this._direction, _arg_2);
                        _local_4.blendMode = this.getBlendMode(this.FurnitureVisualization(_arg_1, this._direction, _arg_2));
                        _local_6 = this.FurnitureVisualization(_arg_1, this._direction, _arg_2);
                        _local_6 = (_local_6 - (_arg_2 * 0.001));
                    }
                    else {
                        _local_4.offsetX = _local_5.offsetX;
                        _local_4.offsetY = (_local_5.offsetY + this.getSpriteYOffset(_arg_1, this._direction, _arg_2));
                        _local_7 = 48;
                        _local_7 = (_local_7 * this._alphaMultiplier);
                        _local_4.alpha = _local_7;
                        _local_4.capturesMouse = false;
                        _local_6 = 1;
                    };
                    _local_6 = (_local_6 * _SafeStr_12609);
                    _local_4.relativeDepth = _local_6;
                    _local_4.assetName = _local_5.assetName;
                    _local_4.clickHandling = this._clickHandling;
                }
                else {
                    this.FurnitureVisualization(_local_4);
                };
            }
            else {
                if (_local_4 != null){
                    this.FurnitureVisualization(_local_4);
                };
            };
        }
        private function FurnitureVisualization(_arg_1:IRoomObjectSprite):void
        {
            _arg_1.asset = null;
            _arg_1.assetName = "";
            _arg_1.tag = "";
            _arg_1.flipH = false;
            _arg_1.flipV = false;
            _arg_1.offsetX = 0;
            _arg_1.offsetY = 0;
            _arg_1.relativeDepth = 0;
            _arg_1.clickHandling = false;
        }
        protected function getBlendMode(_arg_1:int):String
        {
            var _local_2:String = BlendMode.NORMAL;
            switch (_arg_1){
                case LayerData._SafeStr_12548:
                    break;
                case LayerData._SafeStr_12537:
                    _local_2 = BlendMode.ADD;
                    break;
                case LayerData.INK_DARKEN:
                    _local_2 = BlendMode.DARKEN;
                    break;
                case LayerData._SafeStr_12538:
                    _local_2 = BlendMode.SUBTRACT;
                    break;
            };
            return (_local_2);
        }
        protected function updateObject(_arg_1:Number, _arg_2:Number):Boolean
        {
            var _local_4:Number;
            var _local_5:int;
            var _local_3:IRoomObject = object;
            if (_local_3 == null){
                return (false);
            };
            if (((((!((_SafeStr_4455 == _local_3.getUpdateID()))) || (!((_arg_1 == _SafeStr_4369))))) || (!((_arg_2 == this._SafeStr_12610))))){
                _local_4 = (_local_3.getDirection().x - (_arg_2 + 135));
                _local_4 = (((_local_4 % 360) + 360) % 360);
                if (this._data != null){
                    _local_5 = this._data.getDirectionValue(_arg_1, _local_4);
                    this.direction = _local_5;
                };
                _SafeStr_4455 = _local_3.getUpdateID();
                this._SafeStr_12610 = _arg_2;
                _SafeStr_4369 = _arg_1;
                this.FurnitureVisualization(_arg_1, this._direction);
                return (true);
            };
            return (false);
        }
        protected function updateModel(_arg_1:Number):Boolean
        {
            var _local_4:Number;
            var _local_2:IRoomObject = object;
            if (_local_2 == null){
                return (false);
            };
            var _local_3:IRoomObjectModel = _local_2.getModel();
            if (_local_3 == null){
                return (false);
            };
            if (_SafeStr_4365 != _local_3.getUpdateID()){
                this._SafeStr_12611 = _local_3.getNumber(RoomObjectVariableEnum._SafeStr_7220);
                _local_4 = _local_3.getNumber(RoomObjectVariableEnum._SafeStr_5760);
                if (isNaN(_local_4)){
                    _local_4 = 1;
                };
                if (_local_4 != this._alphaMultiplier){
                    this._alphaMultiplier = _local_4;
                    this._SafeStr_12625 = true;
                };
                this._clickUrl = this.FurnitureVisualization(_local_3);
                if ((((this._clickUrl == null)) || (!((this._clickUrl.indexOf("http") == 0))))){
                    this._clickUrl = null;
                };
                this._clickHandling = !((this._clickUrl == null));
                this._SafeStr_12628 = _local_3.getNumber(RoomObjectVariableEnum._SafeStr_7613);
                _SafeStr_4365 = _local_3.getUpdateID();
                return (true);
            };
            return (false);
        }
        protected function FurnitureVisualization(_arg_1:IRoomObjectModel):String
        {
            return (_arg_1.getString(RoomObjectVariableEnum._SafeStr_12448));
        }
        protected function updateAnimation(_arg_1:Number):int
        {
            return (0);
        }
        private function FurnitureVisualization(_arg_1:Number, _arg_2:int):void
        {
            if (((!((this._SafeStr_12616 == _arg_2))) || (!((this._SafeStr_12614 == _arg_1))))){
                this._SafeStr_12612 = [];
                this._SafeStr_12613 = [];
                this._SafeStr_12617 = [];
                this._SafeStr_12618 = [];
                this._SafeStr_12619 = [];
                this._SafeStr_12620 = [];
                this._SafeStr_12621 = [];
                this._SafeStr_12622 = [];
                this._SafeStr_12623 = [];
                this._SafeStr_12624 = [];
                this._SafeStr_12616 = _arg_2;
                this._SafeStr_12614 = _arg_1;
                this._SafeStr_12615 = this.FurnitureVisualization(_arg_1);
                this.FurnitureVisualization((this._data.getLayerCount(_arg_1) + this.FurnitureVisualization()));
            };
        }
        protected function FurnitureVisualization(_arg_1:int):void
        {
            this._layerCount = _arg_1;
            this._SafeStr_12626 = (this._layerCount - this.FurnitureVisualization());
        }
        protected function FurnitureVisualization():int
        {
            return (1);
        }
        protected function getFrameNumber(_arg_1:int, _arg_2:int):int
        {
            return (0);
        }
        protected function getAsset(_arg_1:String):IGraphicAsset
        {
            var _local_2:IGraphicAsset;
            if (assetCollection != null){
                return (assetCollection.getAsset(_arg_1));
            };
            return (null);
        }
        protected function getSpriteAssetName(_arg_1:int, _arg_2:int):String
        {
            var _local_5:int;
            var _local_6:String;
            if ((((this._data == null)) || ((_arg_2 >= FurnitureVisualizationData._SafeStr_4405.length)))){
                return ("");
            };
            var _local_3:String = this._SafeStr_12612[_arg_2];
            var _local_4:Boolean = this._SafeStr_12613[_arg_2];
            if ((((_local_3 == null)) || ((_local_3.length == 0)))){
                _local_5 = this._SafeStr_12615;
                _local_3 = this._type;
                _local_6 = "";
                if (_arg_2 != this._SafeStr_12626){
                    _local_6 = FurnitureVisualizationData._SafeStr_4405[_arg_2];
                }
                else {
                    _local_6 = "sd";
                };
                if (_local_5 == 1){
                    _local_3 = (_local_3 + ("_icon_" + _local_6));
                    _local_4 = false;
                }
                else {
                    _local_3 = (_local_3 + (((((("_" + _local_5) + "_") + _local_6) + "_") + this._direction) + "_"));
                    _local_4 = true;
                };
                this._SafeStr_12612[_arg_2] = _local_3;
                this._SafeStr_12613[_arg_2] = _local_4;
            };
            if (_local_4){
                _local_3 = (_local_3 + this.getFrameNumber(_arg_1, _arg_2));
            };
            return (_local_3);
        }
        protected function FurnitureVisualization(_arg_1:int, _arg_2:int, _arg_3:int):String
        {
            if (this._SafeStr_12617[_arg_3] != null){
                return (this._SafeStr_12617[_arg_3]);
            };
            if (this._data == null){
                return ("");
            };
            var _local_4:String = this._data.getTag(_arg_1, _arg_2, _arg_3);
            this._SafeStr_12617[_arg_3] = _local_4;
            return (_local_4);
        }
        protected function FurnitureVisualization(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            if (((!((this._SafeStr_12618[_arg_3] == null))) && (!(this._SafeStr_12625)))){
                return (this._SafeStr_12618[_arg_3]);
            };
            if (this._data == null){
                return (LayerData._SafeStr_12550);
            };
            var _local_4:int = this._data.getAlpha(_arg_1, _arg_2, _arg_3);
            _local_4 = (_local_4 * this._alphaMultiplier);
            this._SafeStr_12618[_arg_3] = _local_4;
            return (_local_4);
        }
        protected function getSpriteColor(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            if (this._SafeStr_12619[_arg_2] != null){
                return (this._SafeStr_12619[_arg_2]);
            };
            if (this._data == null){
                return (ColorData._SafeStr_4861);
            };
            var _local_4:int = this._data.getColor(_arg_1, _arg_2, _arg_3);
            this._SafeStr_12619[_arg_2] = _local_4;
            return (_local_4);
        }
        protected function getSpriteXOffset(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            if (this._SafeStr_12620[_arg_3] != null){
                return (this._SafeStr_12620[_arg_3]);
            };
            if (this._data == null){
                return (LayerData._SafeStr_12554);
            };
            var _local_4:int = this._data.getXOffset(_arg_1, _arg_2, _arg_3);
            this._SafeStr_12620[_arg_3] = _local_4;
            return (_local_4);
        }
        protected function getSpriteYOffset(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            var _local_4:int;
            if (_arg_3 != this._SafeStr_12626){
                if (this._SafeStr_12621[_arg_3] != null){
                    return (this._SafeStr_12621[_arg_3]);
                };
                if (this._data != null){
                    _local_4 = this._data.getYOffset(_arg_1, _arg_2, _arg_3);
                    this._SafeStr_12621[_arg_3] = _local_4;
                    return (_local_4);
                };
                return (LayerData._SafeStr_12556);
            };
            return (Math.ceil((this._SafeStr_12628 * (_arg_1 / 2))));
        }
        protected function FurnitureVisualization(_arg_1:int, _arg_2:int, _arg_3:int):Boolean
        {
            if (this._SafeStr_12623[_arg_3] != null){
                return (this._SafeStr_12623[_arg_3]);
            };
            if (this._data == null){
                return (true);
            };
            var _local_4 = !(this._data.getIgnoreMouse(_arg_1, _arg_2, _arg_3));
            this._SafeStr_12623[_arg_3] = _local_4;
            return (_local_4);
        }
        protected function FurnitureVisualization(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            if (this._SafeStr_12624[_arg_3] != null){
                return (this._SafeStr_12624[_arg_3]);
            };
            if (this._data == null){
                return (LayerData._SafeStr_12548);
            };
            var _local_4:int = this._data.getInk(_arg_1, _arg_2, _arg_3);
            this._SafeStr_12624[_arg_3] = _local_4;
            return (_local_4);
        }
        protected function FurnitureVisualization(_arg_1:int, _arg_2:int, _arg_3:int):Number
        {
            if (this._SafeStr_12622[_arg_3] != null){
                return (this._SafeStr_12622[_arg_3]);
            };
            if (this._data == null){
                return (LayerData._SafeStr_4401);
            };
            var _local_4:Number = this._data.getZOffset(_arg_1, _arg_2, _arg_3);
            this._SafeStr_12622[_arg_3] = _local_4;
            return (_local_4);
        }
        protected function FurnitureVisualization(_arg_1:int):int
        {
            if (this._data != null){
                return (this._data.FurnitureVisualization(_arg_1));
            };
            return (_arg_1);
        }

    }
}//package com.sulake.habbo.room.object.visualization.furniture

// FurnitureVisualization = "_-0z5" (String#438, DoABC#2)
// _SafeStr_12448 = "_-0Jf" (String#14828, DoABC#2)
// _layerCount = "_-1NH" (String#850, DoABC#2)
// _SafeStr_12537 = "_-ZY" (String#23618, DoABC#2)
// _SafeStr_12538 = "_-1dV" (String#18034, DoABC#2)
// getInk = "_-wG" (String#24542, DoABC#2)
// _SafeStr_12548 = "_-1jC" (String#18252, DoABC#2)
// getAlpha = "_-1Lj" (String#17346, DoABC#2)
// _SafeStr_12550 = "_-1Y" (String#17814, DoABC#2)
// getIgnoreMouse = "_-2MB" (String#19892, DoABC#2)
// getXOffset = "_-be" (String#23698, DoABC#2)
// _SafeStr_12554 = "_-2ZS" (String#20416, DoABC#2)
// getYOffset = "_-In" (String#22959, DoABC#2)
// _SafeStr_12556 = "_-35D" (String#21702, DoABC#2)
// _SafeStr_12609 = "_-1o9" (String#18467, DoABC#2)
// _SafeStr_12610 = "_-29u" (String#19400, DoABC#2)
// _SafeStr_12611 = "_-2TL" (String#20178, DoABC#2)
// _SafeStr_12612 = "_-2zN" (String#21435, DoABC#2)
// _SafeStr_12613 = "_-1tI" (String#18689, DoABC#2)
// _SafeStr_12614 = "_-1p9" (String#18507, DoABC#2)
// _SafeStr_12615 = "_-0r7" (String#16091, DoABC#2)
// _SafeStr_12616 = "_-2w4" (String#21311, DoABC#2)
// _SafeStr_12617 = "_-3-2" (String#21462, DoABC#2)
// _SafeStr_12618 = "_-1wE" (String#18807, DoABC#2)
// _SafeStr_12619 = "_-1Mh" (String#17388, DoABC#2)
// _SafeStr_12620 = "_-jR" (String#24016, DoABC#2)
// _SafeStr_12621 = "_-Kh" (String#23032, DoABC#2)
// _SafeStr_12622 = "_-1H" (String#17151, DoABC#2)
// _SafeStr_12623 = "_-0--" (String#14009, DoABC#2)
// _SafeStr_12624 = "_-0i0" (String#15750, DoABC#2)
// _SafeStr_12625 = "_-0tC" (String#16167, DoABC#2)
// _SafeStr_12626 = "_-0GA" (String#14692, DoABC#2)
// _SafeStr_12627 = "_-0pE" (String#16024, DoABC#2)
// _SafeStr_12628 = "_-2eO" (String#20619, DoABC#2)
// updateSprites = "_-03G" (String#805, DoABC#2)
// updateSprite = "_-2yQ" (String#1975, DoABC#2)
// FurnitureVisualization = "_-00o" (String#14086, DoABC#2)
// FurnitureVisualization = "_-1eb" (String#18082, DoABC#2)
// getSpriteColor = "_-0OM" (String#4054, DoABC#2)
// FurnitureVisualization = "_-1sk" (String#5897, DoABC#2)
// FurnitureVisualization = "_-1LK" (String#17326, DoABC#2)
// FurnitureVisualization = "_-0tL" (String#16173, DoABC#2)
// FurnitureVisualization = "_-2xQ" (String#21367, DoABC#2)
// RoomObjectVariableEnum = "_-1MH" (String#17370, DoABC#2)
// IRoomObjectVisualizationData = "_-26A" (String#6167, DoABC#2)
// IRoomObjectModel = "_-253" (String#6141, DoABC#2)
// FurnitureVisualizationData = "_-0d0" (String#4371, DoABC#2)
// RoomObjectSpriteVisualization = "_-01y" (String#3602, DoABC#2)
// FurnitureVisualization = "_-1sy" (String#5900, DoABC#2)
// IRoomGeometry = "_-0z9" (String#4829, DoABC#2)
// IGraphicAsset = "_-1HF" (String#5195, DoABC#2)
// ColorData = "_-1Hv" (String#5204, DoABC#2)
// IRoomObjectSprite = "_-0di" (String#4386, DoABC#2)
// getLayerCount = "_-0wW" (String#16290, DoABC#2)
// updateAnimation = "_-XZ" (String#166, DoABC#2)
// updateModel = "_-1CW" (String#441, DoABC#2)
// getUpdateID = "_-Ga" (String#932, DoABC#2)
// _SafeStr_4365 = "_-2rK" (String#21130, DoABC#2)
// _SafeStr_4369 = "_-bP" (String#23689, DoABC#2)
// getSprite = "_-sN" (String#2210, DoABC#2)
// spriteCount = "_-2A7" (String#6252, DoABC#2)
// FurnitureVisualization = "_-2P8" (String#6547, DoABC#2)
// FurnitureVisualization = "_-XK" (String#8355, DoABC#2)
// getFrameNumber = "_-0XM" (String#436, DoABC#2)
// getSpriteXOffset = "_-03Y" (String#354, DoABC#2)
// getSpriteYOffset = "_-3IZ" (String#251, DoABC#2)
// FurnitureVisualization = "_-25C" (String#614, DoABC#2)
// _SafeStr_4401 = "_-1Tp" (String#17658, DoABC#2)
// getZOffset = "_-1iZ" (String#18230, DoABC#2)
// getSpriteAssetName = "_-0c-" (String#590, DoABC#2)
// FurnitureVisualization = "_-1GK" (String#5174, DoABC#2)
// _SafeStr_4405 = "_-0gZ" (String#15695, DoABC#2)
// getDirectionValue = "_-0Fe" (String#14670, DoABC#2)
// getTag = "_-01m" (String#14120, DoABC#2)
// createSprites = "_-1Im" (String#17226, DoABC#2)
// _SafeStr_4455 = "_-0tm" (String#16194, DoABC#2)
// increaseUpdateId = "_-vd" (String#24514, DoABC#2)
// _clickUrl = "_-2-C" (String#303, DoABC#2)
// _SafeStr_4861 = "_-0CJ" (String#582, DoABC#2)
// clickHandling = "_-2fU" (String#6858, DoABC#2)
// _clickHandling = "_-13Y" (String#1613, DoABC#2)
// getColor = "_-07L" (String#1406, DoABC#2)
// _SafeStr_5760 = "_-2gS" (String#20707, DoABC#2)
// _SafeStr_7220 = "_-1eF" (String#18068, DoABC#2)
// _SafeStr_7613 = "_-lN" (String#24082, DoABC#2)


