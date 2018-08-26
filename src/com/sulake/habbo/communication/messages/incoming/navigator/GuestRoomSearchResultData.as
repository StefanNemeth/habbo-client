
package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class GuestRoomSearchResultData implements IDisposable, MsgWithRequestId 
    {

        private var _searchType:int;
        private var _searchParam:String;
        private var _rooms:Array;
        private var _ad:OfficialRoomEntryData;
        private var _disposed:Boolean;

        public function GuestRoomSearchResultData(_arg_1:IMessageDataWrapper):void
        {
            this._rooms = new Array();
            super();
            this._searchType = _arg_1.readInteger();
            this._searchParam = _arg_1.readString();
            var _local_2:int = _arg_1.readInteger();
            var _local_3:int;
            while (_local_3 < _local_2) {
                this._rooms.push(new GuestRoomData(_arg_1));
                _local_3++;
            };
            var _local_4:Boolean = _arg_1.readBoolean();
            if (_local_4){
                this._ad = new OfficialRoomEntryData(_arg_1);
            };
        }
        public function dispose():void
        {
            var _local_1:GuestRoomData;
            if (this._disposed){
                return;
            };
            this._disposed = true;
            if (this._rooms != null){
                for each (_local_1 in this._rooms) {
                    _local_1.dispose();
                };
            };
            if (this._ad != null){
                this._ad.dispose();
                this._ad = null;
            };
            this._rooms = null;
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function get searchType():int
        {
            return (this._searchType);
        }
        public function get searchParam():String
        {
            return (this._searchParam);
        }
        public function get rooms():Array
        {
            return (this._rooms);
        }
        public function get ad():OfficialRoomEntryData
        {
            return (this._ad);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.navigator

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// GuestRoomData = "_-06S" (String#3692, DoABC#2)
// MsgWithRequestId = "_-1zv" (String#6029, DoABC#2)
// GuestRoomSearchResultData = "_-SV" (String#8256, DoABC#2)
// OfficialRoomEntryData = "_-0vy" (String#4767, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// readBoolean = "_-0ZR" (String#1499, DoABC#2)
// searchType = "_-2UR" (String#20218, DoABC#2)
// _rooms = "_-36o" (String#456, DoABC#2)
// _searchParam = "_-1-M" (String#16443, DoABC#2)
// _ad = "_-1En" (String#17060, DoABC#2)
// searchParam = "_-1jk" (String#18273, DoABC#2)
// ad = "_-9K" (String#22592, DoABC#2)


