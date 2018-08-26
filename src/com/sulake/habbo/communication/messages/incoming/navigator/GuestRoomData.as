
package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class GuestRoomData implements IDisposable 
    {

        private var _flatId:int;
        private var _event:Boolean;
        private var _roomName:String;
        private var _ownerName:String;
        private var _doorMode:int;
        private var _userCount:int;
        private var _maxUserCount:int;
        private var _description:String;
        private var _srchSpecPrm:int;
        private var _allowTrading:Boolean;
        private var _score:int;
        private var _categoryId:int;
        private var _eventCreationTime:String;
        private var _tags:Array;
        private var _thumbnail:RoomThumbnailData;
        private var _allowPets:Boolean;
        private var _displayRoomEntryAd:Boolean;
        private var _disposed:Boolean;

        public function GuestRoomData(_arg_1:IMessageDataWrapper)
        {
            var _local_4:String;
            this._tags = new Array();
            super();
            this._flatId = _arg_1.readInteger();
            this._event = _arg_1.readBoolean();
            this._roomName = _arg_1.readString();
            this._ownerName = _arg_1.readString();
            this._doorMode = _arg_1.readInteger();
            this._userCount = _arg_1.readInteger();
            this._maxUserCount = _arg_1.readInteger();
            this._description = _arg_1.readString();
            this._srchSpecPrm = _arg_1.readInteger();
            this._allowTrading = _arg_1.readBoolean();
            this._score = _arg_1.readInteger();
            this._categoryId = _arg_1.readInteger();
            this._eventCreationTime = _arg_1.readString();
            var _local_2:int = _arg_1.readInteger();
            var _local_3:int;
            while (_local_3 < _local_2) {
                _local_4 = _arg_1.readString();
                this._tags.push(_local_4);
                _local_3++;
            };
            this._thumbnail = new RoomThumbnailData(_arg_1);
            this._allowPets = _arg_1.readBoolean();
            this._displayRoomEntryAd = _arg_1.readBoolean();
        }
        public function dispose():void
        {
            if (this._disposed){
                return;
            };
            this._disposed = true;
            this._tags = null;
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function get flatId():int
        {
            return (this._flatId);
        }
        public function get event():Boolean
        {
            return (this._event);
        }
        public function get roomName():String
        {
            return (this._roomName);
        }
        public function get ownerName():String
        {
            return (this._ownerName);
        }
        public function get doorMode():int
        {
            return (this._doorMode);
        }
        public function get userCount():int
        {
            return (this._userCount);
        }
        public function get maxUserCount():int
        {
            return (this._maxUserCount);
        }
        public function get description():String
        {
            return (this._description);
        }
        public function get srchSpecPrm():int
        {
            return (this._srchSpecPrm);
        }
        public function get allowTrading():Boolean
        {
            return (this._allowTrading);
        }
        public function get score():int
        {
            return (this._score);
        }
        public function get categoryId():int
        {
            return (this._categoryId);
        }
        public function get eventCreationTime():String
        {
            return (this._eventCreationTime);
        }
        public function get tags():Array
        {
            return (this._tags);
        }
        public function get thumbnail():RoomThumbnailData
        {
            return (this._thumbnail);
        }
        public function get allowPets():Boolean
        {
            return (this._allowPets);
        }
        public function get displayRoomEntryAd():Boolean
        {
            return (this._displayRoomEntryAd);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.navigator

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// GuestRoomData = "_-06S" (String#3692, DoABC#2)
// RoomThumbnailData = "_-2bQ" (String#6781, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// readBoolean = "_-0ZR" (String#1499, DoABC#2)
// _tags = "_-1NU" (String#163, DoABC#2)
// userCount = "_-3Ez" (String#22075, DoABC#2)
// thumbnail = "_-02n" (String#14150, DoABC#2)
// flatId = "_-3CK" (String#21973, DoABC#2)
// doorMode = "_-2zu" (String#21456, DoABC#2)
// maxUserCount = "_-1O9" (String#17440, DoABC#2)
// ownerName = "_-1e1" (String#1730, DoABC#2)
// _description = "_-1a7" (String#164, DoABC#2)
// _doorMode = "_-83" (String#926, DoABC#2)
// _categoryId = "_-1If" (String#186, DoABC#2)
// _allowPets = "_-7k" (String#2056, DoABC#2)
// allowPets = "_-2Zu" (String#20436, DoABC#2)
// _roomName = "_-bX" (String#253, DoABC#2)
// _flatId = "_-2Al" (String#135, DoABC#2)
// allowTrading = "_-0ZL" (String#15416, DoABC#2)
// _userCount = "_-3Cp" (String#918, DoABC#2)
// _event = "_-3R" (String#2046, DoABC#2)
// _maxUserCount = "_-2a1" (String#20442, DoABC#2)
// _srchSpecPrm = "_-0-X" (String#14033, DoABC#2)
// _allowTrading = "_-2Pj" (String#6556, DoABC#2)
// _score = "_-2ca" (String#1911, DoABC#2)
// _eventCreationTime = "_-3BJ" (String#21936, DoABC#2)
// _thumbnail = "_-1ND" (String#17406, DoABC#2)
// _displayRoomEntryAd = "_-1qy" (String#18579, DoABC#2)
// srchSpecPrm = "_-3i" (String#22362, DoABC#2)
// eventCreationTime = "_-0mp" (String#15932, DoABC#2)
// displayRoomEntryAd = "_-2mS" (String#20938, DoABC#2)


