
package com.sulake.habbo.quest
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.communication.messages.incoming.quest.QuestMessageData;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class NextQuestTimer implements IDisposable 
    {

        public static const _SafeStr_12275:int = 1000;
        private static const _SafeStr_12093:String = "next_quest";

        private var _SafeStr_8017:HabboQuestEngine;
        private var _quest:QuestMessageData;
        private var _window:IWindowContainer;
        private var _SafeStr_12346:Boolean = false;
        private var _SafeStr_12260:int;

        public function NextQuestTimer(_arg_1:HabboQuestEngine)
        {
            this._SafeStr_8017 = _arg_1;
        }
        public function dispose():void
        {
            if (this._SafeStr_8017){
                this._SafeStr_8017.toolbar.extensionView.detachExtension(_SafeStr_12093);
            };
            this._SafeStr_8017 = null;
            this._quest = null;
            if (this._window){
                this._window.dispose();
                this._window = null;
            };
        }
        public function get disposed():Boolean
        {
            return ((this._SafeStr_8017 == null));
        }
        public function onQuestCancelled():void
        {
            this._quest = null;
            this.close();
        }
        public function onRoomExit():void
        {
            if (((!((this._window == null))) && (this._window.visible))){
                this._window.findChildByName("more_info_region").visible = false;
                this._window.findChildByName("more_info_txt").visible = false;
            };
        }
        public function onQuest(_arg_1:QuestMessageData):void
        {
            if (_arg_1.waitPeriodSeconds < 1){
                this.close();
                return;
            };
            this._quest = _arg_1;
            this.prepareWindow();
            this.refreshVisibility();
            this._window.visible = true;
            this._SafeStr_8017.toolbar.extensionView.attachExtension(_SafeStr_12093, this._window);
        }
        private function prepareWindow():void
        {
            if (this._window != null){
                return;
            };
            this._window = IWindowContainer(this._SafeStr_8017.getXmlWindow("NextQuestTimer"));
            this._window.x = 0;
            this._window.y = 0;
            this._window.findChildByName("more_info_region").procedure = this.onMoreInfo;
            new PendingImage(this._SafeStr_8017, this._window.findChildByName("quest_timer_expanded"), "quest_timer_expanded");
            new PendingImage(this._SafeStr_8017, this._window.findChildByName("quest_timer_contracted"), "quest_timer_contracted");
            new PendingImage(this._SafeStr_8017, this._window.findChildByName("quest_pic_bitmap"), "quest_timer_questionmark");
            this._window.findChildByName("quest_timer_expanded").procedure = this.onToggleExpanded;
            this._window.findChildByName("quest_timer_contracted").procedure = this.onToggleExpanded;
            this.refreshVisibility();
        }
        private function refresh():void
        {
            var _local_1:int = this._quest.waitPeriodSeconds;
            if (_local_1 < 1){
                this.close();
                this._quest.waitPeriodSeconds = 0;
                this._SafeStr_8017.questController.onQuest(this._quest);
            };
            var _local_2:String = FriendlyTime.getFriendlyTime(this._SafeStr_8017.localization, _local_1);
            var _local_3 = (this._quest.getCampaignLocalizationKey() + ".delayedmsg");
            this._SafeStr_8017.localization.registerParameter("quests.nextquesttimer.caption.contracted", "time", _local_2);
            this._SafeStr_8017.localization.registerParameter(_local_3, "time", _local_2);
            this._window.findChildByName("quest_header_txt").caption = this._SafeStr_8017.localization.getKey(("quests.nextquesttimer.caption." + ((this._SafeStr_12346) ? "expanded" : "contracted")));
            this._window.findChildByName("desc_txt").caption = this._SafeStr_8017.localization.getKey(_local_3, _local_3);
        }
        private function refreshVisibility():void
        {
            this._window.findChildByName("quest_timer_expanded").visible = this._SafeStr_12346;
            this._window.findChildByName("quest_timer_contracted").visible = !(this._SafeStr_12346);
            this._window.findChildByName("more_info_txt").visible = ((this._SafeStr_12346) && (this._SafeStr_8017.currentlyInRoom));
            this._window.findChildByName("more_info_region").visible = ((this._SafeStr_12346) && (this._SafeStr_8017.currentlyInRoom));
            this._window.findChildByName("quest_pic_bitmap").visible = this._SafeStr_12346;
            this._window.findChildByName("desc_txt").visible = this._SafeStr_12346;
            this.refresh();
        }
        private function onMoreInfo(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                this._SafeStr_8017.questController.questDetails.showDetails(this._quest);
            };
        }
        private function onToggleExpanded(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                this._SafeStr_12346 = !(this._SafeStr_12346);
                this.refreshVisibility();
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
            this._SafeStr_12260 = _SafeStr_12275;
            this.refresh();
        }
        private function getDefaultLocationX():int
        {
            return (0);
        }
        public function isVisible():Boolean
        {
            return (((this._window) && (this._window.visible)));
        }
        public function close():void
        {
            if (((!((this._window == null))) && (this._window.visible))){
                this._window.visible = false;
                this._SafeStr_8017.toolbar.extensionView.detachExtension(_SafeStr_12093);
            };
        }
        private function setQuestImageVisible(_arg_1:Boolean):void
        {
            this._window.findChildByName("quest_pic_bitmap").visible = _arg_1;
        }

    }
}//package com.sulake.habbo.quest

// _SafeStr_12093 = "_-0fy" (String#1523, DoABC#2)
// onQuestCancelled = "_-0wk" (String#4785, DoABC#2)
// onQuest = "_-kW" (String#8614, DoABC#2)
// questController = "_-1Hq" (String#17186, DoABC#2)
// currentlyInRoom = "_-15i" (String#16684, DoABC#2)
// questDetails = "_-2H-" (String#19684, DoABC#2)
// _SafeStr_12260 = "_-0Pq" (String#1467, DoABC#2)
// getFriendlyTime = "_-1ci" (String#17999, DoABC#2)
// _SafeStr_12275 = "_-3Kr" (String#22317, DoABC#2)
// _SafeStr_12346 = "_-2vU" (String#21296, DoABC#2)
// refreshVisibility = "_-3IB" (String#22209, DoABC#2)
// onMoreInfo = "_-Ll" (String#8119, DoABC#2)
// onToggleExpanded = "_-fq" (String#23882, DoABC#2)
// getDefaultLocationX = "_-2Bs" (String#6283, DoABC#2)
// setQuestImageVisible = "_-1YC" (String#5523, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// QuestMessageData = "_-2Vr" (String#20275, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// FriendlyTime = "_-1rL" (String#5880, DoABC#2)
// showDetails = "_-3H6" (String#7649, DoABC#2)
// refresh = "_-s9" (String#189, DoABC#2)
// prepareWindow = "_-RN" (String#219, DoABC#2)
// extensionView = "_-qR" (String#8717, DoABC#2)
// detachExtension = "_-gb" (String#8524, DoABC#2)
// attachExtension = "_-01F" (String#3587, DoABC#2)
// isVisible = "_-1rE" (String#18592, DoABC#2)
// _SafeStr_8017 = "_-1jf" (String#150, DoABC#2)
// waitPeriodSeconds = "_-376" (String#21771, DoABC#2)
// getCampaignLocalizationKey = "_-02z" (String#14161, DoABC#2)
// _quest = "_-26O" (String#876, DoABC#2)
// onRoomExit = "_-0Na" (String#356, DoABC#2)


