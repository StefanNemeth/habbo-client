
package com.sulake.habbo.communication.messages.parser.marketplace
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class MarketplaceConfigurationParser implements IMessageParser 
    {

        private var _isEnabled:Boolean;
        private var _commission:int;
        private var _tokenBatchPrice:int;
        private var _tokenBatchSize:int;
        private var _offerMaxPrice:int;
        private var _offerMinPrice:int;
        private var _expirationHours:int;
        private var _averagePricePeriod:int;

        public function get isEnabled():Boolean
        {
            return (this._isEnabled);
        }
        public function get commission():int
        {
            return (this._commission);
        }
        public function get tokenBatchPrice():int
        {
            return (this._tokenBatchPrice);
        }
        public function get tokenBatchSize():int
        {
            return (this._tokenBatchSize);
        }
        public function get offerMinPrice():int
        {
            return (this._offerMinPrice);
        }
        public function get offerMaxPrice():int
        {
            return (this._offerMaxPrice);
        }
        public function get expirationHours():int
        {
            return (this._expirationHours);
        }
        public function get averagePricePeriod():int
        {
            return (this._averagePricePeriod);
        }
        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._isEnabled = _arg_1.readBoolean();
            this._commission = _arg_1.readInteger();
            this._tokenBatchPrice = _arg_1.readInteger();
            this._tokenBatchSize = _arg_1.readInteger();
            this._offerMinPrice = _arg_1.readInteger();
            this._offerMaxPrice = _arg_1.readInteger();
            this._expirationHours = _arg_1.readInteger();
            this._averagePricePeriod = _arg_1.readInteger();
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.marketplace

// MarketplaceConfigurationParser = "_-0-L" (String#14026, DoABC#2)
// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// readBoolean = "_-0ZR" (String#1499, DoABC#2)
// isEnabled = "_-2ri" (String#21145, DoABC#2)
// _isEnabled = "_-2au" (String#895, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)
// _commission = "_-05d" (String#3678, DoABC#2)
// _tokenBatchPrice = "_-0eg" (String#4404, DoABC#2)
// _tokenBatchSize = "_-Jn" (String#8079, DoABC#2)
// _offerMaxPrice = "_-2RC" (String#6585, DoABC#2)
// _offerMinPrice = "_-0F" (String#3849, DoABC#2)
// _expirationHours = "_-1w7" (String#5961, DoABC#2)
// _averagePricePeriod = "_-2nH" (String#1940, DoABC#2)
// tokenBatchPrice = "_-wK" (String#24546, DoABC#2)
// tokenBatchSize = "_-2Aa" (String#19429, DoABC#2)
// offerMinPrice = "_-026" (String#14129, DoABC#2)
// offerMaxPrice = "_-2pR" (String#21056, DoABC#2)
// expirationHours = "_-0xj" (String#16342, DoABC#2)
// averagePricePeriod = "_-0lE" (String#4528, DoABC#2)


