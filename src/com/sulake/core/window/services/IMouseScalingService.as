
package com.sulake.core.window.services
{
    import com.sulake.core.window.IWindow;

    public interface IMouseScalingService 
    {

        function dispose():void;
        function begin(_arg_1:IWindow, _arg_2:uint=0):IWindow;
        function end(_arg_1:IWindow):IWindow;

    }
}//package com.sulake.core.window.services

// IMouseScalingService = "_-Mf" (String#8135, DoABC#2)


