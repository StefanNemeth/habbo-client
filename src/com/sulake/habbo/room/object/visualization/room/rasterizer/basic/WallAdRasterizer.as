
package com.sulake.habbo.room.object.visualization.room.rasterizer.basic
{
    import com.sulake.room.utils.IVector3d;
    import com.sulake.room.utils.XMLValidator;
    import flash.display.BitmapData;
    import com.sulake.habbo.room.object.visualization.room.utils.PlaneBitmapData;

    public class WallAdRasterizer extends WallRasterizer 
    {

        override public function getTextureIdentifier(_arg_1:Number, _arg_2:IVector3d):String
        {
            return (String(_arg_1));
        }
        override protected function initializePlanes():void
        {
            if (data == null){
                return;
            };
            var _local_1:XMLList = data.wallAds;
            if (_local_1.length() > 0){
                this.parseWalls(_local_1[0]);
            };
        }
        override protected function parseWalls(_arg_1:XML):void
        {
            var _local_4:XML;
            var _local_5:String;
            var _local_6:XMLList;
            var _local_7:WallPlane;
            if (_arg_1 == null){
                return;
            };
            var _local_2:XMLList = _arg_1.wallAd;
            var _local_3:int;
            while (_local_3 < _local_2.length()) {
                _local_4 = _local_2[_local_3];
                if (XMLValidator.checkRequiredAttributes(_local_4, ["id"])){
                    _local_5 = _local_4.@id;
                    _local_6 = _local_4.visualization;
                    _local_7 = new WallPlane();
                    parseVisualizations(_local_7, _local_6);
                    if (getPlane(_local_5) == null){
                        addPlane(_local_5, _local_7);
                    }
                    else {
                        _local_7.dispose();
                    };
                };
                _local_3++;
            };
        }
        override public function render(_arg_1:BitmapData, _arg_2:String, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:IVector3d, _arg_7:Boolean, _arg_8:Number=0, _arg_9:Number=0, _arg_10:Number=0, _arg_11:Number=0, _arg_12:int=0):PlaneBitmapData
        {
            var _local_13:WallPlane = (getPlane(_arg_2) as WallPlane);
            if (_local_13 == null){
                _local_13 = (getPlane(_SafeStr_4870) as WallPlane);
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
// parseWalls = "_-0Af" (String#3769, DoABC#2)
// IVector3d = "_-hf" (String#8547, DoABC#2)
// WallRasterizer = "_-17Y" (String#5028, DoABC#2)
// WallAdRasterizer = "_-0Al" (String#3772, DoABC#2)
// PlaneBitmapData = "_-2Mg" (String#6493, DoABC#2)
// WallPlane = "_-O0" (String#23168, DoABC#2)
// initializePlanes = "_-CW" (String#459, DoABC#2)
// addPlane = "_-0lr" (String#4544, DoABC#2)
// getPlane = "_-2oL" (String#21017, DoABC#2)
// _SafeStr_4870 = "_-2b8" (String#20494, DoABC#2)
// getTextureIdentifier = "_-0yx" (String#829, DoABC#2)


