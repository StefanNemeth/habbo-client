
package com.sulake.habbo.sound.music
{
    import com.sulake.habbo.communication.messages.incoming.sound.PlayListEntry;
    import com.sulake.habbo.sound.ISongInfo;
    import com.sulake.habbo.sound.IHabboSound;

    public class SongDataEntry extends PlayListEntry implements ISongInfo 
    {

        private var _soundObject:IHabboSound = null;
        private var _songData:String;
        private var _diskId:int = -1;

        public function SongDataEntry(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:String, _arg_5:IHabboSound)
        {
            this._soundObject = _arg_5;
            this._songData = "";
            super(_arg_1, _arg_2, _arg_3, _arg_4);
        }
        override public function get id():int
        {
            return (_songId);
        }
        override public function get length():int
        {
            return (_length);
        }
        override public function get name():String
        {
            return (_songName);
        }
        override public function get creator():String
        {
            return (_songCreator);
        }
        public function get loaded():Boolean
        {
            return ((((this._soundObject == null)) ? false : this._soundObject.ready));
        }
        public function get soundObject():IHabboSound
        {
            return (this._soundObject);
        }
        public function get songData():String
        {
            return (this._songData);
        }
        public function get diskId():int
        {
            return (this._diskId);
        }
        public function set soundObject(_arg_1:IHabboSound):void
        {
            this._soundObject = _arg_1;
        }
        public function set songData(_arg_1:String):void
        {
            this._songData = _arg_1;
        }
        public function set diskId(_arg_1:int):void
        {
            this._diskId = _arg_1;
        }

    }
}//package com.sulake.habbo.sound.music

// IHabboSound = "_-tK" (String#8755, DoABC#2)
// ISongInfo = "_-2vd" (String#7190, DoABC#2)
// PlayListEntry = "_-17H" (String#5021, DoABC#2)
// SongDataEntry = "_-23d" (String#6117, DoABC#2)
// diskId = "_-0re" (String#4678, DoABC#2)
// _soundObject = "_-kf" (String#8618, DoABC#2)
// _songId = "_-0a-" (String#241, DoABC#2)
// _length = "_-15P" (String#16671, DoABC#2)
// creator = "_-1U2" (String#5433, DoABC#2)
// _songData = "_-2tj" (String#7152, DoABC#2)
// soundObject = "_-HA" (String#8022, DoABC#2)
// _diskId = "_-2iG" (String#20780, DoABC#2)
// loaded = "_-31-" (String#7327, DoABC#2)


