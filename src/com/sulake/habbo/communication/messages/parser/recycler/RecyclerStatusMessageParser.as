
package com.sulake.habbo.communication.messages.parser.recycler
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RecyclerStatusMessageParser implements IMessageParser 
    {

        private var _recyclerStatus:int = -1;
        private var _recyclerTimeoutSeconds:int = 0;

        public function get recyclerStatus():int
        {
            return (this._recyclerStatus);
        }
        public function get recyclerTimeoutSeconds():int
        {
            return (this._recyclerTimeoutSeconds);
        }
        public function flush():Boolean
        {
            this._recyclerStatus = -1;
            this._recyclerTimeoutSeconds = 0;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._recyclerStatus = _arg_1.readInteger();
            this._recyclerTimeoutSeconds = _arg_1.readInteger();
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.recycler

// RecyclerStatusMessageParser = "_-0fr" (String#4422, DoABC#2)
// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// _recyclerTimeoutSeconds = "_-2cV" (String#20544, DoABC#2)
// recyclerStatus = "_-2v4" (String#21281, DoABC#2)
// recyclerTimeoutSeconds = "_-3Db" (String#22017, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


