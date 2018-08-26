
package com.sulake.habbo.communication.messages.parser.room.furniture
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class DoorOtherEndDeletedMessageParser implements IMessageParser 
    {

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var _objectId:int;

        public function get roomId():int
        {
            return (this._roomId);
        }
        public function get roomCategory():int
        {
            return (this._roomCategory);
        }
        public function get objectId():int
        {
            return (this._objectId);
        }
        public function flush():Boolean
        {
            this._roomId = 0;
            this._roomCategory = 0;
            this._objectId = -1;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            if (_arg_1 == null){
                return (false);
            };
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.room.furniture

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// DoorOtherEndDeletedMessageParser = "_-EG" (String#7958, DoABC#2)
// _objectId = "_-1YP" (String#18, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


