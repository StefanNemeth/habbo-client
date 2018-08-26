
package com.sulake.habbo.communication.messages.incoming.users
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class HabboGroupDetailsData 
    {

        public static const _SafeStr_5510:int = 0;
        public static const _SafeStr_5511:int = 1;
        public static const _SafeStr_5512:int = 2;

        private var _groupId:int;
        private var _groupName:String;
        private var _description:String;
        private var _badgeCode:String;
        private var _roomId:int = -1;
        private var _roomName:String = "";
        private var _status:int;
        private var _totalMembers:int;
        private var _favourite:Boolean;

        public function HabboGroupDetailsData(_arg_1:IMessageDataWrapper)
        {
            this._groupId = _arg_1.readInteger();
            this._groupName = _arg_1.readString();
            this._description = _arg_1.readString();
            this._badgeCode = _arg_1.readString();
            this._roomId = _arg_1.readInteger();
            this._roomName = _arg_1.readString();
            this._status = _arg_1.readInteger();
            this._totalMembers = _arg_1.readInteger();
            this._favourite = _arg_1.readBoolean();
        }
        public function get groupId():int
        {
            return (this._groupId);
        }
        public function get groupName():String
        {
            return (this._groupName);
        }
        public function get description():String
        {
            return (this._description);
        }
        public function get badgeCode():String
        {
            return (this._badgeCode);
        }
        public function get roomId():int
        {
            return (this._roomId);
        }
        public function get roomName():String
        {
            return (this._roomName);
        }
        public function get status():int
        {
            return (this._status);
        }
        public function get totalMembers():int
        {
            return (this._totalMembers);
        }
        public function get favourite():Boolean
        {
            return (this._favourite);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.users

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// HabboGroupDetailsData = "_-13j" (String#16607, DoABC#2)
// _groupId = "_-nB" (String#641, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// readBoolean = "_-0ZR" (String#1499, DoABC#2)
// _status = "_-0kS" (String#126, DoABC#2)
// _badgeCode = "_-1MA" (String#1667, DoABC#2)
// badgeCode = "_-2XO" (String#20338, DoABC#2)
// _description = "_-1a7" (String#164, DoABC#2)
// _roomName = "_-bX" (String#253, DoABC#2)
// _SafeStr_5510 = "_-3EI" (String#22048, DoABC#2)
// _SafeStr_5511 = "_-0ID" (String#14766, DoABC#2)
// _SafeStr_5512 = "_-1KO" (String#17290, DoABC#2)
// _groupName = "_-G5" (String#7995, DoABC#2)
// _totalMembers = "_-1b0" (String#17934, DoABC#2)
// _favourite = "_-12f" (String#4928, DoABC#2)
// groupName = "_-2fN" (String#20663, DoABC#2)


