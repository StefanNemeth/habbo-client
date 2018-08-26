
package com.sulake.room.object.visualization
{
    import flash.display.BitmapData;

    public interface IRoomObjectSprite 
    {

        function get asset():BitmapData;
        function set asset(_arg_1:BitmapData):void;
        function get assetName():String;
        function set assetName(_arg_1:String):void;
        function get visible():Boolean;
        function set visible(_arg_1:Boolean):void;
        function get tag():String;
        function set tag(_arg_1:String):void;
        function get alpha():int;
        function set alpha(_arg_1:int):void;
        function get color():int;
        function set color(_arg_1:int):void;
        function get blendMode():String;
        function set blendMode(_arg_1:String):void;
        function get filters():Array;
        function set filters(_arg_1:Array):void;
        function get flipH():Boolean;
        function set flipH(_arg_1:Boolean):void;
        function get flipV():Boolean;
        function set flipV(_arg_1:Boolean):void;
        function get offsetX():int;
        function set offsetX(_arg_1:int):void;
        function get offsetY():int;
        function set offsetY(_arg_1:int):void;
        function get width():int;
        function get height():int;
        function get relativeDepth():Number;
        function set relativeDepth(_arg_1:Number):void;
        function get varyingDepth():Boolean;
        function set varyingDepth(_arg_1:Boolean):void;
        function get capturesMouse():Boolean;
        function set capturesMouse(_arg_1:Boolean):void;
        function get clickHandling():Boolean;
        function set clickHandling(_arg_1:Boolean):void;
        function get instanceId():int;
        function get updateId():int;

    }
}//package com.sulake.room.object.visualization

// IRoomObjectSprite = "_-0di" (String#4386, DoABC#2)
// updateId = "_-0TD" (String#1478, DoABC#2)
// varyingDepth = "_-11d" (String#4909, DoABC#2)
// clickHandling = "_-2fU" (String#6858, DoABC#2)
// instanceId = "_-044" (String#3649, DoABC#2)


