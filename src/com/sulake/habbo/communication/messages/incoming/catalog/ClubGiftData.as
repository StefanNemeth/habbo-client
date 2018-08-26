
package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ClubGiftData 
    {

        private var _offerId:int;
        private var _isVip:Boolean;
        private var _isSelectable:Boolean;
        private var _daysRequired:int;

        public function ClubGiftData(_arg_1:IMessageDataWrapper)
        {
            this._offerId = _arg_1.readInteger();
            this._isVip = _arg_1.readBoolean();
            this._daysRequired = _arg_1.readInteger();
            this._isSelectable = _arg_1.readBoolean();
        }
        public function get offerId():int
        {
            return (this._offerId);
        }
        public function get isVip():Boolean
        {
            return (this._isVip);
        }
        public function get isSelectable():Boolean
        {
            return (this._isSelectable);
        }
        public function get daysRequired():int
        {
            return (this._daysRequired);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.catalog

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// ClubGiftData = "_-2Io" (String#6416, DoABC#2)
// readBoolean = "_-0ZR" (String#1499, DoABC#2)
// _offerId = "_-0i7" (String#125, DoABC#2)
// offerId = "_-9g" (String#928, DoABC#2)
// _isVip = "_-1cX" (String#17991, DoABC#2)
// _isSelectable = "_-t7" (String#947, DoABC#2)
// _daysRequired = "_-1rS" (String#18604, DoABC#2)
// isVip = "_-082" (String#14368, DoABC#2)
// isSelectable = "_-30A" (String#1985, DoABC#2)
// daysRequired = "_-hE" (String#23939, DoABC#2)


