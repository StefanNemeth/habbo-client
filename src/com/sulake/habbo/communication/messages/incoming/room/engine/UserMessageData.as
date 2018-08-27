
package com.sulake.habbo.communication.messages.incoming.room.engine
{
    public class UserMessageData 
    {

        public static const M:String = "M";
        public static const F:String = "F";

        private var _id:int = 0;
        private var _x:Number = 0;
        private var _y:Number = 0;
        private var _z:Number = 0;
        private var _dir:int = 0;
        private var _name:String = "";
        private var _userType:int = 0;
        private var _sex:String = "";
        private var _figure:String = "";
        private var _custom:String = "";
        private var _achievementScore:int;
        private var _webID:int = 0;
        private var _groupID:String = "";
        private var _groupStatus:int = 0;
        private var _xp:int = 0;
        private var _subType:String = "";
        private var _SafeStr_4520:Boolean = false;

        public function UserMessageData(_arg_1:int)
        {
            this._id = _arg_1;
        }
        public function setReadOnly():void
        {
            this._SafeStr_4520 = true;
        }
        public function get id():int
        {
            return (this._id);
        }
        public function get x():Number
        {
            return (this._x);
        }
        public function set x(_arg_1:Number):void
        {
            if (!this._SafeStr_4520){
                this._x = _arg_1;
            };
        }
        public function get y():Number
        {
            return (this._y);
        }
        public function set y(_arg_1:Number):void
        {
            if (!this._SafeStr_4520){
                this._y = _arg_1;
            };
        }
        public function get z():Number
        {
            return (this._z);
        }
        public function set z(_arg_1:Number):void
        {
            if (!this._SafeStr_4520){
                this._z = _arg_1;
            };
        }
        public function get dir():int
        {
            return (this._dir);
        }
        public function set dir(_arg_1:int):void
        {
            if (!this._SafeStr_4520){
                this._dir = _arg_1;
            };
        }
        public function get name():String
        {
            return (this._name);
        }
        public function set name(_arg_1:String):void
        {
            if (!this._SafeStr_4520){
                this._name = _arg_1;
            };
        }
        public function get userType():int
        {
            return (this._userType);
        }
        public function set userType(_arg_1:int):void
        {
            if (!this._SafeStr_4520){
                this._userType = _arg_1;
            };
        }
        public function get sex():String
        {
            return (this._sex);
        }
        public function set sex(_arg_1:String):void
        {
            if (!this._SafeStr_4520){
                this._sex = _arg_1;
            };
        }
        public function get figure():String
        {
            return (this._figure);
        }
        public function set figure(_arg_1:String):void
        {
            if (!this._SafeStr_4520){
                this._figure = _arg_1;
            };
        }
        public function get custom():String
        {
            return (this._custom);
        }
        public function set custom(_arg_1:String):void
        {
            if (!this._SafeStr_4520){
                this._custom = _arg_1;
            };
        }
        public function get achievementScore():int
        {
            return (this._achievementScore);
        }
        public function set achievementScore(_arg_1:int):void
        {
            if (!this._SafeStr_4520){
                this._achievementScore = _arg_1;
            };
        }
        public function get webID():int
        {
            return (this._webID);
        }
        public function set webID(_arg_1:int):void
        {
            if (!this._SafeStr_4520){
                this._webID = _arg_1;
            };
        }
        public function get groupID():String
        {
            return (this._groupID);
        }
        public function set groupID(_arg_1:String):void
        {
            if (!this._SafeStr_4520){
                this._groupID = _arg_1;
            };
        }
        public function get groupStatus():int
        {
            return (this._groupStatus);
        }
        public function set groupStatus(_arg_1:int):void
        {
            if (!this._SafeStr_4520){
                this._groupStatus = _arg_1;
            };
        }
        public function get xp():int
        {
            return (this._xp);
        }
        public function set xp(_arg_1:int):void
        {
            if (!this._SafeStr_4520){
                this._xp = _arg_1;
            };
        }
        public function get subType():String
        {
            return (this._subType);
        }
        public function set subType(_arg_1:String):void
        {
            if (!this._SafeStr_4520){
                this._subType = _arg_1;
            };
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.engine

// UserMessageData = "_-0WX" (String#4238, DoABC#2)
// _userType = "_-1N3" (String#1672, DoABC#2)
// userType = "_-0Dh" (String#14596, DoABC#2)
// setReadOnly = "_-5p" (String#22456, DoABC#2)
// custom = "_-1sW" (String#5894, DoABC#2)
// webID = "_-2uI" (String#7166, DoABC#2)
// sex = "_-0tG" (String#4712, DoABC#2)
// groupID = "_-37J" (String#7452, DoABC#2)
// groupStatus = "_-1Sq" (String#5411, DoABC#2)
// achievementScore = "_-16Z" (String#5005, DoABC#2)
// subType = "_-uO" (String#24467, DoABC#2)
// M = "_-1Tr" (String#17660, DoABC#2)
// F = "_-2bz" (String#20522, DoABC#2)
// _figure = "_-20u" (String#75, DoABC#2)
// _sex = "_-1uF" (String#870, DoABC#2)
// _achievementScore = "_-2Iu" (String#449, DoABC#2)
// _y = "_-02f" (String#64, DoABC#2)
// _dir = "_-1kY" (String#187, DoABC#2)
// _SafeStr_4520 = "_-18k" (String#440, DoABC#2)
// _z = "_-0kf" (String#215, DoABC#2)
// _custom = "_-0pL" (String#4620, DoABC#2)
// _webID = "_-1Ez" (String#1639, DoABC#2)
// _groupID = "_-2b1" (String#6773, DoABC#2)
// _groupStatus = "_-1FO" (String#5162, DoABC#2)
// _xp = "_-0GE" (String#1441, DoABC#2)
// _subType = "_-1w8" (String#18803, DoABC#2)


