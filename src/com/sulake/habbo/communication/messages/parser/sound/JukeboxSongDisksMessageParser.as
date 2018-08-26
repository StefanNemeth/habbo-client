
package com.sulake.habbo.communication.messages.parser.sound
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.utils.Map;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class JukeboxSongDisksMessageParser implements IMessageParser 
    {

        private var _songDisks:Map;
        private var _maxLength:int;

        public function JukeboxSongDisksMessageParser()
        {
            this._songDisks = new Map();
        }
        public function get songDisks():Map
        {
            return (this._songDisks);
        }
        public function get maxLength():int
        {
            return (this._maxLength);
        }
        public function flush():Boolean
        {
            this._songDisks.reset();
            this._maxLength = 0;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._maxLength = _arg_1.readInteger();
            var _local_2:int = _arg_1.readInteger();
            var _local_3:int = -1;
            var _local_4:int = -1;
            var _local_5:int;
            while (_local_5 < _local_2) {
                _local_3 = _arg_1.readInteger();
                _local_4 = _arg_1.readInteger();
                this._songDisks.add(_local_3, _local_4);
                _local_5++;
            };
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.sound

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// JukeboxSongDisksMessageParser = "_-23t" (String#6119, DoABC#2)
// _songDisks = "_-0Ru" (String#15131, DoABC#2)
// _maxLength = "_-9j" (String#22607, DoABC#2)
// songDisks = "_-87" (String#22546, DoABC#2)
// maxLength = "_-4U" (String#22396, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


