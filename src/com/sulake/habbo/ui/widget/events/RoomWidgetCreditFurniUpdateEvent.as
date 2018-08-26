
package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetCreditFurniUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const RWCFUE_CREDIT_FURNI_UPDATE:String = "RWCFUE_CREDIT_FURNI_UPDATE";

        private var _objectId:int;
        private var _creditValue:Number;

        public function RoomWidgetCreditFurniUpdateEvent(_arg_1:String, _arg_2:int, _arg_3:Number, _arg_4:Boolean=false, _arg_5:Boolean=false)
        {
            super(_arg_1, _arg_4, _arg_5);
            this._creditValue = _arg_3;
            this._objectId = _arg_2;
        }
        public function get creditValue():Number
        {
            return (this._creditValue);
        }
        public function get objectId():int
        {
            return (this._objectId);
        }

    }
}//package com.sulake.habbo.ui.widget.events

// _creditValue = "_-1-x" (String#16465, DoABC#2)
// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// RoomWidgetCreditFurniUpdateEvent = "_-2z4" (String#7265, DoABC#2)
// _objectId = "_-1YP" (String#18, DoABC#2)
// RWCFUE_CREDIT_FURNI_UPDATE = "_-1Xg" (String#17802, DoABC#2)
// creditValue = "_-3Aq" (String#21912, DoABC#2)


