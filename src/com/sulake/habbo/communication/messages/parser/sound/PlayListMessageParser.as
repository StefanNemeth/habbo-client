
package com.sulake.habbo.communication.messages.parser.sound
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.sound.PlayListEntry;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PlayListMessageParser implements IMessageParser 
    {

        private var _synchronizationCount:int;
        private var _playList:Array;

        public function get synchronizationCount():int
        {
            return (this._synchronizationCount);
        }
        public function get playList():Array
        {
            return (this._playList);
        }
        public function flush():Boolean
        {
            this._synchronizationCount = -1;
            this._playList = [];
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_4:int;
            var _local_5:int;
            var _local_6:String;
            var _local_7:String;
            this._synchronizationCount = _arg_1.readInteger();
            var _local_2:int = _arg_1.readInteger();
            var _local_3:int;
            while (_local_3 < _local_2) {
                _local_4 = _arg_1.readInteger();
                _local_5 = _arg_1.readInteger();
                _local_6 = _arg_1.readString();
                _local_7 = _arg_1.readString();
                this._playList.push(new PlayListEntry(_local_4, _local_5, _local_6, _local_7));
                _local_3++;
            };
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.sound

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// PlayListEntry = "_-17H" (String#5021, DoABC#2)
// PlayListMessageParser = "_-PK" (String#8191, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// _synchronizationCount = "_-ht" (String#23959, DoABC#2)
// _playList = "_-0bT" (String#15495, DoABC#2)
// synchronizationCount = "_-FT" (String#22830, DoABC#2)
// playList = "_-3E3" (String#22036, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


