
package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetCreditFurniRedeemMessage extends RoomWidgetMessage 
    {

        public static const RWFCRM_REDEEM:String = "RWFCRM_REDEEM";

        private var _objectId:int;

        public function RoomWidgetCreditFurniRedeemMessage(_arg_1:String, _arg_2:int)
        {
            super(_arg_1);
            this._objectId = _arg_2;
        }
        public function get objectId():int
        {
            return (this._objectId);
        }

    }
}//package com.sulake.habbo.ui.widget.messages

// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// RoomWidgetCreditFurniRedeemMessage = "_-2oe" (String#7051, DoABC#2)
// _objectId = "_-1YP" (String#18, DoABC#2)
// RWFCRM_REDEEM = "_-27Y" (String#19313, DoABC#2)


