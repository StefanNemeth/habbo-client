
package com.sulake.room
{
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.room.object.logic.IRoomObjectEventHandler;

    public interface IRoomObjectFactory extends IUnknown 
    {

        function addObjectEventListener(_arg_1:Function):void;
        function removeObjectEventListener(_arg_1:Function):void;
        function createRoomObjectLogic(_arg_1:String):IRoomObjectEventHandler;
        function createRoomObjectManager():IRoomObjectManager;

    }
}//package com.sulake.room

// addObjectEventListener = "_-Jk" (String#8078, DoABC#2)
// removeObjectEventListener = "_-1wN" (String#5964, DoABC#2)
// createRoomObjectLogic = "_-0ly" (String#4548, DoABC#2)
// createRoomObjectManager = "_-1Ry" (String#1688, DoABC#2)
// IRoomObjectManager = "_-iT" (String#8568, DoABC#2)
// IRoomObjectEventHandler = "_-2c8" (String#6797, DoABC#2)
// IRoomObjectFactory = "_-2Bh" (String#6281, DoABC#2)


