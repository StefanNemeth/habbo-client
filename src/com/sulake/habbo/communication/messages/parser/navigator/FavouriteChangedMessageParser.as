
package com.sulake.habbo.communication.messages.parser.navigator
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FavouriteChangedMessageParser implements IMessageParser 
    {

        private var _flatId:int;
        private var _added:Boolean;

        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._flatId = _arg_1.readInteger();
            this._added = _arg_1.readBoolean();
            return (true);
        }
        public function get flatId():int
        {
            return (this._flatId);
        }
        public function get added():Boolean
        {
            return (this._added);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.navigator

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// FavouriteChangedMessageParser = "_-QN" (String#8210, DoABC#2)
// readBoolean = "_-0ZR" (String#1499, DoABC#2)
// flatId = "_-3CK" (String#21973, DoABC#2)
// _flatId = "_-2Al" (String#135, DoABC#2)
// _added = "_-Yx" (String#23598, DoABC#2)
// added = "_-38D" (String#21811, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


