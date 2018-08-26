
package com.sulake.habbo.communication.messages.parser.room.furniture
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ViralFurniGiftReceivedMessageParser implements IMessageParser 
    {

        private var _firstClickUserName:String;
        private var _giftWasReceived:Boolean;

        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._firstClickUserName = _arg_1.readString();
            this._giftWasReceived = _arg_1.readBoolean();
            return (true);
        }
        public function get firstClickUserName():String
        {
            return (this._firstClickUserName);
        }
        public function get giftWasReceived():Boolean
        {
            return (this._giftWasReceived);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.room.furniture

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// ViralFurniGiftReceivedMessageParser = "_-vR" (String#8792, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// readBoolean = "_-0ZR" (String#1499, DoABC#2)
// _firstClickUserName = "_-1Cl" (String#838, DoABC#2)
// _giftWasReceived = "_-TN" (String#2114, DoABC#2)
// firstClickUserName = "_-0jN" (String#15804, DoABC#2)
// giftWasReceived = "_-1AI" (String#16872, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


