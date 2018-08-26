
package com.sulake.core.window.utils
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.utils.Map;

    public interface IWindowParser extends IDisposable 
    {

        function parseAndConstruct(_arg_1:XML, _arg_2:IWindow, _arg_3:Map):IWindow;
        function windowToXMLString(_arg_1:IWindow):String;

    }
}//package com.sulake.core.window.utils

// IWindowParser = "_-14A" (String#4960, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// windowToXMLString = "_-1D-" (String#841, DoABC#2)


