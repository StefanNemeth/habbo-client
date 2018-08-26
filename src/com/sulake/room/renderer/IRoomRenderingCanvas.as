
package com.sulake.room.renderer
{
    import flash.display.DisplayObject;
    import com.sulake.room.utils.IRoomGeometry;

    public interface IRoomRenderingCanvas 
    {

        function set useMask(_arg_1:Boolean):void;
        function initialize(_arg_1:int, _arg_2:int):void;
        function get width():int;
        function get height():int;
        function set screenOffsetX(_arg_1:int):void;
        function set screenOffsetY(_arg_1:int):void;
        function get screenOffsetX():int;
        function get screenOffsetY():int;
        function render(_arg_1:int):void;
        function get displayObject():DisplayObject;
        function get geometry():IRoomGeometry;
        function set mouseListener(_arg_1:IRoomRenderingCanvasMouseListener):void;
        function handleMouseEvent(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:Boolean, _arg_5:Boolean, _arg_6:Boolean, _arg_7:Boolean):Boolean;

    }
}//package com.sulake.room.renderer

// screenOffsetX = "_-08x" (String#3738, DoABC#2)
// screenOffsetY = "_-01t" (String#3600, DoABC#2)
// mouseListener = "_-2K" (String#6442, DoABC#2)
// useMask = "_-1iM" (String#5719, DoABC#2)
// handleMouseEvent = "_-Xa" (String#8360, DoABC#2)
// IRoomGeometry = "_-0z9" (String#4829, DoABC#2)
// IRoomRenderingCanvasMouseListener = "_-Qz" (String#8227, DoABC#2)
// IRoomRenderingCanvas = "_-22o" (String#6102, DoABC#2)


