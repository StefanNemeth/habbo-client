
package com.sulake.habbo.communication.messages.incoming.notifications
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class AchievementLevelUpData 
    {

        private var _type:int;
        private var _level:int;
        private var _points:int;
        private var _levelRewardPoints:int;
        private var _levelRewardPointType:int;
        private var _bonusPoints:int;
        private var _badgeId:int;
        private var _badgeCode:String = "";
        private var _removedBadgeCode:String = "";
        private var _achievementID:int;
        private var _category:String;

        public function AchievementLevelUpData(_arg_1:IMessageDataWrapper)
        {
            this._type = _arg_1.readInteger();
            this._level = _arg_1.readInteger();
            this._badgeId = _arg_1.readInteger();
            this._badgeCode = _arg_1.readString();
            this._points = _arg_1.readInteger();
            this._levelRewardPoints = _arg_1.readInteger();
            this._levelRewardPointType = _arg_1.readInteger();
            this._bonusPoints = _arg_1.readInteger();
            this._achievementID = _arg_1.readInteger();
            this._removedBadgeCode = _arg_1.readString();
            this._category = _arg_1.readString();
        }
        public function get type():int
        {
            return (this._type);
        }
        public function get level():int
        {
            return (this._level);
        }
        public function get points():int
        {
            return (this._points);
        }
        public function get levelRewardPoints():int
        {
            return (this._levelRewardPoints);
        }
        public function get levelRewardPointType():int
        {
            return (this._levelRewardPointType);
        }
        public function get bonusPoints():int
        {
            return (this._bonusPoints);
        }
        public function get badgeId():int
        {
            return (this._badgeId);
        }
        public function get badgeCode():String
        {
            return (this._badgeCode);
        }
        public function get removedBadgeCode():String
        {
            return (this._removedBadgeCode);
        }
        public function get achievementID():int
        {
            return (this._achievementID);
        }
        public function get category():String
        {
            return (this._category);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.notifications

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// AchievementLevelUpData = "_-1h6" (String#5687, DoABC#2)
// _badgeId = "_-rf" (String#642, DoABC#2)
// badgeId = "_-g6" (String#23896, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// bonusPoints = "_-0xr" (String#16347, DoABC#2)
// _level = "_-3FE" (String#250, DoABC#2)
// _points = "_-3-6" (String#7288, DoABC#2)
// _levelRewardPoints = "_-2SZ" (String#6621, DoABC#2)
// _levelRewardPointType = "_-2fq" (String#6862, DoABC#2)
// _bonusPoints = "_-yE" (String#8841, DoABC#2)
// _badgeCode = "_-1MA" (String#1667, DoABC#2)
// _removedBadgeCode = "_-29K" (String#19378, DoABC#2)
// _achievementID = "_-0KN" (String#14854, DoABC#2)
// levelRewardPoints = "_-315" (String#21541, DoABC#2)
// levelRewardPointType = "_-0M3" (String#14917, DoABC#2)
// badgeCode = "_-2XO" (String#20338, DoABC#2)
// removedBadgeCode = "_-4X" (String#22399, DoABC#2)
// achievementID = "_-2B4" (String#19447, DoABC#2)


