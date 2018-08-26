
package mx.core
{
    import flash.display.IBitmapDrawable;
    import flash.events.IEventDispatcher;
    import flash.display.DisplayObject;
    import flash.display.Stage;
    import flash.display.DisplayObjectContainer;
    import flash.geom.Rectangle;
    import flash.geom.Transform;
    import flash.geom.Point;
    import flash.display.LoaderInfo;
    import flash.accessibility.AccessibilityProperties;

    public interface IFlexDisplayObject extends IBitmapDrawable, IEventDispatcher 
    {

        function get root():DisplayObject;
        function get stage():Stage;
        function get name():String;
        function set name(_arg_1:String):void;
        function get parent():DisplayObjectContainer;
        function get mask():DisplayObject;
        function set mask(_arg_1:DisplayObject):void;
        function get visible():Boolean;
        function set visible(_arg_1:Boolean):void;
        function get x():Number;
        function set x(_arg_1:Number):void;
        function get y():Number;
        function set y(_arg_1:Number):void;
        function get scaleX():Number;
        function set scaleX(_arg_1:Number):void;
        function get scaleY():Number;
        function set scaleY(_arg_1:Number):void;
        function get mouseX():Number;
        function get mouseY():Number;
        function get rotation():Number;
        function set rotation(_arg_1:Number):void;
        function get alpha():Number;
        function set alpha(_arg_1:Number):void;
        function get width():Number;
        function set width(_arg_1:Number):void;
        function get height():Number;
        function set height(_arg_1:Number):void;
        function get cacheAsBitmap():Boolean;
        function set cacheAsBitmap(_arg_1:Boolean):void;
        function get opaqueBackground():Object;
        function set opaqueBackground(_arg_1:Object):void;
        function get scrollRect():Rectangle;
        function set scrollRect(_arg_1:Rectangle):void;
        function get filters():Array;
        function set filters(_arg_1:Array):void;
        function get blendMode():String;
        function set blendMode(_arg_1:String):void;
        function get transform():Transform;
        function set transform(_arg_1:Transform):void;
        function get scale9Grid():Rectangle;
        function set scale9Grid(_arg_1:Rectangle):void;
        function globalToLocal(_arg_1:Point):Point;
        function localToGlobal(_arg_1:Point):Point;
        function getBounds(_arg_1:DisplayObject):Rectangle;
        function getRect(_arg_1:DisplayObject):Rectangle;
        function get loaderInfo():LoaderInfo;
        function hitTestObject(_arg_1:DisplayObject):Boolean;
        function hitTestPoint(_arg_1:Number, _arg_2:Number, _arg_3:Boolean=false):Boolean;
        function get accessibilityProperties():AccessibilityProperties;
        function set accessibilityProperties(_arg_1:AccessibilityProperties):void;
        function get measuredHeight():Number;
        function get measuredWidth():Number;
        function move(_arg_1:Number, _arg_2:Number):void;
        function setActualSize(_arg_1:Number, _arg_2:Number):void;

    }
}//package mx.core

