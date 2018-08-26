
package com.sulake.habbo.navigator.mainview.tabpagedecorators
{
    import com.sulake.habbo.navigator.HabboNavigator;
    import com.sulake.core.window.IWindowContainer;

    public class SearchTabPageDecorator implements ITabPageDecorator 
    {

        private var _navigator:HabboNavigator;

        public function SearchTabPageDecorator(_arg_1:HabboNavigator)
        {
            this._navigator = _arg_1;
        }
        public function refreshCustomContent(_arg_1:IWindowContainer):void
        {
        }
        public function tabSelected():void
        {
        }
        public function refreshFooter(_arg_1:IWindowContainer):void
        {
        }
        public function navigatorOpenedWhileInTab():void
        {
            this._navigator.mainViewCtrl.open();
        }
        public function get filterCategory():String
        {
            return (null);
        }

    }
}//package com.sulake.habbo.navigator.mainview.tabpagedecorators

// ITabPageDecorator = "_-0h3" (String#4447, DoABC#2)
// SearchTabPageDecorator = "_-11G" (String#4901, DoABC#2)
// navigatorOpenedWhileInTab = "_-2IQ" (String#6410, DoABC#2)
// refreshCustomContent = "_-1cv" (String#1724, DoABC#2)
// refreshFooter = "_-1IP" (String#1655, DoABC#2)
// tabSelected = "_-2T" (String#6625, DoABC#2)
// filterCategory = "_-1T1" (String#5414, DoABC#2)


