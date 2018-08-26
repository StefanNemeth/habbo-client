
package com.sulake.habbo.communication.messages.parser.avatar
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ChangeUserNameResultMessageParser implements IMessageParser 
    {

        private var _resultCode:int = -1;
        private var _name:String;
        private var _nameSuggestions:Array;

        public function get resultCode():int
        {
            return (this._resultCode);
        }
        public function get name():String
        {
            return (this._name);
        }
        public function get nameSuggestions():Array
        {
            return (this._nameSuggestions);
        }
        public function flush():Boolean
        {
            this._resultCode = -1;
            this._name = "";
            this._nameSuggestions = null;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._resultCode = _arg_1.readInteger();
            this._name = _arg_1.readString();
            var _local_2:int = _arg_1.readInteger();
            this._nameSuggestions = new Array();
            var _local_3:int;
            while (_local_3 < _local_2) {
                this._nameSuggestions.push(_arg_1.readString());
                _local_3++;
            };
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.avatar

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// ChangeUserNameResultMessageParser = "_-9" (String#22578, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// _resultCode = "_-3An" (String#916, DoABC#2)
// resultCode = "_-09c" (String#14431, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)
// _nameSuggestions = "_-2Pl" (String#6557, DoABC#2)
// nameSuggestions = "_-2Cy" (String#19520, DoABC#2)


