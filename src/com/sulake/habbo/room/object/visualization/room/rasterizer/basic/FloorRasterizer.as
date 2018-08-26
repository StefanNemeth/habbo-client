
package com.sulake.habbo.room.object.visualization.room.rasterizer.basic
{
    import com.sulake.room.utils.XMLValidator;
    import flash.display.BitmapData;
    import com.sulake.habbo.room.object.visualization.room.utils.PlaneBitmapData;
    import com.sulake.room.utils.IVector3d;

    public class FloorRasterizer extends PlaneRasterizer 
    {

        override protected function initializePlanes():void
        {
            if (data == null){
                return;
            };
            var _local_1:XMLList = data.floors;
            if (_local_1.length() > 0){
                this.parseFloors(_local_1[0]);
            };
        }
        private function parseFloors(_arg_1:XML):void
        {
            var _local_4:XML;
            var _local_5:String;
            var _local_6:XMLList;
            var _local_7:FloorPlane;
            if (_arg_1 == null){
                return;
            };
            var _local_2:XMLList = _arg_1.floor;
            var _local_3:int;
            while (_local_3 < _local_2.length()) {
                _local_4 = _local_2[_local_3];
                if (XMLValidator.checkRequiredAttributes(_local_4, ["id"])){
                    _local_5 = _local_4.@id;
                    _local_6 = _local_4.visualization;
                    _local_7 = new FloorPlane();
                    parseVisualizations(_local_7, _local_6);
                    if (!addPlane(_local_5, _local_7)){
                        _local_7.dispose();
                    };
                };
                _local_3++;
            };
        }
        override public function render(_arg_1:BitmapData, _arg_2:String, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:IVector3d, _arg_7:Boolean, _arg_8:Number=0, _arg_9:Number=0, _arg_10:Number=0, _arg_11:Number=0, _arg_12:int=0):PlaneBitmapData
        {
            var _local_13:FloorPlane = (getPlane(_arg_2) as FloorPlane);
            if (_local_13 == null){
                _local_13 = (getPlane(_SafeStr_4870) as FloorPlane);
            };
            if (_local_13 == null){
                return (null);
            };
            if (_arg_1 != null){
                _arg_1.fillRect(_arg_1.rect, 0xFFFFFF);
            };
            var _local_14:BitmapData = _local_13.render(_arg_1, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7);
            if (((!((_local_14 == null))) && (!((_local_14 == _arg_1))))){
                _local_14 = _local_14.clone();
            };
            return (new PlaneBitmapData(_local_14, -1));
        }

    }
}//package com.sulake.habbo.room.object.visualization.room.rasterizer.basic

// parseVisualizations = "_-1FB" (String#17078, DoABC#2)
// parseFloors = "_-38h" (String#21830, DoABC#2)
// IVector3d = "_-hf" (String#8547, DoABC#2)
// PlaneRasterizer = "_-0l-" (String#4521, DoABC#2)
// FloorRasterizer = "_-0Pw" (String#4090, DoABC#2)
// PlaneBitmapData = "_-2Mg" (String#6493, DoABC#2)
// FloorPlane = "_-1RS" (String#5386, DoABC#2)
// initializePlanes = "_-CW" (String#459, DoABC#2)
// addPlane = "_-0lr" (String#4544, DoABC#2)
// getPlane = "_-2oL" (String#21017, DoABC#2)
// _SafeStr_4870 = "_-2b8" (String#20494, DoABC#2)


