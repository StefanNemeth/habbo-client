
package com.sulake.habbo.help.help
{
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import flash.display.BitmapData;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.components.IHTMLTextWindow;
    import com.sulake.habbo.help.help.data.FaqIndex;
    import default.GetClientFaqsMessageComposer;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.geom.Point;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.help.enum.HabboHelpViewEnum;
    import com.sulake.habbo.help.help.data.FaqCategory;
    import com.sulake.habbo.help.help.data.FaqItem;

    public class HelpMainView extends HelpViewController 
    {

        private static const _SafeStr_11385:int = 60;

        public function HelpMainView(_arg_1:HelpUI, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary)
        {
            super(_arg_1, _arg_2, _arg_3);
        }
        override public function render():void
        {
            var _local_8:String;
            var _local_9:String;
            var _local_10:BitmapData;
            if (container != null){
                container.dispose();
            };
            container = (buildXmlWindow("help_front_page") as IWindowContainer);
            if (container == null){
                return;
            };
            var _local_1:IWindow = container.findChildByName("help_faq_browse");
            if (_local_1 != null){
                _local_1.setParamFlag(WindowParam._SafeStr_7434);
                _local_1.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onFaqBrowse);
            };
            var _local_2:IHTMLTextWindow = (container.findChildByName("help_habboway_text") as IHTMLTextWindow);
            if (_local_2 != null){
                _local_8 = main.getText("help.button.habboway.url", "");
                if (_local_8 != null){
                    _local_9 = main.getText("help.button.habboway");
                    if (_local_9 != null){
                        _local_2.htmlText = (((('<a href="' + _local_8) + '">') + _local_9) + "</a>");
                    };
                };
            };
            var _local_3:IWindow = container.findChildByTag("help_cfh_button");
            if (_local_3 != null){
                _local_3.setParamFlag(WindowParam._SafeStr_7434);
                _local_3.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onCallForHelp);
            };
            var _local_4:IWindow = container.findChildByTag("help_report_user_button");
            if (_local_4 != null){
                _local_4.setParamFlag(WindowParam._SafeStr_7434);
                _local_4.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onReportUser);
            };
            var _local_5:IWindow = container.findChildByTag("call_guide_bot_button");
            if (_local_5 != null){
                _local_5.setParamFlag(WindowParam._SafeStr_7434);
                _local_5.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onCallGuideBot);
            };
            var _local_6:FaqIndex = main.getFaq();
            if ((((_local_6 == null)) || ((_local_6.getFrontPageUrgentCategory().getAgeSeconds() > _SafeStr_11385)))){
                main.sendMessage(new GetClientFaqsMessageComposer());
            };
            var _local_7:IBitmapWrapperWindow = (container.findChildByName("guidebot_icon") as IBitmapWrapperWindow);
            if (_local_7 != null){
                _local_10 = (assetLibrary.getAssetByName("guidebot_icon_png").content as BitmapData);
                _local_7.bitmap = new BitmapData(_local_7.width, _local_7.height, true);
                _local_7.bitmap.copyPixels(_local_10, _local_10.rect, new Point(0, 0));
            };
            super.render();
            this.update();
        }
        override public function update(_arg_1:*=null):void
        {
            var _local_7:IItemListWindow;
            var _local_8:int;
            var _local_9:IWindowContainer;
            var _local_10:Array;
            var _local_11:String;
            super.update(_arg_1);
            if (container == null){
                return;
            };
            var _local_2:IWindow = container.findChildByName("help_cfh");
            if (_local_2 != null){
                _local_2.visible = roomSessionActive;
            };
            var _local_3:IWindow = container.findChildByName("help_report_user");
            if (_local_3 != null){
                _local_3.visible = roomSessionActive;
            };
            var _local_4:IWindow = container.findChildByName("call_guide_bot_container");
            if (_local_4 != null){
                _local_4.visible = ((main.isCallForGuideBotEnabled()) && (roomSessionActive));
            };
            var _local_5:FaqIndex = main.getFaq();
            if (_local_5 != null){
                _local_10 = _local_5.getFrontPageUrgentCategory().getQuestionTitleArray();
                _local_7 = (container.findChildByTag("content_urgent") as IItemListWindow);
                if (_local_7 != null){
                    _local_7.IItemListWindow();
                    _local_8 = 0;
                    while (_local_8 < _local_10.length) {
                        _local_11 = _local_10[_local_8];
                        _local_9 = buildHelpCategoryListEntryItem(_local_11, "help_itemlist_item_urgent", this.onListItemClick);
                        if (_local_9 != null){
                            _local_9.name = "content_urgent_item";
                            _local_7.addListItem(_local_9);
                        };
                        _local_8++;
                    };
                };
                _local_10 = _local_5.getFrontPageNormalCategory().getQuestionTitleArray();
                _local_7 = (container.findChildByTag("content_normal") as IItemListWindow);
                if (_local_7 != null){
                    _local_7.IItemListWindow();
                    _local_8 = 0;
                    while (_local_8 < _local_10.length) {
                        _local_11 = _local_10[_local_8];
                        _local_9 = buildHelpCategoryListEntryItem(_local_11, "help_itemlist_item_white_bg", this.onListItemClick);
                        if (_local_9 != null){
                            _local_9.name = "content_normal_item";
                            _local_7.addListItem(_local_9);
                        };
                        _local_8++;
                    };
                };
            };
            var _local_6:IItemListWindow = (container.findChildByName("help_itemlist") as IItemListWindow);
            _local_6.IItemListWindow();
            main.updateWindowDimensions();
        }
        private function onFaqBrowse(_arg_1:WindowMouseEvent):void
        {
            main.showUI(HabboHelpViewEnum.HHVE_FAQ_TOP);
        }
        private function onCallForHelp(_arg_1:WindowMouseEvent):void
        {
            main.component.callForHelpData.reportedUserId = 0;
            main.showUI(HabboHelpViewEnum.HHVE_CFG_TOPIC_SELECT);
        }
        private function onReportUser(_arg_1:WindowMouseEvent):void
        {
            main.component.callForHelpData.reportedUserId = 0;
            main.showUI(HabboHelpViewEnum.HHVE_REPORT_USER_SELECT);
        }
        private function onListItemClick(_arg_1:WindowMouseEvent):void
        {
            var _local_2:IWindow = (_arg_1.target as IWindow);
            this.handleListItemClick(_local_2);
        }
        private function onCallGuideBot(_arg_1:WindowMouseEvent):void
        {
            main.handleCallGuideBot();
        }
        private function handleListItemClick(_arg_1:IWindow):void
        {
            var _local_3:FaqCategory;
            var _local_4:IItemListWindow;
            var _local_2:FaqIndex = main.getFaq();
            if ((((((_local_2 == null)) || ((_arg_1 == null)))) || ((_arg_1.parent == null)))){
                return;
            };
            if (_arg_1.parent.name.indexOf("normal") > -1){
                _local_4 = (container.findChildByTag("content_normal") as IItemListWindow);
                _local_3 = _local_2.getFrontPageNormalCategory();
            }
            else {
                _local_4 = (container.findChildByTag("content_urgent") as IItemListWindow);
                _local_3 = _local_2.getFrontPageUrgentCategory();
            };
            if (_local_4 == null){
                return;
            };
            var _local_5:int = _local_4.IItemListWindow(_arg_1.parent);
            if (_local_3 == null){
                return;
            };
            var _local_6:FaqItem = _local_3.getItemByIndex(_local_5);
            if (_local_6 != null){
                main.showUI(HabboHelpViewEnum.HHVE_FAQ_TOPICS);
                main.tellUI(HabboHelpViewEnum.HHVE_FAQ_TOPICS, _local_6);
            };
        }

    }
}//package com.sulake.habbo.help.help

// buildHelpCategoryListEntryItem = "_-Lh" (String#23070, DoABC#2)
// onListItemClick = "_-1AM" (String#598, DoABC#2)
// handleListItemClick = "_-0V1" (String#587, DoABC#2)
// getFrontPageUrgentCategory = "_-zh" (String#24676, DoABC#2)
// getFrontPageNormalCategory = "_-Ij" (String#22955, DoABC#2)
// getItemByIndex = "_-2P9" (String#20007, DoABC#2)
// getQuestionTitleArray = "_-2HA" (String#19692, DoABC#2)
// getAgeSeconds = "_-1CQ" (String#16963, DoABC#2)
// roomSessionActive = "_-4g" (String#7760, DoABC#2)
// _SafeStr_11385 = "_-37M" (String#21782, DoABC#2)
// onFaqBrowse = "_-2Mw" (String#19923, DoABC#2)
// onCallForHelp = "_-1G-" (String#17116, DoABC#2)
// onReportUser = "_-Zz" (String#23631, DoABC#2)
// onCallGuideBot = "_-2-N" (String#18986, DoABC#2)
// IHTMLTextWindow = "_-RR" (String#8235, DoABC#2)
// FaqIndex = "_-3I0" (String#7667, DoABC#2)
// HabboHelpViewEnum = "_-1e7" (String#18062, DoABC#2)
// HelpViewController = "_-IY" (String#8052, DoABC#2)
// HelpMainView = "_-h6" (String#8537, DoABC#2)
// FaqCategory = "_-0JM" (String#3941, DoABC#2)
// FaqItem = "_-1u6" (String#5923, DoABC#2)
// GetClientFaqsMessageComposer = "_-3u" (String#22371, DoABC#2)
// IItemListWindow = "_-0xF" (String#4796, DoABC#2)
// IItemListWindow = "_-6Q" (String#7792, DoABC#2)
// _SafeStr_7434 = "_-2xA" (String#21356, DoABC#2)
// HHVE_FAQ_TOP = "_-0et" (String#15622, DoABC#2)
// HHVE_FAQ_TOPICS = "_-ed" (String#23829, DoABC#2)
// HHVE_CFG_TOPIC_SELECT = "_-2-u" (String#19007, DoABC#2)
// HHVE_REPORT_USER_SELECT = "_-0Cm" (String#14561, DoABC#2)
// IItemListWindow = "_-0fG" (String#4411, DoABC#2)


