
package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ChargeInfo 
    {

        private var _stuffId:int;
        private var _charges:int;
        private var _priceInCredits:int;
        private var _priceInActivityPoints:int;
        private var _activityPointType:int;
        private var _chargePatchSize:int;

        public function ChargeInfo(_arg_1:IMessageDataWrapper)
        {
            this._stuffId = _arg_1.readInteger();
            this._charges = _arg_1.readInteger();
            this._priceInCredits = _arg_1.readInteger();
            this._priceInActivityPoints = _arg_1.readInteger();
            this._activityPointType = _arg_1.readInteger();
            this._chargePatchSize = _arg_1.readInteger();
        }
        public function get stuffId():int
        {
            return (this._stuffId);
        }
        public function get charges():int
        {
            return (this._charges);
        }
        public function get priceInCredits():int
        {
            return (this._priceInCredits);
        }
        public function get priceInActivityPoints():int
        {
            return (this._priceInActivityPoints);
        }
        public function get chargePatchSize():int
        {
            return (this._chargePatchSize);
        }
        public function get activityPointType():int
        {
            return (this._activityPointType);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.catalog

// ChargeInfo = "_-1bU" (String#5587, DoABC#2)
// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// _priceInCredits = "_-29s" (String#1823, DoABC#2)
// _priceInActivityPoints = "_-2WT" (String#1892, DoABC#2)
// _activityPointType = "_-1gC" (String#610, DoABC#2)
// priceInCredits = "_-0Is" (String#3931, DoABC#2)
// priceInActivityPoints = "_-0HW" (String#3908, DoABC#2)
// activityPointType = "_-1gh" (String#5677, DoABC#2)
// _stuffId = "_-0wq" (String#4787, DoABC#2)
// chargePatchSize = "_-pz" (String#24273, DoABC#2)
// _charges = "_-0nO" (String#15952, DoABC#2)
// _chargePatchSize = "_-2PW" (String#20024, DoABC#2)


