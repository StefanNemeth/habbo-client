
package com.sulake.habbo.catalog.viewer
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.IWindowContainer;

    public interface IGridItem extends IDisposable 
    {

        function get view():IWindowContainer;
        function set view(_arg_1:IWindowContainer):void;
        function set grid(_arg_1:IItemGrid):void;
        function ProductGridItem(_arg_1:Boolean):void;
        function activate():void;
        function deActivate():void;

    }
}//package com.sulake.habbo.catalog.viewer

// IGridItem = "_-1oJ" (String#5825, DoABC#2)
// IItemGrid = "_-0i3" (String#4468, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// ProductGridItem = "_-2tF" (String#7142, DoABC#2)


