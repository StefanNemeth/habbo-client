
package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ObjectRemoveMessageParser implements IMessageParser 
    {

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var _id:int;
        private var _isExpired:Boolean;

        public function get roomId():int
        {
            return (this._roomId);
        }
        public function get roomCategory():int
        {
            return (this._roomCategory);
        }
        public function get id():int
        {
            return (this._id);
        }
        public function get isExpired():Boolean
        {
            return (this._isExpired);
        }
        public function flush():Boolean
        {
            this._id = 0;
            this._roomId = 0;
            this._roomCategory = 0;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            if (_arg_1 == null){
                return (false);
            };
            this._id = int(_arg_1.readString());
            this._isExpired = (_arg_1.readInteger() == 1);
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.room.engine

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// ObjectRemoveMessageParser = "_-06f" (String#3694, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// _isExpired = "_-F8" (String#22820, DoABC#2)
// isExpired = "_-0qo" (String#16078, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


