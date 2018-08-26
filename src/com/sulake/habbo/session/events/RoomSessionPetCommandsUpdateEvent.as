
package com.sulake.habbo.session.events
{
    import com.sulake.habbo.session.IRoomSession;

    public class RoomSessionPetCommandsUpdateEvent extends RoomSessionEvent 
    {

        public static const PET_COMMANDS:String = "RSPIUE_ENABLED_PET_COMMANDS";

        private var _id:int;
        private var _allCommandIds:Array;
        private var _enabledCommands:Array;

        public function RoomSessionPetCommandsUpdateEvent(_arg_1:IRoomSession, _arg_2:int, _arg_3:Array, _arg_4:Array, _arg_5:Boolean=false, _arg_6:Boolean=false)
        {
            super(RoomSessionPetCommandsUpdateEvent.PET_COMMANDS, _arg_1, _arg_5, _arg_6);
            this._id = _arg_2;
            this._allCommandIds = _arg_3;
            this._enabledCommands = _arg_4;
        }
        public function get petId():int
        {
            return (this._id);
        }
        public function get allCommands():Array
        {
            return (this._allCommandIds);
        }
        public function get enabledCommands():Array
        {
            return (this._enabledCommands);
        }

    }
}//package com.sulake.habbo.session.events

// IRoomSession = "_-2e4" (String#6835, DoABC#2)
// RoomSessionPetCommandsUpdateEvent = "_-AD" (String#22626, DoABC#2)
// _id = "_-0VE" (String#148, DoABC#2)
// petId = "_-JP" (String#8074, DoABC#2)
// _allCommandIds = "_-37L" (String#7453, DoABC#2)
// _enabledCommands = "_-1gQ" (String#18155, DoABC#2)
// allCommands = "_-2QF" (String#20056, DoABC#2)
// enabledCommands = "_-0yX" (String#16375, DoABC#2)


