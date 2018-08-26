
package com.sulake.habbo.ui
{
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.habbo.ui.widget.IRoomWidget;

    public interface IRoomWidgetFactory extends IUnknown 
    {

        function createWidget(_arg_1:String, _arg_2:IRoomWidgetHandler):IRoomWidget;

    }
}//package com.sulake.habbo.ui

// IRoomWidget = "_-1r4" (String#5876, DoABC#2)
// createWidget = "_-2kN" (String#1932, DoABC#2)


