
package com.sulake.room.renderer
{
    import com.sulake.room.object.IRoomObject;

    public interface IRoomRendererBase 
    {

        function dispose():void;
        function reset():void;
        function feedRoomObject(_arg_1:IRoomObject):void;
        function removeRoomObject(_arg_1:int):void;
        function update(_arg_1:uint):void;

    }
}//package com.sulake.room.renderer

// feedRoomObject = "_-36M" (String#7437, DoABC#2)
// removeRoomObject = "_-kC" (String#8605, DoABC#2)
// IRoomRendererBase = "_-0Eq" (String#3847, DoABC#2)


