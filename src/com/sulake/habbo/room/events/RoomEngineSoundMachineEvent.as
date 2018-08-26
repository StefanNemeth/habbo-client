
package com.sulake.habbo.room.events
{
    public class RoomEngineSoundMachineEvent extends RoomEngineObjectEvent 
    {

        public static const ROSM_SOUND_MACHINE_INIT:String = "ROSM_SOUND_MACHINE_INIT";
        public static const ROSM_SOUND_MACHINE_SWITCHED_ON:String = "ROSM_SOUND_MACHINE_SWITCHED_ON";
        public static const ROSM_SOUND_MACHINE_SWITCHED_OFF:String = "ROSM_SOUND_MACHINE_SWITCHED_OFF";
        public static const ROSM_SOUND_MACHINE_DISPOSE:String = "ROSM_SOUND_MACHINE_DISPOSE";
        public static const ROSM_JUKEBOX_INIT:String = "ROSM_JUKEBOX_INIT";
        public static const ROSM_JUKEBOX_SWITCHED_ON:String = "ROSM_JUKEBOX_SWITCHED_ON";
        public static const ROSM_JUKEBOX_SWITCHED_OFF:String = "ROSM_JUKEBOX_SWITCHED_OFF";
        public static const ROSM_JUKEBOX_DISPOSE:String = "ROSM_JUKEBOX_DISPOSE";

        public function RoomEngineSoundMachineEvent(_arg_1:String, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:Boolean=false, _arg_7:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7);
        }
    }
}//package com.sulake.habbo.room.events

// RoomEngineObjectEvent = "_-10r" (String#16492, DoABC#2)
// ROSM_SOUND_MACHINE_INIT = "_-Tk" (String#23396, DoABC#2)
// ROSM_SOUND_MACHINE_SWITCHED_ON = "_-0SZ" (String#15156, DoABC#2)
// ROSM_SOUND_MACHINE_SWITCHED_OFF = "_-1o2" (String#18464, DoABC#2)
// ROSM_SOUND_MACHINE_DISPOSE = "_-1pK" (String#18515, DoABC#2)
// ROSM_JUKEBOX_INIT = "_-vy" (String#24527, DoABC#2)
// ROSM_JUKEBOX_SWITCHED_ON = "_-nf" (String#24178, DoABC#2)
// ROSM_JUKEBOX_SWITCHED_OFF = "_-3x" (String#22374, DoABC#2)
// ROSM_JUKEBOX_DISPOSE = "_-gi" (String#23919, DoABC#2)


