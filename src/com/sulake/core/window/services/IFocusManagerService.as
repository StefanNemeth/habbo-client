
package com.sulake.core.window.services
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.components.IFocusWindow;

    public interface IFocusManagerService extends IDisposable 
    {

        function registerFocusWindow(_arg_1:IFocusWindow):void;
        function removeFocusWindow(_arg_1:IFocusWindow):void;

    }
}//package com.sulake.core.window.services

// IFocusWindow = "_-1Ty" (String#5431, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// IFocusManagerService = "_-0Jl" (String#3946, DoABC#2)


