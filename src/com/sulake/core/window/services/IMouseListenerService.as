
package com.sulake.core.window.services
{
    import com.sulake.core.window.IWindow;

    public interface IMouseListenerService 
    {

        function get eventTypes():Array;
        function get areaLimit():uint;
        function set areaLimit(_arg_1:uint):void;
        function dispose():void;
        function begin(_arg_1:IWindow, _arg_2:uint=0):IWindow;
        function end(_arg_1:IWindow):IWindow;

    }
}//package com.sulake.core.window.services

// IMouseListenerService = "_-0s7" (String#4688, DoABC#2)
// eventTypes = "_-iE" (String#8559, DoABC#2)
// areaLimit = "_-1I0" (String#5207, DoABC#2)


