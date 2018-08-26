
package com.sulake.habbo.communication.messages.parser.roomsettings
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.FlatControllerData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FlatControllerAddedMessageParser implements IMessageParser 
    {

        private var _flatId:int;
        private var _data:FlatControllerData;

        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._flatId = _arg_1.readInteger();
            this._data = new FlatControllerData(_arg_1);
            return (true);
        }
        public function get flatId():int
        {
            return (this._flatId);
        }
        public function get data():FlatControllerData
        {
            return (this._data);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.roomsettings

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// FlatControllerAddedMessageParser = "_-0zG" (String#4832, DoABC#2)
// FlatControllerData = "_-0aS" (String#4311, DoABC#2)
// flatId = "_-3CK" (String#21973, DoABC#2)
// _flatId = "_-2Al" (String#135, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


