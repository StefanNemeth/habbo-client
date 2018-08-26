
package com.sulake.habbo.navigator.mainview.tabpagedecorators
{
    import com.sulake.core.window.IWindowContainer;

    public interface ITabPageDecorator 
    {

        function refreshCustomContent(_arg_1:IWindowContainer):void;
        function tabSelected():void;
        function navigatorOpenedWhileInTab():void;
        function refreshFooter(_arg_1:IWindowContainer):void;
        function get filterCategory():String;

    }
}//package com.sulake.habbo.navigator.mainview.tabpagedecorators

// ITabPageDecorator = "_-0h3" (String#4447, DoABC#2)
// navigatorOpenedWhileInTab = "_-2IQ" (String#6410, DoABC#2)
// refreshCustomContent = "_-1cv" (String#1724, DoABC#2)
// refreshFooter = "_-1IP" (String#1655, DoABC#2)
// tabSelected = "_-2T" (String#6625, DoABC#2)
// filterCategory = "_-1T1" (String#5414, DoABC#2)


