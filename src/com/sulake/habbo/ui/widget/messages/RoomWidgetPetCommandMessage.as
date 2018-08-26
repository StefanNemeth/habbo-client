
package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetPetCommandMessage extends RoomWidgetMessage 
    {

        public static const RWPCM_REQUEST_PET_COMMANDS:String = "RWPCM_REQUEST_PET_COMMANDS";
        public static const RWPCM_PET_COMMAND:String = "RWPCM_PET_COMMAND";

        private var _id:int = 0;
        private var _value:String;

        public function RoomWidgetPetCommandMessage(_arg_1:String, _arg_2:int, _arg_3:String=null)
        {
            super(_arg_1);
            this._id = _arg_2;
            this._value = _arg_3;
        }
        public function get petId():int
        {
            return (this._id);
        }
        public function get value():String
        {
            return (this._value);
        }

    }
}//package com.sulake.habbo.ui.widget.messages

// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// RoomWidgetPetCommandMessage = "_-1W9" (String#5475, DoABC#2)
// RWPCM_REQUEST_PET_COMMANDS = "_-1pG" (String#18512, DoABC#2)
// RWPCM_PET_COMMAND = "_-3K8" (String#22288, DoABC#2)
// _id = "_-0VE" (String#148, DoABC#2)
// _value = "_-3Ao" (String#188, DoABC#2)
// petId = "_-JP" (String#8074, DoABC#2)


