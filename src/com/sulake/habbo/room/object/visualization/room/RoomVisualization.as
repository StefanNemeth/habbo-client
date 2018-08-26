
package com.sulake.habbo.room.object.visualization.room
{
    import com.sulake.room.object.visualization.RoomObjectSpriteVisualization;
    import com.sulake.core.assets.AssetLibrary;
    import com.sulake.habbo.room.object.RoomPlaneParser;
    import flash.geom.Rectangle;
    import com.sulake.habbo.room.object.RoomPlaneBitmapMaskParser;
    import com.sulake.core.assets.IAsset;
    import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
    import com.sulake.room.object.visualization.IRoomObjectSprite;
    import com.sulake.room.utils.IVector3d;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.habbo.room.object.RoomPlaneData;
    import com.sulake.room.object.IRoomObjectModel;
    import com.sulake.room.utils.IRoomGeometry;
    import flash.geom.Point;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.display.BitmapData;
    import com.sulake.habbo.room.object.RoomPlaneBitmapMaskData;

    public class RoomVisualization extends RoomObjectSpriteVisualization 
    {

        public static const _SafeStr_12916:int = 0xFFFFFF;
        public static const _SafeStr_12917:int = 0xCCCCCC;
        private static const _SafeStr_12918:int = 0xFFFFFF;
        private static const _SafeStr_12919:int = 0xCCCCCC;
        private static const _SafeStr_12920:int = 0x999999;
        private static const _SafeStr_12921:int = 0x999999;
        public static const _SafeStr_12922:int = 0xFFFFFF;
        public static const _SafeStr_12923:int = 0xCCCCCC;
        public static const _SafeStr_12924:int = 0x999999;

        private const _SafeStr_12925:int = 250;

        protected var _data:RoomVisualizationData = null;
        private var _assetLibrary:AssetLibrary = null;
        private var _planeParser:RoomPlaneParser = null;
        private var _SafeStr_12729:Array;
        private var _planesInitialized:Boolean = false;
        private var _SafeStr_12926:Array;
        private var _SafeStr_12927:Array;
        private var _SafeStr_12928:Rectangle = null;
        private var _SafeStr_5763:RoomPlaneBitmapMaskParser = null;
        private var _wallType:String = null;
        private var _floorType:String = null;
        private var _landscapeType:String = null;
        private var _floorThicknessMultiplier:Number = NaN;
        private var _wallThicknessMultiplier:Number = NaN;
        private var _SafeStr_12929:Number = NaN;
        private var _SafeStr_12930:String = null;
        private var _SafeStr_12931:uint = 0xFFFFFF;
        private var _SafeStr_12932:int = 0xFF;
        private var _SafeStr_12933:int = 0xFF;
        private var _SafeStr_12934:int = 0xFF;
        private var _SafeStr_12935:Boolean = true;
        private var _SafeStr_12730:int = 0;
        private var _lastUpdateTime:int = -1000;
        private var _geometryUpdateId:int = -1;
        private var _SafeStr_12788:Number = 0;
        private var _SafeStr_12789:Number = 0;
        private var _SafeStr_12790:Number = 0;
        private var _SafeStr_12791:Number = 0;
        private var _SafeStr_12936:Array;

        public function RoomVisualization()
        {
            this._SafeStr_12729 = [];
            this._SafeStr_12926 = [];
            this._SafeStr_12927 = [];
            this._SafeStr_12936 = [];
            super();
            this._assetLibrary = new AssetLibrary("room visualization");
            this._planeParser = new RoomPlaneParser();
            this._SafeStr_5763 = new RoomPlaneBitmapMaskParser();
            this._SafeStr_12936[RoomPlane._SafeStr_12937] = false;
            this._SafeStr_12936[RoomPlane._SafeStr_7291] = true;
            this._SafeStr_12936[RoomPlane._SafeStr_10277] = true;
            this._SafeStr_12936[RoomPlane.TYPE_LANDSCAPE] = true;
        }
        public function get floorRelativeDepth():Number
        {
            return (100.1);
        }
        public function get wallRelativeDepth():Number
        {
            return (100.5);
        }
        public function get wallAdRelativeDepth():Number
        {
            return (100.49);
        }
        public function get planeCount():int
        {
            return (this._SafeStr_12729.length);
        }
        override public function dispose():void
        {
            var _local_1:int;
            var _local_2:IAsset;
            super.dispose();
            if (this._assetLibrary != null){
                _local_1 = 0;
                while (_local_1 < this._assetLibrary.numAssets) {
                    _local_2 = this._assetLibrary.getAssetByIndex(_local_1);
                    if (_local_2 != null){
                        _local_2.dispose();
                    };
                    _local_1++;
                };
                this._assetLibrary.dispose();
                this._assetLibrary = null;
            };
            this.RoomVisualization();
            this._SafeStr_12729 = null;
            this._SafeStr_12926 = null;
            this._SafeStr_12927 = null;
            if (this._planeParser != null){
                this._planeParser.dispose();
                this._planeParser = null;
            };
            if (this._SafeStr_5763 != null){
                this._SafeStr_5763.dispose();
                this._SafeStr_5763 = null;
            };
            if (this._data != null){
                this._data.clearCache();
                this._data = null;
            };
        }
        private function RoomVisualization():void
        {
            var _local_1:int;
            var _local_2:RoomPlane;
            if (this._SafeStr_12729 != null){
                _local_1 = 0;
                while (_local_1 < this._SafeStr_12729.length) {
                    _local_2 = (this._SafeStr_12729[_local_1] as RoomPlane);
                    if (_local_2 != null){
                        _local_2.dispose();
                    };
                    _local_1++;
                };
                this._SafeStr_12729 = [];
            };
            this._planesInitialized = false;
            this._SafeStr_12730 = (this._SafeStr_12730 + 1);
            this.reset();
        }
        override protected function reset():void
        {
            super.reset();
            this._wallType = null;
            this._floorType = null;
            this._landscapeType = null;
            this._SafeStr_12930 = null;
            this._geometryUpdateId = -1;
            this._SafeStr_12791 = 0;
        }
        override public function get boundingRectangle():Rectangle
        {
            if (this._SafeStr_12928 == null){
                this._SafeStr_12928 = super.boundingRectangle;
            };
            return (new Rectangle(this._SafeStr_12928.x, this._SafeStr_12928.y, this._SafeStr_12928.width, this._SafeStr_12928.height));
        }
        override public function initialize(_arg_1:IRoomObjectVisualizationData):Boolean
        {
            this.reset();
            if ((((_arg_1 == null)) || (!((_arg_1 is RoomVisualizationData))))){
                return (false);
            };
            this._data = (_arg_1 as RoomVisualizationData);
            this._data.initializeAssetCollection(assetCollection);
            return (true);
        }
        protected function RoomVisualization():void
        {
            var _local_3:RoomPlane;
            var _local_4:IRoomObjectSprite;
            var _local_1:int = this._SafeStr_12729.length;
            createSprites(_local_1);
            var _local_2:int;
            while (_local_2 < _local_1) {
                _local_3 = (this._SafeStr_12729[_local_2] as RoomPlane);
                _local_4 = getSprite(_local_2);
                if (((((((!((_local_4 == null))) && (!((_local_3 == null))))) && (!((_local_3.leftSide == null))))) && (!((_local_3.rightSide == null))))){
                    if ((((_local_3.type == RoomPlane._SafeStr_10277)) && ((((_local_3.leftSide.length < 1)) || ((_local_3.rightSide.length < 1)))))){
                        _local_4.capturesMouse = false;
                    }
                    else {
                        _local_4.capturesMouse = true;
                    };
                    if (_local_3.type == RoomPlane._SafeStr_10277){
                        _local_4.tag = ("plane.wall@" + (_local_2 + 1));
                    }
                    else {
                        if (_local_3.type == RoomPlane._SafeStr_7291){
                            _local_4.tag = ("plane.floor@" + (_local_2 + 1));
                        }
                        else {
                            _local_4.tag = ("plane@" + (_local_2 + 1));
                        };
                    };
                };
                _local_2++;
            };
        }
        protected function RoomVisualization():void
        {
            var _local_8:IVector3d;
            var _local_9:IVector3d;
            var _local_10:IVector3d;
            var _local_11:Array;
            var _local_12:int;
            var _local_13:RoomPlane;
            var _local_14:IVector3d;
            var _local_15:int;
            var _local_16:Number;
            var _local_17:Number;
            var _local_18:Number;
            var _local_19:Number;
            if (this._planesInitialized){
                return;
            };
            var _local_1:IRoomObject = object;
            if (_local_1 == null){
                return;
            };
            if (!isNaN(this._floorThicknessMultiplier)){
                this._planeParser.floorThicknessMultiplier = this._floorThicknessMultiplier;
            };
            if (!isNaN(this._wallThicknessMultiplier)){
                this._planeParser.wallThicknessMultiplier = this._wallThicknessMultiplier;
            };
            var _local_2:String = _local_1.getModel().getString(RoomObjectVariableEnum._SafeStr_5774);
            if (!this._planeParser.initializeFromXML(new XML(_local_2))){
                return;
            };
            var _local_3:Number = this.RoomVisualization();
            var _local_4:Number = this.RoomVisualization();
            var _local_5:Number = 0;
            var _local_6:int = _local_1.getModel().getNumber(RoomObjectVariableEnum._SafeStr_12943);
            var _local_7:int;
            while (_local_7 < this._planeParser.planeCount) {
                _local_8 = this._planeParser.getPlaneLocation(_local_7);
                _local_9 = this._planeParser.getPlaneLeftSide(_local_7);
                _local_10 = this._planeParser.getPlaneRightSide(_local_7);
                _local_11 = this._planeParser.getPlaneSecondaryNormals(_local_7);
                _local_12 = this._planeParser.getPlaneType(_local_7);
                _local_13 = null;
                if (((((!((_local_8 == null))) && (!((_local_9 == null))))) && (!((_local_10 == null))))){
                    _local_14 = Vector3d.crossProduct(_local_9, _local_10);
                    _local_6 = ((_local_6 * 7613) + 517);
                    _local_13 = null;
                    if (_local_12 == RoomPlaneData._SafeStr_5829){
                        _local_13 = new RoomPlane(_local_1.getLocation(), _local_8, _local_9, _local_10, RoomPlane._SafeStr_7291, true, _local_11, _local_6);
                        if (_local_14.z != 0){
                            _local_13.color = _SafeStr_12916;
                        }
                        else {
                            _local_13.color = _SafeStr_12917;
                        };
                        if ((((_local_9.length < 1)) || ((_local_10.length < 1)))){
                            _local_13.hasTexture = false;
                        };
                        if (this._data != null){
                            _local_13.rasterizer = this._data.floorRasterizer;
                        };
                    }
                    else {
                        if (_local_12 == RoomPlaneData._SafeStr_5832){
                            _local_13 = new RoomPlane(_local_1.getLocation(), _local_8, _local_9, _local_10, RoomPlane._SafeStr_10277, true, _local_11, _local_6);
                            if ((((_local_9.length < 1)) || ((_local_10.length < 1)))){
                                _local_13.hasTexture = false;
                            };
                            if ((((_local_14.x == 0)) && ((_local_14.y == 0)))){
                                _local_13.color = _SafeStr_12921;
                            }
                            else {
                                if (_local_14.y > 0){
                                    _local_13.color = _SafeStr_12918;
                                }
                                else {
                                    if (_local_14.y == 0){
                                        _local_13.color = _SafeStr_12919;
                                    }
                                    else {
                                        _local_13.color = _SafeStr_12920;
                                    };
                                };
                            };
                            if (this._data != null){
                                _local_13.rasterizer = this._data.wallRasterizer;
                            };
                        }
                        else {
                            if (_local_12 == RoomPlaneData._SafeStr_5831){
                                _local_13 = new RoomPlane(_local_1.getLocation(), _local_8, _local_9, _local_10, RoomPlane.TYPE_LANDSCAPE, true, _local_11, _local_6, _local_5, 0, _local_3, _local_4);
                                if (_local_14.y > 0){
                                    _local_13.color = _SafeStr_12922;
                                }
                                else {
                                    if (_local_14.y == 0){
                                        _local_13.color = _SafeStr_12923;
                                    }
                                    else {
                                        _local_13.color = _SafeStr_12924;
                                    };
                                };
                                if (this._data != null){
                                    _local_13.rasterizer = this._data.landscapeRasterizer;
                                };
                                _local_5 = (_local_5 + _local_9.length);
                            }
                            else {
                                if (_local_12 == RoomPlaneData._SafeStr_12947){
                                    _local_13 = new RoomPlane(_local_1.getLocation(), _local_8, _local_9, _local_10, RoomPlane._SafeStr_10277, true, _local_11, _local_6);
                                    if ((((_local_9.length < 1)) || ((_local_10.length < 1)))){
                                        _local_13.hasTexture = false;
                                    };
                                    if ((((_local_14.x == 0)) && ((_local_14.y == 0)))){
                                        _local_13.color = _SafeStr_12921;
                                    }
                                    else {
                                        if (_local_14.y > 0){
                                            _local_13.color = _SafeStr_12918;
                                        }
                                        else {
                                            if (_local_14.y == 0){
                                                _local_13.color = _SafeStr_12919;
                                            }
                                            else {
                                                _local_13.color = _SafeStr_12920;
                                            };
                                        };
                                    };
                                    if (this._data != null){
                                        _local_13.rasterizer = this._data.wallAdRasterizr;
                                    };
                                };
                            };
                        };
                    };
                    if (_local_13 != null){
                        _local_13.maskManager = this._data.maskManager;
                        _local_15 = 0;
                        while (_local_15 < this._planeParser.getPlaneMaskCount(_local_7)) {
                            _local_16 = this._planeParser.getPlaneMaskLeftSideLoc(_local_7, _local_15);
                            _local_17 = this._planeParser.getPlaneMaskRightSideLoc(_local_7, _local_15);
                            _local_18 = this._planeParser.getPlaneMaskLeftSideLength(_local_7, _local_15);
                            _local_19 = this._planeParser.getPlaneMaskRightSideLength(_local_7, _local_15);
                            _local_13.addRectangleMask(_local_16, _local_17, _local_18, _local_19);
                            _local_15++;
                        };
                        this._SafeStr_12729.push(_local_13);
                    };
                }
                else {
                    return;
                };
                _local_7++;
            };
            this._planesInitialized = true;
            this.RoomVisualization();
        }
        private function RoomVisualization():Number
        {
            var _local_3:int;
            var _local_4:IVector3d;
            var _local_1:Number = 0;
            var _local_2:int;
            while (_local_2 < this._planeParser.planeCount) {
                _local_3 = this._planeParser.getPlaneType(_local_2);
                if (_local_3 == RoomPlaneData._SafeStr_5831){
                    _local_4 = this._planeParser.getPlaneLeftSide(_local_2);
                    _local_1 = (_local_1 + _local_4.length);
                };
                _local_2++;
            };
            return (_local_1);
        }
        private function RoomVisualization():Number
        {
            var _local_3:int;
            var _local_4:IVector3d;
            var _local_1:Number = 0;
            var _local_2:int;
            while (_local_2 < this._planeParser.planeCount) {
                _local_3 = this._planeParser.getPlaneType(_local_2);
                if (_local_3 == RoomPlaneData._SafeStr_5831){
                    _local_4 = this._planeParser.getPlaneRightSide(_local_2);
                    if (_local_4.length > _local_1){
                        _local_1 = _local_4.length;
                    };
                };
                _local_2++;
            };
            if (_local_1 > 5){
                _local_1 = 5;
            };
            return (_local_1);
        }
        override public function update(_arg_1:IRoomGeometry, _arg_2:int, _arg_3:Boolean, _arg_4:Boolean):void
        {
            var _local_10:int;
            var _local_11:int;
            var _local_12:IRoomObjectSprite;
            var _local_13:RoomPlane;
            var _local_14:uint;
            var _local_15:uint;
            var _local_16:uint;
            var _local_17:uint;
            var _local_18:uint;
            var _local_5:IRoomObject = object;
            if (_local_5 == null){
                return;
            };
            if (_arg_1 == null){
                return;
            };
            var _local_6:Boolean = this.RoomVisualization(_arg_1);
            var _local_7:IRoomObjectModel = _local_5.getModel();
            var _local_8:Boolean;
            if (this.RoomVisualization(_local_7)){
                _local_8 = true;
            };
            if (this.RoomVisualization(_local_7)){
                _local_8 = true;
            };
            this.RoomVisualization();
            _local_8 = this.RoomVisualization(_local_7);
            var _local_9:int = _arg_2;
            if ((((((_local_9 < (this._lastUpdateTime + this._SafeStr_12925))) && (!(_local_6)))) && (!(_local_8)))){
                return;
            };
            if (this.RoomVisualization(_local_7)){
                _local_8 = true;
            };
            if (this.RoomVisualization(_arg_1, _local_6, _arg_2)){
                _local_8 = true;
            };
            if (_local_8){
                _local_10 = 0;
                while (_local_10 < this._SafeStr_12926.length) {
                    _local_11 = this._SafeStr_12927[_local_10];
                    _local_12 = getSprite(_local_11);
                    _local_13 = (this._SafeStr_12926[_local_10] as RoomPlane);
                    if (((((!((_local_12 == null))) && (!((_local_13 == null))))) && (!((_local_13.type == RoomPlane.TYPE_LANDSCAPE))))){
                        if (this._SafeStr_12935){
                            _local_14 = _local_13.color;
                            _local_15 = (((_local_14 & 0xFF) * this._SafeStr_12934) / 0xFF);
                            _local_16 = ((((_local_14 >> 8) & 0xFF) * this._SafeStr_12933) / 0xFF);
                            _local_17 = ((((_local_14 >> 16) & 0xFF) * this._SafeStr_12932) / 0xFF);
                            _local_18 = (_local_14 >> 24);
                            _local_14 = ((((_local_18 << 24) + (_local_17 << 16)) + (_local_16 << 8)) + _local_15);
                            _local_12.color = _local_14;
                        }
                        else {
                            _local_12.color = _local_13.color;
                        };
                    };
                    _local_10++;
                };
                increaseUpdateId();
            };
            _SafeStr_4365 = _local_7.getUpdateID();
            this._lastUpdateTime = _local_9;
        }
        private function RoomVisualization(_arg_1:IRoomGeometry):Boolean
        {
            var _local_3:IVector3d;
            var _local_2:Boolean;
            if (_arg_1.updateId != this._geometryUpdateId){
                this._geometryUpdateId = _arg_1.updateId;
                this._SafeStr_12928 = null;
                _local_3 = _arg_1.direction;
                if (((!((_local_3 == null))) && (((((((!((_local_3.x == this._SafeStr_12788))) || (!((_local_3.y == this._SafeStr_12789))))) || (!((_local_3.z == this._SafeStr_12790))))) || (!((_arg_1.scale == this._SafeStr_12791))))))){
                    this._SafeStr_12788 = _local_3.x;
                    this._SafeStr_12789 = _local_3.y;
                    this._SafeStr_12790 = _local_3.z;
                    this._SafeStr_12791 = _arg_1.scale;
                    _local_2 = true;
                };
            };
            return (_local_2);
        }
        private function RoomVisualization(_arg_1:IRoomObjectModel):Boolean
        {
            var _local_3:String;
            var _local_4:uint;
            var _local_5:Boolean;
            var _local_2:Boolean;
            if (_SafeStr_4365 != _arg_1.getUpdateID()){
                _local_3 = _arg_1.getString(RoomObjectVariableEnum._SafeStr_5801);
                if (_local_3 != this._SafeStr_12930){
                    this.RoomVisualization(_local_3);
                    this._SafeStr_12930 = _local_3;
                    _local_2 = true;
                };
                _local_4 = _arg_1.getNumber(RoomObjectVariableEnum._SafeStr_5775);
                if (_local_4 != this._SafeStr_12931){
                    this._SafeStr_12931 = _local_4;
                    this._SafeStr_12934 = (this._SafeStr_12931 & 0xFF);
                    this._SafeStr_12933 = ((this._SafeStr_12931 >> 8) & 0xFF);
                    this._SafeStr_12932 = ((this._SafeStr_12931 >> 16) & 0xFF);
                    _local_2 = true;
                };
                _local_5 = Boolean(_arg_1.getNumber(RoomObjectVariableEnum._SafeStr_5814));
                if (_local_5 != this._SafeStr_12935){
                    this._SafeStr_12935 = _local_5;
                    _local_2 = true;
                };
            };
            return (_local_2);
        }
        private function RoomVisualization(_arg_1:IRoomObjectModel):Boolean
        {
            var _local_2:String;
            var _local_3:String;
            var _local_4:String;
            var _local_5:Boolean;
            var _local_6:Boolean;
            var _local_7:Boolean;
            if (_SafeStr_4365 != _arg_1.getUpdateID()){
                _local_2 = _arg_1.getString(RoomObjectVariableEnum._SafeStr_5786);
                _local_3 = _arg_1.getString(RoomObjectVariableEnum._SafeStr_5784);
                _local_4 = _arg_1.getString(RoomObjectVariableEnum._SafeStr_5788);
                this.RoomVisualization(_local_3, _local_2, _local_4);
                _local_5 = Boolean(_arg_1.getNumber(RoomObjectVariableEnum._SafeStr_5776));
                _local_6 = Boolean(_arg_1.getNumber(RoomObjectVariableEnum._SafeStr_5777));
                _local_7 = Boolean(_arg_1.getNumber(RoomObjectVariableEnum._SafeStr_5778));
                this.RoomVisualization(_local_5, _local_6, _local_7);
                return (true);
            };
            return (false);
        }
        private function RoomVisualization(_arg_1:IRoomObjectModel):Boolean
        {
            var _local_2:Number;
            var _local_3:Number;
            if (_SafeStr_4365 != _arg_1.getUpdateID()){
                _local_2 = _arg_1.getNumber(RoomObjectVariableEnum._SafeStr_5806);
                _local_3 = _arg_1.getNumber(RoomObjectVariableEnum._SafeStr_5808);
                if (((((!(isNaN(_local_2))) && (!(isNaN(_local_3))))) && (((!((_local_2 == this._floorThicknessMultiplier))) || (!((_local_3 == this._wallThicknessMultiplier))))))){
                    this._floorThicknessMultiplier = _local_2;
                    this._wallThicknessMultiplier = _local_3;
                    this.RoomVisualization();
                    return (true);
                };
            };
            return (false);
        }
        private function RoomVisualization(_arg_1:IRoomObjectModel):Boolean
        {
            var _local_2:Number;
            if (_SafeStr_4365 != _arg_1.getUpdateID()){
                _local_2 = _arg_1.getNumber(RoomObjectVariableEnum._SafeStr_5780);
                if (((!(isNaN(_local_2))) && (!((_local_2 == this._SafeStr_12929))))){
                    this._SafeStr_12929 = _local_2;
                    this.RoomVisualization();
                    return (true);
                };
            };
            return (false);
        }
        protected function RoomVisualization(_arg_1:String, _arg_2:String, _arg_3:String):Boolean
        {
            var _local_5:RoomPlane;
            if (_arg_1 != this._floorType){
                this._floorType = _arg_1;
            }
            else {
                _arg_1 = null;
            };
            if (_arg_2 != this._wallType){
                this._wallType = _arg_2;
            }
            else {
                _arg_2 = null;
            };
            if (_arg_3 != this._landscapeType){
                this._landscapeType = _arg_3;
            }
            else {
                _arg_3 = null;
            };
            if ((((((_arg_1 == null)) && ((_arg_2 == null)))) && ((_arg_3 == null)))){
                return (false);
            };
            var _local_4:int;
            while (_local_4 < this._SafeStr_12729.length) {
                _local_5 = (this._SafeStr_12729[_local_4] as RoomPlane);
                if (_local_5 != null){
                    if ((((_local_5.type == RoomPlane._SafeStr_7291)) && (!((_arg_1 == null))))){
                        _local_5.id = _arg_1;
                    }
                    else {
                        if ((((_local_5.type == RoomPlane._SafeStr_10277)) && (!((_arg_2 == null))))){
                            _local_5.id = _arg_2;
                        }
                        else {
                            if ((((_local_5.type == RoomPlane.TYPE_LANDSCAPE)) && (!((_arg_3 == null))))){
                                _local_5.id = _arg_3;
                            };
                        };
                    };
                };
                _local_4++;
            };
            return (true);
        }
        private function RoomVisualization(_arg_1:Boolean, _arg_2:Boolean, _arg_3:Boolean):void
        {
            if (((((!((_arg_1 == this._SafeStr_12936[RoomPlane._SafeStr_7291]))) || (!((_arg_2 == this._SafeStr_12936[RoomPlane._SafeStr_10277]))))) || (!((_arg_3 == this._SafeStr_12936[RoomPlane.TYPE_LANDSCAPE]))))){
                this._SafeStr_12936[RoomPlane._SafeStr_7291] = _arg_1;
                this._SafeStr_12936[RoomPlane._SafeStr_10277] = _arg_2;
                this._SafeStr_12936[RoomPlane.TYPE_LANDSCAPE] = _arg_3;
                this._SafeStr_12926 = [];
                this._SafeStr_12927 = [];
            };
        }
        protected function RoomVisualization(_arg_1:IRoomGeometry, _arg_2:Boolean, _arg_3:int):Boolean
        {
            var _local_10:int;
            var _local_11:IRoomObjectSprite;
            var _local_12:RoomPlane;
            var _local_13:Number;
            var _local_14:String;
            var _local_4:IRoomObject = object;
            if (_local_4 == null){
                return (false);
            };
            if (_arg_1 == null){
                return (false);
            };
            this._SafeStr_12730++;
            if (_arg_2){
                this._SafeStr_12926 = [];
                this._SafeStr_12927 = [];
            };
            var _local_5:int = _arg_3;
            var _local_6:Array = this._SafeStr_12926;
            if (this._SafeStr_12926.length == 0){
                _local_6 = this._SafeStr_12729;
            };
            var _local_7:Boolean;
            var _local_8 = (this._SafeStr_12926.length > 0);
            var _local_9:int;
            while (_local_9 < _local_6.length) {
                _local_10 = _local_9;
                if (_local_8){
                    _local_10 = this._SafeStr_12927[_local_9];
                };
                _local_11 = getSprite(_local_10);
                if (_local_11 != null){
                    _local_12 = (_local_6[_local_9] as RoomPlane);
                    if (_local_12 != null){
                        if (_local_12.update(_arg_1, _local_5)){
                            if (_local_12.visible){
                                _local_13 = ((_local_12.relativeDepth + this.floorRelativeDepth) + (Number(_local_10) / 1000));
                                if (_local_12.type != RoomPlane._SafeStr_7291){
                                    _local_13 = ((_local_12.relativeDepth + this.wallRelativeDepth) + (Number(_local_10) / 1000));
                                    if ((((_local_12.leftSide.length < 1)) || ((_local_12.rightSide.length < 1)))){
                                        _local_13 = (_local_13 + 50);
                                    };
                                };
                                _local_14 = ((("plane " + _local_10) + " ") + _arg_1.scale);
                                this.updateSprite(_local_11, _local_12, _local_14, _local_13);
                            };
                            _local_7 = true;
                        };
                        if (_local_11.visible != ((_local_12.visible) && (this._SafeStr_12936[_local_12.type]))){
                            _local_11.visible = !(_local_11.visible);
                            _local_7 = true;
                        };
                        if (_local_11.visible){
                            if (!_local_8){
                                this._SafeStr_12926.push(_local_12);
                                this._SafeStr_12927.push(_local_9);
                            };
                        };
                    }
                    else {
                        if (_local_11.visible){
                            _local_11.visible = false;
                            _local_7 = true;
                        };
                    };
                };
                _local_9++;
            };
            return (_local_7);
        }
        private function updateSprite(_arg_1:IRoomObjectSprite, _arg_2:RoomPlane, _arg_3:String, _arg_4:Number):void
        {
            var _local_5:Point = _arg_2.offset;
            _arg_1.offsetX = -(_local_5.x);
            _arg_1.offsetY = -(_local_5.y);
            _arg_1.relativeDepth = _arg_4;
            _arg_1.color = _arg_2.color;
            _arg_1.asset = this.RoomVisualization(_arg_2, _arg_3);
            _arg_1.assetName = ((_arg_3 + "_") + this._SafeStr_12730);
        }
        private function RoomVisualization(_arg_1:RoomPlane, _arg_2:String):BitmapData
        {
            var _local_3:BitmapDataAsset = (this._assetLibrary.getAssetByName(_arg_2) as BitmapDataAsset);
            if (_local_3 == null){
                _local_3 = new BitmapDataAsset(this._assetLibrary.IAssetLibrary(BitmapDataAsset));
                this._assetLibrary.IAssetLibrary(_arg_2, _local_3);
            };
            var _local_4:BitmapData = (_local_3.content as BitmapData);
            var _local_5:BitmapData = _arg_1.RoomPlane(_local_4);
            if (_local_5 == null){
                _local_5 = _arg_1.bitmapData;
                if (_local_5 != null){
                    if (_local_4 != _local_5){
                        if (_local_4 != null){
                            _local_4.dispose();
                        };
                        _local_3.setUnknownContent(_local_5);
                    };
                };
            };
            return (_local_5);
        }
        protected function RoomVisualization(_arg_1:String):void
        {
            var _local_10:String;
            var _local_11:IVector3d;
            var _local_12:String;
            var _local_13:int;
            var _local_14:IVector3d;
            var _local_15:Number;
            var _local_16:Number;
            var _local_17:Number;
            var _local_18:int;
            if (_arg_1 == null){
                return;
            };
            var _local_2:XML = XML(_arg_1);
            this._SafeStr_5763.initialize(_local_2);
            var _local_3:RoomPlane;
            var _local_4:Array = [];
            var _local_5:Array = [];
            var _local_6:Boolean;
            var _local_7:int;
            while (_local_7 < this._SafeStr_12729.length) {
                _local_3 = (this._SafeStr_12729[_local_7] as RoomPlane);
                if (_local_3 != null){
                    _local_3.resetBitmapMasks();
                    if (_local_3.type == RoomPlane.TYPE_LANDSCAPE){
                        _local_4.push(_local_7);
                    };
                };
                _local_7++;
            };
            var _local_8:int;
            while (_local_8 < this._SafeStr_5763.maskCount) {
                _local_10 = this._SafeStr_5763.RoomPlaneBitmapMaskParser(_local_8);
                _local_11 = this._SafeStr_5763.RoomPlaneBitmapMaskParser(_local_8);
                _local_12 = this._SafeStr_5763.RoomPlaneBitmapMaskParser(_local_8);
                if (_local_11 != null){
                    _local_13 = 0;
                    while (_local_13 < this._SafeStr_12729.length) {
                        _local_3 = (this._SafeStr_12729[_local_13] as RoomPlane);
                        if ((((_local_3.type == RoomPlane._SafeStr_10277)) || ((_local_3.type == RoomPlane.TYPE_LANDSCAPE)))){
                            if (((((!((_local_3 == null))) && (!((_local_3.location == null))))) && (!((_local_3.normal == null))))){
                                _local_14 = Vector3d.dif(_local_11, _local_3.location);
                                _local_15 = Math.abs(Vector3d.scalarProjection(_local_14, _local_3.normal));
                                if (_local_15 < 0.01){
                                    if (((!((_local_3.leftSide == null))) && (!((_local_3.rightSide == null))))){
                                        _local_16 = Vector3d.scalarProjection(_local_14, _local_3.leftSide);
                                        _local_17 = Vector3d.scalarProjection(_local_14, _local_3.rightSide);
                                        if ((((_local_3.type == RoomPlane._SafeStr_10277)) || ((((_local_3.type == RoomPlane.TYPE_LANDSCAPE)) && ((_local_12 == RoomPlaneBitmapMaskData._SafeStr_5793)))))){
                                            _local_3.addBitmapMask(_local_10, _local_16, _local_17);
                                        }
                                        else {
                                            if (_local_3.type == RoomPlane.TYPE_LANDSCAPE){
                                                if (!_local_3.canBeVisible){
                                                    _local_6 = true;
                                                };
                                                _local_3.canBeVisible = true;
                                                _local_5.push(_local_13);
                                            };
                                        };
                                    };
                                };
                            };
                        };
                        _local_13++;
                    };
                };
                _local_8++;
            };
            var _local_9:int;
            while (_local_9 < _local_4.length) {
                _local_18 = _local_4[_local_9];
                if (_local_5.indexOf(_local_18) < 0){
                    _local_3 = (this._SafeStr_12729[_local_18] as RoomPlane);
                    _local_3.canBeVisible = false;
                    _local_6 = true;
                };
                _local_9++;
            };
            if (_local_6){
                this._SafeStr_12926 = [];
                this._SafeStr_12927 = [];
            };
        }

    }
}//package com.sulake.habbo.room.object.visualization.room

// _SafeStr_10277 = "_-2s7" (String#21163, DoABC#2)
// dif = "_-wu" (String#24566, DoABC#2)
// updateSprite = "_-2yQ" (String#1975, DoABC#2)
// _SafeStr_12729 = "_-29o" (String#879, DoABC#2)
// _SafeStr_12730 = "_-2md" (String#7014, DoABC#2)
// RoomVisualization = "_-10j" (String#4890, DoABC#2)
// crossProduct = "_-0hD" (String#15719, DoABC#2)
// RoomVisualization = "_-22x" (String#6103, DoABC#2)
// _SafeStr_12788 = "_-1ta" (String#5913, DoABC#2)
// _SafeStr_12789 = "_-2si" (String#7133, DoABC#2)
// _SafeStr_12790 = "_-2kj" (String#6971, DoABC#2)
// _SafeStr_12791 = "_-36m" (String#7445, DoABC#2)
// leftSide = "_-3Gi" (String#22151, DoABC#2)
// rightSide = "_-kB" (String#24043, DoABC#2)
// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// floorRasterizer = "_-1ou" (String#18495, DoABC#2)
// wallRasterizer = "_-1Th" (String#17653, DoABC#2)
// wallAdRasterizr = "_-2od" (String#21029, DoABC#2)
// landscapeRasterizer = "_-Am" (String#22646, DoABC#2)
// maskManager = "_-2sw" (String#21196, DoABC#2)
// _SafeStr_12916 = "_-0Iq" (String#14794, DoABC#2)
// _SafeStr_12917 = "_-0xA" (String#16319, DoABC#2)
// _SafeStr_12918 = "_-1mC" (String#18388, DoABC#2)
// _SafeStr_12919 = "_-2so" (String#21192, DoABC#2)
// _SafeStr_12920 = "_-2uO" (String#21256, DoABC#2)
// _SafeStr_12921 = "_-2n2" (String#20963, DoABC#2)
// _SafeStr_12922 = "_-2Ol" (String#19994, DoABC#2)
// _SafeStr_12923 = "_-29e" (String#19390, DoABC#2)
// _SafeStr_12924 = "_-8P" (String#22558, DoABC#2)
// _SafeStr_12925 = "_-2sc" (String#21185, DoABC#2)
// _SafeStr_12926 = "_-1QI" (String#17523, DoABC#2)
// _SafeStr_12927 = "_-Im" (String#22958, DoABC#2)
// _SafeStr_12928 = "_-2-b" (String#18995, DoABC#2)
// _SafeStr_12929 = "_-2NO" (String#19939, DoABC#2)
// _SafeStr_12930 = "_-0QY" (String#15084, DoABC#2)
// _SafeStr_12931 = "_-0jb" (String#15811, DoABC#2)
// _SafeStr_12932 = "_-2LQ" (String#19864, DoABC#2)
// _SafeStr_12933 = "_-1FA" (String#17077, DoABC#2)
// _SafeStr_12934 = "_-1Tj" (String#17654, DoABC#2)
// _SafeStr_12935 = "_-1k" (String#18286, DoABC#2)
// _SafeStr_12936 = "_-2W3" (String#20284, DoABC#2)
// _SafeStr_12937 = "_-Z1" (String#23602, DoABC#2)
// wallAdRelativeDepth = "_-0cc" (String#15540, DoABC#2)
// RoomVisualization = "_-1aq" (String#17927, DoABC#2)
// IVector3d = "_-hf" (String#8547, DoABC#2)
// RoomVisualization = "_-2Ut" (String#20233, DoABC#2)
// RoomVisualization = "_-0gV" (String#15693, DoABC#2)
// RoomVisualization = "_-168" (String#16701, DoABC#2)
// _SafeStr_12943 = "_-21-" (String#19052, DoABC#2)
// getPlaneSecondaryNormals = "_-2-e" (String#18998, DoABC#2)
// hasTexture = "_-sP" (String#24377, DoABC#2)
// rasterizer = "_-1Bj" (String#16931, DoABC#2)
// _SafeStr_12947 = "_-0wA" (String#16279, DoABC#2)
// getPlaneMaskCount = "_-0GG" (String#14695, DoABC#2)
// getPlaneMaskLeftSideLoc = "_-22Z" (String#19113, DoABC#2)
// Vector3d = "_-1Rb" (String#17568, DoABC#2)
// getPlaneMaskRightSideLoc = "_-2qb" (String#21106, DoABC#2)
// getPlaneMaskLeftSideLength = "_-15t" (String#16693, DoABC#2)
// getPlaneMaskRightSideLength = "_-0H7" (String#14723, DoABC#2)
// addRectangleMask = "_-1aF" (String#17905, DoABC#2)
// RoomVisualization = "_-1rl" (String#18621, DoABC#2)
// RoomVisualization = "_-D3" (String#22730, DoABC#2)
// RoomVisualization = "_-2L3" (String#19849, DoABC#2)
// RoomVisualization = "_-2ah" (String#20474, DoABC#2)
// RoomVisualization = "_-1GP" (String#17131, DoABC#2)
// RoomVisualization = "_-2Ms" (String#19921, DoABC#2)
// RoomVisualization = "_-3-M" (String#21476, DoABC#2)
// RoomPlane = "_-1Eg" (String#17056, DoABC#2)
// resetBitmapMasks = "_-1Ab" (String#16883, DoABC#2)
// maskCount = "_-3BF" (String#21934, DoABC#2)
// RoomPlaneBitmapMaskParser = "_-rP" (String#24334, DoABC#2)
// RoomPlaneBitmapMaskParser = "_-3Di" (String#22023, DoABC#2)
// RoomPlaneBitmapMaskParser = "_-1wz" (String#18845, DoABC#2)
// scalarProjection = "_-2p1" (String#21043, DoABC#2)
// addBitmapMask = "_-1GD" (String#17124, DoABC#2)
// RoomObjectVariableEnum = "_-1MH" (String#17370, DoABC#2)
// IRoomObjectVisualizationData = "_-26A" (String#6167, DoABC#2)
// IRoomObjectModel = "_-253" (String#6141, DoABC#2)
// RoomVisualizationData = "_-0T2" (String#4161, DoABC#2)
// RoomObjectSpriteVisualization = "_-01y" (String#3602, DoABC#2)
// RoomVisualization = "_-0ky" (String#4520, DoABC#2)
// IRoomGeometry = "_-0z9" (String#4829, DoABC#2)
// RoomPlaneParser = "_-2Ya" (String#6737, DoABC#2)
// RoomPlaneBitmapMaskParser = "_-27E" (String#6188, DoABC#2)
// RoomPlaneData = "_-1iF" (String#5716, DoABC#2)
// RoomPlaneBitmapMaskData = "_-2dh" (String#6826, DoABC#2)
// IRoomObjectSprite = "_-0di" (String#4386, DoABC#2)
// RoomPlane = "_-04m" (String#3662, DoABC#2)
// _wallType = "_-04G" (String#578, DoABC#2)
// _landscapeType = "_-2Wo" (String#621, DoABC#2)
// _wallThicknessMultiplier = "_-LU" (String#2093, DoABC#2)
// _floorThicknessMultiplier = "_-3Ab" (String#2015, DoABC#2)
// wallThicknessMultiplier = "_-0wt" (String#16306, DoABC#2)
// floorThicknessMultiplier = "_-1NT" (String#17417, DoABC#2)
// getUpdateID = "_-Ga" (String#932, DoABC#2)
// _SafeStr_4365 = "_-2rK" (String#21130, DoABC#2)
// getSprite = "_-sN" (String#2210, DoABC#2)
// _geometryUpdateId = "_-2yN" (String#370, DoABC#2)
// createSprites = "_-1Im" (String#17226, DoABC#2)
// updateId = "_-0TD" (String#1478, DoABC#2)
// increaseUpdateId = "_-vd" (String#24514, DoABC#2)
// boundingRectangle = "_-0m7" (String#4552, DoABC#2)
// _SafeStr_5763 = "_-5-" (String#7764, DoABC#2)
// initializeFromXML = "_-00L" (String#14068, DoABC#2)
// _SafeStr_5774 = "_-19Y" (String#16839, DoABC#2)
// _SafeStr_5775 = "_-M3" (String#23084, DoABC#2)
// _SafeStr_5776 = "_-9N" (String#22594, DoABC#2)
// _SafeStr_5777 = "_-1rI" (String#18595, DoABC#2)
// _SafeStr_5778 = "_-qL" (String#24285, DoABC#2)
// _SafeStr_5780 = "_-0kL" (String#15843, DoABC#2)
// _SafeStr_5784 = "_-2G-" (String#19644, DoABC#2)
// _SafeStr_5786 = "_-1SC" (String#17588, DoABC#2)
// _SafeStr_5788 = "_-Nt" (String#23160, DoABC#2)
// RoomVisualization = "_-7g" (String#7817, DoABC#2)
// _SafeStr_5793 = "_-3En" (String#22068, DoABC#2)
// _SafeStr_5801 = "_-Yf" (String#23585, DoABC#2)
// _SafeStr_5806 = "_-2B8" (String#19450, DoABC#2)
// _SafeStr_5808 = "_-08p" (String#14398, DoABC#2)
// RoomVisualization = "_-1mt" (String#5796, DoABC#2)
// _SafeStr_5814 = "_-2v1" (String#21279, DoABC#2)
// planeCount = "_-2lv" (String#20913, DoABC#2)
// getPlaneLocation = "_-dB" (String#23767, DoABC#2)
// getPlaneLeftSide = "_-IZ" (String#22950, DoABC#2)
// getPlaneRightSide = "_-1a4" (String#17897, DoABC#2)
// getPlaneType = "_-3BR" (String#21940, DoABC#2)
// _SafeStr_5829 = "_-dd" (String#23787, DoABC#2)
// _SafeStr_5831 = "_-1Gc" (String#17138, DoABC#2)
// _SafeStr_5832 = "_-0IL" (String#14772, DoABC#2)
// initializeAssetCollection = "_-24a" (String#19205, DoABC#2)
// _SafeStr_7291 = "_-00x" (String#1383, DoABC#2)
// floorRelativeDepth = "_-1De" (String#17009, DoABC#2)
// wallRelativeDepth = "_-61" (String#22467, DoABC#2)
// setUnknownContent = "_-2zE" (String#7271, DoABC#2)
// IAssetLibrary = "_-08Y" (String#3730, DoABC#2)
// IAssetLibrary = "_-5x" (String#7779, DoABC#2)


