
package com.sulake.habbo.communication.messages.incoming.users
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class HabboGroupEntryData 
    {

        private var _groupId:int;
        private var _groupName:String;
        private var _badgeCode:String;
        private var _favourite:Boolean;

        public function HabboGroupEntryData(_arg_1:IMessageDataWrapper)
        {
            this._groupId = _arg_1.readInteger();
            this._groupName = _arg_1.readString();
            this._badgeCode = _arg_1.readString();
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
        public function get badgeCode():String
        {
            return (this._badgeCode);
        }
        public function get favourite():Boolean
        {
            return (this._favourite);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.users

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// HabboGroupEntryData = "_-sd" (String#24384, DoABC#2)
// _groupId = "_-nB" (String#641, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// readBoolean = "_-0ZR" (String#1499, DoABC#2)
// _badgeCode = "_-1MA" (String#1667, DoABC#2)
// badgeCode = "_-2XO" (String#20338, DoABC#2)
// _groupName = "_-G5" (String#7995, DoABC#2)
// _favourite = "_-12f" (String#4928, DoABC#2)
// groupName = "_-2fN" (String#20663, DoABC#2)


