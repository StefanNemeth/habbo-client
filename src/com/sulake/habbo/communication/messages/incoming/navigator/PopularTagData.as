
package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PopularTagData 
    {

        private var _tagName:String;
        private var _userCount:int;

        public function PopularTagData(_arg_1:IMessageDataWrapper)
        {
            this._tagName = _arg_1.readString();
            this._userCount = _arg_1.readInteger();
        }
        public function get tagName():String
        {
            return (this._tagName);
        }
        public function get userCount():int
        {
            return (this._userCount);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.navigator

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// PopularTagData = "_-2r2" (String#7100, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// userCount = "_-3Ez" (String#22075, DoABC#2)
// tagName = "_-mQ" (String#24124, DoABC#2)
// _userCount = "_-3Cp" (String#918, DoABC#2)
// _tagName = "_-13r" (String#16611, DoABC#2)


