
package com.sulake.room.object.visualization
{
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.utils.IRoomGeometry;
    import flash.display.BitmapData;
    import flash.geom.Rectangle;

    public interface IRoomObjectVisualization 
    {

        function set object(_arg_1:IRoomObject):void;
        function get object():IRoomObject;
        function dispose():void;
        function initialize(_arg_1:IRoomObjectVisualizationData):Boolean;
        function update(_arg_1:IRoomGeometry, _arg_2:int, _arg_3:Boolean, _arg_4:Boolean):void;
        function get image():BitmapData;
        function TwinkleImages(_arg_1:int):BitmapData;
        function get boundingRectangle():Rectangle;
        function getInstanceId():int;
        function getUpdateID():int;

    }
}//package com.sulake.room.object.visualization

// IRoomObjectVisualizationData = "_-26A" (String#6167, DoABC#2)
// IRoomObjectVisualization = "_-3D2" (String#7575, DoABC#2)
// IRoomGeometry = "_-0z9" (String#4829, DoABC#2)
// getUpdateID = "_-Ga" (String#932, DoABC#2)
// TwinkleImages = "_-eg" (String#2150, DoABC#2)
// boundingRectangle = "_-0m7" (String#4552, DoABC#2)


