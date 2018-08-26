
package com.sulake.habbo.communication.messages.incoming.inventory.achievements
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class AchievementData 
    {

        private var _type:int;
        private var _level:int;
        private var _badgeId:String;
        private var _scoreLimit:int;
        private var _levelRewardPoints:int;
        private var _levelRewardPointType:int;
        private var _currentPoints:int;
        private var _finalLevel:Boolean;
        private var _category:String;
        private var _levelCount:int;

        public function AchievementData(_arg_1:IMessageDataWrapper)
        {
            this._type = _arg_1.readInteger();
            this._level = _arg_1.readInteger();
            this._badgeId = _arg_1.readString();
            this._scoreLimit = Math.max(1, _arg_1.readInteger());
            this._levelRewardPoints = _arg_1.readInteger();
            this._levelRewardPointType = _arg_1.readInteger();
            this._currentPoints = _arg_1.readInteger();
            this._finalLevel = _arg_1.readBoolean();
            this._category = _arg_1.readString();
            this._levelCount = _arg_1.readInteger();
        }
        public function get type():int
        {
            return (this._type);
        }
        public function get badgeId():String
        {
            return (this._badgeId);
        }
        public function get level():int
        {
            return (this._level);
        }
        public function get scoreLimit():int
        {
            return (this._scoreLimit);
        }
        public function get levelRewardPoints():int
        {
            return (this._levelRewardPoints);
        }
        public function get levelRewardPointType():int
        {
            return (this._levelRewardPointType);
        }
        public function get currentPoints():int
        {
            return (this._currentPoints);
        }
        public function get finalLevel():Boolean
        {
            return (this._finalLevel);
        }
        public function get category():String
        {
            return (this._category);
        }
        public function get levelCount():int
        {
            return (this._levelCount);
        }
        public function get firstLevelAchieved():Boolean
        {
            return ((((this._level > 1)) || (this._finalLevel)));
        }
        public function AchievementData():void
        {
            this._currentPoints = this._scoreLimit;
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.inventory.achievements

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// AchievementData = "_-39C" (String#7494, DoABC#2)
// _badgeId = "_-rf" (String#642, DoABC#2)
// badgeId = "_-g6" (String#23896, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// readBoolean = "_-0ZR" (String#1499, DoABC#2)
// _level = "_-3FE" (String#250, DoABC#2)
// _levelRewardPoints = "_-2SZ" (String#6621, DoABC#2)
// _levelRewardPointType = "_-2fq" (String#6862, DoABC#2)
// levelRewardPoints = "_-315" (String#21541, DoABC#2)
// levelRewardPointType = "_-0M3" (String#14917, DoABC#2)
// _scoreLimit = "_-xB" (String#24576, DoABC#2)
// _currentPoints = "_-1BJ" (String#16910, DoABC#2)
// _finalLevel = "_-0IV" (String#14780, DoABC#2)
// _levelCount = "_-1Pb" (String#17492, DoABC#2)
// scoreLimit = "_-0Nb" (String#14976, DoABC#2)
// currentPoints = "_-1Hf" (String#17176, DoABC#2)
// finalLevel = "_-0or" (String#16006, DoABC#2)
// levelCount = "_-22S" (String#19107, DoABC#2)
// firstLevelAchieved = "_-2Jb" (String#19794, DoABC#2)
// AchievementData = "_-0WK" (String#15292, DoABC#2)


