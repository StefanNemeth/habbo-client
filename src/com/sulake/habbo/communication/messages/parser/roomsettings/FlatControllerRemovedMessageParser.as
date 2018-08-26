
package com.sulake.habbo.communication.messages.parser.roomsettings
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FlatControllerRemovedMessageParser implements IMessageParser 
    {

        private var _flatId:int;
        private var _userId:int;

        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._flatId = _arg_1.readInteger();
            this._userId = _arg_1.readInteger();
            return (true);
        }
        public function get flatId():int
        {
            return (this._flatId);
        }
        public function get userId():int
        {
            return (this._userId);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.roomsettings

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// FlatControllerRemovedMessageParser = "_-00q" (String#3580, DoABC#2)
// flatId = "_-3CK" (String#21973, DoABC#2)
// _flatId = "_-2Al" (String#135, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


