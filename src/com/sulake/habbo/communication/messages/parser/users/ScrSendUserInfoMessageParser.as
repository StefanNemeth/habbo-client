
package com.sulake.habbo.communication.messages.parser.users
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ScrSendUserInfoMessageParser implements IMessageParser 
    {

        public static const _SafeStr_5851:int = 1;
        public static const RESPONSE_TYPE_PURCHASE:int = 2;
        public static const _SafeStr_5852:int = 3;

        private var _productName:String;
        private var _daysToPeriodEnd:int;
        private var _memberPeriods:int;
        private var _periodsSubscribedAhead:int;
        private var _responseType:int;
        private var _hasEverBeenMember:Boolean;
        private var _isVIP:Boolean;
        private var _pastClubDays:int;
        private var _pastVipDays:int;
        private var _isShowBasicPromo:Boolean;
        private var _basicNormalPrice:int;
        private var _basicPromoPrice:int;

        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._productName = _arg_1.readString();
            this._daysToPeriodEnd = _arg_1.readInteger();
            this._memberPeriods = _arg_1.readInteger();
            this._periodsSubscribedAhead = _arg_1.readInteger();
            this._responseType = _arg_1.readInteger();
            this._hasEverBeenMember = _arg_1.readBoolean();
            this._isVIP = _arg_1.readBoolean();
            this._pastClubDays = _arg_1.readInteger();
            this._pastVipDays = _arg_1.readInteger();
            this._isShowBasicPromo = _arg_1.readBoolean();
            this._basicNormalPrice = _arg_1.readInteger();
            this._basicPromoPrice = _arg_1.readInteger();
            return (true);
        }
        public function get productName():String
        {
            return (this._productName);
        }
        public function get daysToPeriodEnd():int
        {
            return (this._daysToPeriodEnd);
        }
        public function get memberPeriods():int
        {
            return (this._memberPeriods);
        }
        public function get periodsSubscribedAhead():int
        {
            return (this._periodsSubscribedAhead);
        }
        public function get responseType():int
        {
            return (this._responseType);
        }
        public function get hasEverBeenMember():Boolean
        {
            return (this._hasEverBeenMember);
        }
        public function get isVIP():Boolean
        {
            return (this._isVIP);
        }
        public function get pastClubDays():int
        {
            return (this._pastClubDays);
        }
        public function get pastVipDays():int
        {
            return (this._pastVipDays);
        }
        public function get isShowBasicPromo():Boolean
        {
            return (this._isShowBasicPromo);
        }
        public function get basicNormalPrice():int
        {
            return (this._basicNormalPrice);
        }
        public function get basicPromoPrice():int
        {
            return (this._basicPromoPrice);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.users

// ScrSendUserInfoMessageParser = "_-1vA" (String#18764, DoABC#2)
// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// readBoolean = "_-0ZR" (String#1499, DoABC#2)
// _isVIP = "_-1HM" (String#1652, DoABC#2)
// isVIP = "_-3K4" (String#7705, DoABC#2)
// _SafeStr_5851 = "_-2Jh" (String#19798, DoABC#2)
// _SafeStr_5852 = "_-1gA" (String#18147, DoABC#2)
// _productName = "_-09X" (String#1413, DoABC#2)
// _daysToPeriodEnd = "_-0q5" (String#16055, DoABC#2)
// _memberPeriods = "_-223" (String#19093, DoABC#2)
// _periodsSubscribedAhead = "_-3E8" (String#22040, DoABC#2)
// _responseType = "_-2zR" (String#21438, DoABC#2)
// _hasEverBeenMember = "_-2Vg" (String#20267, DoABC#2)
// _pastClubDays = "_-0ju" (String#4499, DoABC#2)
// _pastVipDays = "_-0Py" (String#4091, DoABC#2)
// _isShowBasicPromo = "_-3Eu" (String#22072, DoABC#2)
// _basicNormalPrice = "_-1Lq" (String#17350, DoABC#2)
// _basicPromoPrice = "_-26m" (String#19281, DoABC#2)
// daysToPeriodEnd = "_-3L6" (String#22328, DoABC#2)
// memberPeriods = "_-1m3" (String#18381, DoABC#2)
// periodsSubscribedAhead = "_-08y" (String#14405, DoABC#2)
// responseType = "_-0wX" (String#16291, DoABC#2)
// hasEverBeenMember = "_-iw" (String#23995, DoABC#2)
// pastClubDays = "_-2W7" (String#6687, DoABC#2)
// pastVipDays = "_-373" (String#7449, DoABC#2)
// isShowBasicPromo = "_-0L2" (String#14879, DoABC#2)
// basicNormalPrice = "_-1o" (String#18461, DoABC#2)
// basicPromoPrice = "_-fv" (String#23887, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


