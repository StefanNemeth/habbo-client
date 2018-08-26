
package com.sulake.habbo.communication.messages.parser.recycler
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RecyclerFinishedMessageParser implements IMessageParser 
    {

        private var _recyclerFinishedStatus:int = -1;
        private var _prizeId:int = 0;

        public function get recyclerFinishedStatus():int
        {
            return (this._recyclerFinishedStatus);
        }
        public function get prizeId():int
        {
            return (this._prizeId);
        }
        public function flush():Boolean
        {
            this._recyclerFinishedStatus = -1;
            this._prizeId = 0;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._recyclerFinishedStatus = _arg_1.readInteger();
            this._prizeId = _arg_1.readInteger();
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.recycler

// RecyclerFinishedMessageParser = "_-0EN" (String#3835, DoABC#2)
// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// _prizeId = "_-2RQ" (String#20095, DoABC#2)
// recyclerFinishedStatus = "_-2UK" (String#20212, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


