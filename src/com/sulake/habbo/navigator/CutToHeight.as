
package com.sulake.habbo.navigator
{
    import com.sulake.core.window.components.ITextWindow;

    public class CutToHeight implements BinarySearchTest 
    {

        private var _value:String;
        private var _text:ITextWindow;
        private var _maxHeight:int;

        public function test(_arg_1:int):Boolean
        {
            this._text.text = (this._value.substring(0, _arg_1) + "...");
            return ((this._text.textHeight > this._maxHeight));
        }
        public function beforeSearch(_arg_1:String, _arg_2:ITextWindow, _arg_3:int):void
        {
            this._value = _arg_1;
            this._text = _arg_2;
            this._maxHeight = _arg_3;
        }

    }
}//package com.sulake.habbo.navigator

// beforeSearch = "_-28B" (String#19337, DoABC#2)
// test = "_-qI" (String#8715, DoABC#2)
// BinarySearchTest = "_-Hz" (String#8039, DoABC#2)
// CutToHeight = "_-6V" (String#7794, DoABC#2)
// _value = "_-3Ao" (String#188, DoABC#2)
// _maxHeight = "_-0YM" (String#4270, DoABC#2)


