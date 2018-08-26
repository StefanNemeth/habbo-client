
package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetPetCommandsUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const PET_COMMANDS:String = "RWPCUE_PET_COMMANDS";

        private var _id:int;
        private var _allCommands:Array;
        private var _enabledCommands:Array;

        public function RoomWidgetPetCommandsUpdateEvent(_arg_1:int, _arg_2:Array, _arg_3:Array, _arg_4:Boolean=false, _arg_5:Boolean=false)
        {
            super(RoomWidgetPetCommandsUpdateEvent.PET_COMMANDS, _arg_4, _arg_5);
            this._id = _arg_1;
            this._allCommands = _arg_2;
            this._enabledCommands = _arg_3;
        }
        public function get id():int
        {
            return (this._id);
        }
        public function get allCommands():Array
        {
            return (this._allCommands);
        }
        public function get enabledCommands():Array
        {
            return (this._enabledCommands);
        }

    }
}//package com.sulake.habbo.ui.widget.events

// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// RoomWidgetPetCommandsUpdateEvent = "_-0xD" (String#16321, DoABC#2)
// allCommands = "_-2QF" (String#20056, DoABC#2)
// enabledCommands = "_-0yX" (String#16375, DoABC#2)
// _allCommands = "_-1VM" (String#5464, DoABC#2)
// _enabledCommands = "_-1GF" (String#843, DoABC#2)


