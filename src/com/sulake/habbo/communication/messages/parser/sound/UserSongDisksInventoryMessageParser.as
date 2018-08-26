
package com.sulake.habbo.communication.messages.parser.sound
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.utils.Map;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class UserSongDisksInventoryMessageParser implements IMessageParser 
    {

        private var _SafeStr_5522:Map;

        public function UserSongDisksInventoryMessageParser()
        {
            this._SafeStr_5522 = new Map();
        }
        public function get songDiskCount():int
        {
            return (this._SafeStr_5522.length);
        }
        public function UserSongDisksInventoryMessageParser(_arg_1:int):int
        {
            if ((((_arg_1 >= 0)) && ((_arg_1 < this._SafeStr_5522.length)))){
                return (this._SafeStr_5522.getKey(_arg_1));
            };
            return (-1);
        }
        public function UserSongDisksInventoryMessageParser(_arg_1:int):int
        {
            if ((((_arg_1 >= 0)) && ((_arg_1 < this._SafeStr_5522.length)))){
                return (this._SafeStr_5522.getWithIndex(_arg_1));
            };
            return (-1);
        }
        public function flush():Boolean
        {
            this._SafeStr_5522.reset();
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_4:int;
            var _local_5:int;
            var _local_2:int = _arg_1.readInteger();
            var _local_3:int;
            while (_local_3 < _local_2) {
                _local_4 = _arg_1.readInteger();
                _local_5 = _arg_1.readInteger();
                this._SafeStr_5522.add(_local_4, _local_5);
                _local_3++;
            };
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.sound

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// UserSongDisksInventoryMessageParser = "_-BX" (String#7901, DoABC#2)
// _SafeStr_5522 = "_-2Yj" (String#6740, DoABC#2)
// songDiskCount = "_-HP" (String#22909, DoABC#2)
// UserSongDisksInventoryMessageParser = "_-0O4" (String#14991, DoABC#2)
// UserSongDisksInventoryMessageParser = "_-3Ax" (String#21917, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


