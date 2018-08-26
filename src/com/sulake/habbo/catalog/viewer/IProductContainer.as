
package com.sulake.habbo.catalog.viewer
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.core.window.IWindowContainer;

    public interface IProductContainer extends IDisposable 
    {

        function initProductIcon(_arg_1:IRoomEngine):void;
        function activate():void;
        function deActivate():void;
        function get products():Array;
        function get firstProduct():IProduct;
        function set view(_arg_1:IWindowContainer):void;
        function get view():IWindowContainer;
        function set grid(_arg_1:IItemGrid):void;
        function setClubIconLevel(_arg_1:int):void;

    }
}//package com.sulake.habbo.catalog.viewer

// IProductContainer = "_-7f" (String#7816, DoABC#2)
// IItemGrid = "_-0i3" (String#4468, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// initProductIcon = "_-0Ft" (String#1438, DoABC#2)
// firstProduct = "_-KM" (String#8089, DoABC#2)
// setClubIconLevel = "_-09M" (String#3745, DoABC#2)


