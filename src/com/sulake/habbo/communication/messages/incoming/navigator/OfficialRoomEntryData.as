
package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class OfficialRoomEntryData implements IDisposable 
    {

        public static const _SafeStr_6503:int = 1;
        public static const _SafeStr_4125:int = 2;
        public static const _SafeStr_4124:int = 3;
        public static const _SafeStr_4116:int = 4;

        private var _index:int;
        private var _popupCaption:String;
        private var _popupDesc:String;
        private var _showDetails:Boolean;
        private var _picText:String;
        private var _picRef:String;
        private var _folderId:int;
        private var _userCount:int;
        private var _type:int;
        private var _tag:String;
        private var _guestRoomData:GuestRoomData;
        private var _publicRoomData:PublicRoomData;
        private var _open:Boolean;
        private var _disposed:Boolean;

        public function OfficialRoomEntryData(_arg_1:IMessageDataWrapper)
        {
            this._index = _arg_1.readInteger();
            this._popupCaption = _arg_1.readString();
            this._popupDesc = _arg_1.readString();
            this._showDetails = (_arg_1.readInteger() == 1);
            this._picText = _arg_1.readString();
            this._picRef = _arg_1.readString();
            this._folderId = _arg_1.readInteger();
            this._userCount = _arg_1.readInteger();
            this._type = _arg_1.readInteger();
            if (this._type == _SafeStr_6503){
                this._tag = _arg_1.readString();
            }
            else {
                if (this._type == _SafeStr_4124){
                    this._publicRoomData = new PublicRoomData(_arg_1);
                }
                else {
                    if (this._type == _SafeStr_4125){
                        this._guestRoomData = new GuestRoomData(_arg_1);
                    }
                    else {
                        this._open = _arg_1.readBoolean();
                    };
                };
            };
        }
        public function dispose():void
        {
            if (this._disposed){
                return;
            };
            this._disposed = true;
            if (this._guestRoomData != null){
                this._guestRoomData.dispose();
                this._guestRoomData = null;
            };
            if (this._publicRoomData != null){
                this._publicRoomData.dispose();
                this._publicRoomData = null;
            };
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function get type():int
        {
            return (this._type);
        }
        public function get index():int
        {
            return (this._index);
        }
        public function get popupCaption():String
        {
            return (this._popupCaption);
        }
        public function get popupDesc():String
        {
            return (this._popupDesc);
        }
        public function get QuestDetails():Boolean
        {
            return (this._showDetails);
        }
        public function get picText():String
        {
            return (this._picText);
        }
        public function get picRef():String
        {
            return (this._picRef);
        }
        public function get folderId():int
        {
            return (this._folderId);
        }
        public function get tag():String
        {
            return (this._tag);
        }
        public function get userCount():int
        {
            return (this._userCount);
        }
        public function get guestRoomData():GuestRoomData
        {
            return (this._guestRoomData);
        }
        public function get publicRoomData():PublicRoomData
        {
            return (this._publicRoomData);
        }
        public function get open():Boolean
        {
            return (this._open);
        }
        public function OfficialRoomEntryData():void
        {
            this._open = !(this._open);
        }
        public function get maxUsers():int
        {
            if (this.type == _SafeStr_6503){
                return (0);
            };
            if (this.type == _SafeStr_4125){
                return (this._guestRoomData.maxUserCount);
            };
            if (this.type == _SafeStr_4124){
                return (this._publicRoomData.maxUsers);
            };
            return (0);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.navigator

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// GuestRoomData = "_-06S" (String#3692, DoABC#2)
// OfficialRoomEntryData = "_-0vy" (String#4767, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// PublicRoomData = "_-3Dv" (String#920, DoABC#2)
// _tag = "_-1Gy" (String#601, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// readBoolean = "_-0ZR" (String#1499, DoABC#2)
// _SafeStr_4116 = "_-0nP" (String#15953, DoABC#2)
// popupCaption = "_-041" (String#14202, DoABC#2)
// _SafeStr_4124 = "_-2JO" (String#19784, DoABC#2)
// _SafeStr_4125 = "_-0Hh" (String#14744, DoABC#2)
// QuestDetails = "_-3H6" (String#7649, DoABC#2)
// maxUsers = "_-Rs" (String#23320, DoABC#2)
// userCount = "_-3Ez" (String#22075, DoABC#2)
// guestRoomData = "_-ab" (String#23656, DoABC#2)
// OfficialRoomEntryData = "_-1d6" (String#18017, DoABC#2)
// popupDesc = "_-204" (String#19013, DoABC#2)
// maxUserCount = "_-1O9" (String#17440, DoABC#2)
// folderId = "_-1uf" (String#18744, DoABC#2)
// _picRef = "_-2bD" (String#6775, DoABC#2)
// _userCount = "_-3Cp" (String#918, DoABC#2)
// _SafeStr_6503 = "_-0M7" (String#14920, DoABC#2)
// _popupCaption = "_-23p" (String#19170, DoABC#2)
// _popupDesc = "_-EA" (String#22778, DoABC#2)
// _showDetails = "_-1Ng" (String#17423, DoABC#2)
// _picText = "_-xe" (String#24595, DoABC#2)
// _folderId = "_-wf" (String#24556, DoABC#2)
// _guestRoomData = "_-5C" (String#22429, DoABC#2)
// _publicRoomData = "_-1hl" (String#18201, DoABC#2)


