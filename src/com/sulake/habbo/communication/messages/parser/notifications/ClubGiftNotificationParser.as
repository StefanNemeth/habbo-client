
package com.sulake.habbo.communication.messages.parser.notifications
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ClubGiftNotificationParser implements IMessageParser 
    {

        private var _numGifts:int;

        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._numGifts = _arg_1.readInteger();
            return (true);
        }
        public function get numGifts():int
        {
            return (this._numGifts);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.notifications

// ClubGiftNotificationParser = "_-0bP" (String#4331, DoABC#2)
// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// _numGifts = "_-0Q1" (String#15061, DoABC#2)
// numGifts = "_-2qu" (String#21119, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


