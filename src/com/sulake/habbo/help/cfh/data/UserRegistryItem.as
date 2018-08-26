
package com.sulake.habbo.help.cfh.data
{
    public class UserRegistryItem 
    {

        private var _userId:int;
        private var _userName:String = "";
        private var _roomName:String = "";

        public function UserRegistryItem(_arg_1:int, _arg_2:String, _arg_3:String="")
        {
            this._userId = _arg_1;
            this._userName = _arg_2;
            this._roomName = _arg_3;
        }
        public function get userId():int
        {
            return (this._userId);
        }
        public function get userName():String
        {
            return (this._userName);
        }
        public function get roomName():String
        {
            return (this._roomName);
        }
        public function set roomName(_arg_1:String):void
        {
            this._roomName = _arg_1;
        }

    }
}//package com.sulake.habbo.help.cfh.data

// UserRegistryItem = "_-27a" (String#6193, DoABC#2)
// _roomName = "_-bX" (String#253, DoABC#2)


