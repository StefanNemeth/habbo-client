
package com.sulake.core.window.components
{
    import com.sulake.core.runtime.IDisposable;

    public interface IFocusWindow extends IDisposable 
    {

        function get focused():Boolean;
        function focus():Boolean;
        function WindowController():Boolean;

    }
}//package com.sulake.core.window.components

// IFocusWindow = "_-1Ty" (String#5431, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// WindowController = "_-Rh" (String#8242, DoABC#2)


