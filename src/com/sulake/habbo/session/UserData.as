
package com.sulake.habbo.session
{
    public class UserData implements IUserData 
    {

        private var _id:int = -1;
        private var _name:String = "";
        private var _type:int = 0;
        private var _sex:String = "";
        private var _figure:String = "";
        private var _custom:String = "";
        private var _achievementScore:int;
        private var _webID:int = 0;
        private var _groupID:String = "";
        private var _groupStatus:int = 0;
        private var _xp:int = 0;

        public function UserData(_arg_1:int)
        {
            this._id = _arg_1;
        }
        public function get id():int
        {
            return (this._id);
        }
        public function get achievementScore():int
        {
            return (this._achievementScore);
        }
        public function set achievementScore(_arg_1:int):void
        {
            this._achievementScore = _arg_1;
        }
        public function get name():String
        {
            return (this._name);
        }
        public function set name(_arg_1:String):void
        {
            this._name = _arg_1;
        }
        public function get type():int
        {
            return (this._type);
        }
        public function set type(_arg_1:int):void
        {
            this._type = _arg_1;
        }
        public function get sex():String
        {
            return (this._sex);
        }
        public function set sex(_arg_1:String):void
        {
            this._sex = _arg_1;
        }
        public function get figure():String
        {
            return (this._figure);
        }
        public function set figure(_arg_1:String):void
        {
            this._figure = _arg_1;
        }
        public function get custom():String
        {
            return (this._custom);
        }
        public function set custom(_arg_1:String):void
        {
            this._custom = _arg_1;
        }
        public function get webID():int
        {
            return (this._webID);
        }
        public function set webID(_arg_1:int):void
        {
            this._webID = _arg_1;
        }
        public function get groupID():String
        {
            return (this._groupID);
        }
        public function set groupID(_arg_1:String):void
        {
            this._groupID = _arg_1;
        }
        public function get groupStatus():int
        {
            return (this._groupStatus);
        }
        public function set groupStatus(_arg_1:int):void
        {
            this._groupStatus = _arg_1;
        }
        public function get xp():int
        {
            return (this._xp);
        }
        public function set xp(_arg_1:int):void
        {
            this._xp = _arg_1;
        }

    }
}//package com.sulake.habbo.session

// IUserData = "_-0n7" (String#4570, DoABC#2)
// UserData = "_-2Mt" (String#19922, DoABC#2)
// custom = "_-1sW" (String#5894, DoABC#2)
// webID = "_-2uI" (String#7166, DoABC#2)
// sex = "_-0tG" (String#4712, DoABC#2)
// groupID = "_-37J" (String#7452, DoABC#2)
// groupStatus = "_-1Sq" (String#5411, DoABC#2)
// achievementScore = "_-16Z" (String#5005, DoABC#2)
// _figure = "_-20u" (String#75, DoABC#2)
// _sex = "_-1uF" (String#870, DoABC#2)
// _achievementScore = "_-2Iu" (String#449, DoABC#2)
// _custom = "_-0pL" (String#4620, DoABC#2)
// _webID = "_-1Ez" (String#1639, DoABC#2)
// _groupID = "_-2b1" (String#6773, DoABC#2)
// _groupStatus = "_-1FO" (String#5162, DoABC#2)
// _xp = "_-0GE" (String#1441, DoABC#2)


