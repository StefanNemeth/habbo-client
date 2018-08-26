
package com.sulake.habbo.communication.messages.parser.sound
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class NowPlayingMessageParser implements IMessageParser 
    {

        private var _currentSongId:int;
        private var _currentPosition:int;
        private var _nextSongId:int;
        private var _nextPosition:int;
        private var _syncCount:int;

        public function get currentSongId():int
        {
            return (this._currentSongId);
        }
        public function get currentPosition():int
        {
            return (this._currentPosition);
        }
        public function get nextSongId():int
        {
            return (this._nextSongId);
        }
        public function get nextPosition():int
        {
            return (this._nextPosition);
        }
        public function get syncCount():int
        {
            return (this._syncCount);
        }
        public function flush():Boolean
        {
            this._currentSongId = -1;
            this._currentPosition = -1;
            this._nextSongId = -1;
            this._nextPosition = -1;
            this._syncCount = -1;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._currentSongId = _arg_1.readInteger();
            this._currentPosition = _arg_1.readInteger();
            this._nextSongId = _arg_1.readInteger();
            this._nextPosition = _arg_1.readInteger();
            this._syncCount = _arg_1.readInteger();
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.sound

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// NowPlayingMessageParser = "_-2On" (String#6536, DoABC#2)
// _currentSongId = "_-m9" (String#24115, DoABC#2)
// _nextSongId = "_-23s" (String#19172, DoABC#2)
// _nextPosition = "_-04J" (String#14215, DoABC#2)
// _syncCount = "_-2m5" (String#20922, DoABC#2)
// currentSongId = "_-A6" (String#22622, DoABC#2)
// currentPosition = "_-2Ed" (String#19591, DoABC#2)
// nextSongId = "_-Gd" (String#22875, DoABC#2)
// nextPosition = "_-1VQ" (String#17716, DoABC#2)
// syncCount = "_-2kq" (String#20879, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


