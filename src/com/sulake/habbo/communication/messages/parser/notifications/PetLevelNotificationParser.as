
package com.sulake.habbo.communication.messages.parser.notifications
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PetLevelNotificationParser implements IMessageParser 
    {

        private var _id:int;
        private var _petName:String;
        private var _level:int;
        private var _petType:int;
        private var _breed:int;
        private var _color:String;

        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._id = _arg_1.readInteger();
            this._petName = _arg_1.readString();
            this._level = _arg_1.readInteger();
            this._petType = _arg_1.readInteger();
            this._breed = _arg_1.readInteger();
            this._color = _arg_1.readString();
            return (true);
        }
        public function get petId():int
        {
            return (this._id);
        }
        public function get petName():String
        {
            return (this._petName);
        }
        public function get level():int
        {
            return (this._level);
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

    }
}//package com.sulake.habbo.communication.messages.parser.notifications

// PetLevelNotificationParser = "_-21" (String#6064, DoABC#2)
// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// _id = "_-0VE" (String#148, DoABC#2)
// petId = "_-JP" (String#8074, DoABC#2)
// _breed = "_-0BH" (String#297, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// _petType = "_-0zB" (String#439, DoABC#2)
// petType = "_-0GK" (String#3877, DoABC#2)
// _level = "_-3FE" (String#250, DoABC#2)
// _petName = "_-3FT" (String#7618, DoABC#2)
// petName = "_-qP" (String#24289, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


