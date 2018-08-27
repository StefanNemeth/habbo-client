
package com.sulake.habbo.catalog.navigation
{
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.communication.messages.incoming.catalog.NodeData;

    public interface ICatalogNavigator 
    {

        function dispose():void;
        function get catalog():IHabboCatalog;
        function buildCatalogIndex(_arg_1:NodeData):void;
        function activateNode(_arg_1:ICatalogNode):void;
        function openPage(_arg_1:String):void;
        function openPageById(_arg_1:int, _arg_2:int):void;
        function loadFrontPage():void;
        function loadNewAdditionsPage(_arg_1:String):void;
        function isInitialized():Boolean;

    }
}//package com.sulake.habbo.catalog.navigation

// buildCatalogIndex = "_-0KM" (String#3963, DoABC#2)
// openPageById = "_-0qZ" (String#4651, DoABC#2)
// loadFrontPage = "_-0fU" (String#4415, DoABC#2)
// loadNewAdditionsPage = "_-2Cc" (String#6295, DoABC#2)
// ICatalogNavigator = "_-24D" (String#6126, DoABC#2)
// NodeData = "_-02P" (String#3615, DoABC#2)
// IHabboCatalog = "_-1fJ" (String#5651, DoABC#2)
// ICatalogNode = "_-0Td" (String#4172, DoABC#2)
// openPage = "_-6Z" (String#2052, DoABC#2)
// isInitialized = "_-1Cr" (String#840, DoABC#2)


