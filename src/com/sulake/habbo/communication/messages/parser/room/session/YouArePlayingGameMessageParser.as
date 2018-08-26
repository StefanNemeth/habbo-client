
package com.sulake.habbo.communication.messages.parser.room.session
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class YouArePlayingGameMessageParser implements IMessageParser 
    {

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var _isPlaying:Boolean = false;

        public function get roomId():int
        {
            return (this._roomId);
        }
        public function get roomCategory():int
        {
            return (this._roomCategory);
        }
        public function get isPlaying():Boolean
        {
            return (this._isPlaying);
        }
        public function flush():Boolean
        {
            this._roomId = 0;
            this._roomCategory = 0;
            this._isPlaying = false;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._isPlaying = _arg_1.readBoolean();
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.room.session

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// YouArePlayingGameMessageParser = "_-0w-" (String#4768, DoABC#2)
// readBoolean = "_-0ZR" (String#1499, DoABC#2)
// isPlaying = "_-2gK" (String#6876, DoABC#2)
// _isPlaying = "_-21z" (String#1803, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


