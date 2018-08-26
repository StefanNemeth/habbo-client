
package com.sulake.habbo.quest
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.habbo.communication.messages.incoming.quest.QuestMessageData;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.communication.messages.outgoing.quest.OpenQuestTrackerMessageComposer;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.communication.messages.outgoing.quest.GetQuestsMessageComposer;
    import com.sulake.core.window.components.ITextWindow;

    public class QuestCompleted implements IDisposable 
    {

        private static const _SafeStr_12276:int = 2000;
        private static const _SafeStr_12277:int = 5;
        private static const _SafeStr_12278:int = 31;

        private var _window:IFrameWindow;
        private var _SafeStr_8017:HabboQuestEngine;
        private var _quest:QuestMessageData;
        private var _SafeStr_12279:Animation;
        private var _SafeStr_12280:int;

        public function QuestCompleted(_arg_1:HabboQuestEngine)
        {
            this._SafeStr_8017 = _arg_1;
        }
        public function dispose():void
        {
            this._SafeStr_8017 = null;
            this._quest = null;
            if (this._window){
                this._window.dispose();
                this._window = null;
            };
            if (this._SafeStr_12279){
                this._SafeStr_12279.dispose();
                this._SafeStr_12279 = null;
            };
        }
        public function get disposed():Boolean
        {
            return ((this._window == null));
        }
        public function QuestTracker(_arg_1:QuestMessageData):void
        {
            this.close();
        }
        public function QuestTracker():void
        {
            this.close();
        }
        public function QuestTracker(_arg_1:QuestMessageData):void
        {
            this.prepare(_arg_1);
            this._SafeStr_12280 = _SafeStr_12276;
        }
        private function close():void
        {
            if (this._window){
                this._window.visible = false;
            };
        }
        private function QuestCompleted(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            this._window.visible = false;
            this._SafeStr_8017.questController.questDetails.openForNextQuest = (this._SafeStr_8017.configuration.getKey("questing.showDetailsForNextQuest") == "true");
            this._SafeStr_8017.send(new OpenQuestTrackerMessageComposer());
        }
        private function QuestCompleted(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                this._window.visible = false;
                this._SafeStr_8017.send(new GetQuestsMessageComposer());
            };
        }
        public function prepare(_arg_1:QuestMessageData):void
        {
            this._quest = _arg_1;
            if (this._window == null){
                this._window = IFrameWindow(this._SafeStr_8017.getXmlWindow("QuestCompletedDialog"));
                this._window.findChildByTag("close").procedure = this.QuestCompleted;
                this._window.findChildByName("next_quest_button").procedure = this.QuestCompleted;
                this._window.findChildByName("more_quests_button").procedure = this.QuestCompleted;
                new PendingImage(this._SafeStr_8017, this._window.findChildByName("reward_icon"), "quest_doneicon");
                new PendingImage(this._SafeStr_8017, this._window.findChildByName("campaign_reward_icon"), "ach_receive_star");
                this._window.findChildByName("catalog_link_region").procedure = this.QuestCompleted;
                this._SafeStr_12279 = this._SafeStr_8017.getTwinkleAnimation(this._window);
            };
            this._window.findChildByName("catalog_link_txt").caption = this._SafeStr_8017.localization.getKey(("quests.completed.cataloglink." + this._quest.activityPointType));
            var _local_2:String = ("quests.completed.reward." + this._quest.activityPointType);
            this._SafeStr_8017.localization.registerParameter(_local_2, "amount", this._quest.rewardCurrencyAmount.toString());
            this._window.findChildByName("reward_txt").caption = this._SafeStr_8017.localization.getKey(_local_2, _local_2);
            this._window.visible = false;
            this._window.findChildByName("congrats_txt").caption = this._SafeStr_8017.localization.getKey(((this._quest.lastQuestInCampaign) ? "quests.completed.campaign.caption" : "quests.completed.quest.caption"));
            this._window.findChildByName("more_quests_button").visible = this._quest.lastQuestInCampaign;
            this._window.findChildByName("campaign_reward_icon").visible = this._quest.lastQuestInCampaign;
            this._window.findChildByName("catalog_link_region").visible = !(this._quest.lastQuestInCampaign);
            this._window.findChildByName("next_quest_button").visible = !(this._quest.lastQuestInCampaign);
            this._window.findChildByName("reward_icon").visible = !(this._quest.lastQuestInCampaign);
            this._window.findChildByName("campaign_reward_icon").visible = this._quest.lastQuestInCampaign;
            this._window.findChildByName("campaign_pic_bitmap").visible = this._quest.lastQuestInCampaign;
            this.QuestCompleted(((this._quest.lastQuestInCampaign) ? "quests.completed.campaign.title" : "quests.completed.quest.title"));
            this._SafeStr_8017.setupCampaignImage(this._window, _arg_1, this._quest.lastQuestInCampaign);
            var _local_3:ITextWindow = ITextWindow(this._window.findChildByName("desc_txt"));
            var _local_4:int = _local_3.height;
            this.QuestCompleted((this._quest.QuestMessageData() + ".completed"));
            _local_3.height = Math.max(_SafeStr_12278, (_local_3.textHeight + _SafeStr_12277));
            var _local_5:int = (_local_3.height - _local_4);
            this._window.height = (this._window.height + _local_5);
        }
        private function QuestCompleted(_arg_1:String):void
        {
            this._SafeStr_8017.localization.registerParameter(_arg_1, "category", this._SafeStr_8017.getCampaignName(this._quest));
            this._window.caption = this._SafeStr_8017.localization.getKey(_arg_1, _arg_1);
        }
        private function QuestCompleted(_arg_1:String):void
        {
            this._window.findChildByName("desc_txt").caption = this._SafeStr_8017.localization.getKey(_arg_1, _arg_1);
        }
        private function QuestCompleted(_arg_1:WindowEvent, _arg_2:IWindow=null):void
        {
            if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                this._SafeStr_8017.openCatalog(this._quest);
            };
        }
        public function update(_arg_1:uint):void
        {
            if (this._SafeStr_12280 > 0){
                this._SafeStr_12280 = (this._SafeStr_12280 - _arg_1);
                if (this._SafeStr_12280 < 1){
                    this._window.center();
                    this._window.visible = true;
                    this._window.activate();
                    if (this._quest.lastQuestInCampaign){
                        this._SafeStr_12279.Animation();
                    }
                    else {
                        this._SafeStr_12279.stop();
                    };
                };
            };
            if (this._SafeStr_12279 != null){
                this._SafeStr_12279.update(_arg_1);
            };
        }

    }
}//package com.sulake.habbo.quest

// QuestTracker = "_-2Ht" (String#6400, DoABC#2)
// QuestTracker = "_-0wk" (String#4785, DoABC#2)
// QuestTracker = "_-kW" (String#8614, DoABC#2)
// questController = "_-1Hq" (String#17186, DoABC#2)
// questDetails = "_-2H-" (String#19684, DoABC#2)
// Animation = "_-3BQ" (String#21939, DoABC#2)
// getCampaignName = "_-24T" (String#19199, DoABC#2)
// setupCampaignImage = "_-Ux" (String#23445, DoABC#2)
// _SafeStr_12276 = "_-2t1" (String#7138, DoABC#2)
// _SafeStr_12277 = "_-0zs" (String#4845, DoABC#2)
// _SafeStr_12278 = "_-33-" (String#21620, DoABC#2)
// _SafeStr_12279 = "_-2fE" (String#6856, DoABC#2)
// _SafeStr_12280 = "_-24L" (String#19192, DoABC#2)
// QuestCompleted = "_-1wY" (String#18823, DoABC#2)
// openForNextQuest = "_-UH" (String#23420, DoABC#2)
// QuestCompleted = "_-1AQ" (String#16877, DoABC#2)
// QuestCompleted = "_-1QV" (String#17532, DoABC#2)
// getTwinkleAnimation = "_-0MD" (String#14924, DoABC#2)
// QuestCompleted = "_-dG" (String#23770, DoABC#2)
// QuestCompleted = "_-0xx" (String#16352, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// Animation = "_-2Eu" (String#1841, DoABC#2)
// QuestMessageData = "_-2Vr" (String#20275, DoABC#2)
// OpenQuestTrackerMessageComposer = "_-07J" (String#3708, DoABC#2)
// GetQuestsMessageComposer = "_-2ct" (String#6810, DoABC#2)
// QuestCompleted = "_-2rj" (String#7117, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// activityPointType = "_-1gh" (String#5677, DoABC#2)
// openCatalog = "_-RM" (String#8233, DoABC#2)
// _SafeStr_8017 = "_-1jf" (String#150, DoABC#2)
// rewardCurrencyAmount = "_-2PB" (String#20009, DoABC#2)
// QuestMessageData = "_-D-" (String#22728, DoABC#2)
// lastQuestInCampaign = "_-2Xd" (String#20345, DoABC#2)
// _quest = "_-26O" (String#876, DoABC#2)


