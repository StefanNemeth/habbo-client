
package com.sulake.habbo.communication.messages.parser.catalog
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.catalog.ClubOfferData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class HabboClubOffersMessageParser implements IMessageParser 
    {

        private var _offers:Array;

        public function flush():Boolean
        {
            this._offers = [];
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._offers = new Array();
            var _local_2:int = _arg_1.readInteger();
            var _local_3:int;
            while (_local_3 < _local_2) {
                this._offers.push(new ClubOfferData(_arg_1));
                _local_3++;
            };
            return (true);
        }
        public function get offers():Array
        {
            return (this._offers);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.catalog

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// ClubOfferData = "_-0TZ" (String#4170, DoABC#2)
// HabboClubOffersMessageParser = "_-254" (String#6142, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


