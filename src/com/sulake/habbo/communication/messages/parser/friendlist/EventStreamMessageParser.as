
package com.sulake.habbo.communication.messages.parser.friendlist
{
    import com.sulake.core.communication.messages.IMessageParser;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.communication.messages.incoming.friendlist.EventStreamData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;
    import __AS3__.vec.*;

    public class EventStreamMessageParser implements IMessageParser 
    {

        private var _events:Vector.<EventStreamData>;

        public function get events():Vector.<EventStreamData>
        {
            return (this._events);
        }
        public function flush():Boolean
        {
            this._events = null;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_2:int = _arg_1.readInteger();
            this._events = new Vector.<EventStreamData>();
            while (_local_2-- > 0) {
                this._events.push(new EventStreamData(_arg_1.readInteger(), _arg_1.readInteger(), _arg_1.readString(), _arg_1.readString(), _arg_1.readString(), _arg_1.readString(), _arg_1.readInteger(), _arg_1.readInteger(), _arg_1.readInteger(), _arg_1.readBoolean(), _arg_1));
            };
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.friendlist

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// EventStreamMessageParser = "_-g0" (String#8512, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// readBoolean = "_-0ZR" (String#1499, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


