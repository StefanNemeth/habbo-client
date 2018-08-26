
package com.sulake.habbo.communication.messages.parser.navigator
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomRatingMessageParser implements IMessageParser 
    {

        private var _rating:int;

        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._rating = _arg_1.readInteger();
            return (true);
        }
        public function get rating():int
        {
            return (this._rating);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.navigator

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// RoomRatingMessageParser = "_-3KE" (String#7710, DoABC#2)
// _rating = "_-PE" (String#8188, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


