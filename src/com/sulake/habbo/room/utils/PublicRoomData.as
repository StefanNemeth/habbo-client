
package com.sulake.habbo.room.utils
{
    import com.sulake.core.utils.Map;

    public class PublicRoomData 
    {

        private var _type:String = "";
        private var _SafeStr_13202:Map = null;

        public function PublicRoomData(_arg_1:String)
        {
            this._type = _arg_1;
            this._SafeStr_13202 = new Map();
        }
        public function get type():String
        {
            return (this._type);
        }
        public function PublicRoomData(_arg_1:String, _arg_2:Number, _arg_3:Number):Boolean
        {
            if (this._SafeStr_13202.getValue(_arg_1) != null){
                return (false);
            };
            var _local_4:PublicRoomWorldData = new PublicRoomWorldData(_arg_1, _arg_2, _arg_3);
            this._SafeStr_13202.add(_arg_1, _local_4);
            return (true);
        }
        public function PublicRoomData(_arg_1:String):Boolean
        {
            if (this._SafeStr_13202.getValue(_arg_1) != null){
                return (true);
            };
            return (false);
        }
        public function PublicRoomData(_arg_1:String):Number
        {
            var _local_2:PublicRoomWorldData = (this._SafeStr_13202.getValue(_arg_1) as PublicRoomWorldData);
            if (_local_2 != null){
                return (_local_2.scale);
            };
            return (1);
        }
        public function PublicRoomData(_arg_1:String):Number
        {
            var _local_2:PublicRoomWorldData = (this._SafeStr_13202.getValue(_arg_1) as PublicRoomWorldData);
            if (_local_2 != null){
                return (_local_2.heightScale);
            };
            return (1);
        }

    }
}//package com.sulake.habbo.room.utils

// _SafeStr_13202 = "_-49" (String#22385, DoABC#2)
// PublicRoomData = "_-1uk" (String#18747, DoABC#2)
// PublicRoomData = "_-0E2" (String#14609, DoABC#2)
// PublicRoomData = "_-2bc" (String#20509, DoABC#2)
// PublicRoomData = "_-cl" (String#23744, DoABC#2)
// PublicRoomData = "_-3Dv" (String#920, DoABC#2)
// PublicRoomWorldData = "_-2IL" (String#6408, DoABC#2)


