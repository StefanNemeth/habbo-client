
package com.sulake.habbo.room.object.visualization.room.rasterizer.animated
{
    import com.sulake.habbo.room.object.visualization.room.rasterizer.basic.PlaneRasterizer;
    import com.sulake.habbo.room.object.visualization.room.rasterizer.basic.PlaneVisualization;
    import com.sulake.habbo.room.object.visualization.room.rasterizer.basic.PlaneMaterial;
    import com.sulake.room.utils.XMLValidator;
    import com.sulake.habbo.room.object.visualization.room.utils.Randomizer;
    import com.sulake.habbo.room.object.visualization.room.rasterizer.basic.PlaneVisualizationLayer;
    import flash.display.BitmapData;
    import com.sulake.habbo.room.object.visualization.room.utils.PlaneBitmapData;
    import com.sulake.room.utils.IVector3d;

    public class LandscapeRasterizer extends PlaneRasterizer 
    {

        private static const _SafeStr_4848:int = 500;

        private var _SafeStr_4849:int = 0;
        private var _SafeStr_4850:int = 0;

        override public function initializeDimensions(_arg_1:int, _arg_2:int):Boolean
        {
            if (_arg_1 < 0){
                _arg_1 = 0;
            };
            if (_arg_2 < 0){
                _arg_2 = 0;
            };
            this._SafeStr_4849 = _arg_1;
            this._SafeStr_4850 = _arg_2;
            return (true);
        }
        override protected function initializePlanes():void
        {
            if (data == null){
                return;
            };
            var _local_1:XMLList = data.landscapes;
            if (_local_1.length() > 0){
                this.parseLandscapes(_local_1[0]);
            };
        }
        private function parseLandscapes(_arg_1:XML):void
        {
            var _local_6:XML;
            var _local_7:String;
            var _local_8:XMLList;
            var _local_9:LandscapePlane;
            var _local_10:int;
            var _local_11:XML;
            var _local_12:int;
            var _local_13:String;
            var _local_14:String;
            var _local_15:Number;
            var _local_16:Number;
            var _local_17:int;
            var _local_18:PlaneVisualization;
            var _local_19:int;
            var _local_20:XML;
            var _local_21:XML;
            var _local_22:PlaneMaterial;
            var _local_23:int;
            var _local_24:String;
            var _local_25:int;
            var _local_26:String;
            var _local_27:uint;
            var _local_28:String;
            var _local_29:String;
            var _local_30:XMLList;
            var _local_31:XML;
            var _local_32:int;
            var _local_33:XML;
            var _local_34:int;
            var _local_35:String;
            var _local_36:Number;
            var _local_37:Number;
            var _local_38:Number;
            var _local_39:Number;
            if (_arg_1 == null){
                return;
            };
            var _local_2:Array = ["id", "assetId"];
            var _local_3:int = (Math.random() * 654321);
            var _local_4:XMLList = _arg_1.landscape;
            var _local_5:int;
            while (_local_5 < _local_4.length()) {
                _local_6 = _local_4[_local_5];
                if (XMLValidator.checkRequiredAttributes(_local_6, ["id"])){
                    _local_7 = _local_6.@id;
                    _local_8 = _local_6.animatedVisualization;
                    _local_9 = new LandscapePlane();
                    _local_10 = 0;
                    while (_local_10 < _local_8.length()) {
                        _local_11 = _local_8[_local_10];
                        if (XMLValidator.checkRequiredAttributes(_local_11, ["size"])){
                            _local_12 = parseInt(_local_11.@size);
                            _local_13 = _local_11.@horizontalAngle;
                            _local_14 = _local_11.@verticalAngle;
                            _local_15 = LandscapePlane._SafeStr_4854;
                            if (_local_13 != ""){
                                _local_15 = parseFloat(_local_13);
                            };
                            _local_16 = LandscapePlane._SafeStr_4855;
                            if (_local_14 != ""){
                                _local_16 = parseFloat(_local_14);
                            };
                            _local_17 = (_local_11.visualizationLayer.length() + _local_11.animationLayer.length());
                            _local_18 = _local_9.createPlaneVisualization(_local_12, _local_17, getGeometry(_local_12, _local_15, _local_16));
                            if (_local_18 != null){
                                Randomizer.setSeed(_local_3);
                                _local_19 = 0;
                                while (_local_19 < _local_11.children().length()) {
                                    _local_20 = _local_11.children()[_local_19];
                                    if (_local_20.name() == "visualizationLayer"){
                                        _local_21 = _local_20;
                                        _local_22 = null;
                                        _local_23 = PlaneVisualizationLayer.ALIGN_DEFAULT;
                                        if (XMLValidator.checkRequiredAttributes(_local_21, ["materialId"])){
                                            _local_29 = _local_21.@materialId;
                                            _local_22 = getMaterial(_local_29);
                                        };
                                        _local_24 = _local_21.@offset;
                                        _local_25 = PlaneVisualizationLayer._SafeStr_4860;
                                        if (_local_24.length > 0){
                                            _local_25 = parseInt(_local_24);
                                        };
                                        _local_26 = _local_21.@color;
                                        _local_27 = LandscapePlane._SafeStr_4861;
                                        if (_local_26.length > 0){
                                            _local_27 = parseInt(_local_26);
                                        };
                                        _local_28 = _local_21.@align;
                                        if (_local_28 == "bottom"){
                                            _local_23 = PlaneVisualizationLayer._SafeStr_4862;
                                        }
                                        else {
                                            if (_local_28 == "top"){
                                                _local_23 = PlaneVisualizationLayer._SafeStr_4863;
                                            };
                                        };
                                        _local_18._SafeStr_4864(_local_19, _local_22, _local_27, _local_23, _local_25);
                                    }
                                    else {
                                        if (_local_20.name() == "animationLayer"){
                                            _local_30 = _local_20.animationItem;
                                            _local_31 = <animation/>
                                            ;
                                            _local_32 = 0;
                                            while (_local_32 < _local_30.length()) {
                                                _local_33 = (_local_30[_local_32] as XML);
                                                if (_local_33 != null){
                                                    if (XMLValidator.checkRequiredAttributes(_local_33, _local_2)){
                                                        _local_34 = parseInt(_local_33.@id);
                                                        _local_35 = _local_33.@assetId;
                                                        _local_36 = 0;
                                                        _local_37 = 0;
                                                        _local_36 = this.getCoordinateValue(_local_33.@x, _local_33.@randomX);
                                                        _local_37 = this.getCoordinateValue(_local_33.@y, _local_33.@randomY);
                                                        _local_38 = 0;
                                                        _local_39 = 0;
                                                        _local_38 = parseFloat(_local_33.@speedX);
                                                        _local_39 = parseFloat(_local_33.@speedY);
                                                        _local_31.appendChild(new (XML)((((((((((('<item x="' + _local_36) + '" y="') + _local_37) + '" speedX="') + _local_38) + '" speedY="') + _local_39) + '" asset="') + _local_35) + '"/>')));
                                                    };
                                                };
                                                _local_32++;
                                            };
                                            _local_18.setAnimationLayer(_local_19, _local_31, assetCollection);
                                        };
                                    };
                                    _local_19++;
                                };
                            };
                        };
                        _local_10++;
                    };
                    if (!addPlane(_local_7, _local_9)){
                        _local_9.dispose();
                    };
                };
                _local_5++;
            };
        }
        private function getCoordinateValue(_arg_1:String, _arg_2:String):Number
        {
            var _local_4:Number;
            var _local_5:Array;
            var _local_6:Number;
            var _local_3:Number = 0;
            if (_arg_1.length > 0){
                if (_arg_1.charAt((_arg_1.length - 1)) == "%"){
                    _arg_1 = _arg_1.substr(0, (_arg_1.length - 1));
                    _local_3 = (parseFloat(_arg_1) / 100);
                };
            };
            if (_arg_2.length > 0){
                _local_4 = 10000;
                _local_5 = Randomizer.getValues(1, 0, _local_4);
                _local_6 = (_local_5[0] / _local_4);
                if (_arg_2.charAt((_arg_2.length - 1)) == "%"){
                    _arg_2 = _arg_2.substr(0, (_arg_2.length - 1));
                    _local_3 = (_local_3 + ((_local_6 * parseFloat(_arg_2)) / 100));
                };
            };
            return (_local_3);
        }
        override public function render(_arg_1:BitmapData, _arg_2:String, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:IVector3d, _arg_7:Boolean, _arg_8:Number=0, _arg_9:Number=0, _arg_10:Number=0, _arg_11:Number=0, _arg_12:int=0):PlaneBitmapData
        {
            var _local_13:LandscapePlane = (getPlane(_arg_2) as LandscapePlane);
            if (_local_13 == null){
                _local_13 = (getPlane(_SafeStr_4870) as LandscapePlane);
            };
            if (_local_13 == null){
                return (null);
            };
            if (_arg_1 != null){
                _arg_1.fillRect(_arg_1.rect, 0xFFFFFF);
            };
            var _local_14:BitmapData = _local_13.render(_arg_1, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11, _arg_12);
            if (((!((_local_14 == null))) && (!((_local_14 == _arg_1))))){
                _local_14 = _local_14.clone();
            };
            var _local_15:PlaneBitmapData;
            if (((!(_local_13.isStatic(_arg_5))) && ((_SafeStr_4848 > 0)))){
                _local_15 = new PlaneBitmapData(_local_14, ((Math.round((_arg_12 / _SafeStr_4848)) * _SafeStr_4848) + _SafeStr_4848));
            }
            else {
                _local_15 = new PlaneBitmapData(_local_14, -1);
            };
            return (_local_15);
        }
        override public function getTextureIdentifier(_arg_1:Number, _arg_2:IVector3d):String
        {
            if (_arg_2 != null){
                if (_arg_2.x < 0){
                    return (String((_arg_1 + "_0")));
                };
                return (String((_arg_1 + "_1")));
            };
            return (super.getTextureIdentifier(_arg_1, _arg_2));
        }

    }
}//package com.sulake.habbo.room.object.visualization.room.rasterizer.animated

// IVector3d = "_-hf" (String#8547, DoABC#2)
// PlaneRasterizer = "_-0l-" (String#4521, DoABC#2)
// LandscapeRasterizer = "_-3EP" (String#7601, DoABC#2)
// PlaneBitmapData = "_-2Mg" (String#6493, DoABC#2)
// PlaneVisualizationLayer = "_-3FM" (String#22091, DoABC#2)
// PlaneMaterial = "_-W-" (String#8321, DoABC#2)
// LandscapePlane = "_-1vR" (String#18775, DoABC#2)
// Randomizer = "_-FS" (String#7982, DoABC#2)
// _SafeStr_4848 = "_-0i-" (String#1531, DoABC#2)
// _SafeStr_4849 = "_-0Y0" (String#15357, DoABC#2)
// _SafeStr_4850 = "_-2JI" (String#19780, DoABC#2)
// initializeDimensions = "_-1dY" (String#5624, DoABC#2)
// initializePlanes = "_-CW" (String#459, DoABC#2)
// parseLandscapes = "_-04" (String#14200, DoABC#2)
// _SafeStr_4854 = "_-34T" (String#21676, DoABC#2)
// _SafeStr_4855 = "_-3AQ" (String#21897, DoABC#2)
// createPlaneVisualization = "_-8X" (String#22562, DoABC#2)
// getGeometry = "_-uD" (String#24459, DoABC#2)
// setSeed = "_-2fM" (String#20662, DoABC#2)
// getMaterial = "_-dk" (String#23789, DoABC#2)
// _SafeStr_4860 = "_-0HE" (String#14729, DoABC#2)
// _SafeStr_4861 = "_-0CJ" (String#582, DoABC#2)
// _SafeStr_4862 = "_-3BX" (String#7541, DoABC#2)
// _SafeStr_4863 = "_-0Ny" (String#4045, DoABC#2)
// _SafeStr_4864 = "finally" (String#45073, DoABC#2)
// getCoordinateValue = "_-1Rd" (String#17570, DoABC#2)
// setAnimationLayer = "_-16q" (String#16729, DoABC#2)
// addPlane = "_-0lr" (String#4544, DoABC#2)
// getValues = "_-2U9" (String#20205, DoABC#2)
// getPlane = "_-2oL" (String#21017, DoABC#2)
// _SafeStr_4870 = "_-2b8" (String#20494, DoABC#2)
// isStatic = "_-2HT" (String#19704, DoABC#2)
// getTextureIdentifier = "_-0yx" (String#829, DoABC#2)


