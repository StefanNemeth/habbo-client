
package com.sulake.habbo.avatar
{
    import com.sulake.core.runtime.IDisposable;
    import flash.display.BitmapData;
    import com.sulake.habbo.avatar.animation.ISpriteDataContainer;
    import com.sulake.habbo.avatar.animation.IAnimationLayerData;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.habbo.avatar.structure.figure.IPartColor;
    import com.sulake.habbo.avatar.animation.IAvatarDataContainer;

    public interface IAvatarImage extends IDisposable 
    {

        function getCroppedImage(_arg_1:String):BitmapData;
        function TwinkleImages(_arg_1:String, _arg_2:Boolean):BitmapData;
        function setDirection(_arg_1:String, _arg_2:int):void;
        function setDirectionAngle(_arg_1:String, _arg_2:int):void;
        function updateAnimationByFrames(_arg_1:int=1):void;
        function getScale():String;
        function getSubType():int;
        function getSprites():Array;
        function getLayerData(_arg_1:ISpriteDataContainer):IAnimationLayerData;
        function getAsset(_arg_1:String):BitmapDataAsset;
        function getDirection():int;
        function getFigure():IAvatarFigureContainer;
        function getPartColor(_arg_1:String):IPartColor;
        function isAnimating():Boolean;
        function getCanvasOffsets():Array;
        function get petType():int;
        function get petBreed():int;
        function IAvatarImage():void;
        function IAvatarImage():void;
        function IAvatarImage(_arg_1:String, ... _args):Boolean;
        function get avatarSpriteData():IAvatarDataContainer;
        function IAvatarImage():Boolean;
        function IAvatarImage():void;

    }
}//package com.sulake.habbo.avatar

// getSubType = "_-0Cx" (String#3807, DoABC#2)
// avatarSpriteData = "_-13z" (String#4955, DoABC#2)
// petBreed = "_-2bx" (String#6794, DoABC#2)
// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// IAvatarFigureContainer = "_-2-D" (String#6034, DoABC#2)
// IAnimationLayerData = "_-14E" (String#4961, DoABC#2)
// ISpriteDataContainer = "_-2J5" (String#6422, DoABC#2)
// IAvatarDataContainer = "_-2OR" (String#6528, DoABC#2)
// IPartColor = "_-1dO" (String#5620, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// setDirectionAngle = "_-0-V" (String#3555, DoABC#2)
// updateAnimationByFrames = "_-05f" (String#3680, DoABC#2)
// isAnimating = "_-1hz" (String#5707, DoABC#2)
// getCanvasOffsets = "_-0gi" (String#4439, DoABC#2)
// TwinkleImages = "_-eg" (String#2150, DoABC#2)
// getSprites = "_-3Go" (String#7642, DoABC#2)
// getLayerData = "_-0Qg" (String#1470, DoABC#2)
// getScale = "_-1EW" (String#5151, DoABC#2)
// IAvatarImage = "_-2j7" (String#6936, DoABC#2)
// IAvatarImage = "_-1hS" (String#5696, DoABC#2)
// IAvatarImage = "_-1gH" (String#5667, DoABC#2)
// petType = "_-0GK" (String#3877, DoABC#2)
// getCroppedImage = "_-2Ez" (String#6342, DoABC#2)
// IAvatarImage = "_-0qX" (String#4650, DoABC#2)
// IAvatarImage = "_-128" (String#4919, DoABC#2)
// getPartColor = "_-2yW" (String#7250, DoABC#2)
// getFigure = "_-0KG" (String#3958, DoABC#2)


