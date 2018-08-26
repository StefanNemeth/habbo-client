
package com.sulake.habbo.communication.messages.parser.help
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FaqTextMessageParser implements IMessageParser 
    {

        private var _questionId:int;
        private var _answerText:String;

        public function get questionId():int
        {
            return (this._questionId);
        }
        public function get answerText():String
        {
            return (this._answerText);
        }
        public function flush():Boolean
        {
            this._questionId = -1;
            this._answerText = null;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._questionId = _arg_1.readInteger();
            this._answerText = _arg_1.readString();
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.help

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// FaqTextMessageParser = "_-1tS" (String#5910, DoABC#2)
// _questionId = "_-1oG" (String#865, DoABC#2)
// questionId = "_-3-c" (String#21486, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// _answerText = "_-J-" (String#8061, DoABC#2)
// answerText = "_-3JS" (String#22262, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


