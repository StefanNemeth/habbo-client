
package com.sulake.habbo.navigator.mainview.tabpagedecorators
{
    import com.sulake.habbo.navigator.HabboNavigator;
    import com.sulake.core.window.components.IDropMenuWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.communication.messages.outgoing.navigator.CanCreateRoomMessageComposer;
    import com.sulake.habbo.navigator.domain.Tabs;
    import com.sulake.core.window.events.*;
    import com.sulake.core.window.enum.*;

    public class MyRoomsTabPageDecorator implements ITabPageDecorator 
    {

        private var _navigator:HabboNavigator;
        private var _SafeStr_6615:IDropMenuWindow;

        public function MyRoomsTabPageDecorator(_arg_1:HabboNavigator)
        {
            this._navigator = _arg_1;
        }
        public function refreshCustomContent(_arg_1:IWindowContainer):void
        {
            var _local_2:String = "me_header";
            var _local_3:IWindowContainer = (_arg_1.getChildByName(_local_2) as IWindowContainer);
            if (this._SafeStr_6615 == null){
                this._SafeStr_6615 = IDropMenuWindow(_local_3.findChildByName("meSubNavi"));
                this.prepareSubNavi();
                this._SafeStr_6615.addEventListener(WindowEvent.WE_SELECTED, this.onFilterSelected);
            };
            _local_3.visible = true;
        }
        public function tabSelected():void
        {
            if (this._SafeStr_6615 != null){
                this._SafeStr_6615.removeEventListener(WindowEvent.WE_SELECTED, this.onFilterSelected);
                this._SafeStr_6615.selection = 0;
                this._SafeStr_6615.addEventListener(WindowEvent.WE_SELECTED, this.onFilterSelected);
            };
        }
        public function refreshFooter(_arg_1:IWindowContainer):void
        {
            var _local_2:IWindowContainer = (_arg_1.getChildByName("me_footer") as IWindowContainer);
            var _local_3:IWindow = _local_2.findChildByName("create_room_but");
            if (_local_3 != null){
                _local_3.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onCreateRoomClick);
            };
            this._navigator.refreshButton(_local_2, "create_room", true, null, 0);
            _local_2.visible = true;
        }
        public function navigatorOpenedWhileInTab():void
        {
            this.startSearch();
        }
        private function onCreateRoomClick(_arg_1:WindowEvent):void
        {
            this._navigator.send(new CanCreateRoomMessageComposer());
        }
        private function prepareSubNavi():void
        {
            if (this._SafeStr_6615 == null){
                return;
            };
            var _local_1:Array = new Array();
            _local_1.push(this._navigator.getText("navigator.navisel.myrooms"));
            _local_1.push(this._navigator.getText("navigator.navisel.wherearemyfriends"));
            _local_1.push(this._navigator.getText("navigator.navisel.myfriendsrooms"));
            _local_1.push(this._navigator.getText("navigator.navisel.myfavourites"));
            _local_1.push(this._navigator.getText("navigator.navisel.visitedrooms"));
            this._SafeStr_6615.populate(_local_1);
            this._SafeStr_6615.selection = 0;
        }
        private function onFilterSelected(_arg_1:WindowEvent):void
        {
            this.startSearch();
            var _local_2:IWindow = _arg_1.target;
            if ((_local_2 is IDropMenuWindow)){
                this._navigator.trackNavigationDataPoint(IDropMenuWindow(_local_2).IDropMenuWindow()[IDropMenuWindow(_local_2).selection], "me.category.view");
            };
        }
        private function startSearch():void
        {
            var _local_1:int = (((this._SafeStr_6615 == null)) ? 0 : this._SafeStr_6615.selection);
            Logger.log(("Me subNavi selection changed: " + _local_1));
            this._navigator.mainViewCtrl.startSearch(Tabs._SafeStr_4286, this.getSearchTypeForIndex(_local_1));
        }
        private function getSearchTypeForIndex(_arg_1:int):int
        {
            if (_arg_1 == 1){
                return (Tabs._SafeStr_4304);
            };
            if (_arg_1 == 2){
                return (Tabs._SafeStr_4299);
            };
            if (_arg_1 == 3){
                return (Tabs._SafeStr_4298);
            };
            if (_arg_1 == 4){
                return (Tabs._SafeStr_4300);
            };
            return (Tabs._SafeStr_4301);
        }
        public function get filterCategory():String
        {
            return (((this._SafeStr_6615) ? this._SafeStr_6615.IDropMenuWindow()[this._SafeStr_6615.selection] : null));
        }

    }
}//package com.sulake.habbo.navigator.mainview.tabpagedecorators

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// Tabs = "_-1b9" (String#5579, DoABC#2)
// IDropMenuWindow = "_-4Z" (String#2049, DoABC#2)
// ITabPageDecorator = "_-0h3" (String#4447, DoABC#2)
// MyRoomsTabPageDecorator = "_-0rE" (String#4667, DoABC#2)
// CanCreateRoomMessageComposer = "_-2Ug" (String#20225, DoABC#2)
// navigatorOpenedWhileInTab = "_-2IQ" (String#6410, DoABC#2)
// WE_SELECTED = "_-17F" (String#16745, DoABC#2)
// refreshCustomContent = "_-1cv" (String#1724, DoABC#2)
// refreshFooter = "_-1IP" (String#1655, DoABC#2)
// _SafeStr_4286 = "_-3k" (String#22364, DoABC#2)
// tabSelected = "_-2T" (String#6625, DoABC#2)
// _SafeStr_4298 = "_-0Jm" (String#14833, DoABC#2)
// _SafeStr_4299 = "_-2ob" (String#21028, DoABC#2)
// _SafeStr_4300 = "_-0Q4" (String#15063, DoABC#2)
// _SafeStr_4301 = "_-1o0" (String#18463, DoABC#2)
// _SafeStr_4304 = "_-0CH" (String#14541, DoABC#2)
// filterCategory = "_-1T1" (String#5414, DoABC#2)
// _SafeStr_6615 = "_-3Aj" (String#915, DoABC#2)
// onFilterSelected = "_-yH" (String#2229, DoABC#2)
// trackNavigationDataPoint = "_-17A" (String#16741, DoABC#2)
// IDropMenuWindow = "_-2oo" (String#7052, DoABC#2)
// prepareSubNavi = "_-1k-" (String#18287, DoABC#2)
// onCreateRoomClick = "_-Gy" (String#22890, DoABC#2)
// getSearchTypeForIndex = "_-2xB" (String#21357, DoABC#2)


