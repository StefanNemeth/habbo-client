
package com.sulake.habbo.catalog.purse
{
    import flash.utils.Dictionary;

    public class Purse implements IPurse 
    {

        private var _credits:int = 0;
        private var _activityPoints:Dictionary;
        private var _clubDays:int = 0;
        private var _clubPeriods:int = 0;
        private var _isVIP:Boolean = false;
        private var _pastClubDays:int = 0;
        private var _pastVipDays:int = 0;
        private var _isExpiring:Boolean = false;

        public function Purse()
        {
            this._activityPoints = new Dictionary();
            super();
        }
        public function get credits():int
        {
            return (this._credits);
        }
        public function set credits(_arg_1:int):void
        {
            this._credits = _arg_1;
        }
        public function get clubDays():int
        {
            return (this._clubDays);
        }
        public function set clubDays(_arg_1:int):void
        {
            this._clubDays = _arg_1;
        }
        public function get clubPeriods():int
        {
            return (this._clubPeriods);
        }
        public function set clubPeriods(_arg_1:int):void
        {
            this._clubPeriods = _arg_1;
        }
        public function get hasClubLeft():Boolean
        {
            return ((((this._clubDays > 0)) || ((this._clubPeriods > 0))));
        }
        public function get isVIP():Boolean
        {
            return (this._isVIP);
        }
        public function get isExpiring():Boolean
        {
            return (this._isExpiring);
        }
        public function set isExpiring(_arg_1:Boolean):void
        {
            this._isExpiring = _arg_1;
        }
        public function set isVIP(_arg_1:Boolean):void
        {
            this._isVIP = _arg_1;
        }
        public function get pastClubDays():int
        {
            return (this._pastClubDays);
        }
        public function set pastClubDays(_arg_1:int):void
        {
            this._pastClubDays = _arg_1;
        }
        public function get pastVipDays():int
        {
            return (this._pastVipDays);
        }
        public function set pastVipDays(_arg_1:int):void
        {
            this._pastVipDays = _arg_1;
        }
        public function get activityPoints():Dictionary
        {
            return (this._activityPoints);
        }
        public function set activityPoints(_arg_1:Dictionary):void
        {
            this._activityPoints = _arg_1;
        }
        public function getActivityPointsForType(_arg_1:int):int
        {
            return (this._activityPoints[_arg_1]);
        }

    }
}//package com.sulake.habbo.catalog.purse

// IPurse = "_-0GN" (String#3880, DoABC#2)
// Purse = "_-M9" (String#8125, DoABC#2)
// _clubDays = "_-zt" (String#8881, DoABC#2)
// _clubPeriods = "_-0rC" (String#4666, DoABC#2)
// _isVIP = "_-1HM" (String#1652, DoABC#2)
// _isExpiring = "_-0lo" (String#4542, DoABC#2)
// isVIP = "_-3K4" (String#7705, DoABC#2)
// _credits = "_-e9" (String#8486, DoABC#2)
// hasClubLeft = "_-1Sl" (String#5409, DoABC#2)
// getActivityPointsForType = "_-1c9" (String#5603, DoABC#2)
// _pastClubDays = "_-0ju" (String#4499, DoABC#2)
// _pastVipDays = "_-0Py" (String#4091, DoABC#2)
// pastClubDays = "_-2W7" (String#6687, DoABC#2)
// pastVipDays = "_-373" (String#7449, DoABC#2)
// isExpiring = "_-YW" (String#8383, DoABC#2)
// _activityPoints = "_-2qa" (String#21105, DoABC#2)
// activityPoints = "_-0j3" (String#15794, DoABC#2)


