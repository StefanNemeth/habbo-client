
package com.sulake.core.window
{
    import com.sulake.core.runtime.IDisposable;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import com.sulake.core.window.utils.IRectLimiter;
    import com.sulake.core.window.components.IDesktopWindow;
    import com.sulake.core.utils.Map;
    import flash.display.IBitmapDrawable;

    public interface IWindow extends IDisposable 
    {

        function get x():int;
        function get y():int;
        function get id():uint;
        function get name():String;
        function get width():int;
        function get height():int;
        function get position():Point;
        function get rectangle():Rectangle;
        function get properties():Array;
        function get procedure():Function;
        function get background():Boolean;
        function get alpha():uint;
        function get color():uint;
        function get blend():Number;
        function get style():uint;
        function get visible():Boolean;
        function get clipping():Boolean;
        function get caption():String;
        function get parent():IWindow;
        function get debug():Boolean;
        function get filters():Array;
        function get mouseThreshold():uint;
        function get type():uint;
        function get state():uint;
        function get param():uint;
        function get limits():IRectLimiter;
        function get context():IWindowContext;
        function get desktop():IDesktopWindow;
        function get host():IWindow;
        function get tags():Array;
        function set x(_arg_1:int):void;
        function set y(_arg_1:int):void;
        function set id(_arg_1:uint):void;
        function set name(_arg_1:String):void;
        function set width(_arg_1:int):void;
        function set height(_arg_1:int):void;
        function set position(_arg_1:Point):void;
        function set rectangle(_arg_1:Rectangle):void;
        function set properties(_arg_1:Array):void;
        function set procedure(_arg_1:Function):void;
        function set background(_arg_1:Boolean):void;
        function set alpha(_arg_1:uint):void;
        function set color(_arg_1:uint):void;
        function set blend(_arg_1:Number):void;
        function set style(_arg_1:uint):void;
        function set visible(_arg_1:Boolean):void;
        function set clipping(_arg_1:Boolean):void;
        function set caption(_arg_1:String):void;
        function set parent(_arg_1:IWindow):void;
        function set debug(_arg_1:Boolean):void;
        function set filters(_arg_1:Array):void;
        function set mouseThreshold(_arg_1:uint):void;
        function toString():String;
        function clone():IWindow;
        function invalidate(_arg_1:Rectangle=null):void;
        function WindowController():uint;
        function buildFromXML(_arg_1:XML, _arg_2:Map=null):Boolean;
        function center():void;
        function offset(_arg_1:Number, _arg_2:Number):void;
        function scale(_arg_1:Number, _arg_2:Number):void;
        function WindowController():IBitmapDrawable;
        function WindowController(_arg_1:Point):void;
        function WindowController(_arg_1:Point):void;
        function WindowController(_arg_1:Rectangle):void;
        function getMouseRegion(_arg_1:Rectangle):void;
        function WindowController(_arg_1:Point):void;
        function WindowController(_arg_1:Rectangle):void;
        function WindowController(_arg_1:Point):Boolean;
        function WindowController(_arg_1:Rectangle):Boolean;
        function getGlobalPosition(_arg_1:Point):void;
        function WindowController(_arg_1:Point):void;
        function WindowController(_arg_1:Rectangle):void;
        function WindowController(_arg_1:Rectangle):void;
        function hitTestGlobalPoint(_arg_1:Point):Boolean;
        function WindowController(_arg_1:Rectangle):Boolean;
        function WindowController():Number;
        function WindowController():Number;
        function WindowController(_arg_1:Point):void;
        function WindowController(_arg_1:Point):void;
        function WindowController(_arg_1:String):IWindow;
        function WindowController(_arg_1:uint, _arg_2:Boolean=true):void;
        function WindowController(_arg_1:uint):Boolean;
        function IWindow(_arg_1:uint, _arg_2:uint=0):Boolean;
        function WindowController(_arg_1:uint, _arg_2:Boolean=true):void;
        function WindowController(_arg_1:uint):Boolean;
        function IWindow(_arg_1:uint, _arg_2:uint=0):Boolean;
        function setParamFlag(_arg_1:uint, _arg_2:Boolean=true):void;
        function WindowController(_arg_1:uint):Boolean;
        function IWindow(_arg_1:uint, _arg_2:uint=0):Boolean;
        function destroy():Boolean;
        function minimize():Boolean;
        function WindowController():Boolean;
        function WindowController():Boolean;
        function activate():Boolean;
        function deactivate():Boolean;
        function lock():Boolean;
        function unlock():Boolean;
        function enable():Boolean;
        function disable():Boolean;
        function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:int=0):void;
        function removeEventListener(_arg_1:String, _arg_2:Function):void;
        function hasEventListener(_arg_1:String):Boolean;

    }
}//package com.sulake.core.window

// IWindowContext = "_-8b" (String#2061, DoABC#2)
// IRectLimiter = "_-1O2" (String#5311, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// WindowController = "_-05T" (String#3675, DoABC#2)
// WindowController = "_-1nM" (String#5804, DoABC#2)
// mouseThreshold = "_-0OA" (String#4051, DoABC#2)
// WindowController = "_-1jq" (String#5750, DoABC#2)
// destroy = "_-25R" (String#615, DoABC#2)
// WindowController = "_-38B" (String#7475, DoABC#2)
// WindowController = "_-1wW" (String#1785, DoABC#2)
// IWindow = "_-1ml" (String#5794, DoABC#2)
// IWindow = "_-35A" (String#7410, DoABC#2)
// WindowController = "_-1XU" (String#5508, DoABC#2)
// WindowController = "_-0xH" (String#1582, DoABC#2)
// WindowController = "_-0oc" (String#1553, DoABC#2)
// WindowController = "_-0iw" (String#4478, DoABC#2)
// limits = "_-2BM" (String#6274, DoABC#2)
// WindowController = "_-313" (String#1987, DoABC#2)
// WindowController = "_-0Vq" (String#4224, DoABC#2)
// WindowController = "_-E9" (String#7955, DoABC#2)
// IWindow = "_-3C2" (String#7553, DoABC#2)
// WindowController = "_-0fS" (String#4413, DoABC#2)
// WindowController = "_-35W" (String#7418, DoABC#2)
// WindowController = "_-2j" (String#6932, DoABC#2)
// WindowController = "_-1sE" (String#5889, DoABC#2)
// WindowController = "_-0OJ" (String#4052, DoABC#2)
// WindowController = "_-Bj" (String#7906, DoABC#2)
// WindowController = "_-02I" (String#3611, DoABC#2)
// WindowController = "_-2pw" (String#7076, DoABC#2)
// WindowController = "_-21w" (String#6085, DoABC#2)
// WindowController = "_-2Dz" (String#6320, DoABC#2)
// WindowController = "_-2x8" (String#7224, DoABC#2)
// WindowController = "_-18B" (String#5040, DoABC#2)
// WindowController = "_-18X" (String#5049, DoABC#2)


