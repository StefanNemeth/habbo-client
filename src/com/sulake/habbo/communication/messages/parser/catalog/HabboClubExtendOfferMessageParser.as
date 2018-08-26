
package com.sulake.habbo.communication.messages.parser.catalog
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.catalog.ClubOfferExtendData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class HabboClubExtendOfferMessageParser implements IMessageParser 
    {

        private var _offer:ClubOfferExtendData;

        public function flush():Boolean
        {
            this._offer = null;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._offer = new ClubOfferExtendData(_arg_1);
            return (true);
        }
        public function offer():ClubOfferExtendData
        {
            return (this._offer);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.catalog

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// HabboClubExtendOfferMessageParser = "_-0BJ" (String#3785, DoABC#2)
// _offer = "_-1jb" (String#165, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


