
package com.sulake.room.object
{
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.room.object.visualization.IRoomObjectGraphicVisualization;
    import com.sulake.room.object.visualization.utils.IGraphicAssetCollection;
    import com.sulake.room.object.visualization.IRoomObjectVisualizationData;

    public interface IRoomObjectVisualizationFactory extends IUnknown 
    {

        function createRoomObjectVisualization(_arg_1:String):IRoomObjectGraphicVisualization;
        function createGraphicAssetCollection():IGraphicAssetCollection;
        function getRoomObjectVisualizationData(_arg_1:String, _arg_2:String, _arg_3:XML):IRoomObjectVisualizationData;

    }
}//package com.sulake.room.object

// createRoomObjectVisualization = "_-0ao" (String#4319, DoABC#2)
// getRoomObjectVisualizationData = "_-1Qq" (String#5368, DoABC#2)
// createGraphicAssetCollection = "_-Ba" (String#2071, DoABC#2)
// IRoomObjectVisualizationData = "_-26A" (String#6167, DoABC#2)
// IRoomObjectGraphicVisualization = "_-rv" (String#8734, DoABC#2)
// IGraphicAssetCollection = "_-24o" (String#6134, DoABC#2)
// IRoomObjectVisualizationFactory = "_-T7" (String#8269, DoABC#2)


