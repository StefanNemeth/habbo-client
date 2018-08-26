
package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.habbo.catalog.viewer.ICatalogPage;
    import flash.events.IEventDispatcher;
    import com.sulake.core.window.IWindowContainer;

    public interface ICatalogWidget 
    {

        function set page(_arg_1:ICatalogPage):void;
        function set events(_arg_1:IEventDispatcher):void;
        function get window():IWindowContainer;
        function get events():IEventDispatcher;
        function get page():ICatalogPage;
        function dispose():void;
        function init():Boolean;
        function closed():void;

    }
}//package com.sulake.habbo.catalog.viewer.widgets

// ICatalogWidget = "_-016" (String#3585, DoABC#2)
// ICatalogPage = "_-0mL" (String#4556, DoABC#2)


