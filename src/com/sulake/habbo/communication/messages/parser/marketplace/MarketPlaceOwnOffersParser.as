
package com.sulake.habbo.communication.messages.parser.marketplace
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.marketplace.MarketPlaceOffer;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class MarketPlaceOwnOffersParser implements IMessageParser 
    {

        private const _SafeStr_8269:int = 500;

        private var _offers:Array;
        private var _creditsWaiting:int;

        public function flush():Boolean
        {
            this._offers = null;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_2:int;
            var _local_3:int;
            var _local_4:int;
            var _local_5:int;
            var _local_6:String;
            var _local_7:int;
            var _local_8:int;
            var _local_9:int;
            var _local_12:MarketPlaceOffer;
            this._offers = new Array();
            this._creditsWaiting = _arg_1.readInteger();
            var _local_10:int = _arg_1.readInteger();
            var _local_11:int;
            while (_local_11 < _local_10) {
                _local_2 = _arg_1.readInteger();
                _local_3 = _arg_1.readInteger();
                _local_4 = _arg_1.readInteger();
                _local_5 = _arg_1.readInteger();
                _local_6 = _arg_1.readString();
                _local_7 = _arg_1.readInteger();
                _local_8 = _arg_1.readInteger();
                _local_9 = _arg_1.readInteger();
                _local_12 = new MarketPlaceOffer(_local_2, _local_5, _local_4, _local_6, _local_7, _local_3, _local_8, _local_9);
                if (_local_11 < this._SafeStr_8269){
                    this._offers.push(_local_12);
                };
                _local_11++;
            };
            return (true);
        }
        public function get offers():Array
        {
            return (this._offers);
        }
        public function get creditsWaiting():int
        {
            return (this._creditsWaiting);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.marketplace

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// MarketPlaceOwnOffersParser = "_-mo" (String#8656, DoABC#2)
// MarketPlaceOffer = "_-1BB" (String#5098, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)
// _SafeStr_8269 = "_-1bv" (String#5597, DoABC#2)
// _creditsWaiting = "_-1BM" (String#5102, DoABC#2)
// creditsWaiting = "_-1Ru" (String#5396, DoABC#2)


