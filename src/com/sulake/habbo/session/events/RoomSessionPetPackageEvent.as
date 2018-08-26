
package com.sulake.habbo.session.events
{
    import com.sulake.habbo.session.IRoomSession;

    public class RoomSessionPetPackageEvent extends RoomSessionEvent 
    {

        public static const RSOPPE_OPEN_PET_PACKAGE_REQUESTED:String = "RSOPPE_OPEN_PET_PACKAGE_REQUESTED";
        public static const RSOPPE_OPEN_PET_PACKAGE_RESULT:String = "RSOPPE_OPEN_PET_PACKAGE_RESULT";

        private var _objectId:int = -1;
        private var _petType:int = -1;
        private var _breed:int = -1;
        private var _color:String = "";
        private var _nameValidationStatus:int = 0;
        private var _nameValidationInfo:String = null;

        public function RoomSessionPetPackageEvent(_arg_1:String, _arg_2:IRoomSession, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:String, _arg_7:int, _arg_8:String, _arg_9:Boolean=false, _arg_10:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_9, _arg_10);
            this._objectId = _arg_3;
            this._petType = _arg_4;
            this._breed = _arg_5;
            this._color = _arg_6;
            this._nameValidationStatus = _arg_7;
            this._nameValidationInfo = _arg_8;
        }
        public function get objectId():int
        {
            return (this._objectId);
        }
        public function get petType():int
        {
            return (this._petType);
        }
        public function get breed():int
        {
            return (this._breed);
        }
        public function get color():String
        {
            return (this._color);
        }
        public function get nameValidationStatus():int
        {
            return (this._nameValidationStatus);
        }
        public function get nameValidationInfo():String
        {
            return (this._nameValidationInfo);
        }

    }
}//package com.sulake.habbo.session.events

// IRoomSession = "_-2e4" (String#6835, DoABC#2)
// RoomSessionPetPackageEvent = "_-0sq" (String#4702, DoABC#2)
// _objectId = "_-1YP" (String#18, DoABC#2)
// _breed = "_-0BH" (String#297, DoABC#2)
// RSOPPE_OPEN_PET_PACKAGE_REQUESTED = "_-FG" (String#22824, DoABC#2)
// RSOPPE_OPEN_PET_PACKAGE_RESULT = "_-2JR" (String#19786, DoABC#2)
// _petType = "_-0zB" (String#439, DoABC#2)
// _nameValidationStatus = "_-1hU" (String#1745, DoABC#2)
// _nameValidationInfo = "_-2R" (String#619, DoABC#2)
// petType = "_-0GK" (String#3877, DoABC#2)


