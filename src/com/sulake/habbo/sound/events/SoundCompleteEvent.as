
package com.sulake.habbo.sound.events
{
    import flash.events.Event;

    public class SoundCompleteEvent extends Event 
    {

        public static const TRAX_SONG_COMPLETE:String = "SCE_TRAX_SONG_COMPLETE";

        private var _id:int;

        public function SoundCompleteEvent(_arg_1:String, _arg_2:int, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(_arg_1, _arg_3, _arg_4);
            this._id = _arg_2;
        }
        public function get id():int
        {
            return (this._id);
        }

    }
}//package com.sulake.habbo.sound.events

// SoundCompleteEvent = "_-2-X" (String#6037, DoABC#2)


