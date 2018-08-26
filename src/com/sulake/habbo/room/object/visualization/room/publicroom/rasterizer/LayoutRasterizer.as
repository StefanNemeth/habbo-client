
package com.sulake.habbo.room.object.visualization.room.publicroom.rasterizer
{
    import com.sulake.room.object.visualization.utils.IGraphicAssetCollection;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.core.utils.Map;
    import flash.geom.Point;
    import com.sulake.room.utils.IRoomGeometry;
    import com.sulake.room.object.visualization.IRoomObjectSprite;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.room.object.visualization.IRoomObjectSpriteVisualization;
    import flash.display.BlendMode;
    import com.sulake.room.object.visualization.utils.IGraphicAsset;
    import flash.display.BitmapData;

    public class LayoutRasterizer 
    {

        private var _assetCollection:IGraphicAssetCollection;
        private var _elementList:XMLList;
        private var _offsetX:int;
        private var _originalOffsetY:int;
        private var _SafeStr_5909:Vector3d;
        private var _SafeStr_5910:String;
        private var _SafeStr_5911:Map = null;
        private var _SafeStr_5912:String = "";
        private var _adBgIndex:int = -1;
        private var _adImgIndex:int = -1;
        private var _SafeStr_5913:Boolean = false;
        private var _SafeStr_5914:String = "";
        private var _SafeStr_5915:int = 0;
        private var _graphicsChanged:Boolean = true;
        private var _SafeStr_5917:Array;
        private var _SafeStr_5918:Array;
        private var _SafeStr_5919:Array;
        private var _SafeStr_5920:Point = null;
        private var _LayoutRasterizer:LayoutRasterizerData = null;

        public function LayoutRasterizer()
        {
            this._SafeStr_5917 = [];
            this._SafeStr_5918 = [];
            this._SafeStr_5919 = [];
            super();
            this._SafeStr_5911 = new Map();
            this._SafeStr_5910 = "";
            this._SafeStr_5920 = new Point();
        }
        public function get graphicsChanged():Boolean
        {
            return (this._graphicsChanged);
        }
        public function set layout(_arg_1:String):void
        {
            if (_arg_1 != this._SafeStr_5910){
                this._SafeStr_5910 = _arg_1;
                this._adBgIndex = -1;
                this._adImgIndex = -1;
                this._LayoutRasterizer = this._SafeStr_5911.getValue(this._SafeStr_5910);
            };
        }
        public function dispose():void
        {
            var _local_1:int;
            var _local_2:LayoutRasterizerData;
            this._assetCollection = null;
            this._elementList = null;
            this._SafeStr_5917 = null;
            this._SafeStr_5918 = null;
            this._SafeStr_5919 = null;
            if (this._SafeStr_5911 != null){
                _local_1 = 0;
                while (_local_1 < this._SafeStr_5911.length) {
                    _local_2 = (this._SafeStr_5911.getWithIndex(_local_1) as LayoutRasterizerData);
                    if (_local_2 != null){
                        _local_2.dispose();
                    };
                    _local_1++;
                };
                this._SafeStr_5911.dispose();
                this._SafeStr_5911 = null;
            };
            this._LayoutRasterizer = null;
        }
        public function initialize(_arg_1:XML):void
        {
            var _local_2:String = String(_arg_1.@name);
            var _local_3:LayoutRasterizerData = new LayoutRasterizerData(_arg_1);
            this._SafeStr_5911.add(_local_2, _local_3);
            this._SafeStr_5909 = new Vector3d(-0.5, 0.5, 0);
            this._graphicsChanged = false;
        }
        public function initializeGeometry(_arg_1:IRoomGeometry):void
        {
            var _local_2:Point = _arg_1.RoomGeometry(new Vector3d(0, 0, 0));
            var _local_3:Point = _arg_1.RoomGeometry(this._SafeStr_5909);
            _local_3.x = (_local_3.x - _local_2.x);
            _local_3.y = (_local_3.y - _local_2.y);
            _local_3.x = Math.round(_local_3.x);
            _local_3.y = Math.round(_local_3.y);
            this._SafeStr_5920.x = _local_3.x;
            this._SafeStr_5920.y = _local_3.y;
        }
        public function initializeAds(_arg_1:int, _arg_2:IRoomObjectSpriteVisualization):void
        {
            var _local_7:XML;
            var _local_8:XMLList;
            var _local_9:XML;
            var _local_10:String;
            var _local_11:String;
            this._SafeStr_5915 = _arg_1;
            var _local_3:LayoutRasterizerData = this._SafeStr_5911.getValue(this._SafeStr_5910);
            if (_local_3 == null){
                return;
            };
            var _local_4:XMLList = _local_3.elementList;
            if (_local_4 == null){
                return;
            };
            var _local_5:IRoomObjectSprite;
            var _local_6:int;
            while (_local_6 < _local_4.length()) {
                _local_7 = _local_4[_local_6];
                if (_local_7 != null){
                    _local_8 = _local_7.visualization;
                    if ((((_local_8.length() > 0)) && ((_local_8.visualizationLayer.length() > 0)))){
                        _local_9 = _local_8.visualizationLayer[0];
                        if (_local_9 != null){
                            if (_local_7.@id.toString().length > 0){
                                _local_10 = String(_local_7.@id);
                                if (_local_10 == "billboard_bg"){
                                    this._adBgIndex = _local_6;
                                    _local_11 = String(_local_9.@asset);
                                    if (_local_11.indexOf("left") > -1){
                                        this._SafeStr_5912 = RoomObjectVariableEnum._SafeStr_5925;
                                    };
                                    if (_local_11.indexOf("right") > -1){
                                        this._SafeStr_5912 = RoomObjectVariableEnum._SafeStr_5926;
                                    };
                                    if (_arg_2 != null){
                                        _local_5 = _arg_2.getSprite((this._SafeStr_5915 + this._adBgIndex));
                                        if (_local_5 != null){
                                            _local_5.visible = false;
                                            _local_5.alpha = 0;
                                        };
                                    };
                                };
                                if (_local_10 == "billboard_img"){
                                    this._adImgIndex = _local_6;
                                    if (_arg_2 != null){
                                        _local_5 = _arg_2.getSprite((this._SafeStr_5915 + this._adImgIndex));
                                        if (_local_5 != null){
                                            _local_5.visible = false;
                                            _local_5.alpha = 0;
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
                _local_6++;
            };
        }
        public function initializeAssetCollection(_arg_1:IGraphicAssetCollection):void
        {
            this._assetCollection = _arg_1;
        }
        public function elementCount():int
        {
            var _local_1:LayoutRasterizerData = this._SafeStr_5911.getValue(this._SafeStr_5910);
            if (_local_1 == null){
                return (0);
            };
            var _local_2:XMLList = _local_1.elementList;
            if (_local_2 == null){
                return (0);
            };
            return (_local_2.length());
        }
        private function getBlendMode(_arg_1:String):String
        {
            var _local_2:String = BlendMode.NORMAL;
            switch (_arg_1){
                case "ADD":
                    _local_2 = BlendMode.ADD;
                    break;
                case "SUBTRACT":
                    _local_2 = BlendMode.SUBTRACT;
                    break;
                case "DARKEN":
                    _local_2 = BlendMode.DARKEN;
                    break;
            };
            return (_local_2);
        }
        public function showAd(_arg_1:IRoomObjectSpriteVisualization, _arg_2:String="", _arg_3:Boolean=false):void
        {
            if ((((_arg_2 == this._SafeStr_5914)) && ((_arg_3 == this._SafeStr_5913)))){
                return;
            };
            if ((((this._adBgIndex == -1)) || ((this._adImgIndex == -1)))){
                Logger.log("ERROR! Billboard sprite indices not defined, cannot show room ad!");
                return;
            };
            var _local_4:IRoomObjectSprite;
            var _local_5:IRoomObjectSprite;
            if (_arg_1 != null){
                _local_4 = _arg_1.getSprite((this._SafeStr_5915 + this._adBgIndex));
                _local_5 = _arg_1.getSprite((this._SafeStr_5915 + this._adImgIndex));
            };
            if ((((_local_4 == null)) || ((_local_5 == null)))){
                Logger.log("ERROR! Billboard sprites not defined, cannot show room ad!");
                return;
            };
            if (_arg_3){
                this.exchangeElementGraphics("billboard_img", _arg_2);
            }
            else {
                this.exchangeElementGraphics("billboard_img", this._SafeStr_5912);
            };
            this.setElementToSprite(this._adBgIndex, _local_4, _arg_2, _arg_3);
            this.setElementToSprite(this._adImgIndex, _local_5, _arg_2, _arg_3);
            if (_arg_3){
                _local_5.capturesMouse = true;
                _local_5.clickHandling = true;
                _local_5.tag = RoomObjectVariableEnum._SafeStr_5325;
            };
            if (_arg_2 != ""){
                _local_4.visible = true;
                _local_4.alpha = 0xFF;
                _local_5.visible = true;
                _local_5.alpha = 0xFF;
            }
            else {
                _local_4.visible = false;
                _local_4.alpha = 0;
                _local_5.visible = false;
                _local_5.alpha = 0;
            };
            _local_5.offsetX = (_local_5.offsetX - (_local_5.width / 2));
            _local_5.offsetY = (_local_5.offsetY - (_local_5.height / 2));
            this._SafeStr_5914 = _arg_2;
            this._SafeStr_5913 = _arg_3;
        }
        public function setElementToSprite(_arg_1:int, _arg_2:IRoomObjectSprite, _arg_3:String="", _arg_4:Boolean=false):void
        {
            var _local_10:String;
            if (this._LayoutRasterizer == null){
                return;
            };
            var _local_5:XMLList = this._LayoutRasterizer.elementList;
            if (_local_5 == null){
                return;
            };
            if ((((_arg_1 < 0)) || ((_arg_1 >= _local_5.length())))){
                return;
            };
            var _local_6:XML = _local_5[_arg_1];
            if (_local_6 == null){
                return;
            };
            var _local_7:XMLList = _local_6.visualization;
            if ((((_local_7.length() == 0)) || ((_local_7.visualizationLayer.length() == 0)))){
                return;
            };
            var _local_8:XML = _local_7.visualizationLayer[0];
            if (_local_8 == null){
                return;
            };
            var _local_9:IGraphicAsset = this._assetCollection.getAsset(_local_8.@asset);
            if ((((_local_9 == null)) || ((_local_9.asset == null)))){
                return;
            };
            _arg_2.visible = true;
            _arg_2.alpha = 0xFF;
            _arg_2.asset = (_local_9.asset.content as BitmapData);
            _arg_2.offsetX = ((int(_local_8.@x) + _local_9.offsetX) + this._SafeStr_5920.x);
            _arg_2.offsetY = ((int(_local_8.@y) + _local_9.offsetY) + this._SafeStr_5920.y);
            _arg_2.blendMode = this.getBlendMode(String(_local_8.@ink));
            _arg_2.capturesMouse = false;
            if (parseInt(_local_8.@capturesMouse) > 0){
                _arg_2.capturesMouse = true;
                _arg_2.tag = String(_local_6.@id);
            };
            if (String(_local_8.@z) != ""){
                _arg_2.relativeDepth = ((-(Number(_local_8.@z)) / Math.sqrt(2)) - (1E-5 * _arg_1));
            }
            else {
                _arg_2.relativeDepth = -((0.001 * _arg_1));
            };
            if (_local_8.@blend.toString().length > 0){
                _arg_2.alpha = int((Number(_local_8.@blend) * 2.55));
            };
            if (_local_8.@flipH.toString().length > 0){
                _arg_2.flipH = Boolean(_local_8.@flipH);
            };
            if (_local_6.@id.toString().length > 0){
                _local_10 = String(_local_6.@id);
                if ((((this._SafeStr_5917.indexOf(_local_10) >= 0)) && (this._graphicsChanged))){
                    _arg_1 = this._SafeStr_5917.indexOf(_local_10);
                    if (this._SafeStr_5918[_arg_1] != ""){
                        _local_9 = this._assetCollection.getAsset(this._SafeStr_5918[_arg_1]);
                        if (((!((_local_9 == null))) && (!((_local_9.asset == null))))){
                            _arg_2.asset = (_local_9.asset.content as BitmapData);
                        }
                        else {
                            _arg_2.asset = null;
                        };
                    };
                    if (this._SafeStr_5919[_arg_1] != -1){
                        _arg_2.alpha = this._SafeStr_5919[_arg_1];
                    };
                    this._SafeStr_5917.splice(_arg_1, 1);
                    this._SafeStr_5918.splice(_arg_1, 1);
                    this._SafeStr_5919.splice(_arg_1, 1);
                    if (this._SafeStr_5917.length == 0){
                        this._graphicsChanged = false;
                    };
                };
            };
        }
        public function exchangeElementGraphics(_arg_1:String, _arg_2:String):void
        {
            this._graphicsChanged = true;
            var _local_3:int = this._SafeStr_5917.indexOf(_arg_1);
            if (_local_3 < 0){
                this._SafeStr_5917.push(_arg_1);
                this._SafeStr_5918.push(_arg_2);
                this._SafeStr_5919.push(-1);
            }
            else {
                this._SafeStr_5918[_local_3] = _arg_2;
            };
        }
        public function changeElementAlpha(_arg_1:String, _arg_2:Number):void
        {
            this._graphicsChanged = true;
            var _local_3:int = this._SafeStr_5917.indexOf(_arg_1);
            if (_local_3 < 0){
                this._SafeStr_5917.push(_arg_1);
                this._SafeStr_5918.push("");
                this._SafeStr_5919.push(_arg_2);
            }
            else {
                this._SafeStr_5919[_local_3] = _arg_2;
            };
        }

    }
}//package com.sulake.habbo.room.object.visualization.room.publicroom.rasterizer

// Vector3d = "_-1Rb" (String#17568, DoABC#2)
// RoomObjectVariableEnum = "_-1MH" (String#17370, DoABC#2)
// IGraphicAssetCollection = "_-24o" (String#6134, DoABC#2)
// IRoomObjectSpriteVisualization = "_-2Xc" (String#6715, DoABC#2)
// IRoomGeometry = "_-0z9" (String#4829, DoABC#2)
// IGraphicAsset = "_-1HF" (String#5195, DoABC#2)
// LayoutRasterizer = "_-2Xe" (String#6716, DoABC#2)
// IRoomObjectSprite = "_-0di" (String#4386, DoABC#2)
// LayoutRasterizerData = "_-jp" (String#8597, DoABC#2)
// getSprite = "_-sN" (String#2210, DoABC#2)
// RoomGeometry = "_-34h" (String#7403, DoABC#2)
// _SafeStr_5325 = "_-1vh" (String#18784, DoABC#2)
// _assetCollection = "_-2PR" (String#888, DoABC#2)
// clickHandling = "_-2fU" (String#6858, DoABC#2)
// _elementList = "_-3ES" (String#7602, DoABC#2)
// _originalOffsetY = "_-hb" (String#375, DoABC#2)
// _SafeStr_5909 = "_-1s2" (String#18634, DoABC#2)
// _SafeStr_5910 = "_-03q" (String#14196, DoABC#2)
// _SafeStr_5911 = "_-Kn" (String#8097, DoABC#2)
// _SafeStr_5912 = "_-06Q" (String#14303, DoABC#2)
// _SafeStr_5913 = "_-2wv" (String#21344, DoABC#2)
// _SafeStr_5914 = "_-01e" (String#14116, DoABC#2)
// _SafeStr_5915 = "_-sp" (String#24394, DoABC#2)
// _graphicsChanged = "_-23o" (String#19169, DoABC#2)
// _SafeStr_5917 = "_-0XO" (String#15330, DoABC#2)
// _SafeStr_5918 = "_-1wr" (String#18839, DoABC#2)
// _SafeStr_5919 = "_-1f8" (String#18103, DoABC#2)
// _SafeStr_5920 = "_-0kt" (String#15860, DoABC#2)
// _LayoutRasterizer = "_-0-R" (String#14030, DoABC#2)
// initializeGeometry = "_-26d" (String#19277, DoABC#2)
// initializeAds = "_-U2" (String#23411, DoABC#2)
// elementList = "_-30K" (String#21514, DoABC#2)
// _SafeStr_5925 = "_-3Ks" (String#22318, DoABC#2)
// _SafeStr_5926 = "_-1Vb" (String#17726, DoABC#2)
// initializeAssetCollection = "_-24a" (String#19205, DoABC#2)
// showAd = "_-7u" (String#22539, DoABC#2)
// exchangeElementGraphics = "_-Rb" (String#23307, DoABC#2)


