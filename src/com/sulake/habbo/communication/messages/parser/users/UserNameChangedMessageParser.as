
package com.sulake.habbo.communication.messages.parser.users
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class UserNameChangedMessageParser implements IMessageParser 
    {

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var _webId:int;
        private var _id:int;
        private var _newName:String;

        public function get roomId():int
        {
            return (this._roomId);
        }
        public function get roomCategory():int
        {
            return (this._roomCategory);
        }
        public function get webId():int
        {
            return (this._webId);
        }
        public function get id():int
        {
            return (this._id);
        }
        public function get newName():String
        {
            return (this._newName);
        }
        public function flush():Boolean
        {
            this._webId = -1;
            this._id = -1;
            this._newName = "";
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._webId = _arg_1.readInteger();
            this._id = _arg_1.readInteger();
            this._newName = _arg_1.readString();
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.users

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// UserNameChangedMessageParser = "_-1TI" (String#17637, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// _webId = "_-18N" (String#16791, DoABC#2)
// _newName = "_-3Fl" (String#22107, DoABC#2)
// webId = "_-27Z" (String#19314, DoABC#2)
// newName = "_-2Fm" (String#19634, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


