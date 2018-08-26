
package com.sulake.habbo.catalog.viewer
{
    import flash.events.Event;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.room.IRoomEngine;

    public interface ICatalogViewer 
    {

        function showCatalogPage(_arg_1:int, _arg_2:String, _arg_3:IPageLocalization, _arg_4:Array, _arg_5:int):void;
        function dispatchWidgetEvent(_arg_1:Event):Boolean;
        function get catalog():IHabboCatalog;
        function get roomEngine():IRoomEngine;
        function dispose():void;
        function getCurrentLayoutCode():String;

    }
}//package com.sulake.habbo.catalog.viewer

// IPageLocalization = "_-0gS" (String#4433, DoABC#2)
// ICatalogViewer = "_-Ve" (String#8313, DoABC#2)
// IHabboCatalog = "_-1fJ" (String#5651, DoABC#2)
// showCatalogPage = "_-0nw" (String#4589, DoABC#2)
// dispatchWidgetEvent = "_-2V-" (String#1888, DoABC#2)
// getCurrentLayoutCode = "_-nh" (String#2189, DoABC#2)


