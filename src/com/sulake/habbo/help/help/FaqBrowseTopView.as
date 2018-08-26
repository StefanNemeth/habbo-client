
package com.sulake.habbo.help.help
{
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.help.help.data.FaqIndex;
    import com.sulake.core.window.IWindowContainer;
    import default.GetFaqCategoriesMessageComposer;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.help.help.data.FaqCategory;
    import com.sulake.habbo.help.enum.HabboHelpViewEnum;

    public class FaqBrowseTopView extends HelpViewController 
    {

        public function FaqBrowseTopView(_arg_1:HelpUI, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary)
        {
            super(_arg_1, _arg_2, _arg_3);
        }
        override public function render():void
        {
            var _local_6:String;
            var _local_7:IWindow;
            if (container != null){
                container.dispose();
            };
            var _local_1:FaqIndex = main.getFaq();
            if (_local_1 == null){
                return;
            };
            container = (buildXmlWindow("help_faq_categories") as IWindowContainer);
            if (container == null){
                return;
            };
            if (_local_1.getCategoryCount() == 0){
                main.sendMessage(new GetFaqCategoriesMessageComposer());
                return;
            };
            var _local_2:IItemListWindow = (container.findChildByTag("content") as IItemListWindow);
            if (_local_2 == null){
                return;
            };
            _local_2.IItemListWindow();
            var _local_3:String = "";
            var _local_4:Array = _local_1.getCategoryTitleArray();
            var _local_5:int;
            while (_local_5 < _local_4.length) {
                _local_6 = ((("#" + _local_5) + " .. ") + _local_4[_local_5]);
                _local_3 = ((_local_3 + _local_6) + String.fromCharCode(13));
                _local_7 = (buildHelpCategoryListEntryItem(_local_6, "help_itemlist_item", this.onListItemClick) as IWindow);
                if (((!((_local_2 == null))) && (!((_local_7 == null))))){
                    _local_7.name = "list_entry";
                    _local_2.addListItem(_local_7);
                };
                _local_5++;
            };
            super.render();
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
            var _local_4:FaqIndex = main.getFaq();
            if (_local_4 == null){
                return;
            };
            var _local_5:FaqCategory = _local_4.getCategoryByIndex(_local_3);
            if (_local_5 == null){
                return;
            };
            main.showUI(HabboHelpViewEnum.HHVE_FAQ_CATEGORY);
            main.tellUI(HabboHelpViewEnum.HHVE_FAQ_CATEGORY, _local_5);
        }

    }
}//package com.sulake.habbo.help.help

// buildHelpCategoryListEntryItem = "_-Lh" (String#23070, DoABC#2)
// onListItemClick = "_-1AM" (String#598, DoABC#2)
// handleListItemClick = "_-0V1" (String#587, DoABC#2)
// getCategoryCount = "_-0sg" (String#16149, DoABC#2)
// getCategoryByIndex = "_-11L" (String#16511, DoABC#2)
// getCategoryTitleArray = "_-0nT" (String#15955, DoABC#2)
// FaqIndex = "_-3I0" (String#7667, DoABC#2)
// HabboHelpViewEnum = "_-1e7" (String#18062, DoABC#2)
// HelpViewController = "_-IY" (String#8052, DoABC#2)
// FaqBrowseTopView = "_-28S" (String#6211, DoABC#2)
// FaqCategory = "_-0JM" (String#3941, DoABC#2)
// GetFaqCategoriesMessageComposer = "_-0Ik" (String#14789, DoABC#2)
// IItemListWindow = "_-0xF" (String#4796, DoABC#2)
// IItemListWindow = "_-6Q" (String#7792, DoABC#2)
// HHVE_FAQ_CATEGORY = "_-1AU" (String#16879, DoABC#2)


