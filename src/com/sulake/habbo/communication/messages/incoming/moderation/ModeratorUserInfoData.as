
package com.sulake.habbo.communication.messages.incoming.moderation
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ModeratorUserInfoData 
    {

        private var _userId:int;
        private var _userName:String;
        private var _minutesSinceRegistration:int;
        private var _minutesSinceLastLogin:int;
        private var _online:Boolean;
        private var _cfhCount:int;
        private var _abusiveCfhCount:int;
        private var _cautionCount:int;
        private var _banCount:int;

        public function ModeratorUserInfoData(_arg_1:IMessageDataWrapper)
        {
            this._userId = _arg_1.readInteger();
            this._userName = _arg_1.readString();
            this._minutesSinceRegistration = _arg_1.readInteger();
            this._minutesSinceLastLogin = _arg_1.readInteger();
            this._online = _arg_1.readBoolean();
            this._cfhCount = _arg_1.readInteger();
            this._abusiveCfhCount = _arg_1.readInteger();
            this._cautionCount = _arg_1.readInteger();
            this._banCount = _arg_1.readInteger();
        }
        public function get userId():int
        {
            return (this._userId);
        }
        public function get userName():String
        {
            return (this._userName);
        }
        public function get minutesSinceRegistration():int
        {
            return (this._minutesSinceRegistration);
        }
        public function get minutesSinceLastLogin():int
        {
            return (this._minutesSinceLastLogin);
        }
        public function get online():Boolean
        {
            return (this._online);
        }
        public function get _SafeStr_6425():int
        {
            return (this._cfhCount);
        }
        public function get abusiveCfhCount():int
        {
            return (this._abusiveCfhCount);
        }
        public function get cautionCount():int
        {
            return (this._cautionCount);
        }
        public function get banCount():int
        {
            return (this._banCount);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.moderation

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// ModeratorUserInfoData = "_-0Cn" (String#3805, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// readBoolean = "_-0ZR" (String#1499, DoABC#2)
// _minutesSinceRegistration = "_-0p-" (String#16013, DoABC#2)
// _minutesSinceLastLogin = "_-045" (String#14205, DoABC#2)
// _online = "_-0-Y" (String#573, DoABC#2)
// _cfhCount = "_-1hk" (String#18200, DoABC#2)
// _abusiveCfhCount = "_-1O8" (String#17439, DoABC#2)
// _cautionCount = "_-0No" (String#14982, DoABC#2)
// _banCount = "_-29V" (String#19385, DoABC#2)
// minutesSinceRegistration = "_-35X" (String#21714, DoABC#2)
// minutesSinceLastLogin = "_-1gG" (String#18150, DoABC#2)
// _SafeStr_6425 = "super" (String#46908, DoABC#2)
// abusiveCfhCount = "_-qT" (String#24291, DoABC#2)
// cautionCount = "_-KY" (String#23025, DoABC#2)
// banCount = "_-0ys" (String#16386, DoABC#2)


