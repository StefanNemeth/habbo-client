
package com.sulake.habbo.session.events
{
    import com.sulake.habbo.session.IRoomSession;

    public class RoomSessionPresentEvent extends RoomSessionEvent 
    {

        public static const RSPE_PRESENT_OPENED:String = "RSPE_PRESENT_OPENED";

        private var _classId:int = 0;
        private var _itemType:String = "";
        private var _productCode:String;

        public function RoomSessionPresentEvent(_arg_1:String, _arg_2:IRoomSession, _arg_3:int, _arg_4:String, _arg_5:String, _arg_6:Boolean=false, _arg_7:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_6, _arg_7);
            this._classId = _arg_3;
            this._itemType = _arg_4;
            this._productCode = _arg_5;
        }
        public function get classId():int
        {
            return (this._classId);
        }
        public function get itemType():String
        {
            return (this._itemType);
        }
        public function get productCode():String
        {
            return (this._productCode);
        }

    }
}//package com.sulake.habbo.session.events

// IRoomSession = "_-2e4" (String#6835, DoABC#2)
// RoomSessionPresentEvent = "_-30Q" (String#7312, DoABC#2)
// _itemType = "_-0dA" (String#242, DoABC#2)
// _classId = "_-172" (String#597, DoABC#2)
// itemType = "_-De" (String#22756, DoABC#2)
// classId = "_-1mV" (String#18401, DoABC#2)
// RSPE_PRESENT_OPENED = "_-1eK" (String#18071, DoABC#2)
// _productCode = "_-uv" (String#312, DoABC#2)
// productCode = "_-2co" (String#20558, DoABC#2)


