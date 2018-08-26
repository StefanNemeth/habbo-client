
package com.sulake.habbo.communication.messages.parser.sound
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.sound.PlayListEntry;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PlayListSongAddedMessageParser implements IMessageParser 
    {

        private var _entry:PlayListEntry;

        public function get entry():PlayListEntry
        {
            return (this._entry);
        }
        public function flush():Boolean
        {
            this._entry = null;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_2:int = _arg_1.readInteger();
            var _local_3:int = _arg_1.readInteger();
            var _local_4:String = _arg_1.readString();
            var _local_5:String = _arg_1.readString();
            this._entry = new PlayListEntry(_local_2, _local_3, _local_4, _local_5);
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.sound

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// PlayListEntry = "_-17H" (String#5021, DoABC#2)
// PlayListSongAddedMessageParser = "_-19g" (String#5070, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// _entry = "_-2Nn" (String#19957, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


