
package com.sulake.habbo.quest
{
    import com.sulake.core.runtime.IDisposable;
    import flash.geom.Point;
    import flash.display.BitmapData;

    public interface AnimationObject extends IDisposable 
    {

        function getPosition(_arg_1:int):Point;
        function getBitmap(_arg_1:int):BitmapData;
        function isFinished(_arg_1:int):Boolean;
        function onAnimationStart():void;

    }
}//package com.sulake.habbo.quest

// onAnimationStart = "_-3Hw" (String#7665, DoABC#2)
// isFinished = "_-2pC" (String#7064, DoABC#2)
// getBitmap = "_-0zS" (String#4837, DoABC#2)
// AnimationObject = "_-0y7" (String#4813, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// getPosition = "_-GB" (String#7997, DoABC#2)


