
package com.sulake.habbo.communication.messages.parser.help
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class TutorialStatusMessageParser implements IMessageParser 
    {

        private var _hasChangedLooks:Boolean;
        private var _hasChangedName:Boolean;
        private var _hasCalledGuideBot:Boolean;

        public function get hasChangedLooks():Boolean
        {
            return (this._hasChangedLooks);
        }
        public function get hasChangedName():Boolean
        {
            return (this._hasChangedName);
        }
        public function get hasCalledGuideBot():Boolean
        {
            return (this._hasCalledGuideBot);
        }
        public function flush():Boolean
        {
            this._hasChangedLooks = false;
            this._hasChangedName = false;
            this._hasCalledGuideBot = false;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._hasChangedLooks = _arg_1.readBoolean();
            this._hasChangedName = _arg_1.readBoolean();
            this._hasCalledGuideBot = _arg_1.readBoolean();
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.help

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// TutorialStatusMessageParser = "_-1ZY" (String#5556, DoABC#2)
// readBoolean = "_-0ZR" (String#1499, DoABC#2)
// hasChangedName = "_-33G" (String#7371, DoABC#2)
// _hasChangedLooks = "_-01Z" (String#3593, DoABC#2)
// _hasChangedName = "_-0FH" (String#3858, DoABC#2)
// _hasCalledGuideBot = "_-19F" (String#5062, DoABC#2)
// hasChangedLooks = "_-32V" (String#21597, DoABC#2)
// hasCalledGuideBot = "_-l6" (String#24074, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


