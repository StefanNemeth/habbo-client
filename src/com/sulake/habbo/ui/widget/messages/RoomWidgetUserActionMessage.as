
package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetUserActionMessage extends RoomWidgetMessage 
    {

        public static const RWUAM_WHISPER_USER:String = "RWUAM_WHISPER_USER";
        public static const RWUAM_IGNORE_USER:String = "RWUAM_IGNORE_USER";
        public static const RWUAM_UNIGNORE_USER:String = "RWUAM_UNIGNORE_USER";
        public static const RWUAM_KICK_USER:String = "RWUAM_KICK_USER";
        public static const RWUAM_BAN_USER:String = "RWUAM_BAN_USER";
        public static const RWUAM_SEND_FRIEND_REQUEST:String = "RWUAM_SEND_FRIEND_REQUEST";
        public static const RWUAM_RESPECT_USER:String = "RWUAM_RESPECT_USER";
        public static const RWUAM_GIVE_RIGHTS:String = "RWUAM_GIVE_RIGHTS";
        public static const RWUAM_TAKE_RIGHTS:String = "RWUAM_TAKE_RIGHTS";
        public static const RWUAM_START_TRADING:String = "RWUAM_START_TRADING";
        public static const RWUAM_OPEN_HOME_PAGE:String = "RWUAM_OPEN_HOME_PAGE";
        public static const RWUAM_KICK_BOT:String = "RWUAM_KICK_BOT";
        public static const RWUAM_REPORT:String = "RWUAM_REPORT";
        public static const RWUAM_PICKUP_PET:String = "RWUAM_PICKUP_PET";
        public static const RWUAM_TRAIN_PET:String = "RWUAM_TRAIN_PET";
        public static const  RWUAM_RESPECT_PET:String = " RWUAM_RESPECT_PET";
        public static const RWUAM_REQUEST_PET_UPDATE:String = "RWUAM_REQUEST_PET_UPDATE";
        public static const RWUAM_START_NAME_CHANGE:String = "RWUAM_START_NAME_CHANGE";

        private var _userId:int = 0;

        public function RoomWidgetUserActionMessage(_arg_1:String, _arg_2:int=0)
        {
            super(_arg_1);
            this._userId = _arg_2;
        }
        public function get userId():int
        {
            return (this._userId);
        }

    }
}//package com.sulake.habbo.ui.widget.messages

// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// RoomWidgetUserActionMessage = "_-22U" (String#19109, DoABC#2)
// RWUAM_WHISPER_USER = "_-0oT" (String#15994, DoABC#2)
// RWUAM_IGNORE_USER = "_-XM" (String#23537, DoABC#2)
// RWUAM_UNIGNORE_USER = "_-1-L" (String#16442, DoABC#2)
// RWUAM_KICK_USER = "_-02D" (String#14135, DoABC#2)
// RWUAM_BAN_USER = "_-0ex" (String#15625, DoABC#2)
// RWUAM_SEND_FRIEND_REQUEST = "_-2XL" (String#20336, DoABC#2)
// RWUAM_RESPECT_USER = "_-6j" (String#22488, DoABC#2)
// RWUAM_GIVE_RIGHTS = "_-1ns" (String#18455, DoABC#2)
// RWUAM_TAKE_RIGHTS = "_-20C" (String#19019, DoABC#2)
// RWUAM_START_TRADING = "_-J3" (String#22970, DoABC#2)
// RWUAM_OPEN_HOME_PAGE = "_-0z1" (String#16395, DoABC#2)
// RWUAM_KICK_BOT = "_-0BZ" (String#14509, DoABC#2)
// RWUAM_REPORT = "_-3-T" (String#21480, DoABC#2)
// RWUAM_PICKUP_PET = "_-2JW" (String#19790, DoABC#2)
// RWUAM_TRAIN_PET = "_-3F2" (String#22078, DoABC#2)
//  RWUAM_RESPECT_PET = "_-0nn" (String#15968, DoABC#2)
// RWUAM_REQUEST_PET_UPDATE = "_-0Ro" (String#15130, DoABC#2)
// RWUAM_START_NAME_CHANGE = "_-21I" (String#19065, DoABC#2)


