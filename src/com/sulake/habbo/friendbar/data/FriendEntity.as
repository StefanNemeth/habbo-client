
package com.sulake.habbo.friendbar.data
{
    import __AS3__.vec.Vector;
    import __AS3__.vec.*;

    public class FriendEntity implements IFriendEntity 
    {

        private static var _SafeStr_10923:int = 0;

        private var _id:int;
        private var _name:String;
        private var _gender:int;
        private var _online:Boolean;
        private var _allowFollow:Boolean;
        private var _figure:String;
        private var _categoryId:int;
        private var _motto:String;
        private var _lastAccess:String;
        private var _realName:String;
        private var _HabboSoundManagerFlash10:Vector.<FriendNotification>;
        private var _logEventId:int = -1;

        public function FriendEntity(_arg_1:int, _arg_2:String, _arg_3:String, _arg_4:String, _arg_5:int, _arg_6:Boolean, _arg_7:Boolean, _arg_8:String, _arg_9:int, _arg_10:String)
        {
            this._id = _arg_1;
            this._name = _arg_2;
            this._realName = _arg_3;
            this._motto = _arg_4;
            this._gender = _arg_5;
            this._online = _arg_6;
            this._allowFollow = _arg_7;
            this._figure = _arg_8;
            this._categoryId = _arg_9;
            this._lastAccess = _arg_10;
        }
        public function get id():int
        {
            return (this._id);
        }
        public function get name():String
        {
            return (this._name);
        }
        public function get gender():int
        {
            return (this._gender);
        }
        public function get online():Boolean
        {
            return (this._online);
        }
        public function get allowFollow():Boolean
        {
            return (this._allowFollow);
        }
        public function get figure():String
        {
            return (this._figure);
        }
        public function get categoryId():int
        {
            return (this._categoryId);
        }
        public function get motto():String
        {
            return (this._motto);
        }
        public function get lastAccess():String
        {
            return (this._lastAccess);
        }
        public function get realName():String
        {
            return (this._realName);
        }
        public function get logEventId():int
        {
            return (this._logEventId);
        }
        public function get notifications():Vector.<FriendNotification>
        {
            if (!this._HabboSoundManagerFlash10){
                this._HabboSoundManagerFlash10 = new Vector.<FriendNotification>();
            };
            return (this._HabboSoundManagerFlash10);
        }
        public function set name(_arg_1:String):void
        {
            this._name = _arg_1;
        }
        public function set gender(_arg_1:int):void
        {
            this._gender = _arg_1;
        }
        public function set online(_arg_1:Boolean):void
        {
            this._online = _arg_1;
        }
        public function set allowFollow(_arg_1:Boolean):void
        {
            this._allowFollow = _arg_1;
        }
        public function set figure(_arg_1:String):void
        {
            this._figure = _arg_1;
        }
        public function set categoryId(_arg_1:int):void
        {
            this._categoryId = _arg_1;
        }
        public function set motto(_arg_1:String):void
        {
            this._motto = _arg_1;
        }
        public function set lastAccess(_arg_1:String):void
        {
            this._lastAccess = _arg_1;
        }
        public function set realName(_arg_1:String):void
        {
            this._realName = _arg_1;
        }
        public function set logEventId(_arg_1:int):void
        {
            this._logEventId = _arg_1;
        }
        public function IFriendEntity():int
        {
            return (++_SafeStr_10923);
        }

    }
}//package com.sulake.habbo.friendbar.data

// _lastAccess = "_-jH" (String#943, DoABC#2)
// lastAccess = "_-Es" (String#7968, DoABC#2)
// allowFollow = "_-1Va" (String#5466, DoABC#2)
// notifications = "_-1zJ" (String#1789, DoABC#2)
// logEventId = "_-Vm" (String#8316, DoABC#2)
// IFriendEntity = "_-0OK" (String#4053, DoABC#2)
// _SafeStr_10923 = "_-0Ap" (String#14481, DoABC#2)
// _HabboSoundManagerFlash10 = "_-ef" (String#940, DoABC#2)
// _logEventId = "_-1zR" (String#18945, DoABC#2)
// IFriendEntity = "_-2nQ" (String#7031, DoABC#2)
// FriendEntity = "_-0R1" (String#15104, DoABC#2)
// _gender = "_-a0" (String#95, DoABC#2)
// _motto = "_-2ti" (String#453, DoABC#2)
// _figure = "_-20u" (String#75, DoABC#2)
// realName = "_-3HH" (String#922, DoABC#2)
// _categoryId = "_-1If" (String#186, DoABC#2)
// _online = "_-0-Y" (String#573, DoABC#2)


