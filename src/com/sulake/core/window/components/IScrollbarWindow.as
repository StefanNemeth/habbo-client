
package com.sulake.core.window.components
{
    public interface IScrollbarWindow extends IInteractiveWindow 
    {

        function get scrollH():Number;
        function get scrollV():Number;
        function get scrollable():IScrollableWindow;
        function set scrollH(_arg_1:Number):void;
        function set scrollV(_arg_1:Number):void;
        function set scrollable(_arg_1:IScrollableWindow):void;
        function get vertical():Boolean;
        function get horizontal():Boolean;

    }
}//package com.sulake.core.window.components

// IScrollableWindow = "_-2R2" (String#1880, DoABC#2)
// IInteractiveWindow = "_-0KX" (String#1454, DoABC#2)
// IScrollbarWindow = "_-2fP" (String#1920, DoABC#2)


