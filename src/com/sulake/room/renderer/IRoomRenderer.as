
package com.sulake.room.renderer
{
    public interface IRoomRenderer extends IRoomRendererBase 
    {

        function set roomObjectVariableAccurateZ(_arg_1:String):void;
        function createCanvas(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):IRoomRenderingCanvas;
        function getCanvas(_arg_1:int):IRoomRenderingCanvas;
        function disposeCanvas(_arg_1:int):Boolean;

    }
}//package com.sulake.room.renderer

// createCanvas = "_-24l" (String#6132, DoABC#2)
// disposeCanvas = "_-37k" (String#7463, DoABC#2)
// IRoomRendererBase = "_-0Eq" (String#3847, DoABC#2)
// IRoomRenderer = "_-2jS" (String#6944, DoABC#2)
// IRoomRenderingCanvas = "_-22o" (String#6102, DoABC#2)


