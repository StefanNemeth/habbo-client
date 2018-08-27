
package com.sulake.habbo.catalog.navigation
{
    import flash.display.BitmapData;

    public interface ICatalogNode 
    {

        function dispose():void;
        function get isOpen():Boolean;
        function get depth():int;
        function get isBranch():Boolean;
        function get isLeaf():Boolean;
        function get isNavigateable():Boolean;
        function get localization():String;
        function get pageId():int;
        function get color():uint;
        function get icon():BitmapData;
        function get children():Array;
        function activate():void;
        function deActivate():void;
        function hasChild(_arg_1:ICatalogNode):Boolean;
        function addChild(_arg_1:ICatalogNode):void;
        function open():void;
        function close():void;
        function get parent():ICatalogNode;
        function set parent(_arg_1:ICatalogNode):void;

    }
}//package com.sulake.habbo.catalog.navigation

// isNavigateable = "_-1Ts" (String#5429, DoABC#2)
// isBranch = "_-0o2" (String#4593, DoABC#2)
// isLeaf = "_-2Tk" (String#6641, DoABC#2)
// hasChild = "_-1eH" (String#5633, DoABC#2)
// ICatalogNode = "_-0Td" (String#4172, DoABC#2)
// isOpen = "_-2i4" (String#897, DoABC#2)


