
package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetTeaserDataUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const RWTDUE_TEASER_DATA:String = "RWTDUE_TEASER_DATA";
        public static const RWTDUE_GIFT_DATA:String = "RWTDUE_GIFT_DATA";
        public static const RWTDUE_GIFT_RECEIVED:String = "RWTDUE_GIFT_RECEIVED";

        private var _objectId:int;
        private var _data:String;
        private var _status:int;
        private var _campaignID:String;
        private var _firstClickUserName:String;
        private var _giftWasReceived:Boolean;
        private var _itemCategory:int = 0;
        private var _ownRealName:String;

        public function RoomWidgetTeaserDataUpdateEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_3);
        }
        public function get objectId():int
        {
            return (this._objectId);
        }
        public function get data():String
        {
            return (this._data);
        }
        public function get status():int
        {
            return (this._status);
        }
        public function get firstClickUserName():String
        {
            return (this._firstClickUserName);
        }
        public function get giftWasReceived():Boolean
        {
            return (this._giftWasReceived);
        }
        public function get ownRealName():String
        {
            return (this._ownRealName);
        }
        public function get itemCategory():int
        {
            return (this._itemCategory);
        }
        public function set status(_arg_1:int):void
        {
            this._status = _arg_1;
        }
        public function set data(_arg_1:String):void
        {
            this._data = _arg_1;
        }
        public function set firstClickUserName(_arg_1:String):void
        {
            this._firstClickUserName = _arg_1;
        }
        public function set giftWasReceived(_arg_1:Boolean):void
        {
            this._giftWasReceived = _arg_1;
        }
        public function set ownRealName(_arg_1:String):void
        {
            this._ownRealName = _arg_1;
        }
        public function set objectId(_arg_1:int):void
        {
            this._objectId = _arg_1;
        }
        public function get campaignID():String
        {
            return (this._campaignID);
        }
        public function set campaignID(_arg_1:String):void
        {
            this._campaignID = _arg_1;
        }
        public function set itemCategory(_arg_1:int):void
        {
            this._itemCategory = _arg_1;
        }

    }
}//package com.sulake.habbo.ui.widget.events

// _ownRealName = "_-C0" (String#22691, DoABC#2)
// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// RoomWidgetTeaserDataUpdateEvent = "_-Cu" (String#7931, DoABC#2)
// _objectId = "_-1YP" (String#18, DoABC#2)
// _status = "_-0kS" (String#126, DoABC#2)
// _campaignID = "_-eQ" (String#639, DoABC#2)
// _firstClickUserName = "_-1Cl" (String#838, DoABC#2)
// _giftWasReceived = "_-TN" (String#2114, DoABC#2)
// _itemCategory = "_-0MW" (String#814, DoABC#2)
// firstClickUserName = "_-0jN" (String#15804, DoABC#2)
// giftWasReceived = "_-1AI" (String#16872, DoABC#2)
// itemCategory = "_-3Bq" (String#21955, DoABC#2)
// campaignID = "_-09Z" (String#14429, DoABC#2)
// RWTDUE_TEASER_DATA = "_-0sx" (String#16159, DoABC#2)
// RWTDUE_GIFT_DATA = "_-3G0" (String#22116, DoABC#2)
// RWTDUE_GIFT_RECEIVED = "_-io" (String#23991, DoABC#2)
// ownRealName = "_-ZW" (String#23616, DoABC#2)


