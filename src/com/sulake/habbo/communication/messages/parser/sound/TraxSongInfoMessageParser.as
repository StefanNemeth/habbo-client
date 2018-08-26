
package com.sulake.habbo.communication.messages.parser.sound
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.sound.SongInfoEntry;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class TraxSongInfoMessageParser implements IMessageParser 
    {

        private var _songs:Array;

        public function get songs():Array
        {
            return (this._songs);
        }
        public function flush():Boolean
        {
            this._songs = new Array();
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_2:int;
            var _local_3:String;
            var _local_4:String;
            var _local_5:int;
            var _local_6:String;
            var _local_9:SongInfoEntry;
            var _local_7:int = _arg_1.readInteger();
            var _local_8:int;
            while (_local_8 < _local_7) {
                _local_2 = _arg_1.readInteger();
                _local_3 = _arg_1.readString();
                _local_4 = _arg_1.readString();
                _local_5 = _arg_1.readInteger();
                _local_6 = _arg_1.readString();
                _local_9 = new SongInfoEntry(_local_2, _local_5, _local_3, _local_6, _local_4);
                this._songs.push(_local_9);
                _local_8++;
            };
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.sound

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// SongInfoEntry = "_-1f6" (String#5645, DoABC#2)
// TraxSongInfoMessageParser = "_-Tc" (String#8278, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// _songs = "_-B7" (String#22659, DoABC#2)
// songs = "_-2uJ" (String#21251, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


