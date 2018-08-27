
package com.sulake.habbo.quest
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.habbo.communication.messages.incoming.quest.QuestCompletedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.quest.QuestCancelledMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.session.CloseConnectionMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.RoomEntryInfoMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.quest.QuestsMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.quest.QuestMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.achievements.AchievementsEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.achievements.AchievementEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.achievements.AchievementsScoreEvent;
    import com.sulake.habbo.communication.messages.incoming.notifications.HabboAchievementNotificationMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.notifications.HabboAchievementShareIdMessageEvent;
    import com.sulake.habbo.communication.messages.parser.quest.QuestCompletedMessageParser;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.quest.QuestsMessageParser;
    import com.sulake.habbo.communication.messages.parser.quest.QuestMessageParser;
    import com.sulake.habbo.communication.messages.parser.inventory.achievements.AchievementsMessageParser;
    import com.sulake.habbo.communication.messages.parser.inventory.achievements.AchievementMessageParser;
    import com.sulake.habbo.communication.messages.parser.inventory.achievements.AchievementsScoreMessageParser;
    import com.sulake.habbo.communication.messages.parser.notifications.HabboAchievementNotificationMessageParser;
    import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;

    public class IncomingMessages implements IDisposable 
    {

        private var _SafeStr_8017:HabboQuestEngine;
        private var _communication:IHabboCommunicationManager;
        private var _SafeStr_12161:IAlertDialog;
        private var _disposed:Boolean = false;

        public function IncomingMessages(_arg_1:HabboQuestEngine)
        {
            this._SafeStr_8017 = _arg_1;
            this._communication = this._SafeStr_8017.communication;
            this._communication.addHabboConnectionMessageEvent(new QuestCompletedMessageEvent(this.onQuestCompleted));
            this._communication.addHabboConnectionMessageEvent(new QuestCancelledMessageEvent(this.onQuestCancelled));
            this._communication.addHabboConnectionMessageEvent(new CloseConnectionMessageEvent(this.onRoomExit));
            this._communication.addHabboConnectionMessageEvent(new RoomEntryInfoMessageEvent(this.onRoomEnter));
            this._communication.addHabboConnectionMessageEvent(new QuestsMessageEvent(this.onQuests));
            this._communication.addHabboConnectionMessageEvent(new QuestMessageEvent(this.onQuest));
            this._communication.addHabboConnectionMessageEvent(new AchievementsEvent(this.onAchievements));
            this._communication.addHabboConnectionMessageEvent(new AchievementEvent(this.onAchievement));
            this._communication.addHabboConnectionMessageEvent(new AchievementsScoreEvent(this.onAchievementsScore));
            this._communication.addHabboConnectionMessageEvent(new HabboAchievementNotificationMessageEvent(this.onLevelUp));
            this._communication.addHabboConnectionMessageEvent(new HabboAchievementShareIdMessageEvent(this.onAchievementShareId));
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        private function onQuestCompleted(_arg_1:IMessageEvent):void
        {
            var _local_2:QuestCompletedMessageParser = (_arg_1 as QuestCompletedMessageEvent).getParser();
            Logger.log(((("Quest Completed: " + _local_2.questData.campaignCode) + " quest: ") + _local_2.questData.id));
            this._SafeStr_8017.questController.onQuestCompleted(_local_2.questData);
        }
        private function onQuestCancelled(_arg_1:IMessageEvent):void
        {
            Logger.log("Quest Cancelled: ");
            this._SafeStr_8017.questController.onQuestCancelled();
        }
        private function onQuests(_arg_1:IMessageEvent):void
        {
            var _local_2:QuestsMessageParser = (_arg_1 as QuestsMessageEvent).getParser();
            Logger.log(((("Got Quests: " + _local_2.quests) + ", ") + _local_2.openWindow));
            this._SafeStr_8017.questController.onQuests(_local_2.quests, _local_2.openWindow);
        }
        private function onQuest(_arg_1:IMessageEvent):void
        {
            var _local_2:QuestMessageParser = (_arg_1 as QuestMessageEvent).getParser();
            Logger.log(("Got Quest: " + _local_2.quest));
            this._SafeStr_8017.questController.onQuest(_local_2.quest);
        }
        public function dispose():void
        {
            if (this._SafeStr_12161){
                this._SafeStr_12161.dispose();
                this._SafeStr_12161 = null;
            };
            this._disposed = true;
        }
        private function onRoomEnter(_arg_1:IMessageEvent):void
        {
            this._SafeStr_8017.questController.onRoomEnter();
            this._SafeStr_8017.currentlyInRoom = true;
        }
        private function onRoomExit(_arg_1:IMessageEvent):void
        {
            this._SafeStr_8017.questController.onRoomExit();
            this._SafeStr_8017.achievementController.onRoomExit();
            this._SafeStr_8017.currentlyInRoom = false;
        }
        private function onAchievements(_arg_1:IMessageEvent):void
        {
            var _local_2:AchievementsEvent = (_arg_1 as AchievementsEvent);
            var _local_3:AchievementsMessageParser = (_local_2.getParser() as AchievementsMessageParser);
            this._SafeStr_8017.achievementController.onAchievements(_local_3.achievements, _local_3.defaultCategory);
        }
        private function onAchievement(_arg_1:IMessageEvent):void
        {
            var _local_2:AchievementEvent = (_arg_1 as AchievementEvent);
            var _local_3:AchievementMessageParser = (_local_2.getParser() as AchievementMessageParser);
            this._SafeStr_8017.achievementController.onAchievement(_local_3.achievement);
        }
        private function onAchievementsScore(_arg_1:IMessageEvent):void
        {
            var _local_2:AchievementsScoreEvent = (_arg_1 as AchievementsScoreEvent);
            var _local_3:AchievementsScoreMessageParser = (_local_2.getParser() as AchievementsScoreMessageParser);
            this._SafeStr_8017.localization.registerParameter("achievements.categories.score", "score", _local_3.score.toString());
        }
        private function onLevelUp(_arg_1:IMessageEvent):void
        {
            var _local_2:HabboAchievementNotificationMessageEvent = (_arg_1 as HabboAchievementNotificationMessageEvent);
            var _local_3:HabboAchievementNotificationMessageParser = _local_2.getParser();
            var _local_4:String = this._SafeStr_8017.localization.getBadgeBaseName(_local_3.data.badgeCode);
            this._SafeStr_8017.send(new EventLogMessageComposer("Achievements", _local_4, "Leveled", "", _local_3.data.level));
            this._SafeStr_8017.achievementController.levelUpDialog.onLevelUp(_local_3.data);
        }
        private function onAchievementShareId(_arg_1:IMessageEvent):void
        {
            var _local_2:HabboAchievementShareIdMessageEvent = (_arg_1 as HabboAchievementShareIdMessageEvent);
            this._SafeStr_8017.achievementController.levelUpDialog.requestFacebookPostDialog(_local_2.badgeID, _local_2.shareID);
        }

    }
}//package com.sulake.habbo.quest

// onAchievementsScore = "_-28h" (String#6216, DoABC#2)
// getBadgeBaseName = "_-25N" (String#6149, DoABC#2)
// _SafeStr_12161 = "_-023" (String#14128, DoABC#2)
// onQuestCompleted = "_-2Ht" (String#6400, DoABC#2)
// onQuestCancelled = "_-0wk" (String#4785, DoABC#2)
// onQuests = "_-1uj" (String#5933, DoABC#2)
// onQuest = "_-kW" (String#8614, DoABC#2)
// onAchievements = "_-2x" (String#7223, DoABC#2)
// onAchievement = "_-3BD" (String#7532, DoABC#2)
// onLevelUp = "_-2UY" (String#6656, DoABC#2)
// questController = "_-1Hq" (String#17186, DoABC#2)
// currentlyInRoom = "_-15i" (String#16684, DoABC#2)
// achievementController = "_-0e" (String#15584, DoABC#2)
// levelUpDialog = "_-3Ft" (String#22111, DoABC#2)
// requestFacebookPostDialog = "_-VO" (String#23466, DoABC#2)
// IAlertDialog = "_-2LY" (String#6472, DoABC#2)
// IncomingMessages = "_-2Xb" (String#216, DoABC#2)
// AchievementsScoreEvent = "_-JF" (String#8067, DoABC#2)
// AchievementsScoreMessageParser = "_-hH" (String#23941, DoABC#2)
// QuestCompletedMessageEvent = "_-Kr" (String#8100, DoABC#2)
// QuestsMessageEvent = "_-0xi" (String#4803, DoABC#2)
// QuestMessageEvent = "_-2xP" (String#7229, DoABC#2)
// HabboAchievementShareIdMessageEvent = "_-0CV" (String#3800, DoABC#2)
// QuestCancelledMessageEvent = "_-0Xi" (String#4262, DoABC#2)
// AchievementEvent = "_-12h" (String#4929, DoABC#2)
// AchievementsEvent = "_-3FG" (String#7617, DoABC#2)
// QuestMessageParser = "_-0Wc" (String#4240, DoABC#2)
// QuestsMessageParser = "_-0ra" (String#4677, DoABC#2)
// AchievementsMessageParser = "_-Rf" (String#8241, DoABC#2)
// AchievementMessageParser = "_-fU" (String#8507, DoABC#2)
// QuestCompletedMessageParser = "_-0UU" (String#4192, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// _disposed = "_-6m" (String#31, DoABC#2)
// communication = "_-3HD" (String#22171, DoABC#2)
// addHabboConnectionMessageEvent = "_-0r" (String#4663, DoABC#2)
// badgeCode = "_-2XO" (String#20338, DoABC#2)
// badgeID = "_-Cm" (String#22716, DoABC#2)
// shareID = "_-02x" (String#14159, DoABC#2)
// IHabboCommunicationManager = "_-0ls" (String#4545, DoABC#2)
// _SafeStr_8017 = "_-1jf" (String#150, DoABC#2)
// campaignCode = "_-DA" (String#22735, DoABC#2)
// quests = "_-Bu" (String#22684, DoABC#2)
// openWindow = "_-1na" (String#18444, DoABC#2)
// questData = "_-2gU" (String#20709, DoABC#2)
// HabboAchievementNotificationMessageParser = "_-Zs" (String#8418, DoABC#2)
// achievements = "_-2JC" (String#19776, DoABC#2)
// defaultCategory = "_-12L" (String#16551, DoABC#2)
// EventLogMessageComposer = "_-2lH" (String#6984, DoABC#2)
// RoomEntryInfoMessageEvent = "_-nk" (String#24182, DoABC#2)
// HabboAchievementNotificationMessageEvent = "_-2LH" (String#6465, DoABC#2)
// CloseConnectionMessageEvent = "_-2cv" (String#6811, DoABC#2)
// onRoomEnter = "_-El" (String#460, DoABC#2)
// onRoomExit = "_-0Na" (String#356, DoABC#2)


