
package com.sulake.habbo.ui.widget
{
    import flash.events.IEventDispatcher;
    import com.sulake.core.window.IWindow;

    public interface IRoomWidget 
    {

        function get state():int;
        function initialize(_arg_1:int=0):void;
        function dispose():void;
        function set messageListener(_arg_1:IRoomWidgetMessageListener):void;
        function registerUpdateEvents(_arg_1:IEventDispatcher):void;
        function unregisterUpdateEvents(_arg_1:IEventDispatcher):void;
        function get mainWindow():IWindow;

    }
}//package com.sulake.habbo.ui.widget

// IRoomWidgetMessageListener = "_-2FI" (String#6349, DoABC#2)
// IRoomWidget = "_-1r4" (String#5876, DoABC#2)
// registerUpdateEvents = "_-1yD" (String#1787, DoABC#2)
// unregisterUpdateEvents = "_-0-c" (String#3556, DoABC#2)
// mainWindow = "_-2Lh" (String#1862, DoABC#2)


