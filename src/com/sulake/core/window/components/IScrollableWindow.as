
package com.sulake.core.window.components
{
    import com.sulake.core.window.IWindow;
    import flash.geom.Rectangle;

    public interface IScrollableWindow extends IWindow 
    {

        function get scrollH():Number;
        function get scrollV():Number;
        function set scrollH(_arg_1:Number):void;
        function set scrollV(_arg_1:Number):void;
        function get scrollStepH():Number;
        function get scrollStepV():Number;
        function set scrollStepH(_arg_1:Number):void;
        function set scrollStepV(_arg_1:Number):void;
        function get maxScrollH():int;
        function get maxScrollV():int;
        function get visibleRegion():Rectangle;
        function get scrollableRegion():Rectangle;

    }
}//package com.sulake.core.window.components

// IScrollableWindow = "_-2R2" (String#1880, DoABC#2)
// scrollableRegion = "_-2ku" (String#6976, DoABC#2)
// scrollStepH = "_-1Qu" (String#5371, DoABC#2)
// scrollStepV = "_-2Ee" (String#6333, DoABC#2)
// visibleRegion = "_-MK" (String#8129, DoABC#2)


