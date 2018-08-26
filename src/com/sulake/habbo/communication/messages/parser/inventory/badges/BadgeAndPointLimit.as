
package com.sulake.habbo.communication.messages.parser.inventory.badges
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class BadgeAndPointLimit 
    {

        private var _badgeId:String;
        private var _limit:int;

        public function BadgeAndPointLimit(_arg_1:String, _arg_2:IMessageDataWrapper)
        {
            this._badgeId = (("ACH_" + _arg_1) + _arg_2.readInteger());
            this._limit = _arg_2.readInteger();
        }
        public function get badgeId():String
        {
            return (this._badgeId);
        }
        public function get limit():int
        {
            return (this._limit);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.inventory.badges

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// BadgeAndPointLimit = "_-2-t" (String#19006, DoABC#2)
// _badgeId = "_-rf" (String#642, DoABC#2)
// badgeId = "_-g6" (String#23896, DoABC#2)
// _limit = "_-1nj" (String#1760, DoABC#2)


