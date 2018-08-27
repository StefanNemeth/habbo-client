
package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.room.engine.UserMessageData;
    import com.sulake.habbo.room.object.RoomObjectTypeEnum;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class UsersMessageParser implements IMessageParser 
    {

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var _users:Array;

        public function UsersMessageParser()
        {
            this._users = [];
            super();
        }
        public static function convertOldPetFigure(_arg_1:String):String
        {
            var _local_8:int;
            var _local_9:int;
            var _local_2:Array = new Array("FF7B3A", "FF9763", "FFCDB3", "F59500", "FBBD5C", "FEE4B2", "EDD400", "F5E759", "FBF8B1", "84A95F", "B0C993", "DBEFC7", "65B197", "91C7B5", "C5EDDE", "7F89B2", "98A1C5", "CAD2EC", "A47FB8", "C09ED5", "DBC7E9", "BD7E9D", "DA9DBD", "ECC6DB", "DD7B7D", "F08B90", "F9BABF", "ABABAB", "D4D4D4", "FFFFFF", "D98961", "DFA281", "F1D2C2", "D5B35F", "DAC480", "FCFAD3", "EAA7AF", "86BC40", "E8CE25", "8E8839", "888F67", "5E9414", "84CE84", "96E75A", "88E70D", "B99105", "C8D71D", "838851", "C08337", "83A785", "E6AF26", "ECFF99", "94FFF9", "ABC8E5", "F2E5CC", "D2FF00");
            var _local_3:Array = _arg_1.split(" ");
            if (_local_3.length < 3){
                return ("");
            };
            var _local_4:int = int(_local_3[0]);
            var _local_5:int = (int(_local_3[1]) + 1);
            var _local_6:String = String(_local_3[2]);
            _local_6 = _local_6.substr((_local_6.length - 6), 6);
            var _local_7:int = 25;
            if (_local_4 <= 1){
                _local_8 = ((_local_7 * _local_4) + _local_5);
            }
            else {
                _local_8 = 64;
            };
            _local_9 = (_local_2.indexOf(_local_6.toUpperCase()) + 1);
            var _local_10:String = "";
            _local_10 = (_local_10 + ((("phd-" + _local_8) + "-") + _local_9));
            _local_10 = (_local_10 + (((".pbd-" + _local_8) + "-") + _local_9));
            return ((_local_10 + (((".ptl-" + _local_8) + "-") + _local_9)));
        }

        public function get roomId():int
        {
            return (this._roomId);
        }
        public function get roomCategory():int
        {
            return (this._roomCategory);
        }
        public function flush():Boolean
        {
            this._users = [];
            this._roomId = 0;
            this._roomCategory = 0;
            return (true);
        }
        public function getUserCount():int
        {
            return (this._users.length);
        }
        public function getUser(_arg_1:int):UserMessageData
        {
            if ((((_arg_1 < 0)) || ((_arg_1 >= this.getUserCount())))){
                return (null);
            };
            var _local_2:UserMessageData = (this._users[_arg_1] as UserMessageData);
            if (_local_2 != null){
                _local_2.setReadOnly();
            };
            return (_local_2);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_4:int;
            var _local_5:String;
            var _local_6:String;
            var _local_7:String;
            var _local_8:int;
            var _local_9:int;
            var _local_10:int;
            var _local_11:String;
            var _local_12:int;
            var _local_13:int;
            var _local_14:UserMessageData;
            var _local_15:String;
            this._users = [];
            var _local_2:int = _arg_1.readInteger();
            Logger.log(("MEMBERCOUNT: " + _local_2));
            var _local_3:int;
            while (_local_3 < _local_2) {
                _local_4 = _arg_1.readInteger();
                _local_5 = _arg_1.readString();
                _local_6 = _arg_1.readString();
                _local_7 = _arg_1.readString();
                _local_8 = _arg_1.readInteger();
                _local_9 = _arg_1.readInteger();
                _local_10 = _arg_1.readInteger();
                _local_11 = _arg_1.readString();
                _local_12 = _arg_1.readInteger();
                _local_13 = _arg_1.readInteger();
                _local_14 = new UserMessageData(_local_8);
                _local_14.dir = _local_12;
                _local_14.name = _local_5;
                _local_14.custom = _local_6;
                _local_14.x = _local_9;
                _local_14.y = _local_10;
                _local_14.z = Number(_local_11);
                this._users.push(_local_14);
                if (_local_13 == 1){
                    Logger.log("Got user member.");
                    _local_14.webID = _local_4;
                    _local_14.userType = RoomObjectTypeEnum._SafeStr_3740;
                    _local_14.sex = this.resolveSex(_arg_1.readString());
                    _local_14.xp = _arg_1.readInteger();
                    _local_14.groupID = ("" + _arg_1.readInteger());
                    _local_14.groupStatus = _arg_1.readInteger();
                    _local_15 = _arg_1.readString();
                    if (_local_15 != ""){
                        _local_7 = this.convertSwimFigure(_local_15, _local_7, _local_14.sex);
                    };
                    _local_14.figure = _local_7;
                    _local_14.achievementScore = _arg_1.readInteger();
                }
                else {
                    if (_local_13 == 2){
                        _local_14.userType = RoomObjectTypeEnum._SafeStr_3747;
                        _local_14.figure = _local_7;
                        _local_14.webID = _local_4;
                        _local_14.subType = _arg_1.readInteger().toString();
                    }
                    else {
                        if (_local_13 == 3){
                            _local_14.userType = RoomObjectTypeEnum._SafeStr_3749;
                            _local_14.webID = (_local_8 * -1);
                            if (_local_7.indexOf("/") == -1){
                                _local_14.figure = _local_7;
                            }
                            else {
                                _local_14.figure = "hr-100-.hd-180-1.ch-876-66.lg-270-94.sh-300-64";
                            };
                            _local_14.sex = UserMessageData.M;
                        };
                    };
                };
                _local_3++;
            };
            return (true);
        }
        private function resolveSex(_arg_1:String):String
        {
            if (_arg_1.substr(0, 1).toLowerCase() == "f"){
                return (UserMessageData.F);
            };
            return (UserMessageData.M);
        }
        private function convertSwimFigure(_arg_1:String, _arg_2:String, _arg_3:String):String
        {
            var _local_13:String;
            var _local_14:Array;
            var _local_15:String;
            var _local_16:Array;
            var _local_17:String;
            var _local_18:String;
            var _local_19:int;
            var _local_4:Array = _arg_2.split(".");
            var _local_5:int = 1;
            var _local_6:int = 1;
            var _local_7:int = 1;
            var _local_8 = 10000;
            var _local_9:int;
            while (_local_9 < _local_4.length) {
                _local_13 = _local_4[_local_9];
                _local_14 = _local_13.split("-");
                if (_local_14.length > 2){
                    _local_15 = _local_14[0];
                    if (_local_15 == "hd"){
                        _local_5 = int(_local_14[2]);
                    };
                };
                _local_9++;
            };
            var _local_10:Array = ["238,238,238", "250,56,49", "253,146,160", "42,199,210", "53,51,44", "239,255,146", "198,255,152", "255,146,90", "157,89,126", "182,243,255", "109,255,51", "51,120,201", "255,182,49", "223,161,233", "249,251,50", "202,175,143", "197,198,197", "71,98,61", "138,131,97", "255,140,51", "84,198,39", "30,108,153", "152,79,136", "119,200,255", "255,192,142", "60,75,135", "124,44,71", "215,255,227", "143,63,28", "255,99,147", "31,155,121", "253,255,51"];
            var _local_11:Array = _arg_1.split("=");
            if (_local_11.length > 1){
                _local_16 = (_local_11[1] as String).split("/");
                _local_17 = _local_16[0];
                _local_18 = _local_16[1];
                if (_arg_3 == "F"){
                    _local_7 = 10010;
                }
                else {
                    _local_7 = 10011;
                };
                _local_19 = _local_10.indexOf(_local_18);
                _local_6 = ((_local_8 + _local_19) + 1);
            };
            var _local_12:String = (((((".bds-10001-" + _local_5) + ".ss-") + _local_7) + "-") + _local_6);
            return ((_arg_2 + _local_12));
        }

    }
}//package com.sulake.habbo.communication.messages.parser.room.engine

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// UsersMessageParser = "_-3Iv" (String#7687, DoABC#2)
// UserMessageData = "_-0WX" (String#4238, DoABC#2)
// RoomObjectTypeEnum = "_-2hK" (String#20744, DoABC#2)
// userType = "_-0Dh" (String#14596, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// convertOldPetFigure = "_-0Cp" (String#14563, DoABC#2)
// getUserCount = "_-xV" (String#24590, DoABC#2)
// getUser = "_-0C8" (String#14534, DoABC#2)
// setReadOnly = "_-5p" (String#22456, DoABC#2)
// custom = "_-1sW" (String#5894, DoABC#2)
// webID = "_-2uI" (String#7166, DoABC#2)
// _SafeStr_3740 = "_-39-" (String#21844, DoABC#2)
// sex = "_-0tG" (String#4712, DoABC#2)
// resolveSex = "_-22e" (String#19117, DoABC#2)
// groupID = "_-37J" (String#7452, DoABC#2)
// groupStatus = "_-1Sq" (String#5411, DoABC#2)
// convertSwimFigure = "_-20t" (String#19047, DoABC#2)
// achievementScore = "_-16Z" (String#5005, DoABC#2)
// _SafeStr_3747 = "_-gF" (String#23903, DoABC#2)
// subType = "_-uO" (String#24467, DoABC#2)
// _SafeStr_3749 = "_-1aR" (String#17911, DoABC#2)
// M = "_-1Tr" (String#17660, DoABC#2)
// F = "_-2bz" (String#20522, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


