
package com.sulake.core.window.components
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.utils.IMargins;

    public interface IFrameWindow extends IWindowContainer 
    {

        function get title():ILabelWindow;
        function get header():IHeaderWindow;
        function get content():IWindowContainer;
        function get margins():IMargins;
        function get scaler():IScalerWindow;
        function resizeToFitContent():void;

    }
}//package com.sulake.core.window.components

// IScalerWindow = "_-2bU" (String#1906, DoABC#2)
// IHeaderWindow = "_-1zq" (String#1792, DoABC#2)
// IMargins = "_-1mu" (String#1757, DoABC#2)
// resizeToFitContent = "_-09S" (String#3746, DoABC#2)


