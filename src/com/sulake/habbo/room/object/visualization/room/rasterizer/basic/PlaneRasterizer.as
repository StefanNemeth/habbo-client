
package com.sulake.habbo.room.object.visualization.room.rasterizer.basic
{
    import com.sulake.habbo.room.object.visualization.room.rasterizer.IPlaneRasterizer;
    import com.sulake.room.object.visualization.utils.IGraphicAssetCollection;
    import com.sulake.core.utils.Map;
    import com.sulake.room.utils.RoomGeometry;
    import com.sulake.room.object.visualization.utils.IGraphicAsset;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.display.BitmapData;
    import com.sulake.room.utils.XMLValidator;
    import com.sulake.room.utils.Rasterizer;
    import flash.geom.Point;
    import com.sulake.room.utils.IRoomGeometry;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.room.utils.IVector3d;
    import com.sulake.habbo.room.object.visualization.room.utils.PlaneBitmapData;

    public class PlaneRasterizer implements IPlaneRasterizer 
    {

        protected static const _SafeStr_4870:String = "default";

        private var _assetCollection:IGraphicAssetCollection = null;
        private var _SafeStr_12852:Map = null;
        private var _SafeStr_12797:Map = null;
        private var _SafeStr_12729:Map = null;
        private var _SafeStr_12853:Map = null;
        private var _data:XML = null;

        public function PlaneRasterizer()
        {
            this._SafeStr_12797 = new Map();
            this._SafeStr_12852 = new Map();
            this._SafeStr_12729 = new Map();
            this._SafeStr_12853 = new Map();
        }
        protected function get data():XML
        {
            return (this._data);
        }
        protected function get assetCollection():IGraphicAssetCollection
        {
            return (this._assetCollection);
        }
        public function initializeDimensions(_arg_1:int, _arg_2:int):Boolean
        {
            return (true);
        }
        public function dispose():void
        {
            var _local_2:Plane;
            var _local_3:RoomGeometry;
            var _local_1:int;
            if (this._SafeStr_12729 != null){
                _local_1 = 0;
                while (_local_1 < this._SafeStr_12729.length) {
                    _local_2 = (this._SafeStr_12729.getWithIndex(_local_1) as Plane);
                    if (_local_2 != null){
                        _local_2.dispose();
                    };
                    _local_1++;
                };
                this._SafeStr_12729.dispose();
                this._SafeStr_12729 = null;
            };
            if (this._SafeStr_12852 != null){
                this.resetMaterials();
                this._SafeStr_12852.dispose();
                this._SafeStr_12852 = null;
            };
            if (this._SafeStr_12797 != null){
                this.resetTextures();
                this._SafeStr_12797.dispose();
                this._SafeStr_12797 = null;
            };
            if (this._SafeStr_12853 != null){
                _local_1 = 0;
                while (_local_1 < this._SafeStr_12853.length) {
                    _local_3 = this._SafeStr_12853.getWithIndex(_local_1);
                    if (_local_3 != null){
                        _local_3.dispose();
                    };
                    _local_1++;
                };
                this._SafeStr_12853.dispose();
                this._SafeStr_12853 = null;
            };
            this._data = null;
            this._assetCollection = null;
        }
        public function clearCache():void
        {
            var _local_2:Plane;
            var _local_3:PlaneMaterial;
            var _local_1:int;
            _local_1 = 0;
            while (_local_1 < this._SafeStr_12729.length) {
                _local_2 = (this._SafeStr_12729.getWithIndex(_local_1) as Plane);
                if (_local_2 != null){
                    _local_2.clearCache();
                };
                _local_1++;
            };
            _local_1 = 0;
            while (_local_1 < this._SafeStr_12852.length) {
                _local_3 = (this._SafeStr_12852.getWithIndex(_local_1) as PlaneMaterial);
                if (_local_3 != null){
                    _local_3.clearCache();
                };
                _local_1++;
            };
        }
        public function initialize(_arg_1:XML):void
        {
            this._data = _arg_1;
        }
        public function reinitialize():void
        {
            this.resetTextures();
            this.resetMaterials();
            this.initializeAll();
        }
        private function resetMaterials():void
        {
            var _local_2:PlaneMaterial;
            var _local_1:int;
            while (_local_1 < this._SafeStr_12852.length) {
                _local_2 = (this._SafeStr_12852.getWithIndex(_local_1) as PlaneMaterial);
                if (_local_2 != null){
                    _local_2.dispose();
                };
                _local_1++;
            };
            this._SafeStr_12852.reset();
        }
        private function resetTextures():void
        {
            var _local_2:PlaneTexture;
            var _local_1:int;
            while (_local_1 < this._SafeStr_12797.length) {
                _local_2 = (this._SafeStr_12797.getWithIndex(_local_1) as PlaneTexture);
                if (_local_2 != null){
                    _local_2.dispose();
                };
                _local_1++;
            };
            this._SafeStr_12797.reset();
        }
        protected function getTexture(_arg_1:String):PlaneTexture
        {
            return ((this._SafeStr_12797.getValue(_arg_1) as PlaneTexture));
        }
        protected function getMaterial(_arg_1:String):PlaneMaterial
        {
            return ((this._SafeStr_12852.getValue(_arg_1) as PlaneMaterial));
        }
        protected function getPlane(_arg_1:String):Plane
        {
            return (this._SafeStr_12729.getValue(_arg_1));
        }
        protected function addPlane(_arg_1:String, _arg_2:Plane):Boolean
        {
            if (_arg_2 == null){
                return (false);
            };
            if (this._SafeStr_12729.getValue(_arg_1) == null){
                this._SafeStr_12729.add(_arg_1, _arg_2);
                return (true);
            };
            return (false);
        }
        public function initializeAssetCollection(_arg_1:IGraphicAssetCollection):void
        {
            if (this.data == null){
                return;
            };
            this._assetCollection = _arg_1;
            this.initializeAll();
        }
        private function initializeAll():void
        {
            if (this.data == null){
                return;
            };
            this.initializeTexturesAndMaterials();
            this.initializePlanes();
        }
        private function initializeTexturesAndMaterials():void
        {
            var _local_1:XMLList = this.data.textures;
            if (_local_1.length() > 0){
                this.parseTextures(_local_1[0], this.assetCollection);
            };
            var _local_2:XMLList = this.data.materials;
            if (_local_2.length() > 0){
                this.parsePlaneMaterials(_local_2[0]);
            };
        }
        protected function initializePlanes():void
        {
        }
        private function parseTextures(_arg_1:XML, _arg_2:IGraphicAssetCollection):void
        {
            var _local_5:XML;
            var _local_6:String;
            var _local_7:PlaneTexture;
            var _local_8:XMLList;
            var _local_9:int;
            var _local_10:XML;
            var _local_11:Number;
            var _local_12:Number;
            var _local_13:Number;
            var _local_14:Number;
            var _local_15:String;
            var _local_16:IGraphicAsset;
            var _local_17:BitmapDataAsset;
            var _local_18:BitmapData;
            if ((((_arg_1 == null)) || ((_arg_2 == null)))){
                return;
            };
            var _local_3:XMLList = _arg_1.texture;
            var _local_4:int;
            while (_local_4 < _local_3.length()) {
                _local_5 = _local_3[_local_4];
                if (XMLValidator.checkRequiredAttributes(_local_5, ["id"])){
                    _local_6 = _local_5.@id;
                    if (this._SafeStr_12797.getValue(_local_6) == null){
                        _local_7 = new PlaneTexture();
                        _local_8 = _local_5.bitmap;
                        _local_9 = 0;
                        while (_local_9 < _local_8.length()) {
                            _local_10 = _local_8[_local_9];
                            if (XMLValidator.checkRequiredAttributes(_local_10, ["assetName"])){
                                _local_11 = PlaneTexture._SafeStr_12841;
                                _local_12 = PlaneTexture.MAX_NORMAL_COORDINATE_VALUE;
                                _local_13 = PlaneTexture._SafeStr_12841;
                                _local_14 = PlaneTexture.MAX_NORMAL_COORDINATE_VALUE;
                                if (String(_local_10.@normalMinX) != ""){
                                    _local_11 = parseFloat(_local_10.@normalMinX);
                                };
                                if (String(_local_10.@normalMaxX) != ""){
                                    _local_12 = parseFloat(_local_10.@normalMaxX);
                                };
                                if (String(_local_10.@normalMinY) != ""){
                                    _local_13 = parseFloat(_local_10.@normalMinY);
                                };
                                if (String(_local_10.@normalMaxY) != ""){
                                    _local_14 = parseFloat(_local_10.@normalMaxY);
                                };
                                _local_15 = _local_10.@assetName;
                                _local_16 = _arg_2.getAsset(_local_15);
                                if (_local_16 != null){
                                    _local_17 = (_local_16.asset as BitmapDataAsset);
                                    if (_local_17 != null){
                                        _local_18 = (_local_17.content as BitmapData);
                                        if (_local_18 != null){
                                            if (_local_16.flipH){
                                                _local_18 = Rasterizer.getFlipHBitmapData(_local_18);
                                            }
                                            else {
                                                _local_18 = _local_18.clone();
                                            };
                                            _local_7.addBitmap(_local_18, _local_11, _local_12, _local_13, _local_14);
                                        };
                                    };
                                };
                            };
                            _local_9++;
                        };
                        this._SafeStr_12797.add(_local_6, _local_7);
                    };
                };
                _local_4++;
            };
        }
        private function parsePlaneMaterials(_arg_1:XML):void
        {
            var _local_4:XML;
            var _local_5:String;
            var _local_6:PlaneMaterial;
            var _local_7:XMLList;
            var _local_8:int;
            var _local_9:XML;
            var _local_10:String;
            var _local_11:String;
            var _local_12:int;
            var _local_13:int;
            var _local_14:Number;
            var _local_15:Number;
            var _local_16:Number;
            var _local_17:Number;
            var _local_18:XMLList;
            var _local_19:PlaneMaterialCellMatrix;
            var _local_20:int;
            var _local_21:XML;
            if (_arg_1 == null){
                return;
            };
            var _local_2:XMLList = _arg_1.material;
            var _local_3:int;
            while (_local_3 < _local_2.length()) {
                _local_4 = _local_2[_local_3];
                if (XMLValidator.checkRequiredAttributes(_local_4, ["id"])){
                    _local_5 = _local_4.@id;
                    _local_6 = new PlaneMaterial();
                    _local_7 = _local_4.materialCellMatrix;
                    _local_8 = 0;
                    while (_local_8 < _local_7.length()) {
                        _local_9 = _local_7[_local_8];
                        _local_10 = _local_9.@repeatMode;
                        _local_11 = _local_9.@align;
                        _local_12 = PlaneMaterialCellMatrix._SafeStr_12860;
                        switch (_local_10){
                            case "borders":
                                _local_12 = PlaneMaterialCellMatrix._SafeStr_12861;
                                break;
                            case "center":
                                _local_12 = PlaneMaterialCellMatrix._SafeStr_12862;
                                break;
                            case "first":
                                _local_12 = PlaneMaterialCellMatrix._SafeStr_12863;
                                break;
                            case "last":
                                _local_12 = PlaneMaterialCellMatrix._SafeStr_12864;
                                break;
                            case "random":
                                _local_12 = PlaneMaterialCellMatrix._SafeStr_12865;
                                break;
                        };
                        _local_13 = PlaneMaterialCellMatrix.ALIGN_DEFAULT;
                        switch (_local_11){
                            case "top":
                                _local_13 = PlaneMaterialCellMatrix._SafeStr_4863;
                                break;
                            case "bottom":
                                _local_13 = PlaneMaterialCellMatrix._SafeStr_4862;
                                break;
                        };
                        _local_14 = PlaneMaterialCellMatrix._SafeStr_12841;
                        _local_15 = PlaneMaterialCellMatrix.MAX_NORMAL_COORDINATE_VALUE;
                        _local_16 = PlaneMaterialCellMatrix._SafeStr_12841;
                        _local_17 = PlaneMaterialCellMatrix.MAX_NORMAL_COORDINATE_VALUE;
                        if (String(_local_9.@normalMinX) != ""){
                            _local_14 = parseFloat(_local_9.@normalMinX);
                        };
                        if (String(_local_9.@normalMaxX) != ""){
                            _local_15 = parseFloat(_local_9.@normalMaxX);
                        };
                        if (String(_local_9.@normalMinY) != ""){
                            _local_16 = parseFloat(_local_9.@normalMinY);
                        };
                        if (String(_local_9.@normalMaxY) != ""){
                            _local_17 = parseFloat(_local_9.@normalMaxY);
                        };
                        _local_18 = _local_9.materialCellColumn;
                        if (_local_18.length() > 0){
                            _local_19 = null;
                            _local_19 = _local_6.addMaterialCellMatrix(_local_18.length(), _local_12, _local_13, _local_14, _local_15, _local_16, _local_17);
                            _local_20 = 0;
                            while (_local_20 < _local_18.length()) {
                                _local_21 = _local_18[_local_20];
                                this.parsePlaneMaterialCellColumn(_local_21, _local_19, _local_20);
                                _local_20++;
                            };
                        };
                        this._SafeStr_12852.add(_local_5, _local_6);
                        _local_8++;
                    };
                };
                _local_3++;
            };
        }
        private function parsePlaneMaterialCellColumn(_arg_1:XML, _arg_2:PlaneMaterialCellMatrix, _arg_3:int):void
        {
            if ((((_arg_1 == null)) || ((_arg_2 == null)))){
                return;
            };
            var _local_4:String = _arg_1.@repeatMode;
            var _local_5:int = parseInt(_arg_1.@width);
            var _local_6:int = PlaneMaterialCellColumn._SafeStr_12868;
            switch (_local_4){
                case "borders":
                    _local_6 = PlaneMaterialCellColumn._SafeStr_12861;
                    break;
                case "center":
                    _local_6 = PlaneMaterialCellColumn._SafeStr_12862;
                    break;
                case "first":
                    _local_6 = PlaneMaterialCellColumn._SafeStr_12863;
                    break;
                case "last":
                    _local_6 = PlaneMaterialCellColumn._SafeStr_12864;
                    break;
                case "none":
                    _local_6 = PlaneMaterialCellColumn._SafeStr_12869;
            };
            var _local_7:Array = this.parsePlaneMaterialCells(_arg_1);
            _arg_2.createColumn(_arg_3, _local_5, _local_7, _local_6);
        }
        private function parsePlaneMaterialCells(_arg_1:XML):Array
        {
            var _local_5:XML;
            var _local_6:String;
            var _local_7:Array;
            var _local_8:Array;
            var _local_9:Array;
            var _local_10:int;
            var _local_11:XMLList;
            var _local_12:PlaneTexture;
            var _local_13:PlaneMaterialCell;
            var _local_14:XML;
            var _local_15:XMLList;
            var _local_16:XMLList;
            var _local_17:XML;
            var _local_18:XML;
            var _local_19:int;
            var _local_20:String;
            var _local_21:IGraphicAsset;
            if (_arg_1 == null){
                return (null);
            };
            var _local_2:Array = [];
            var _local_3:XMLList = _arg_1.materialCell;
            var _local_4:int;
            while (_local_4 < _local_3.length()) {
                _local_5 = _local_3[_local_4];
                _local_6 = _local_5.@textureId;
                _local_7 = null;
                _local_8 = null;
                _local_9 = null;
                _local_10 = 0;
                _local_11 = _local_5.extraItemData;
                if (_local_11.length() > 0){
                    _local_14 = _local_11[0];
                    _local_15 = _local_14.extraItemTypes;
                    _local_16 = _local_14.offsets;
                    if ((((_local_15.length() > 0)) && ((_local_16.length() > 0)))){
                        _local_17 = _local_15[0];
                        _local_18 = _local_16[0];
                        _local_7 = this.parseExtraItemTypes(_local_17);
                        _local_9 = this.parseExtraItemOffsets(_local_18);
                        _local_10 = _local_9.length;
                        if (String(_local_14.@limitMax) != ""){
                            _local_10 = parseInt(_local_14.@limitMax);
                        };
                    };
                };
                if (_local_7 != null){
                    _local_8 = [];
                    _local_19 = 0;
                    while (_local_19 < _local_7.length) {
                        _local_20 = _local_7[_local_4];
                        _local_21 = this._assetCollection.getAsset(_local_20);
                        if (_local_21 != null){
                            _local_8.push(_local_21);
                        };
                        _local_19++;
                    };
                };
                _local_12 = this.getTexture(_local_6);
                _local_13 = new PlaneMaterialCell(_local_12, _local_8, _local_9, _local_10);
                _local_2.push(_local_13);
                _local_4++;
            };
            if (_local_2.length == 0){
                _local_2 = null;
            };
            return (_local_2);
        }
        private function parseExtraItemTypes(_arg_1:XML):Array
        {
            var _local_4:XMLList;
            var _local_5:int;
            var _local_6:XML;
            var _local_7:String;
            var _local_2:Array = [];
            var _local_3:Array = ["assetName"];
            if (_arg_1 != null){
                _local_4 = _arg_1.extraItemType;
                _local_5 = 0;
                while (_local_5 < _local_4.length()) {
                    _local_6 = _local_4[_local_5];
                    if (XMLValidator.checkRequiredAttributes(_local_6, _local_3)){
                        _local_7 = _local_6.@assetName;
                        _local_2.push(_local_7);
                    };
                    _local_5++;
                };
            };
            return (_local_2);
        }
        private function parseExtraItemOffsets(_arg_1:XML):Array
        {
            var _local_4:XMLList;
            var _local_5:int;
            var _local_6:XML;
            var _local_7:int;
            var _local_8:int;
            var _local_2:Array = [];
            var _local_3:Array = ["x", "y"];
            if (_arg_1 != null){
                _local_4 = _arg_1.offset;
                _local_5 = 0;
                while (_local_5 < _local_4.length()) {
                    _local_6 = _local_4[_local_5];
                    if (XMLValidator.checkRequiredAttributes(_local_6, _local_3)){
                        _local_7 = parseInt(_local_6.@x);
                        _local_8 = parseInt(_local_6.@y);
                        _local_2.push(new Point(_local_7, _local_8));
                    };
                    _local_5++;
                };
            };
            return (_local_2);
        }
        protected function getGeometry(_arg_1:int, _arg_2:Number, _arg_3:Number):IRoomGeometry
        {
            _arg_2 = Math.abs(_arg_2);
            if (_arg_2 > 90){
                _arg_2 = 90;
            };
            _arg_3 = Math.abs(_arg_3);
            if (_arg_3 > 90){
                _arg_3 = 90;
            };
            var _local_4:String = ((((_arg_1 + "_") + Math.round(_arg_2)) + "_") + Math.round(_arg_3));
            var _local_5:IRoomGeometry = this._SafeStr_12853.getValue(_local_4);
            if (_local_5 == null){
                _local_5 = new RoomGeometry(_arg_1, new Vector3d(_arg_2, _arg_3), new Vector3d(-10, 0, 0));
                this._SafeStr_12853.add(_local_4, _local_5);
            };
            return (_local_5);
        }
        protected function parseVisualizations(_arg_1:Plane, _arg_2:XMLList):void
        {
            var _local_4:XML;
            var _local_5:int;
            var _local_6:String;
            var _local_7:String;
            var _local_8:Number;
            var _local_9:Number;
            var _local_10:XMLList;
            var _local_11:PlaneVisualization;
            var _local_12:int;
            var _local_13:XML;
            var _local_14:PlaneMaterial;
            var _local_15:int;
            var _local_16:String;
            var _local_17:int;
            var _local_18:String;
            var _local_19:uint;
            var _local_20:String;
            var _local_21:String;
            if ((((_arg_1 == null)) || ((_arg_2 == null)))){
                return;
            };
            var _local_3:int;
            while (_local_3 < _arg_2.length()) {
                _local_4 = _arg_2[_local_3];
                if (XMLValidator.checkRequiredAttributes(_local_4, ["size"])){
                    _local_5 = parseInt(_local_4.@size);
                    _local_6 = _local_4.@horizontalAngle;
                    _local_7 = _local_4.@verticalAngle;
                    _local_8 = FloorPlane._SafeStr_4854;
                    if (_local_6 != ""){
                        _local_8 = parseFloat(_local_6);
                    };
                    _local_9 = FloorPlane._SafeStr_4855;
                    if (_local_7 != ""){
                        _local_9 = parseFloat(_local_7);
                    };
                    _local_10 = _local_4.visualizationLayer;
                    _local_11 = _arg_1.createPlaneVisualization(_local_5, _local_10.length(), this.getGeometry(_local_5, _local_8, _local_9));
                    if (_local_11 != null){
                        _local_12 = 0;
                        while (_local_12 < _local_10.length()) {
                            _local_13 = _local_10[_local_12];
                            _local_14 = null;
                            _local_15 = PlaneVisualizationLayer.ALIGN_DEFAULT;
                            if (XMLValidator.checkRequiredAttributes(_local_13, ["materialId"])){
                                _local_21 = _local_13.@materialId;
                                _local_14 = this.getMaterial(_local_21);
                            };
                            _local_16 = _local_13.@offset;
                            _local_17 = PlaneVisualizationLayer._SafeStr_4860;
                            if (_local_16.length > 0){
                                _local_17 = parseInt(_local_16);
                            };
                            _local_18 = _local_13.@color;
                            _local_19 = FloorPlane._SafeStr_4861;
                            if (_local_18.length > 0){
                                _local_19 = parseInt(_local_18);
                            };
                            _local_20 = _local_13.@align;
                            if (_local_20 == "bottom"){
                                _local_15 = PlaneVisualizationLayer._SafeStr_4862;
                            }
                            else {
                                if (_local_20 == "top"){
                                    _local_15 = PlaneVisualizationLayer._SafeStr_4863;
                                };
                            };
                            _local_11._SafeStr_4864(_local_12, _local_14, _local_19, _local_15, _local_17);
                            _local_12++;
                        };
                    };
                };
                _local_3++;
            };
        }
        public function render(_arg_1:BitmapData, _arg_2:String, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:IVector3d, _arg_7:Boolean, _arg_8:Number=0, _arg_9:Number=0, _arg_10:Number=0, _arg_11:Number=0, _arg_12:int=0):PlaneBitmapData
        {
            return (null);
        }
        public function getTextureIdentifier(_arg_1:Number, _arg_2:IVector3d):String
        {
            return (String(_arg_1));
        }

    }
}//package com.sulake.habbo.room.object.visualization.room.rasterizer.basic

// _SafeStr_12729 = "_-29o" (String#879, DoABC#2)
// _SafeStr_12797 = "_-2x-" (String#1970, DoABC#2)
// getTexture = "_-2Aw" (String#1826, DoABC#2)
// getFlipHBitmapData = "_-Gl" (String#22880, DoABC#2)
// _SafeStr_12841 = "_-TR" (String#23383, DoABC#2)
// addBitmap = "_-0pF" (String#16025, DoABC#2)
// _SafeStr_12852 = "_-2x1" (String#21349, DoABC#2)
// _SafeStr_12853 = "_-A1" (String#22619, DoABC#2)
// resetMaterials = "_-2NM" (String#19937, DoABC#2)
// resetTextures = "_-29r" (String#19398, DoABC#2)
// initializeAll = "_-0Q2" (String#15062, DoABC#2)
// initializeTexturesAndMaterials = "_-3Jn" (String#22275, DoABC#2)
// parseTextures = "_-1IZ" (String#17216, DoABC#2)
// parsePlaneMaterials = "_-1N8" (String#17404, DoABC#2)
// _SafeStr_12860 = "_-38J" (String#21815, DoABC#2)
// _SafeStr_12861 = "_-2SP" (String#20134, DoABC#2)
// _SafeStr_12862 = "_-Cz" (String#22727, DoABC#2)
// _SafeStr_12863 = "_-04O" (String#14218, DoABC#2)
// _SafeStr_12864 = "_-0AL" (String#14461, DoABC#2)
// _SafeStr_12865 = "_-1Bd" (String#16925, DoABC#2)
// addMaterialCellMatrix = "_-1Tu" (String#17662, DoABC#2)
// parsePlaneMaterialCellColumn = "_-1Q4" (String#17513, DoABC#2)
// _SafeStr_12868 = "_-2X0" (String#20323, DoABC#2)
// _SafeStr_12869 = "_-0n6" (String#15943, DoABC#2)
// parsePlaneMaterialCells = "_-1Dz" (String#17024, DoABC#2)
// createColumn = "_-0iO" (String#15767, DoABC#2)
// parseExtraItemTypes = "_-0Gh" (String#14709, DoABC#2)
// parseExtraItemOffsets = "_-0au" (String#15470, DoABC#2)
// parseVisualizations = "_-1FB" (String#17078, DoABC#2)
// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// IVector3d = "_-hf" (String#8547, DoABC#2)
// Vector3d = "_-1Rb" (String#17568, DoABC#2)
// IGraphicAssetCollection = "_-24o" (String#6134, DoABC#2)
// IRoomGeometry = "_-0z9" (String#4829, DoABC#2)
// RoomGeometry = "_-2l9" (String#20887, DoABC#2)
// IGraphicAsset = "_-1HF" (String#5195, DoABC#2)
// IPlaneRasterizer = "_-2El" (String#6336, DoABC#2)
// PlaneRasterizer = "_-0l-" (String#4521, DoABC#2)
// PlaneBitmapData = "_-2Mg" (String#6493, DoABC#2)
// Rasterizer = "_-jl" (String#8595, DoABC#2)
// PlaneTexture = "_-1Us" (String#17699, DoABC#2)
// Plane = "_-0S9" (String#4141, DoABC#2)
// FloorPlane = "_-1RS" (String#5386, DoABC#2)
// PlaneVisualizationLayer = "_-3FM" (String#22091, DoABC#2)
// PlaneMaterialCell = "_-3G6" (String#7632, DoABC#2)
// PlaneMaterialCellColumn = "_-2SG" (String#6614, DoABC#2)
// PlaneMaterial = "_-W-" (String#8321, DoABC#2)
// PlaneMaterialCellMatrix = "_-0Pa" (String#4083, DoABC#2)
// initializeDimensions = "_-1dY" (String#5624, DoABC#2)
// initializePlanes = "_-CW" (String#459, DoABC#2)
// _SafeStr_4854 = "_-34T" (String#21676, DoABC#2)
// _SafeStr_4855 = "_-3AQ" (String#21897, DoABC#2)
// createPlaneVisualization = "_-8X" (String#22562, DoABC#2)
// getGeometry = "_-uD" (String#24459, DoABC#2)
// getMaterial = "_-dk" (String#23789, DoABC#2)
// _SafeStr_4860 = "_-0HE" (String#14729, DoABC#2)
// _SafeStr_4861 = "_-0CJ" (String#582, DoABC#2)
// _SafeStr_4862 = "_-3BX" (String#7541, DoABC#2)
// _SafeStr_4863 = "_-0Ny" (String#4045, DoABC#2)
// _SafeStr_4864 = "finally" (String#45073, DoABC#2)
// addPlane = "_-0lr" (String#4544, DoABC#2)
// getPlane = "_-2oL" (String#21017, DoABC#2)
// _SafeStr_4870 = "_-2b8" (String#20494, DoABC#2)
// getTextureIdentifier = "_-0yx" (String#829, DoABC#2)
// _assetCollection = "_-2PR" (String#888, DoABC#2)
// initializeAssetCollection = "_-24a" (String#19205, DoABC#2)
// reinitialize = "_-0gk" (String#4440, DoABC#2)


