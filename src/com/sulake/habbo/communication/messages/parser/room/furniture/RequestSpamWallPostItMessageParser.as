
package com.sulake.habbo.communication.messages.parser.room.furniture
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RequestSpamWallPostItMessageParser implements IMessageParser 
    {

        private var _itemId:int;
        private var _location:String;

        public function get itemId():int
        {
            return (this._itemId);
        }
        public function get location():String
        {
            return (this._location);
        }
        public function flush():Boolean
        {
            this._itemId = -1;
            this._location = "";
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            if (_arg_1 == null){
                return (false);
            };
            this._itemId = _arg_1.readInteger();
            this._location = _arg_1.readString();
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.room.furniture

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// RequestSpamWallPostItMessageParser = "_-0QR" (String#4101, DoABC#2)
// _location = "_-245" (String#244, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// _itemId = "_-01C" (String#574, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


