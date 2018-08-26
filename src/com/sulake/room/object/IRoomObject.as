
package com.sulake.room.object
{
    import com.sulake.room.utils.IVector3d;
    import com.sulake.room.object.visualization.IRoomObjectVisualization;
    import com.sulake.room.object.logic.IRoomObjectMouseHandler;

    public interface IRoomObject 
    {

        function getId():int;
        function getInstanceId():int;
        function getType():String;
        function getLocation():IVector3d;
        function getDirection():IVector3d;
        function getModel():IRoomObjectModel;
        function getVisualization():IRoomObjectVisualization;
        function getMouseHandler():IRoomObjectMouseHandler;
        function getState(_arg_1:int):int;
        function getUpdateID():int;

    }
}//package com.sulake.room.object

// IVector3d = "_-hf" (String#8547, DoABC#2)
// getMouseHandler = "_-EC" (String#7957, DoABC#2)
// getVisualization = "_-1At" (String#5090, DoABC#2)
// IRoomObjectMouseHandler = "_-2xI" (String#7227, DoABC#2)
// IRoomObjectVisualization = "_-3D2" (String#7575, DoABC#2)
// IRoomObjectModel = "_-253" (String#6141, DoABC#2)
// getUpdateID = "_-Ga" (String#932, DoABC#2)


