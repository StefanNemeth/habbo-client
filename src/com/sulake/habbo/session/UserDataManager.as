
package com.sulake.habbo.session
{
    import com.sulake.core.utils.Map;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.communication.messages.outgoing.users.GetSelectedBadgesMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.pets.GetPetInfoMessageComposer;

    public class UserDataManager implements IUserDataManager 
    {

        private static const _SafeStr_13654:int = 1;
        private static const _SafeStr_13655:int = 2;
        private static const _SafeStr_13656:int = 3;

        private var _SafeStr_13657:Map;
        private var _userDataByIds:Map;
        private var _SafeStr_13658:Map;
        private var _connection:IConnection;

        public function UserDataManager()
        {
            this._SafeStr_13657 = new Map();
            this._userDataByIds = new Map();
            this._SafeStr_13658 = new Map();
        }
        public function dispose():void
        {
            this._connection = null;
            this._SafeStr_13657.dispose();
            this._SafeStr_13657 = null;
            this._userDataByIds.dispose();
            this._userDataByIds = null;
            this._SafeStr_13658.dispose();
            this._SafeStr_13658 = null;
        }
        public function set connection(_arg_1:IConnection):void
        {
            this._connection = _arg_1;
        }
        public function getUserData(_arg_1:int):IUserData
        {
            return (this.getUserDataByType(_arg_1, _SafeStr_13654));
        }
        public function getUserDataByType(_arg_1:int, _arg_2:int):IUserData
        {
            var _local_3:IUserData;
            var _local_4:Map = this._SafeStr_13657.getValue(_arg_2);
            if (_local_4 != null){
                _local_3 = _local_4.getValue(_arg_1);
            };
            return (_local_3);
        }
        public function getUserDataByIndex(_arg_1:int):IUserData
        {
            return (this._userDataByIds.getValue(_arg_1));
        }
        public function getUserBadges(_arg_1:int):Array
        {
            if (this._connection != null){
                this._connection.send(new GetSelectedBadgesMessageComposer(_arg_1));
            };
            var _local_2:Array = (this._SafeStr_13658.getValue(_arg_1) as Array);
            if (_local_2 == null){
                _local_2 = [];
            };
            return (_local_2);
        }
        public function setUserData(_arg_1:IUserData):void
        {
            if (_arg_1 == null){
                return;
            };
            this.removeUserDataByIndex(_arg_1.id);
            var _local_2:Map = this._SafeStr_13657.getValue(_arg_1.type);
            if (_local_2 == null){
                _local_2 = new Map();
                this._SafeStr_13657.add(_arg_1.type, _local_2);
            };
            _local_2.add(_arg_1.webID, _arg_1);
            this._userDataByIds.add(_arg_1.id, _arg_1);
        }
        public function removeUserDataByIndex(_arg_1:int):void
        {
            var _local_3:Map;
            var _local_4:IUserData;
            var _local_2:IUserData = this._userDataByIds.remove(_arg_1);
            if (_local_2 != null){
                _local_3 = this._SafeStr_13657.getValue(_local_2.type);
                if (_local_3 != null){
                    _local_4 = _local_3.remove(_local_2.webID);
                    if (_local_4 != null){
                    };
                };
            };
        }
        public function setUserBadges(_arg_1:int, _arg_2:Array):void
        {
            this._SafeStr_13658.remove(_arg_1);
            this._SafeStr_13658.add(_arg_1, _arg_2);
        }
        public function updateFigure(_arg_1:int, _arg_2:String, _arg_3:String):void
        {
            var _local_4:IUserData = this.getUserDataByIndex(_arg_1);
            if (_local_4 != null){
                _local_4.figure = _arg_2;
                _local_4.sex = _arg_3;
            };
        }
        public function updateCustom(_arg_1:int, _arg_2:String):void
        {
            var _local_3:IUserData = this.getUserDataByIndex(_arg_1);
            if (_local_3 != null){
                _local_3.custom = _arg_2;
            };
        }
        public function updateAchievementScore(_arg_1:int, _arg_2:int):void
        {
            var _local_3:IUserData = this.getUserDataByIndex(_arg_1);
            if (_local_3 != null){
                _local_3.achievementScore = _arg_2;
            };
        }
        public function updateNameByIndex(_arg_1:int, _arg_2:String):void
        {
            var _local_3:IUserData = this.getUserDataByIndex(_arg_1);
            if (_local_3 != null){
                _local_3.name = _arg_2;
            };
        }
        public function getPetUserData(_arg_1:int):IUserData
        {
            return (this.getUserDataByType(_arg_1, _SafeStr_13655));
        }
        public function requestPetInfo(_arg_1:int):void
        {
            var _local_2:IUserData = this.getPetUserData(_arg_1);
            if (((!((_local_2 == null))) && (!((this._connection == null))))){
                this._connection.send(new GetPetInfoMessageComposer(_local_2.webID));
            };
        }

    }
}//package com.sulake.habbo.session

// _SafeStr_13654 = "_-I8" (String#22935, DoABC#2)
// _SafeStr_13655 = "_-16D" (String#16705, DoABC#2)
// _SafeStr_13656 = "_-4W" (String#22398, DoABC#2)
// _SafeStr_13657 = "_-8Z" (String#22563, DoABC#2)
// _SafeStr_13658 = "_-1QH" (String#17522, DoABC#2)
// IUserDataManager = "_-YM" (String#8379, DoABC#2)
// IUserData = "_-0n7" (String#4570, DoABC#2)
// UserDataManager = "_-3BN" (String#7536, DoABC#2)
// GetPetInfoMessageComposer = "_-fj" (String#23877, DoABC#2)
// GetSelectedBadgesMessageComposer = "_-24x" (String#19219, DoABC#2)
// custom = "_-1sW" (String#5894, DoABC#2)
// webID = "_-2uI" (String#7166, DoABC#2)
// sex = "_-0tG" (String#4712, DoABC#2)
// achievementScore = "_-16Z" (String#5005, DoABC#2)
// getUserData = "_-1-1" (String#4848, DoABC#2)
// getPetUserData = "_-2Rz" (String#6606, DoABC#2)
// getUserDataByIndex = "_-1XZ" (String#5510, DoABC#2)
// setUserData = "_-Hx" (String#8038, DoABC#2)
// removeUserDataByIndex = "_-1he" (String#5701, DoABC#2)
// setUserBadges = "_-2Fj" (String#6358, DoABC#2)
// updateFigure = "_-15u" (String#1619, DoABC#2)
// updateCustom = "_-0N7" (String#4021, DoABC#2)
// updateAchievementScore = "_-1bB" (String#5581, DoABC#2)
// updateNameByIndex = "_-2vz" (String#7201, DoABC#2)
// requestPetInfo = "_-12z" (String#4933, DoABC#2)
// getUserBadges = "_-2Ny" (String#6521, DoABC#2)
// getUserDataByType = "_-1UX" (String#5443, DoABC#2)


