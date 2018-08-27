
package com.sulake.core.window.graphics
{
    import flash.display.IBitmapDrawable;
    import flash.events.IEventDispatcher;
    import com.sulake.core.runtime.IDisposable;
    import flash.display.DisplayObjectContainer;
    import flash.geom.Rectangle;
    import flash.display.DisplayObject;
    import flash.geom.Point;

    public interface IGraphicContext extends IBitmapDrawable, IEventDispatcher, IDisposable 
    {

        function get parent():DisplayObjectContainer;
        function set parent(_arg_1:DisplayObjectContainer):void;
        function get filters():Array;
        function set filters(_arg_1:Array):void;
        function get visible():Boolean;
        function set visible(_arg_1:Boolean):void;
        function get blend():Number;
        function set blend(_arg_1:Number):void;
        function get mouse():Boolean;
        function set mouse(_arg_1:Boolean):void;
        function getDrawRegion():Rectangle;
        function setDrawRegion(_arg_1:Rectangle, _arg_2:Boolean, _arg_3:Rectangle):void;
        function getDisplayObject():DisplayObject;
        function setDisplayObject(_arg_1:DisplayObject):DisplayObject;
        function getAbsoluteMousePosition(_arg_1:Point):void;
        function getRelativeMousePosition(_arg_1:Point):void;
        function fetchDrawBuffer():IBitmapDrawable;
        function showRedrawRegion(_arg_1:Rectangle):void;
        function get numChildContexts():int;
        function addChildContext(_arg_1:IGraphicContext):IGraphicContext;
        function addChildContextAt(_arg_1:IGraphicContext, _arg_2:int):IGraphicContext;
        function getChildContextAt(_arg_1:int):IGraphicContext;
        function getChildContextIndex(_arg_1:IGraphicContext):int;
        function removeChildContext(_arg_1:IGraphicContext):IGraphicContext;
        function removeChildContextAt(_arg_1:int):IGraphicContext;
        function setChildContextIndex(_arg_1:IGraphicContext, _arg_2:int):void;
        function swapChildContexts(_arg_1:IGraphicContext, _arg_2:IGraphicContext):void;
        function swapChildContextsAt(_arg_1:int, _arg_2:int):void;

    }
}//package com.sulake.core.window.graphics

// IGraphicContext = "_-2I9" (String#1849, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// mouse = "_-2qv" (String#7094, DoABC#2)
// getRelativeMousePosition = "_-1wW" (String#1785, DoABC#2)
// getDrawRegion = "_-0xH" (String#1582, DoABC#2)
// fetchDrawBuffer = "_-0oc" (String#1553, DoABC#2)
// setDrawRegion = "_-340" (String#7389, DoABC#2)
// getAbsoluteMousePosition = "_-313" (String#1987, DoABC#2)
// showRedrawRegion = "_-2Qs" (String#6574, DoABC#2)
// numChildContexts = "_-1cY" (String#5611, DoABC#2)
// addChildContext = "_-1ax" (String#5575, DoABC#2)
// addChildContextAt = "_-2dP" (String#6819, DoABC#2)
// getChildContextAt = "_-105" (String#4870, DoABC#2)
// getChildContextIndex = "_-2bO" (String#6780, DoABC#2)
// removeChildContext = "_-28x" (String#6224, DoABC#2)
// removeChildContextAt = "_-2rG" (String#7107, DoABC#2)
// setChildContextIndex = "_-je" (String#8591, DoABC#2)
// swapChildContexts = "_-0Zm" (String#4292, DoABC#2)
// swapChildContextsAt = "_-2yp" (String#7257, DoABC#2)


