
package com.sulake.habbo.help.help.data
{
    public class FaqItem 
    {

        private var _questionId:int;
        private var _questionText:String;
        private var _answerText:String;
        private var _index:int;
        private var _category:FaqCategory;
        private var _answerText:Boolean = false;

        public function FaqItem(_arg_1:int, _arg_2:String, _arg_3:int, _arg_4:FaqCategory)
        {
            this._questionId = _arg_1;
            this._questionText = _arg_2;
            this._index = _arg_3;
            this._category = _arg_4;
        }
        public function get questionId():int
        {
            return (this._questionId);
        }
        public function get questionText():String
        {
            return (this._questionText);
        }
        public function get answerText():String
        {
            return (this._answerText);
        }
        public function get hasAnswer():Boolean
        {
            return (this._answerText);
        }
        public function get index():int
        {
            return (this._index);
        }
        public function get category():FaqCategory
        {
            return (this._category);
        }
        public function set answerText(_arg_1:String):void
        {
            this._answerText = _arg_1;
            this._answerText = true;
        }

    }
}//package com.sulake.habbo.help.help.data

// questionText = "_-0FL" (String#14658, DoABC#2)
// _questionText = "_-1s4" (String#18636, DoABC#2)
// _answerText = "_-f1" (String#23846, DoABC#2)
// hasAnswer = "_-1ET" (String#17047, DoABC#2)
// FaqCategory = "_-0JM" (String#3941, DoABC#2)
// FaqItem = "_-1u6" (String#5923, DoABC#2)
// _questionId = "_-1oG" (String#865, DoABC#2)
// questionId = "_-3-c" (String#21486, DoABC#2)
// _answerText = "_-J-" (String#8061, DoABC#2)
// answerText = "_-3JS" (String#22262, DoABC#2)


