
package com.sulake.habbo.communication.messages.parser.handshake
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class UserObjectMessageParser implements IMessageParser 
    {

        private var _id:int;
        private var _name:String;
        private var _figure:String;
        private var _sex:String;
        private var _customData:String;
        private var _realName:String;
        private var _directMail:int;
        private var _respectTotal:int;
        private var _respectLeft:int;
        private var _petRespectLeft:int;
        private var _streamPublishingAllowed:Boolean;

        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._id = int(_arg_1.readString());
            this._name = _arg_1.readString();
            this._figure = _arg_1.readString();
            this._sex = _arg_1.readString();
            this._customData = _arg_1.readString();
            this._realName = _arg_1.readString();
            this._directMail = _arg_1.readInteger();
            this._respectTotal = _arg_1.readInteger();
            this._respectLeft = _arg_1.readInteger();
            this._petRespectLeft = _arg_1.readInteger();
            this._streamPublishingAllowed = _arg_1.readBoolean();
            return (true);
        }
        public function get id():int
        {
            return (this._id);
        }
        public function get name():String
        {
            return (this._name);
        }
        public function get figure():String
        {
            return (this._figure);
        }
        public function get sex():String
        {
            return (this._sex);
        }
        public function get customData():String
        {
            return (this._customData);
        }
        public function get realName():String
        {
            return (this._realName);
        }
        public function get directMail():int
        {
            return (this._directMail);
        }
        public function get respectTotal():int
        {
            return (this._respectTotal);
        }
        public function get respectLeft():int
        {
            return (this._respectLeft);
        }
        public function get petRespectLeft():int
        {
            return (this._petRespectLeft);
        }
        public function get streamPublishingAllowed():Boolean
        {
            return (this._streamPublishingAllowed);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.handshake

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// UserObjectMessageParser = "_-04X" (String#14223, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// readBoolean = "_-0ZR" (String#1499, DoABC#2)
// sex = "_-0tG" (String#4712, DoABC#2)
// _figure = "_-20u" (String#75, DoABC#2)
// _sex = "_-1uF" (String#870, DoABC#2)
// _customData = "_-0Li" (String#14901, DoABC#2)
// _directMail = "_-32m" (String#21609, DoABC#2)
// _respectTotal = "_-00y" (String#1384, DoABC#2)
// _respectLeft = "_-1Pr" (String#853, DoABC#2)
// _petRespectLeft = "_-36a" (String#913, DoABC#2)
// _streamPublishingAllowed = "_-1K2" (String#17275, DoABC#2)
// customData = "_-uV" (String#24470, DoABC#2)
// realName = "_-3HH" (String#922, DoABC#2)
// directMail = "_-17U" (String#16754, DoABC#2)
// respectTotal = "_-3KU" (String#22304, DoABC#2)
// respectLeft = "_-2Yo" (String#6743, DoABC#2)
// petRespectLeft = "_-0wV" (String#4782, DoABC#2)
// streamPublishingAllowed = "_-3d" (String#22359, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


