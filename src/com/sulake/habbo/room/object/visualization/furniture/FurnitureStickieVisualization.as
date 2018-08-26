
package com.sulake.habbo.room.object.visualization.furniture
{
    import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
    import com.sulake.habbo.room.object.visualization.data.ColorData;

    public class FurnitureStickieVisualization extends FurnitureVisualization 
    {

        private var _data:FurnitureVisualizationData = null;

        override public function initialize(_arg_1:IRoomObjectVisualizationData):Boolean
        {
            this._data = (_arg_1 as FurnitureVisualizationData);
            return (super.initialize(_arg_1));
        }
        override protected function getSpriteColor(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            if (this._data == null){
                return (ColorData._SafeStr_4861);
            };
            return (this._data.getColor(_arg_1, _arg_2, _arg_3));
        }

    }
}//package com.sulake.habbo.room.object.visualization.furniture

// getSpriteColor = "_-0OM" (String#4054, DoABC#2)
// IRoomObjectVisualizationData = "_-26A" (String#6167, DoABC#2)
// FurnitureVisualizationData = "_-0d0" (String#4371, DoABC#2)
// FurnitureVisualization = "_-1sy" (String#5900, DoABC#2)
// FurnitureStickieVisualization = "_-Wl" (String#8343, DoABC#2)
// ColorData = "_-1Hv" (String#5204, DoABC#2)
// _SafeStr_4861 = "_-0CJ" (String#582, DoABC#2)
// getColor = "_-07L" (String#1406, DoABC#2)


