
package com.sulake.room.utils
{
    import flash.geom.Point;

    public interface IRoomGeometry 
    {

        function get scale():Number;
        function get directionAxis():IVector3d;
        function get direction():IVector3d;
        function getCoordinatePosition(_arg_1:IVector3d):IVector3d;
        function getScreenPoint(_arg_1:IVector3d):Point;
        function getScreenPosition(_arg_1:IVector3d):IVector3d;
        function getPlanePosition(_arg_1:Point, _arg_2:IVector3d, _arg_3:IVector3d, _arg_4:IVector3d):Point;
        function setDisplacement(_arg_1:IVector3d, _arg_2:IVector3d):void;
        function adjustLocation(_arg_1:IVector3d, _arg_2:Number):void;
        function performZoom():void;
        function performZoomOut():void;
        function performZoomIn():void;
        function isZoomedIn():Boolean;
        function get updateId():int;
        function set z_scale(_arg_1:Number):void;

    }
}//package com.sulake.room.utils

// getCoordinatePosition = "_-05e" (String#3679, DoABC#2)
// directionAxis = "_-3Gq" (String#7644, DoABC#2)
// getScreenPosition = "_-1QP" (String#5358, DoABC#2)
// IVector3d = "_-hf" (String#8547, DoABC#2)
// z_scale = "_-2LM" (String#6468, DoABC#2)
// setDisplacement = "_-03w" (String#3646, DoABC#2)
// performZoom = "_-2Oh" (String#6534, DoABC#2)
// IRoomGeometry = "_-0z9" (String#4829, DoABC#2)
// updateId = "_-0TD" (String#1478, DoABC#2)
// getScreenPoint = "_-34h" (String#7403, DoABC#2)
// adjustLocation = "_-9w" (String#7863, DoABC#2)
// isZoomedIn = "_-1S5" (String#5398, DoABC#2)
// performZoomOut = "_-2Z0" (String#6746, DoABC#2)
// performZoomIn = "_-10E" (String#4875, DoABC#2)
// getPlanePosition = "_-eX" (String#8492, DoABC#2)


