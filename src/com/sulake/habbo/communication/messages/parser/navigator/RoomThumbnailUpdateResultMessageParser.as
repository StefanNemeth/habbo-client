
package com.sulake.habbo.communication.messages.parser.navigator
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomThumbnailUpdateResultMessageParser implements IMessageParser 
    {

        private var _flatId:int;
        private var _resultCode:int;

        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._flatId = _arg_1.readInteger();
            this._resultCode = _arg_1.readInteger();
            return (true);
        }
        public function get flatId():int
        {
            return (this._flatId);
        }
        public function get resultCode():int
        {
            return (this._resultCode);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.navigator

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// RoomThumbnailUpdateResultMessageParser = "_-2v2" (String#7180, DoABC#2)
// flatId = "_-3CK" (String#21973, DoABC#2)
// _flatId = "_-2Al" (String#135, DoABC#2)
// _resultCode = "_-3An" (String#916, DoABC#2)
// resultCode = "_-09c" (String#14431, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


