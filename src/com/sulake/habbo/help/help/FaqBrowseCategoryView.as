
package com.sulake.habbo.help.help
{
    import com.sulake.habbo.help.help.data.FaqCategory;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.help.help.data.FaqIndex;
    import default.GetFaqCategoryMessageComposer;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.help.enum.HabboHelpViewEnum;
    import com.sulake.habbo.help.help.data.FaqItem;

    public class FaqBrowseCategoryView extends HelpViewController 
    {

        private var _category:FaqCategory;

        public function FaqBrowseCategoryView(_arg_1:HelpUI, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary)
        {
            super(_arg_1, _arg_2, _arg_3);
        }
        override public function render():void
        {
            if (container != null){
                container.dispose();
            };
            container = (buildXmlWindow("help_faq_category") as IWindowContainer);
            if (container == null){
                return;
            };
            var _local_1:IWindow = container.findChildByTag("help_faq_back_link");
            if (_local_1 != null){
                _local_1.setParamFlag(WindowParam._SafeStr_7434);
                _local_1.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.AchievementController);
            };
            super.render();
            if (this._category != null){
                this.update();
            };
        }
        override public function update(_arg_1:*=null):void
        {
            var _local_6:String;
            var _local_7:IWindowContainer;
            super.update(_arg_1);
            var _local_2:FaqIndex = main.getFaq();
            if (_arg_1 != null){
                if ((((((_local_2 == null)) || ((container == null)))) || ((_arg_1 == null)))){
                    return;
                };
                this._category = FaqCategory(_arg_1);
            };
            if (this._category == null){
                return;
            };
            if (!this._category.hasContent()){
                main.sendMessage(new GetFaqCategoryMessageComposer(this._category.categoryId));
                return;
            };
            var _local_3:IItemListWindow = (container.findChildByTag("content") as IItemListWindow);
            if (_local_3 == null){
                return;
            };
            _local_3.IItemListWindow();
            var _local_4:Array = this._category.getQuestionTitleArray();
            var _local_5:int;
            while (_local_5 < _local_4.length) {
                _local_6 = _local_4[_local_5];
                _local_7 = buildHelpCategoryListEntryItem(_local_6, "help_itemlist_item", this.onListItemClick);
                if (_local_7 != null){
                    _local_3.addListItem(_local_7);
                };
                _local_5++;
            };
        }
        private function AchievementController(_arg_1:WindowMouseEvent):void
        {
            main.showUI(HabboHelpViewEnum.HHVE_FAQ_TOP);
        }
        private function onListItemClick(_arg_1:WindowMouseEvent):void
        {
            var _local_2:IWindow = (_arg_1.target as IWindow);
            this.handleListItemClick(_local_2);
        }
        private function handleListItemClick(_arg_1:IWindow):void
        {
            var _local_2:IItemListWindow = (container.findChildByTag("content") as IItemListWindow);
            var _local_3:FaqIndex = main.getFaq();
            if ((((((((_local_3 == null)) || ((_local_2 == null)))) || ((_arg_1 == null)))) || ((_arg_1.parent == null)))){
                return;
            };
            var _local_4:int = _local_2.IItemListWindow(_arg_1.parent);
            if (this._category == null){
                return;
            };
            var _local_5:FaqItem = this._category.getItemByIndex(_local_4);
            if (_local_5 != null){
                main.showUI(HabboHelpViewEnum.HHVE_FAQ_TOPICS);
                main.tellUI(HabboHelpViewEnum.HHVE_FAQ_TOPICS, _local_5);
            };
        }

    }
}//package com.sulake.habbo.help.help

// buildHelpCategoryListEntryItem = "_-Lh" (String#23070, DoABC#2)
// onListItemClick = "_-1AM" (String#598, DoABC#2)
// handleListItemClick = "_-0V1" (String#587, DoABC#2)
// getItemByIndex = "_-2P9" (String#20007, DoABC#2)
// getQuestionTitleArray = "_-2HA" (String#19692, DoABC#2)
// hasContent = "_-1Qz" (String#17547, DoABC#2)
// AchievementController = "_-2yv" (String#905, DoABC#2)
// FaqIndex = "_-3I0" (String#7667, DoABC#2)
// HabboHelpViewEnum = "_-1e7" (String#18062, DoABC#2)
// HelpViewController = "_-IY" (String#8052, DoABC#2)
// FaqBrowseCategoryView = "_-qA" (String#8712, DoABC#2)
// FaqCategory = "_-0JM" (String#3941, DoABC#2)
// FaqItem = "_-1u6" (String#5923, DoABC#2)
// GetFaqCategoryMessageComposer = "_-Zf" (String#23622, DoABC#2)
// IItemListWindow = "_-0xF" (String#4796, DoABC#2)
// IItemListWindow = "_-6Q" (String#7792, DoABC#2)
// _SafeStr_7434 = "_-2xA" (String#21356, DoABC#2)
// HHVE_FAQ_TOP = "_-0et" (String#15622, DoABC#2)
// HHVE_FAQ_TOPICS = "_-ed" (String#23829, DoABC#2)


