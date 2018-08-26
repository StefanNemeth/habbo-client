
package com.sulake.habbo.communication.messages.parser.catalog
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class NotEnoughBalanceMessageParser implements IMessageParser 
    {

        private var _notEnoughCredits:int = 0;
        private var _notEnoughActivityPoints:int = 0;
        private var _activityPointType:int = 0;

        public function get notEnoughCredits():int
        {
            return (this._notEnoughCredits);
        }
        public function get notEnoughActivityPoints():int
        {
            return (this._notEnoughActivityPoints);
        }
        public function get activityPointType():int
        {
            return (this._activityPointType);
        }
        public function flush():Boolean
        {
            this._notEnoughCredits = 0;
            this._notEnoughActivityPoints = 0;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._notEnoughCredits = _arg_1.readInteger();
            this._notEnoughActivityPoints = _arg_1.readInteger();
            this._activityPointType = _arg_1.readInteger();
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.catalog

// notEnoughActivityPoints = "_-2kI" (String#20856, DoABC#2)
// _notEnoughCredits = "_-2G" (String#19643, DoABC#2)
// _notEnoughActivityPoints = "_-0yM" (String#16366, DoABC#2)
// NotEnoughBalanceMessageParser = "_-Oj" (String#8179, DoABC#2)
// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// _activityPointType = "_-1gC" (String#610, DoABC#2)
// activityPointType = "_-1gh" (String#5677, DoABC#2)
// notEnoughCredits = "_-0aV" (String#15455, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


