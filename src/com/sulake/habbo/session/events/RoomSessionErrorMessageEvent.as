
package com.sulake.habbo.session.events
{
    import com.sulake.habbo.session.IRoomSession;

    public class RoomSessionErrorMessageEvent extends RoomSessionEvent 
    {

        public static const RSEME_DOOR_OTHER_DELETED:String = "RSEME_DOOR_OTHER_DELETED";
        public static const RSEME_DOOR_NOT_INSTALLED:String = "RSEME_DOOR_NOT_INSTALLED";
        public static const RSEME_CANT_TRADE_STUFF:String = "RSEME_CANT_TRADE_STUFF";
        public static const RSEME_INVALID_ITEM_LOC:String = "RSEME_INVALID_ITEM_LOC";
        public static const RSEME_CANT_SET_NOT_OWNER:String = "RSEME_CANT_SET_NOT_OWNER";
        public static const RSEME_MAX_STICKIES:String = "RSEME_MAX_STICKIES";
        public static const RSEME_MAX_FURNITURE:String = "RSEME_MAX_FURNITURE";
        public static const RSEME_MAX_QUEUE:String = "RSEME_MAX_QUEUE";
        public static const RSEME_MAX_SOUND:String = "RSEME_MAX_SOUND";
        public static const RSEME_KICKED:String = "RSEME_KICKED";
        public static const RSEME_GUIDE_BUSY:String = "RSEME_GUIDE_BUSY";
        public static const RSEME_GUIDE_EXISTS:String = "RSEME_GUIDE_EXISTS";
        public static const RSEME_PETS_FORBIDDEN_IN_HOTEL:String = "RSEME_PETS_FORBIDDEN_IN_HOTEL";
        public static const RSEME_PETS_FORBIDDEN_IN_FLAT:String = "RSEME_PETS_FORBIDDEN_IN_FLAT";
        public static const RSEME_MAX_PETS:String = "RSEME_MAX_PETS";
        public static const RSEME_NO_FREE_TILES_FOR_PET:String = "RSEME_NO_FREE_TILES_FOR_PET";
        public static const RSEME_SELECTED_TILE_NOT_FREE_FOR_PET:String = "RSEME_SELECTED_TILE_NOT_FREE_FOR_PET";

        private var _message:String;

        public function RoomSessionErrorMessageEvent(_arg_1:String, _arg_2:IRoomSession, _arg_3:String=null, _arg_4:Boolean=false, _arg_5:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_4, _arg_5);
            this._message = _arg_3;
        }
        public function get message():String
        {
            return (this._message);
        }

    }
}//package com.sulake.habbo.session.events

// IRoomSession = "_-2e4" (String#6835, DoABC#2)
// RoomSessionErrorMessageEvent = "_-2Xn" (String#6720, DoABC#2)
// RSEME_DOOR_OTHER_DELETED = "_-1tU" (String#18697, DoABC#2)
// RSEME_DOOR_NOT_INSTALLED = "_-3CD" (String#21969, DoABC#2)
// RSEME_CANT_TRADE_STUFF = "_-1qQ" (String#18560, DoABC#2)
// RSEME_INVALID_ITEM_LOC = "_-0ad" (String#15460, DoABC#2)
// RSEME_CANT_SET_NOT_OWNER = "_-11R" (String#16514, DoABC#2)
// RSEME_MAX_STICKIES = "_-A0" (String#22618, DoABC#2)
// RSEME_MAX_FURNITURE = "_-3f" (String#22360, DoABC#2)
// RSEME_MAX_QUEUE = "_-0vV" (String#16257, DoABC#2)
// RSEME_MAX_SOUND = "_-37I" (String#21780, DoABC#2)
// RSEME_KICKED = "_-1Ip" (String#17229, DoABC#2)
// RSEME_GUIDE_BUSY = "_-0OL" (String#15002, DoABC#2)
// RSEME_GUIDE_EXISTS = "_-0O6" (String#14993, DoABC#2)
// RSEME_PETS_FORBIDDEN_IN_HOTEL = "_-7b" (String#22526, DoABC#2)
// RSEME_PETS_FORBIDDEN_IN_FLAT = "_-2Zv" (String#20437, DoABC#2)
// RSEME_MAX_PETS = "_-LM" (String#23061, DoABC#2)
// RSEME_NO_FREE_TILES_FOR_PET = "_-lQ" (String#24085, DoABC#2)
// RSEME_SELECTED_TILE_NOT_FREE_FOR_PET = "_-2DI" (String#19538, DoABC#2)


