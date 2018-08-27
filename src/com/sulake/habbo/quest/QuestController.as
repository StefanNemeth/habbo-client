
package com.sulake.habbo.quest
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.habbo.communication.messages.incoming.quest.QuestMessageData;

    public class QuestController implements IDisposable, IUpdateReceiver 
    {

        private var _SafeStr_8017:HabboQuestEngine;
        private var _questsList:QuestsList;
        private var _questDetails:QuestDetails;
        private var _questCompleted:QuestCompleted;
        private var _questTracker:QuestTracker;
        private var _SafeStr_12177:NextQuestTimer;

        public function QuestController(_arg_1:HabboQuestEngine)
        {
            this._SafeStr_8017 = _arg_1;
            this._questTracker = new QuestTracker(this._SafeStr_8017);
            this._questsList = new QuestsList(this._SafeStr_8017);
            this._questDetails = new QuestDetails(this._SafeStr_8017);
            this._questCompleted = new QuestCompleted(this._SafeStr_8017);
            this._SafeStr_12177 = new NextQuestTimer(this._SafeStr_8017);
        }
        public function onToolbarClick():void
        {
            this._questsList.onToolbarClick();
        }
        public function onQuests(_arg_1:Array, _arg_2:Boolean):void
        {
            this._questsList.onQuests(_arg_1, _arg_2);
        }
        public function onQuest(_arg_1:QuestMessageData):void
        {
            this._questTracker.onQuest(_arg_1);
            this._questDetails.onQuest(_arg_1);
            this._questCompleted.onQuest(_arg_1);
            this._SafeStr_12177.onQuest(_arg_1);
        }
        public function onQuestCompleted(_arg_1:QuestMessageData):void
        {
            this._questTracker.onQuestCompleted(_arg_1);
            this._questDetails.onQuestCompleted(_arg_1);
            this._questCompleted.onQuestCompleted(_arg_1);
        }
        public function onQuestCancelled():void
        {
            this._questTracker.onQuestCancelled();
            this._questDetails.onQuestCancelled();
            this._questCompleted.onQuestCancelled();
            this._SafeStr_12177.onQuestCancelled();
        }
        public function onRoomEnter():void
        {
            this._questTracker.onRoomEnter();
        }
        public function onRoomExit():void
        {
            this._questsList.onRoomExit();
            this._questTracker.onRoomExit();
            this._questDetails.onRoomExit();
            this._SafeStr_12177.onRoomExit();
        }
        public function update(_arg_1:uint):void
        {
            this._questCompleted.update(_arg_1);
            this._questTracker.update(_arg_1);
            this._SafeStr_12177.update(_arg_1);
            this._questsList.update(_arg_1);
            this._questDetails.update(_arg_1);
        }
        public function dispose():void
        {
            this._SafeStr_8017 = null;
            if (this._questsList){
                this._questsList.dispose();
                this._questsList = null;
            };
            if (this._questTracker){
                this._questTracker.dispose();
                this._questTracker = null;
            };
            if (this._questDetails){
                this._questDetails.dispose();
                this._questDetails = null;
            };
            if (this._questCompleted){
                this._questCompleted.dispose();
                this._questCompleted = null;
            };
            if (this._SafeStr_12177){
                this._SafeStr_12177.dispose();
                this._SafeStr_12177 = null;
            };
        }
        public function get disposed():Boolean
        {
            return ((this._SafeStr_8017 == null));
        }
        public function get questsList():QuestsList
        {
            return (this._questsList);
        }
        public function get questDetails():QuestDetails
        {
            return (this._questDetails);
        }
        public function get questTracker():QuestTracker
        {
            return (this._questTracker);
        }

    }
}//package com.sulake.habbo.quest

// onQuestCompleted = "_-2Ht" (String#6400, DoABC#2)
// onQuestCancelled = "_-0wk" (String#4785, DoABC#2)
// onQuests = "_-1uj" (String#5933, DoABC#2)
// onQuest = "_-kW" (String#8614, DoABC#2)
// _questsList = "_-09d" (String#14432, DoABC#2)
// _questDetails = "_-0ai" (String#15463, DoABC#2)
// _questTracker = "_-0QX" (String#15083, DoABC#2)
// _SafeStr_12177 = "_-1j9" (String#18250, DoABC#2)
// onToolbarClick = "_-2UP" (String#6654, DoABC#2)
// questsList = "_-0W6" (String#15282, DoABC#2)
// questDetails = "_-2H-" (String#19684, DoABC#2)
// questTracker = "_-Vi" (String#23481, DoABC#2)
// QuestController = "_-BP" (String#7897, DoABC#2)
// QuestMessageData = "_-2Vr" (String#20275, DoABC#2)
// QuestsList = "_-1Gq" (String#5185, DoABC#2)
// QuestCompleted = "_-2rj" (String#7117, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// IUpdateReceiver = "_-Qe" (String#8218, DoABC#2)
// _SafeStr_8017 = "_-1jf" (String#150, DoABC#2)
// onRoomEnter = "_-El" (String#460, DoABC#2)
// onRoomExit = "_-0Na" (String#356, DoABC#2)


