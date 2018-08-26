
package com.sulake.habbo.communication.messages.parser.navigator
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.navigator.FlatCategory;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class UserFlatCatsMessageParser implements IMessageParser 
    {

        private var _nodes:Array;

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._nodes = new Array();
            var _local_2:int = _arg_1.readInteger();
            var _local_3:int;
            while (_local_3 < _local_2) {
                this._nodes.push(new FlatCategory(_arg_1));
                _local_3++;
            };
            return (true);
        }
        public function flush():Boolean
        {
            this._nodes = null;
            return (true);
        }
        public function get nodes():Array
        {
            return (this._nodes);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.navigator

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// FlatCategory = "_-1Lo" (String#5274, DoABC#2)
// UserFlatCatsMessageParser = "_-FJ" (String#7976, DoABC#2)
// _nodes = "_-JB" (String#8065, DoABC#2)
// nodes = "_-7H" (String#22513, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


