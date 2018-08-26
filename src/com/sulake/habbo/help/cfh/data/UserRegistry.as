
package com.sulake.habbo.help.cfh.data
{
    import com.sulake.core.utils.Map;

    public class UserRegistry 
    {

        private static const _SafeStr_5386:int = 80;

        private var _SafeStr_5387:Map;
        private var _roomName:String = "";
        private var _SafeStr_5389:Array;

        public function UserRegistry()
        {
            this._SafeStr_5387 = new Map();
            this._SafeStr_5389 = new Array();
            super();
        }
        public function getRegistry():Map
        {
            return (this._SafeStr_5387);
        }
        public function registerRoom(_arg_1:String):void
        {
            this._roomName = _arg_1;
            if (this._roomName != ""){
                this.addRoomNameForMissing();
            };
        }
        public function unregisterRoom():void
        {
            this._roomName = "";
        }
        public function registerUser(_arg_1:int, _arg_2:String, _arg_3:Boolean=true):void
        {
            var _local_4:UserRegistryItem;
            if (this._SafeStr_5387.getValue(_arg_1) != null){
                this._SafeStr_5387.remove(_arg_1);
            };
            if (_arg_3){
                _local_4 = new UserRegistryItem(_arg_1, _arg_2, this._roomName);
            }
            else {
                _local_4 = new UserRegistryItem(_arg_1, _arg_2);
            };
            if (((_arg_3) && ((this._roomName == "")))){
                this._SafeStr_5389.push(_arg_1);
            };
            this._SafeStr_5387.add(_arg_1, _local_4);
            this.purgeUserIndex();
        }
        private function purgeUserIndex():void
        {
            var _local_1:int;
            while (this._SafeStr_5387.length > _SafeStr_5386) {
                _local_1 = this._SafeStr_5387.getKey(0);
                this._SafeStr_5387.remove(_local_1);
            };
        }
        private function addRoomNameForMissing():void
        {
            var _local_1:UserRegistryItem;
            while (this._SafeStr_5389.length > 0) {
                _local_1 = this._SafeStr_5387.getValue(this._SafeStr_5389.shift());
                if (_local_1 != null){
                    _local_1.roomName = this._roomName;
                };
            };
        }

    }
}//package com.sulake.habbo.help.cfh.data

// UserRegistry = "_-1w-" (String#18798, DoABC#2)
// UserRegistryItem = "_-27a" (String#6193, DoABC#2)
// _SafeStr_5386 = "_-2Sr" (String#20154, DoABC#2)
// _SafeStr_5387 = "_-2nR" (String#20975, DoABC#2)
// _roomName = "_-bX" (String#253, DoABC#2)
// _SafeStr_5389 = "_-2Nk" (String#19954, DoABC#2)
// registerRoom = "_-30l" (String#21530, DoABC#2)
// addRoomNameForMissing = "_-1Nh" (String#17424, DoABC#2)
// unregisterRoom = "_-2Uo" (String#20230, DoABC#2)
// registerUser = "_-Hq" (String#22924, DoABC#2)
// purgeUserIndex = "_-wE" (String#24540, DoABC#2)


