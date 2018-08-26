
package com.sulake.habbo.communication.messages.incoming.sound
{
    public class SongInfoEntry extends PlayListEntry 
    {

        private var _songData:String = "";

        public function SongInfoEntry(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:String, _arg_5:String)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
            this._songData = _arg_5;
        }
        public function get data():String
        {
            return (this._songData);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.sound

// PlayListEntry = "_-17H" (String#5021, DoABC#2)
// SongInfoEntry = "_-1f6" (String#5645, DoABC#2)
// _songData = "_-2tj" (String#7152, DoABC#2)


