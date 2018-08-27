
package com.sulake.habbo.quest
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.components.IScrollbarWindow;
    import com.sulake.habbo.utils.WindowToggle;
    import com.sulake.habbo.communication.messages.outgoing.quest.GetQuestsMessageComposer;
    import com.sulake.habbo.communication.messages.incoming.quest.QuestMessageData;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.help.WelcomeNotification;
    import com.sulake.habbo.toolbar.HabboToolbarIconEnum;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.communication.messages.outgoing.quest.AcceptQuestMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.quest.RejectQuestMessageComposer;
    import com.sulake.habbo.window.utils.IAlertDialog;

    public class QuestsList implements IDisposable 
    {

        private static const _SafeStr_12254:int = 5;
        private static const _SafeStr_12255:int = 10;
        private static const _SafeStr_12256:int = 10;
        private static const _SafeStr_12257:int = 30;

        private var _SafeStr_8017:HabboQuestEngine;
        private var _window:IFrameWindow;
        private var _content:IItemListWindow;
        private var _scrollV:IScrollbarWindow;
        private var _SafeStr_12258:Boolean = true;
        private var _SafeStr_12259:Boolean;
        private var _SafeStr_4248:WindowToggle;
        private var _quests:Array;
        private var _SafeStr_12260:int = 1000;

        public function QuestsList(_arg_1:HabboQuestEngine)
        {
            this._SafeStr_8017 = _arg_1;
        }
        public function dispose():void
        {
            this._SafeStr_8017 = null;
            if (this._window){
                this._window.dispose();
                this._window = null;
            };
            if (this._SafeStr_4248){
                this._SafeStr_4248.dispose();
                this._SafeStr_4248 = null;
            };
            this._content = null;
            this._scrollV = null;
            this._quests = null;
        }
        public function get disposed():Boolean
        {
            return ((this._SafeStr_8017 == null));
        }
        public function isVisible():Boolean
        {
            return (((this._window) && (this._window.visible)));
        }
        public function close():void
        {
            if (this._window){
                this._window.visible = false;
            };
        }
        public function onRoomExit():void
        {
            this.close();
        }
        public function onToolbarClick():void
        {
            if (!this._window){
                this.requestQuests();
                return;
            };
            if (((!(this._SafeStr_4248)) || (this._SafeStr_4248.disposed))){
                this._SafeStr_4248 = new WindowToggle(this._window, this._window.desktop, this.requestQuests, this.close);
            };
            this._SafeStr_4248.toggle();
            this._SafeStr_12258 = false;
        }
        private function requestQuests():void
        {
            this._SafeStr_8017.send(new GetQuestsMessageComposer());
        }
        public function onQuests(_arg_1:Array, _arg_2:Boolean):void
        {
            var _local_3:QuestMessageData;
            this._quests = _arg_1;
            if (((!(this.isVisible())) && (!(_arg_2)))){
                return;
            };
            this.refresh(false);
            this._window.visible = true;
            this._window.activate();
            this._SafeStr_12259 = false;
            for each (_local_3 in _arg_1) {
                if (_local_3.accepted){
                    this._SafeStr_12259 = true;
                };
            };
        }
        private function refresh(_arg_1:Boolean):void
        {
            var _local_3:Boolean;
            this.prepareWindow();
            this._content.autoArrangeItems = false;
            var _local_2:int;
            while (true) {
                if (_local_2 < this._quests.length){
                    this.refreshEntry(true, _local_2, this._quests[_local_2], _arg_1);
                }
                else {
                    _local_3 = this.refreshEntry(false, _local_2, null, _arg_1);
                    if (_local_3) break;
                };
                _local_2++;
            };
            this._content.autoArrangeItems = true;
        }
        private function prepareWindow():void
        {
            if (this._window != null){
                return;
            };
            this._window = IFrameWindow(this._SafeStr_8017.getXmlWindow("Quests"));
            this._window.findChildByTag("close").procedure = this.onWindowClose;
            this._content = IItemListWindow(this._window.findChildByName("quest_list"));
            this._scrollV = IScrollbarWindow(this._window.findChildByName("scroller"));
            this._window.center();
            this._content.spacing = _SafeStr_12255;
        }
        private function refreshEntry(_arg_1:Boolean, _arg_2:int, _arg_3:QuestMessageData, _arg_4:Boolean):Boolean
        {
            var _local_5:IWindowContainer = IWindowContainer(this._content.getListItemAt(_arg_2));
            var _local_6:Boolean;
            if (_local_5 == null){
                if (!_arg_1){
                    return (true);
                };
                _local_5 = this.createListEntry();
                this._content.addListItem(_local_5);
                _local_6 = true;
            };
            if (_arg_1){
                if (_arg_4){
                    this.refreshDelay(_local_5, _arg_3);
                }
                else {
                    this.refreshEntryDetails(_local_5, _arg_3);
                };
                _local_5.visible = true;
            }
            else {
                _local_5.visible = false;
            };
            return (false);
        }
        public function createListEntry():IWindowContainer
        {
            var _local_1:IWindowContainer = IWindowContainer(this._SafeStr_8017.getXmlWindow("QuestEntry"));
            var _local_2:IWindowContainer = IWindowContainer(this._SafeStr_8017.getXmlWindow("Campaign"));
            var _local_3:IWindowContainer = IWindowContainer(this._SafeStr_8017.getXmlWindow("Quest"));
            var _local_4:IWindowContainer = IWindowContainer(this._SafeStr_8017.getXmlWindow("EntryArrows"));
            var _local_5:IWindowContainer = IWindowContainer(this._SafeStr_8017.getXmlWindow("CampaignCompleted"));
            _local_1.addChild(_local_2);
            _local_1.addChild(_local_3);
            _local_1.addChild(_local_5);
            _local_1.addChild(_local_4);
            _local_3.findChildByName("accept_button").procedure = this.onAcceptQuest;
            _local_3.findChildByName("cancel_region").procedure = this.onCancelQuest;
            _local_1.findChildByName("hint_txt").visible = false;
            _local_1.findChildByName("link_region").visible = false;
            var _local_6:IWindow = _local_1.findChildByName("cancel_region");
            var _local_7:IWindow = _local_1.findChildByName("cancel_txt");
            _local_6.width = _local_7.width;
            _local_6.x = ((_local_3.width - _local_6.width) - _SafeStr_12256);
            new PendingImage(this._SafeStr_8017, IBitmapWrapperWindow(_local_4.findChildByName("arrow_0")), "quest_arrow1");
            new PendingImage(this._SafeStr_8017, IBitmapWrapperWindow(_local_4.findChildByName("arrow_1")), "quest_arrow2");
            new PendingImage(this._SafeStr_8017, IBitmapWrapperWindow(_local_2.findChildByName("completion_bg_red_bitmap")), "quest_counterbkg_disabled");
            new PendingImage(this._SafeStr_8017, IBitmapWrapperWindow(_local_2.findChildByName("completion_bg_blue_bitmap")), "quest_counterbkg_active");
            new PendingImage(this._SafeStr_8017, IBitmapWrapperWindow(_local_2.findChildByName("completion_bg_green_bitmap")), "quest_counterbkg_completed");
            new PendingImage(this._SafeStr_8017, IBitmapWrapperWindow(_local_5.findChildByName("completed_pic_bitmap")), "category_completed");
            _local_3.x = ((_local_2.x + _local_2.width) + _SafeStr_12254);
            _local_1.width = (_local_3.x + _local_3.width);
            _local_5.x = _local_3.x;
            this.setEntryHeight(_local_1);
            return (_local_1);
        }
        public function setEntryHeight(_arg_1:IWindowContainer):void
        {
            var _local_2:IWindowContainer = IWindowContainer(_arg_1.findChildByName("campaign_container"));
            var _local_3:IWindowContainer = IWindowContainer(_arg_1.findChildByName("quest_container"));
            var _local_4:IWindowContainer = IWindowContainer(_arg_1.findChildByName("entry_arrows_cont"));
            _local_2.height = _local_3.height;
            _arg_1.height = _local_3.height;
            _local_4.x = ((_local_2.x + _local_2.width) - 2);
            _local_4.y = (Math.floor(((_local_2.height - _local_4.height) / 2)) + 1);
            _local_2.findChildByName("completion_txt").y = (_local_2.height - _SafeStr_12257);
            var _local_5:int = 2;
            var _local_6:IWindow = _local_2.findChildByName("bg_bottom");
            _local_6.height = Math.floor(((_local_2.height - (2 * _local_5)) / 2));
            _local_6.y = (_local_5 + _local_6.height);
        }
        public function refreshEntryDetails(_arg_1:IWindowContainer, _arg_2:QuestMessageData):void
        {
            _arg_1.findChildByName("campaign_header_txt").caption = this._SafeStr_8017.getCampaignName(_arg_2);
            _arg_1.findChildByName("completion_txt").caption = ((_arg_2.completedQuestsInCampaign + "/") + _arg_2.questCountInCampaign);
            this._SafeStr_8017.setupCampaignImage(_arg_1, _arg_2, true);
            this.setColor(_arg_1, "bg", _arg_2.accepted, 4290944315, 4284769380);
            this.setColor(_arg_1, "bg_top", _arg_2.accepted, 0xFFFFD788, 4290427578);
            this.setColor(_arg_1, "bg_bottom", _arg_2.accepted, 0xFFFFC758, 4289440683);
            _arg_1.findChildByName("completion_bg_red_bitmap").visible = ((!(_arg_2.completedCampaign)) && ((_arg_2.completedQuestsInCampaign < 1)));
            _arg_1.findChildByName("completion_bg_blue_bitmap").visible = ((!(_arg_2.completedCampaign)) && ((_arg_2.completedQuestsInCampaign > 0)));
            _arg_1.findChildByName("completion_bg_green_bitmap").visible = _arg_2.completedCampaign;
            _arg_1.findChildByName("arrow_0").visible = !(_arg_2.accepted);
            _arg_1.findChildByName("arrow_1").visible = _arg_2.accepted;
            _arg_1.findChildByName("quest_container").visible = !(_arg_2.completedCampaign);
            _arg_1.findChildByName("campaign_completed_container").visible = _arg_2.completedCampaign;
            if (!_arg_2.completedCampaign){
                this.refreshEntryQuestDetails(IWindowContainer(_arg_1.findChildByName("quest_container")), _arg_2);
                this.refreshDelay(_arg_1, _arg_2);
            };
        }
        private function refreshEntryQuestDetails(_arg_1:IWindowContainer, _arg_2:QuestMessageData):void
        {
            _arg_1.findChildByName("quest_header_txt").caption = this._SafeStr_8017.getQuestRowTitle(_arg_2);
            _arg_1.findChildByName("desc_txt").caption = this._SafeStr_8017.getQuestDesc(_arg_2);
            _arg_1.findChildByName("cancel_txt").visible = _arg_2.accepted;
            _arg_1.findChildByName("cancel_region").visible = _arg_2.accepted;
            _arg_1.findChildByName("accept_button").visible = !(_arg_2.accepted);
            _arg_1.findChildByName("accept_button").id = _arg_2.id;
            this.setColor(_arg_1, null, _arg_2.accepted, 15982264, 0xC8C8C8);
            this.setColor(_arg_1, "quest_header", _arg_2.accepted, 15577658, 0x8D8D8D);
            ITextWindow(_arg_1.findChildByName("quest_header_txt")).textColor = ((_arg_2.accepted) ? 0xFFFFFFFF : 4281808695);
            this._SafeStr_8017.setupQuestImage(_arg_1, _arg_2);
            this._SafeStr_8017.refreshReward((_arg_2.waitPeriodSeconds < 1), _arg_1, _arg_2.activityPointType, _arg_2.rewardCurrencyAmount);
            _arg_1.findChildByName("delay_desc_txt").visible = (_arg_2.waitPeriodSeconds > 0);
            _arg_1.findChildByName("delay_txt").visible = (_arg_2.waitPeriodSeconds > 0);
            _arg_1.findChildByName("desc_txt").visible = (_arg_2.waitPeriodSeconds < 1);
        }
        public function refreshDelay(_arg_1:IWindowContainer, _arg_2:QuestMessageData):Boolean
        {
            var _local_3:int;
            var _local_4:String;
            if (_arg_1.findChildByName("delay_desc_txt").visible){
                _local_3 = _arg_2.waitPeriodSeconds;
                if (_local_3 > 0){
                    _local_4 = FriendlyTime.getFriendlyTime(this._SafeStr_8017.localization, _local_3);
                    _arg_1.findChildByName("delay_txt").caption = _local_4;
                }
                else {
                    this.refreshEntryQuestDetails(_arg_1, _arg_2);
                    return (true);
                };
            };
            return (false);
        }
        private function onWindowClose(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:Boolean;
            if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                this.close();
                _local_3 = Boolean(parseInt(this._SafeStr_8017.configuration.getKey("new.identity", "0")));
                if (((((_local_3) && (this._SafeStr_12258))) && (!(this._SafeStr_12259)))){
                    this._SafeStr_12258 = false;
                    this._SafeStr_8017.habboHelp.showWelcomeScreen(new WelcomeNotification(HabboToolbarIconEnum.QUESTS, "quests.rejectnotification"));
                };
            };
        }
        private function onAcceptQuest(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            var _local_3:int = _arg_2.id;
            Logger.log(("Accept quest: " + _local_3));
            this._SafeStr_8017.send(new AcceptQuestMessageComposer(_local_3));
            this._window.visible = false;
        }
        private function onCancelQuest(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            Logger.log("Reject quest");
            this._SafeStr_8017.send(new RejectQuestMessageComposer());
        }
        private function setColor(_arg_1:IWindowContainer, _arg_2:String, _arg_3:Boolean, _arg_4:uint, _arg_5:uint):void
        {
            (((_arg_2 == null)) ? _arg_1 : _arg_1.findChildByName(_arg_2)).color = ((_arg_3) ? _arg_4 : _arg_5);
        }
        public function onAlert(_arg_1:IAlertDialog, _arg_2:WindowEvent):void
        {
            if ((((_arg_2.type == WindowEvent.WE_OK)) || ((_arg_2.type == WindowEvent.WE_CANCEL)))){
                _arg_1.dispose();
            };
        }
        public function update(_arg_1:uint):void
        {
            if ((((this._window == null)) || (!(this._window.visible)))){
                return;
            };
            this._SafeStr_12260 = (this._SafeStr_12260 - _arg_1);
            if (this._SafeStr_12260 > 0){
                return;
            };
            this._SafeStr_12260 = NextQuestTimer._SafeStr_12275;
            this.refresh(true);
        }

    }
}//package com.sulake.habbo.quest

// showWelcomeScreen = "_-QV" (String#8213, DoABC#2)
// onAlert = "_-OQ" (String#23185, DoABC#2)
// onQuests = "_-1uj" (String#5933, DoABC#2)
// onToolbarClick = "_-2UP" (String#6654, DoABC#2)
// refreshReward = "_-13f" (String#16604, DoABC#2)
// _SafeStr_12254 = "_-3Jd" (String#22269, DoABC#2)
// _SafeStr_12255 = "_-0yK" (String#16364, DoABC#2)
// _SafeStr_12256 = "_-9n" (String#22609, DoABC#2)
// _SafeStr_12257 = "_-k2" (String#24035, DoABC#2)
// _SafeStr_12258 = "_-2CF" (String#19493, DoABC#2)
// _SafeStr_12259 = "_-U" (String#23407, DoABC#2)
// _SafeStr_12260 = "_-0Pq" (String#1467, DoABC#2)
// requestQuests = "_-2tB" (String#21209, DoABC#2)
// createListEntry = "_-0F6" (String#14648, DoABC#2)
// refreshDelay = "_-0uc" (String#16225, DoABC#2)
// onAcceptQuest = "_-2SV" (String#20137, DoABC#2)
// onCancelQuest = "_-0he" (String#15733, DoABC#2)
// setEntryHeight = "_-2zx" (String#21458, DoABC#2)
// getCampaignName = "_-24T" (String#19199, DoABC#2)
// setupCampaignImage = "_-Ux" (String#23445, DoABC#2)
// setColor = "_-0-w" (String#3562, DoABC#2)
// refreshEntryQuestDetails = "_-1d3" (String#18016, DoABC#2)
// getQuestRowTitle = "_-2cY" (String#20547, DoABC#2)
// getQuestDesc = "_-0-A" (String#14017, DoABC#2)
// setupQuestImage = "_-1a5" (String#17898, DoABC#2)
// getFriendlyTime = "_-1ci" (String#17999, DoABC#2)
// _SafeStr_12275 = "_-3Kr" (String#22317, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// IAlertDialog = "_-2LY" (String#6472, DoABC#2)
// WindowToggle = "_-1Ud" (String#17689, DoABC#2)
// IScrollbarWindow = "_-2fP" (String#1920, DoABC#2)
// WelcomeNotification = "_-ka" (String#8616, DoABC#2)
// QuestMessageData = "_-2Vr" (String#20275, DoABC#2)
// AcceptQuestMessageComposer = "_-Th" (String#23394, DoABC#2)
// GetQuestsMessageComposer = "_-2ct" (String#6810, DoABC#2)
// RejectQuestMessageComposer = "_-20K" (String#19025, DoABC#2)
// QuestsList = "_-1Gq" (String#5185, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// FriendlyTime = "_-1rL" (String#5880, DoABC#2)
// refreshEntry = "_-2v6" (String#308, DoABC#2)
// refresh = "_-s9" (String#189, DoABC#2)
// _content = "_-1Q8" (String#74, DoABC#2)
// _scrollV = "_-0Ir" (String#1449, DoABC#2)
// refreshEntryDetails = "_-xU" (String#24589, DoABC#2)
// _SafeStr_4248 = "_-25w" (String#6159, DoABC#2)
// toggle = "_-2MR" (String#19903, DoABC#2)
// onWindowClose = "_-2tr" (String#136, DoABC#2)
// activityPointType = "_-1gh" (String#5677, DoABC#2)
// prepareWindow = "_-RN" (String#219, DoABC#2)
// habboHelp = "_-015" (String#3584, DoABC#2)
// isVisible = "_-1rE" (String#18592, DoABC#2)
// _SafeStr_8017 = "_-1jf" (String#150, DoABC#2)
// completedQuestsInCampaign = "_-0kr" (String#15858, DoABC#2)
// questCountInCampaign = "_-hn" (String#23957, DoABC#2)
// accepted = "_-1rY" (String#18610, DoABC#2)
// rewardCurrencyAmount = "_-2PB" (String#20009, DoABC#2)
// waitPeriodSeconds = "_-376" (String#21771, DoABC#2)
// completedCampaign = "_-35O" (String#21710, DoABC#2)
// _quests = "_-0jY" (String#4492, DoABC#2)
// WE_OK = "_-0UB" (String#15212, DoABC#2)
// onRoomExit = "_-0Na" (String#356, DoABC#2)
// WE_CANCEL = "_-0gf" (String#15696, DoABC#2)


