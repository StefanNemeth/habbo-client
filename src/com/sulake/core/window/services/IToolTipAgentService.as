
package com.sulake.core.window.services
{
    import com.sulake.core.window.IWindow;

    public interface IToolTipAgentService 
    {

        function dispose():void;
        function begin(_arg_1:IWindow, _arg_2:uint=0):IWindow;
        function end(_arg_1:IWindow):IWindow;

    }
}//package com.sulake.core.window.services

// IToolTipAgentService = "_-0Sl" (String#4154, DoABC#2)


