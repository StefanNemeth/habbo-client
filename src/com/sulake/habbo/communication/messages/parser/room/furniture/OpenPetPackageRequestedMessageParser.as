
package com.sulake.habbo.communication.messages.parser.room.furniture
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class OpenPetPackageRequestedMessageParser implements IMessageParser 
    {

        private var _objectId:int = -1;
        private var _petType:int = -1;
        private var _breed:int = -1;
        private var _color:String = "";

        public function get objectId():int
        {
            return (this._objectId);
        }
        public function get petType():int
        {
            return (this._petType);
        }
        public function get breed():int
        {
            return (this._breed);
        }
        public function get color():String
        {
            return (this._color);
        }
        public function flush():Boolean
        {
            this._objectId = -1;
            this._petType = -1;
            this._breed = -1;
            this._color = "";
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            if (_arg_1 == null){
                return (false);
            };
            this._objectId = _arg_1.readInteger();
            this._petType = _arg_1.readInteger();
            this._breed = _arg_1.readInteger();
            this._color = _arg_1.readString();
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.room.furniture

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// _objectId = "_-1YP" (String#18, DoABC#2)
// _breed = "_-0BH" (String#297, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// _petType = "_-0zB" (String#439, DoABC#2)
// petType = "_-0GK" (String#3877, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


