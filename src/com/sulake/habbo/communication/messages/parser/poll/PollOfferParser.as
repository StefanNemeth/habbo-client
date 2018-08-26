
package com.sulake.habbo.communication.messages.parser.poll
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PollOfferParser implements IMessageParser 
    {

        private var _id:int = -1;
        private var _summary:String = "";

        public function get id():int
        {
            return (this._id);
        }
        public function get summary():String
        {
            return (this._summary);
        }
        public function flush():Boolean
        {
            this._id = -1;
            this._summary = "";
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._id = _arg_1.readInteger();
            this._summary = _arg_1.readString();
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.poll

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// PollOfferParser = "_-13H" (String#4940, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// _summary = "_-0Dd" (String#811, DoABC#2)
// summary = "_-Vo" (String#2121, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


