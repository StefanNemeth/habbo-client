
package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.room.engine.UserUpdateMessageData;
    import com.sulake.habbo.communication.messages.incoming.room.engine.AvatarActionMessageData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class UserUpdateMessageParser implements IMessageParser 
    {

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var _users:Array;

        public function UserUpdateMessageParser()
        {
            this._users = [];
            super();
        }
        public function get roomId():int
        {
            return (this._roomId);
        }
        public function get roomCategory():int
        {
            return (this._roomCategory);
        }
        public function get userUpdateCount():int
        {
            return (this._users.length);
        }
        public function flush():Boolean
        {
            this._roomId = 0;
            this._roomCategory = 0;
            this._users = [];
            return (true);
        }
        public function getUserUpdateData(_arg_1:int):UserUpdateMessageData
        {
            if ((((_arg_1 < 0)) || ((_arg_1 >= this.userUpdateCount)))){
                return (null);
            };
            return (this._users[_arg_1]);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_4:int;
            var _local_5:Number;
            var _local_6:Number;
            var _local_7:Number;
            var _local_8:Number;
            var _local_9:int;
            var _local_10:int;
            var _local_11:String;
            var _local_12:int;
            var _local_13:int;
            var _local_14:Array;
            var _local_15:Number;
            var _local_16:Number;
            var _local_17:Number;
            var _local_18:Boolean;
            var _local_19:Array;
            var _local_20:int;
            var _local_21:UserUpdateMessageData;
            var _local_22:String;
            var _local_23:Array;
            var _local_24:String;
            var _local_25:String;
            var _local_26:Array;
            var _local_27:Number;
            var _local_28:Number;
            if (_arg_1 == null){
                return (false);
            };
            var _local_2:int = _arg_1.readInteger();
            var _local_3:int;
            while (_local_3 < _local_2) {
                _local_4 = _arg_1.readInteger();
                _local_5 = _arg_1.readInteger();
                _local_6 = _arg_1.readInteger();
                _local_7 = Number(_arg_1.readString());
                _local_8 = 0;
                _local_9 = _arg_1.readInteger();
                _local_10 = _arg_1.readInteger();
                _local_11 = _arg_1.readString();
                _local_12 = ((_local_9 % 8) * 45);
                _local_13 = ((_local_10 % 8) * 45);
                _local_14 = [];
                _local_15 = 0;
                _local_16 = 0;
                _local_17 = 0;
                _local_18 = false;
                _local_19 = _local_11.split("/");
                _local_20 = 0;
                while (_local_20 < _local_19.length) {
                    _local_22 = (_local_19[_local_20] as String);
                    _local_23 = _local_22.split(" ");
                    _local_24 = String(_local_23[0]);
                    _local_25 = "";
                    if (_local_24 != ""){
                        if (_local_23.length >= 2){
                            _local_25 = String(_local_23[1]);
                            switch (_local_24){
                                case "mv":
                                    _local_26 = _local_25.split(",");
                                    if (_local_26.length >= 3){
                                        _local_15 = int(_local_26[0]);
                                        _local_16 = int(_local_26[1]);
                                        _local_17 = Number(_local_26[2]);
                                        _local_18 = true;
                                    };
                                    break;
                                case "sit":
                                    _local_27 = Number(_local_25);
                                    _local_8 = _local_27;
                                    break;
                                case "lay":
                                    _local_28 = Number(_local_25);
                                    if (_local_28 < 0){
                                    };
                                    _local_8 = Math.abs(_local_28);
                                    break;
                            };
                        };
                        _local_14.push(new AvatarActionMessageData(_local_24, _local_25));
                    };
                    _local_20++;
                };
                _local_21 = new UserUpdateMessageData(_local_4, _local_5, _local_6, _local_7, _local_8, _local_13, _local_12, _local_15, _local_16, _local_17, _local_18, _local_14);
                this._users.push(_local_21);
                _local_3++;
            };
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.room.engine

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// UserUpdateMessageData = "_-2GW" (String#6378, DoABC#2)
// AvatarActionMessageData = "_-iI" (String#8562, DoABC#2)
// UserUpdateMessageParser = "_-2BT" (String#6276, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// userUpdateCount = "_-a6" (String#23635, DoABC#2)
// getUserUpdateData = "_-lO" (String#24083, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


