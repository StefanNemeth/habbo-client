
package com.sulake.room
{
    import com.sulake.room.object.IRoomObjectController;

    public interface IRoomObjectManager 
    {

        function dispose():void;
        function createObject(_arg_1:int, _arg_2:uint, _arg_3:String):IRoomObjectController;
        function getObject(_arg_1:int):IRoomObjectController;
        function disposeObject(_arg_1:int):Boolean;
        function getObjectCount():int;
        function getObjectWithIndex(_arg_1:int):IRoomObjectController;
        function getObjectCountForType(_arg_1:String):int;
        function getObjectWithIndexAndType(_arg_1:int, _arg_2:String):IRoomObjectController;
        function reset():void;

    }
}//package com.sulake.room

// getObjectWithIndex = "_-252" (String#1807, DoABC#2)
// createObject = "_-j8" (String#2167, DoABC#2)
// disposeObject = "_-3E-" (String#921, DoABC#2)
// IRoomObjectController = "_-17p" (String#5034, DoABC#2)
// getObjectCountForType = "_-2T0" (String#1882, DoABC#2)
// getObjectWithIndexAndType = "_-2OS" (String#1870, DoABC#2)
// IRoomObjectManager = "_-iT" (String#8568, DoABC#2)
// getObjectCount = "_-09y" (String#1415, DoABC#2)
// getObject = "_-1GT" (String#844, DoABC#2)


