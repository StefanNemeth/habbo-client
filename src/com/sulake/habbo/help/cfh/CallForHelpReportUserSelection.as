
package com.sulake.habbo.help.cfh
{
    import com.sulake.habbo.help.help.HelpViewController;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.help.help.HelpUI;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.help.cfh.data.UserRegistryItem;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.help.enum.HabboHelpViewEnum;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class CallForHelpReportUserSelection extends HelpViewController 
    {

        private var _SafeStr_11346:Map;

        public function CallForHelpReportUserSelection(_arg_1:HelpUI, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary)
        {
            this._SafeStr_11346 = new Map();
            super(_arg_1, _arg_2, _arg_3);
        }
        override public function render():void
        {
            super.render();
            if (container != null){
                container.dispose();
            };
            container = (buildXmlWindow("report_user_pick_user") as IWindowContainer);
            this.update();
            if (container == null){
                return;
            };
        }
        override public function update(parameter:*=null):void
        {
            var user:UserRegistryItem;
            var title:String;
            var item:IWindowContainer;
            super.update();
            if (disposed){
                return;
            };
            if (container == null){
                return;
            };
            var content:IItemListWindow = (container.findChildByTag("content") as IItemListWindow);
            if (content == null){
                return;
            };
            while (content.numListItems > 0) {
                content.IItemListWindow(0);
            };
            this._SafeStr_11346 = main.component.userRegistry.getRegistry();
            if (this._SafeStr_11346.length == 0){
                main.showUI(HabboHelpViewEnum.HHVE_HELP_FRONTPAGE);
                windowManager.alert("${generic.alert.title}", "${report.user.error.nolist}", 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
                {
                    _arg_1.dispose();
                });
                return;
            };
            var i:int;
            while (i < this._SafeStr_11346.length) {
                user = this._SafeStr_11346.getWithIndex(i);
                title = ((user.userName + "/") + user.roomName);
                main.localization.registerParameter("report.user.list.entry", "name", user.userName);
                main.localization.registerParameter("report.user.list.entry", "room", user.roomName);
                title = getText("report.user.list.entry");
                item = buildHelpCategoryListEntryItem(title, "report_user_pick_user_item", this.onListItemClick);
                if (item != null){
                    content.addListItem(item);
                };
                i = (i + 1);
            };
        }
        private function onListItemClick(_arg_1:WindowMouseEvent):void
        {
            var _local_2:IWindow = (_arg_1.target as IWindow);
            this.handleListItemClick(_local_2);
        }
        private function handleListItemClick(_arg_1:IWindow):void
        {
            var _local_2:IItemListWindow = (container.findChildByTag("content") as IItemListWindow);
            if ((((((_local_2 == null)) || ((_arg_1 == null)))) || ((_arg_1.parent == null)))){
                return;
            };
            var _local_3:int = _local_2.IItemListWindow(_arg_1.parent);
            if ((((_local_3 < 0)) || ((_local_3 > this._SafeStr_11346.length)))){
                return;
            };
            var _local_4:UserRegistryItem = this._SafeStr_11346.getWithIndex(_local_3);
            if (_local_4 == null){
                return;
            };
            main.component.callForHelpData.reportedUserId = _local_4.userId;
            main.component.callForHelpData.reportedUserName = _local_4.userName;
            if (_local_3 > -1){
                main.showUI(HabboHelpViewEnum.HHVE_CFG_TOPIC_SELECT);
            };
        }

    }
}//package com.sulake.habbo.help.cfh

// buildHelpCategoryListEntryItem = "_-Lh" (String#23070, DoABC#2)
// onListItemClick = "_-1AM" (String#598, DoABC#2)
// handleListItemClick = "_-0V1" (String#587, DoABC#2)
// _SafeStr_11346 = "_-2K3" (String#19809, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// IAlertDialog = "_-2LY" (String#6472, DoABC#2)
// HabboHelpViewEnum = "_-1e7" (String#18062, DoABC#2)
// UserRegistryItem = "_-27a" (String#6193, DoABC#2)
// HelpViewController = "_-IY" (String#8052, DoABC#2)
// CallForHelpReportUserSelection = "_-1jP" (String#5743, DoABC#2)
// IItemListWindow = "_-6Q" (String#7792, DoABC#2)
// IItemListWindow = "_-Td" (String#8279, DoABC#2)
// HHVE_HELP_FRONTPAGE = "_-2WD" (String#20292, DoABC#2)
// HHVE_CFG_TOPIC_SELECT = "_-2-u" (String#19007, DoABC#2)


