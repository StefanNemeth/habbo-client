
package com.sulake.core.window.graphics
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.graphics.renderer.ISkinRenderer;
    import com.sulake.core.window.utils.DefaultAttStruct;

    public interface ISkinContainer extends IDisposable 
    {

        function getSkinRendererByTypeAndStyle(_arg_1:uint, _arg_2:uint):ISkinRenderer;
        function getDefaultAttributesByTypeAndStyle(_arg_1:uint, _arg_2:uint):DefaultAttStruct;
        function getTheActualState(_arg_1:uint, _arg_2:uint, _arg_3:uint):uint;

    }
}//package com.sulake.core.window.graphics

// DefaultAttStruct = "_-2e0" (String#20604, DoABC#2)
// ISkinContainer = "_-us" (String#8781, DoABC#2)
// ISkinRenderer = "_-1uJ" (String#1780, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// getSkinRendererByTypeAndStyle = "_-0j" (String#4480, DoABC#2)
// getDefaultAttributesByTypeAndStyle = "_-Sn" (String#8262, DoABC#2)
// getTheActualState = "_-0Or" (String#4067, DoABC#2)


