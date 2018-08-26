
package com.sulake.habbo.communication.messages.parser.recycler
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.recycler.PrizeLevelMessageData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RecyclerPrizesMessageParser implements IMessageParser 
    {

        private var _prizeLevels:Array;

        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_2:int = _arg_1.readInteger();
            this._prizeLevels = new Array();
            var _local_3:int;
            while (_local_3 < _local_2) {
                this._prizeLevels.push(new PrizeLevelMessageData(_arg_1));
                _local_3++;
            };
            return (true);
        }
        public function get prizeLevels():Array
        {
            return (this._prizeLevels);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.recycler

// RecyclerPrizesMessageParser = "_-J7" (String#8064, DoABC#2)
// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// PrizeLevelMessageData = "_-0gy" (String#4444, DoABC#2)
// _prizeLevels = "_-7C" (String#22510, DoABC#2)
// prizeLevels = "_-2CI" (String#19496, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


