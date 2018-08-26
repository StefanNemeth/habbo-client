
package com.sulake.room
{
    import com.sulake.core.runtime.IUnknown;

    public interface IRoomManager extends IUnknown 
    {

        function initialize(_arg_1:XML, _arg_2:IRoomManagerListener):Boolean;
        function update(_arg_1:uint):void;
        function setContentLoader(_arg_1:IRoomContentLoader):void;
        function addObjectUpdateCategory(_arg_1:int):void;
        function removeObjectUpdateCategory(_arg_1:int):void;
        function createRoom(_arg_1:String, _arg_2:XML):IRoomInstance;
        function disposeRoom(_arg_1:String):Boolean;
        function getRoom(_arg_1:String):IRoomInstance;
        function getRoomWithIndex(_arg_1:int):IRoomInstance;
        function getRoomCount():int;
        function isContentAvailable(_arg_1:String):Boolean;

    }
}//package com.sulake.room

// IRoomManagerListener = "_-2KC" (String#6449, DoABC#2)
// disposeRoom = "_-2ya" (String#904, DoABC#2)
// getRoom = "_-1jg" (String#1750, DoABC#2)
// getRoomCount = "_-1cQ" (String#5608, DoABC#2)
// getRoomWithIndex = "_-0lP" (String#4533, DoABC#2)
// addObjectUpdateCategory = "_-2A6" (String#6251, DoABC#2)
// setContentLoader = "_-2Q-" (String#6563, DoABC#2)
// createRoom = "_-1mK" (String#1756, DoABC#2)
// isContentAvailable = "_-0ic" (String#4474, DoABC#2)
// removeObjectUpdateCategory = "_-0Cw" (String#3806, DoABC#2)
// IRoomInstance = "_-1j8" (String#5739, DoABC#2)
// IRoomContentLoader = "_-6z" (String#7806, DoABC#2)
// IRoomManager = "_-2kG" (String#6961, DoABC#2)


