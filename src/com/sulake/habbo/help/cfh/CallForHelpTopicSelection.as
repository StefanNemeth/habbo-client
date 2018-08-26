
package com.sulake.habbo.help.cfh
{
    import com.sulake.habbo.help.help.HelpViewController;
    import com.sulake.habbo.help.help.IHelpViewController;
    import com.sulake.habbo.help.help.HelpUI;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.help.enum.HabboHelpViewEnum;

    public class CallForHelpTopicSelection extends HelpViewController implements IHelpViewController 
    {

        private static const _SafeStr_11337:int = 0;
        private static const _SafeStr_11338:int = 1;

        private var _SafeStr_11339:Array;

        public function CallForHelpTopicSelection(_arg_1:HelpUI, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary)
        {
            super(_arg_1, _arg_2, _arg_3);
        }
        override public function render():void
        {
            var _local_3:String;
            var _local_5:String;
            var _local_6:int;
            var _local_7:int;
            var _local_8:int;
            var _local_9:String;
            var _local_10:String;
            var _local_11:IWindowContainer;
            super.render();
            if (container != null){
                container.dispose();
            };
            var _local_1:int = _SafeStr_11337;
            if (main.component.callForHelpData.userSelected){
                _local_1 = _SafeStr_11338;
            };
            if (_local_1 == _SafeStr_11338){
                container = (buildXmlWindow("report_user_pick_topic") as IWindowContainer);
            }
            else {
                container = (buildXmlWindow("help_cfh_pick_topic") as IWindowContainer);
            };
            if (container == null){
                return;
            };
            var _local_2:IItemListWindow = (container.findChildByTag("content") as IItemListWindow);
            if (_local_2 == null){
                return;
            };
            if (_local_1 == _SafeStr_11338){
                _local_3 = main.getConfigurationKey("cfh.usercategories.withharasser");
            }
            else {
                _local_3 = main.getConfigurationKey("cfh.usercategories.withnoharasser");
            };
            var _local_4:Array = _local_3.split(",");
            this._SafeStr_11339 = new Array();
            for each (_local_5 in _local_4) {
                _local_7 = int(_local_5.replace(" ", ""));
                if (_local_7 != 0){
                    this._SafeStr_11339.push(_local_7);
                };
            };
            _local_6 = 0;
            while (_local_6 < this._SafeStr_11339.length) {
                _local_8 = this._SafeStr_11339[_local_6];
                _local_9 = main.component.callForHelpData.getTopicKey(_local_8);
                if (_local_1 == _SafeStr_11338){
                    main.localization.registerParameter(_local_9, "name", main.component.callForHelpData.reportedUserName);
                };
                _local_10 = getText(main.component.callForHelpData.getTopicKey(_local_8));
                _local_11 = buildHelpCategoryListEntryItem((((_local_10)!=null) ? _local_10 : _local_9), "help_cfh_pick_topic_item", this.onListItemClick);
                if (_local_11 != null){
                    _local_2.addListItem(_local_11);
                };
                _local_6++;
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
            if ((((((this._SafeStr_11339 == null)) || ((_local_3 < 0)))) || ((_local_3 >= this._SafeStr_11339.length)))){
                return;
            };
            if (_local_3 > -1){
                main.component.callForHelpData.topicIndex = this._SafeStr_11339[_local_3];
                main.showUI(HabboHelpViewEnum.HHVE_CFH_TEXT_INPUT);
                main.tellUI(HabboHelpViewEnum.HHVE_CFH_TEXT_INPUT, null);
            };
        }

    }
}//package com.sulake.habbo.help.cfh

// _SafeStr_11337 = "_-27C" (String#19299, DoABC#2)
// _SafeStr_11338 = "_-lT" (String#24088, DoABC#2)
// _SafeStr_11339 = "_-cZ" (String#23735, DoABC#2)
// buildHelpCategoryListEntryItem = "_-Lh" (String#23070, DoABC#2)
// onListItemClick = "_-1AM" (String#598, DoABC#2)
// handleListItemClick = "_-0V1" (String#587, DoABC#2)
// HabboHelpViewEnum = "_-1e7" (String#18062, DoABC#2)
// IHelpViewController = "_-0cs" (String#4364, DoABC#2)
// HelpViewController = "_-IY" (String#8052, DoABC#2)
// CallForHelpTopicSelection = "_-un" (String#8780, DoABC#2)
// IItemListWindow = "_-6Q" (String#7792, DoABC#2)
// HHVE_CFH_TEXT_INPUT = "_-0Ke" (String#14865, DoABC#2)


