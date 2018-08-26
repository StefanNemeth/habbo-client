
package com.sulake.habbo.room.messages
{
    import com.sulake.room.messages.RoomObjectUpdateMessage;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.room.utils.IVector3d;

    public class RoomObjectRoomMaskUpdateMessage extends RoomObjectUpdateMessage 
    {

        public static const RORMUM_ADD_MASK:String = "RORMUM_ADD_MASK";
        public static const RORMUM_ADD_MASK:String = "RORMUM_ADD_MASK";
        public static const _SafeStr_8203:String = "door";
        public static const _SafeStr_5791:String = "window";
        public static const _SafeStr_5793:String = "hole";

        private var _type:String = "";
        private var _maskId:String = "";
        private var _maskType:String = "";
        private var _maskLocation:Vector3d = null;
        private var _maskCategory:String = "window";

        public function RoomObjectRoomMaskUpdateMessage(_arg_1:String, _arg_2:String, _arg_3:String=null, _arg_4:IVector3d=null, _arg_5:String="window")
        {
            super(null, null);
            this._type = _arg_1;
            this._maskId = _arg_2;
            this._maskType = _arg_3;
            if (_arg_4 != null){
                this._maskLocation = new Vector3d(_arg_4.x, _arg_4.y, _arg_4.z);
            };
            this._maskCategory = _arg_5;
        }
        public function get type():String
        {
            return (this._type);
        }
        public function get maskId():String
        {
            return (this._maskId);
        }
        public function get maskType():String
        {
            return (this._maskType);
        }
        public function get maskLocation():IVector3d
        {
            return (this._maskLocation);
        }
        public function get maskCategory():String
        {
            return (this._maskCategory);
        }

    }
}//package com.sulake.habbo.room.messages

// IVector3d = "_-hf" (String#8547, DoABC#2)
// Vector3d = "_-1Rb" (String#17568, DoABC#2)
// RoomObjectUpdateMessage = "_-73" (String#22503, DoABC#2)
// RoomObjectRoomMaskUpdateMessage = "_-0S6" (String#15141, DoABC#2)
// _SafeStr_5791 = "_-2fX" (String#20670, DoABC#2)
// maskCategory = "_-0Eb" (String#14628, DoABC#2)
// _SafeStr_5793 = "_-3En" (String#22068, DoABC#2)
// maskId = "_-0KY" (String#14862, DoABC#2)
// maskType = "_-2Ek" (String#19595, DoABC#2)
// maskLocation = "_-0I8" (String#14763, DoABC#2)
// RORMUM_ADD_MASK = "_-0tl" (String#16193, DoABC#2)
// RORMUM_ADD_MASK = "_-0LP" (String#14892, DoABC#2)
// _SafeStr_8203 = "_-1KE" (String#17283, DoABC#2)
// _maskId = "_-17K" (String#16749, DoABC#2)
// _maskType = "_-17T" (String#16753, DoABC#2)
// _maskLocation = "_-1YN" (String#17829, DoABC#2)
// _maskCategory = "_-1Cs" (String#16977, DoABC#2)


