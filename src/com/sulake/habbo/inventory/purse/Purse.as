
package com.sulake.habbo.inventory.purse
{
    public class Purse 
    {

        private var _clubDays:int = 0;
        private var _clubPeriods:int = 0;
        private var _clubPastPeriods:int = 0;
        private var _clubHasEverBeenMember:Boolean = false;
        private var _isVIP:Boolean = false;
        private var _isExpiring:Boolean = false;

        public function set clubDays(_arg_1:int):void
        {
            this._clubDays = Math.max(0, _arg_1);
        }
        public function set clubPeriods(_arg_1:int):void
        {
            this._clubPeriods = Math.max(0, _arg_1);
        }
        public function set clubPastPeriods(_arg_1:int):void
        {
            this._clubPastPeriods = Math.max(0, _arg_1);
        }
        public function set clubHasEverBeenMember(_arg_1:Boolean):void
        {
            this._clubHasEverBeenMember = _arg_1;
        }
        public function set isVIP(_arg_1:Boolean):void
        {
            this._isVIP = _arg_1;
        }
        public function set clubIsExpiring(_arg_1:Boolean):void
        {
            this._isExpiring = _arg_1;
        }
        public function get clubDays():int
        {
            return (this._clubDays);
        }
        public function get clubPeriods():int
        {
            return (this._clubPeriods);
        }
        public function get clubPastPeriods():int
        {
            return (this._clubPastPeriods);
        }
        public function get clubHasEverBeenMember():Boolean
        {
            return (this._clubHasEverBeenMember);
        }
        public function get isVIP():Boolean
        {
            return (this._isVIP);
        }
        public function get clubIsExpiring():Boolean
        {
            return (this._isExpiring);
        }

    }
}//package com.sulake.habbo.inventory.purse

// Purse = "_-M9" (String#8125, DoABC#2)
// _clubDays = "_-zt" (String#8881, DoABC#2)
// _clubPeriods = "_-0rC" (String#4666, DoABC#2)
// _clubPastPeriods = "_-1xZ" (String#18871, DoABC#2)
// _clubHasEverBeenMember = "_-27G" (String#19302, DoABC#2)
// _isVIP = "_-1HM" (String#1652, DoABC#2)
// _isExpiring = "_-0lo" (String#4542, DoABC#2)
// clubPastPeriods = "_-U4" (String#8286, DoABC#2)
// clubHasEverBeenMember = "_-2m" (String#7004, DoABC#2)
// isVIP = "_-3K4" (String#7705, DoABC#2)
// clubIsExpiring = "_-0Gw" (String#3893, DoABC#2)


