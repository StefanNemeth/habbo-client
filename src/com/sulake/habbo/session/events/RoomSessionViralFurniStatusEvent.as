
package com.sulake.habbo.session.events
{
    import com.sulake.habbo.session.IRoomSession;

    public class RoomSessionViralFurniStatusEvent extends RoomSessionEvent 
    {

        public static const RSVFS_STATUS:String = "RSVFS_STATUS";
        public static const RSVFS_RECEIVED:String = "RSVFS_RECEIVED";

        private var _campaignID:String;
        private var _objectId:int;
        private var _status:int = -1;
        private var _shareId:String;
        private var _firstClickUserName:String;
        private var _giftWasReceived:Boolean;
        private var _itemCategory:int = 0;

        public function RoomSessionViralFurniStatusEvent(_arg_1:String, _arg_2:IRoomSession, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
            this._status = this.status;
            this._shareId = this.shareId;
        }
        public function get objectId():int
        {
            return (this._objectId);
        }
        public function get status():int
        {
            return (this._status);
        }
        public function get shareId():String
        {
            return (this._shareId);
        }
        public function get firstClickUserName():String
        {
            return (this._firstClickUserName);
        }
        public function get giftWasReceived():Boolean
        {
            return (this._giftWasReceived);
        }
        public function get itemCategory():int
        {
            return (this._itemCategory);
        }
        public function set objectId(_arg_1:int):void
        {
            this._objectId = _arg_1;
        }
        public function set status(_arg_1:int):void
        {
            this._status = _arg_1;
        }
        public function set shareId(_arg_1:String):void
        {
            this._shareId = _arg_1;
        }
        public function set firstClickUserName(_arg_1:String):void
        {
            this._firstClickUserName = _arg_1;
        }
        public function set giftWasReceived(_arg_1:Boolean):void
        {
            this._giftWasReceived = _arg_1;
        }
        public function set itemCategory(_arg_1:int):void
        {
            this._itemCategory = _arg_1;
        }
        public function get campaignID():String
        {
            return (this._campaignID);
        }
        public function set campaignID(_arg_1:String):void
        {
            this._campaignID = _arg_1;
        }

    }
}//package com.sulake.habbo.session.events

// IRoomSession = "_-2e4" (String#6835, DoABC#2)
// RoomSessionViralFurniStatusEvent = "_-2OF" (String#6524, DoABC#2)
// _objectId = "_-1YP" (String#18, DoABC#2)
// _status = "_-0kS" (String#126, DoABC#2)
// RSVFS_STATUS = "_-W" (String#23492, DoABC#2)
// RSVFS_RECEIVED = "_-3n" (String#22366, DoABC#2)
// _campaignID = "_-eQ" (String#639, DoABC#2)
// _firstClickUserName = "_-1Cl" (String#838, DoABC#2)
// _giftWasReceived = "_-TN" (String#2114, DoABC#2)
// _itemCategory = "_-0MW" (String#814, DoABC#2)
// shareId = "_-0L" (String#14876, DoABC#2)
// firstClickUserName = "_-0jN" (String#15804, DoABC#2)
// giftWasReceived = "_-1AI" (String#16872, DoABC#2)
// itemCategory = "_-3Bq" (String#21955, DoABC#2)
// campaignID = "_-09Z" (String#14429, DoABC#2)


