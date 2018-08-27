
package com.sulake.habbo.catalog.viewer
{
    import flash.events.Event;
    import com.sulake.core.window.IWindowContainer;

    public interface ICatalogPage 
    {

        function dispose():void;
        function init():void;
        function closed():void;
        function dispatchWidgetEvent(_arg_1:Event):Boolean;
        function get window():IWindowContainer;
        function get viewer():ICatalogViewer;
        function get pageId():int;
        function get offers():Array;
        function get localization():IPageLocalization;
        function get layoutCode():String;
        function get hasLinks():Boolean;
        function get links():Array;
        function selectOffer(_arg_1:int):void;
        function replaceOffers(_arg_1:Array, _arg_2:Boolean=false):void;

    }
}//package com.sulake.habbo.catalog.viewer

// IPageLocalization = "_-0gS" (String#4433, DoABC#2)
// ICatalogViewer = "_-Ve" (String#8313, DoABC#2)
// ICatalogPage = "_-0mL" (String#4556, DoABC#2)
// dispatchWidgetEvent = "_-2V-" (String#1888, DoABC#2)
// selectOffer = "_-26U" (String#6175, DoABC#2)


