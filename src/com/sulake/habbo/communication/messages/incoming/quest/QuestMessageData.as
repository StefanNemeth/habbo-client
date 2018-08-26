
package com.sulake.habbo.communication.messages.incoming.quest
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class QuestMessageData 
    {

        private var _campaignCode:String;
        private var _completedQuestsInCampaign:int;
        private var _questCountInCampaign:int;
        private var _activityPointType:int;
        private var _id:int;
        private var _accepted:Boolean;
        private var _type:String;
        private var _imageVersion:String;
        private var _rewardCurrencyAmount:int;
        private var _localizationCode:String;
        private var _completedSteps:int;
        private var _totalSteps:int;
        private var _waitPeriodSeconds:int;
        private var _receiveTime:Date;

        public function QuestMessageData(_arg_1:IMessageDataWrapper)
        {
            this._receiveTime = new Date();
            super();
            this._campaignCode = _arg_1.readString();
            this._completedQuestsInCampaign = _arg_1.readInteger();
            this._questCountInCampaign = _arg_1.readInteger();
            this._activityPointType = _arg_1.readInteger();
            this._id = _arg_1.readInteger();
            this._accepted = _arg_1.readBoolean();
            this._type = _arg_1.readString();
            this._imageVersion = _arg_1.readString();
            this._rewardCurrencyAmount = _arg_1.readInteger();
            this._localizationCode = _arg_1.readString();
            this._completedSteps = _arg_1.readInteger();
            this._totalSteps = _arg_1.readInteger();
            this._waitPeriodSeconds = _arg_1.readInteger();
        }
        public function get campaignCode():String
        {
            return (this._campaignCode);
        }
        public function get localizationCode():String
        {
            return (this._localizationCode);
        }
        public function get completedQuestsInCampaign():int
        {
            return (this._completedQuestsInCampaign);
        }
        public function get questCountInCampaign():int
        {
            return (this._questCountInCampaign);
        }
        public function get activityPointType():int
        {
            return (this._activityPointType);
        }
        public function get accepted():Boolean
        {
            return (this._accepted);
        }
        public function get id():int
        {
            return (this._id);
        }
        public function get type():String
        {
            return (this._type);
        }
        public function get imageVersion():String
        {
            return (this._imageVersion);
        }
        public function get rewardCurrencyAmount():int
        {
            return (this._rewardCurrencyAmount);
        }
        public function get completedSteps():int
        {
            return (this._completedSteps);
        }
        public function get totalSteps():int
        {
            return (this._totalSteps);
        }
        public function get waitPeriodSeconds():int
        {
            if (this._waitPeriodSeconds < 1){
                return (0);
            };
            var _local_1:Date = new Date();
            var _local_2:int = (_local_1.getTime() - this._receiveTime.getTime());
            return (Math.max(0, (this._waitPeriodSeconds - Math.floor((_local_2 / 1000)))));
        }
        public function QuestMessageData():String
        {
            return (("quests." + this._campaignCode));
        }
        public function QuestMessageData():String
        {
            return (((this.QuestMessageData() + ".") + this._localizationCode));
        }
        public function get completedCampaign():Boolean
        {
            return ((this._id < 1));
        }
        public function set id(_arg_1:int):void
        {
            this._id = _arg_1;
        }
        public function set accepted(_arg_1:Boolean):void
        {
            this._accepted = _arg_1;
        }
        public function get lastQuestInCampaign():Boolean
        {
            return ((this._completedQuestsInCampaign >= this._questCountInCampaign));
        }
        public function get receiveTime():Date
        {
            return (this._receiveTime);
        }
        public function set waitPeriodSeconds(_arg_1:int):void
        {
            this._waitPeriodSeconds = _arg_1;
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.quest

// QuestMessageData = "_-2Vr" (String#20275, DoABC#2)
// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// readBoolean = "_-0ZR" (String#1499, DoABC#2)
// _activityPointType = "_-1gC" (String#610, DoABC#2)
// activityPointType = "_-1gh" (String#5677, DoABC#2)
// _campaignCode = "_-17k" (String#16764, DoABC#2)
// _completedQuestsInCampaign = "_-3DF" (String#22005, DoABC#2)
// _questCountInCampaign = "_-1xd" (String#18874, DoABC#2)
// _accepted = "_-1FL" (String#17087, DoABC#2)
// _imageVersion = "_-2ZX" (String#20420, DoABC#2)
// _rewardCurrencyAmount = "_-mL" (String#24120, DoABC#2)
// _localizationCode = "_-8i" (String#22569, DoABC#2)
// _completedSteps = "_-0yF" (String#16363, DoABC#2)
// _totalSteps = "_-0x1" (String#16313, DoABC#2)
// _waitPeriodSeconds = "_-0WH" (String#15290, DoABC#2)
// _receiveTime = "_-18E" (String#16785, DoABC#2)
// campaignCode = "_-DA" (String#22735, DoABC#2)
// localizationCode = "_-05w" (String#14279, DoABC#2)
// completedQuestsInCampaign = "_-0kr" (String#15858, DoABC#2)
// questCountInCampaign = "_-hn" (String#23957, DoABC#2)
// accepted = "_-1rY" (String#18610, DoABC#2)
// imageVersion = "_-0eu" (String#15623, DoABC#2)
// rewardCurrencyAmount = "_-2PB" (String#20009, DoABC#2)
// completedSteps = "_-fZ" (String#23868, DoABC#2)
// totalSteps = "_-1aT" (String#17912, DoABC#2)
// waitPeriodSeconds = "_-376" (String#21771, DoABC#2)
// QuestMessageData = "_-02z" (String#14161, DoABC#2)
// QuestMessageData = "_-D-" (String#22728, DoABC#2)
// completedCampaign = "_-35O" (String#21710, DoABC#2)
// lastQuestInCampaign = "_-2Xd" (String#20345, DoABC#2)
// receiveTime = "_-0XC" (String#15322, DoABC#2)


