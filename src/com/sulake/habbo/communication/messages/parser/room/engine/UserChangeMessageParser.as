
package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class UserChangeMessageParser implements IMessageParser 
    {

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var _id:int;
        private var _figure:String;
        private var _sex:String;
        private var _customInfo:String;
        private var _achievementScore:int;

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
        public function get figure():String
        {
            return (this._figure);
        }
        public function get sex():String
        {
            return (this._sex);
        }
        public function get customInfo():String
        {
            return (this._customInfo);
        }
        public function get achievementScore():int
        {
            return (this._achievementScore);
        }
        public function flush():Boolean
        {
            this._id = 0;
            this._figure = "";
            this._sex = "";
            this._customInfo = "";
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._id = _arg_1.readInteger();
            this._figure = _arg_1.readString();
            this._sex = _arg_1.readString();
            this._customInfo = _arg_1.readString();
            this._achievementScore = _arg_1.readInteger();
            if (this._sex){
                this._sex = this._sex.toUpperCase();
            };
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.room.engine

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// UserChangeMessageParser = "_-0M8" (String#4003, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// sex = "_-0tG" (String#4712, DoABC#2)
// achievementScore = "_-16Z" (String#5005, DoABC#2)
// _figure = "_-20u" (String#75, DoABC#2)
// _sex = "_-1uF" (String#870, DoABC#2)
// _customInfo = "_-290" (String#1821, DoABC#2)
// _achievementScore = "_-2Iu" (String#449, DoABC#2)
// customInfo = "_-2Mk" (String#19916, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


