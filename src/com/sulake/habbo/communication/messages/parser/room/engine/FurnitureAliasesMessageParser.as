
package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.utils.Map;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FurnitureAliasesMessageParser implements IMessageParser 
    {

        private var _SafeStr_3791:Map = null;

        public function FurnitureAliasesMessageParser()
        {
            this._SafeStr_3791 = new Map();
        }
        public function get aliasCount():int
        {
            return (this._SafeStr_3791.length);
        }
        public function getName(_arg_1:int):String
        {
            if ((((_arg_1 < 0)) || ((_arg_1 >= this.aliasCount)))){
                return (null);
            };
            return (this._SafeStr_3791.getKey(_arg_1));
        }
        public function FurnitureAliasesMessageParser(_arg_1:int):String
        {
            if ((((_arg_1 < 0)) || ((_arg_1 >= this.aliasCount)))){
                return (null);
            };
            return (this._SafeStr_3791.getWithIndex(_arg_1));
        }
        public function flush():Boolean
        {
            this._SafeStr_3791.reset();
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_4:String;
            var _local_5:String;
            this._SafeStr_3791.reset();
            var _local_2:int = _arg_1.readInteger();
            var _local_3:int;
            while (_local_3 < _local_2) {
                _local_4 = _arg_1.readString();
                _local_5 = _arg_1.readString();
                this._SafeStr_3791.remove(_local_4);
                this._SafeStr_3791.add(_local_4, _local_5);
                _local_3++;
            };
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.room.engine

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// FurnitureAliasesMessageParser = "_-1bc" (String#5591, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// _SafeStr_3791 = "_-Xm" (String#8363, DoABC#2)
// aliasCount = "_-2Xv" (String#20355, DoABC#2)
// getName = "_-D1" (String#931, DoABC#2)
// FurnitureAliasesMessageParser = "_-30C" (String#21508, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


