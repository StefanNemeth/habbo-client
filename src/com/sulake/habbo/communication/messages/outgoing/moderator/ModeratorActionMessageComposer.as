
package com.sulake.habbo.communication.messages.outgoing.moderator
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;

    public class ModeratorActionMessageComposer implements IMessageComposer, IDisposable 
    {

        public static const _SafeStr_7594:int = 0;
        public static const _SafeStr_7595:int = 1;
        public static const _SafeStr_7596:int = 0;
        public static const _SafeStr_7597:int = 1;
        public static const _SafeStr_7598:int = 2;
        public static const _SafeStr_7599:int = 3;
        public static const _SafeStr_7600:int = 4;

        private var _messageArray:Array;

        public function ModeratorActionMessageComposer(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:String, _arg_5:String, _arg_6:int=0)
        {
            this._messageArray = new Array();
            super();
            this._messageArray.push(_arg_1);
            this._messageArray.push(_arg_2);
            this._messageArray.push(_arg_3);
            this._messageArray.push(_arg_4);
            this._messageArray.push(_arg_5);
            this._messageArray.push(_arg_6);
            this._messageArray.push(false);
            this._messageArray.push(false);
        }
        public function getMessageArray():Array
        {
            return (this._messageArray);
        }
        public function dispose():void
        {
            this._messageArray = null;
        }
        public function get disposed():Boolean
        {
            return (false);
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.moderator

// ModeratorActionMessageComposer = "_-B-" (String#22655, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// _messageArray = "_-2oC" (String#11, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)
// _SafeStr_7594 = "_-RI" (String#23296, DoABC#2)
// _SafeStr_7595 = "_-0tI" (String#16171, DoABC#2)
// _SafeStr_7596 = "_-29x" (String#19403, DoABC#2)
// _SafeStr_7597 = "_-0JQ" (String#14819, DoABC#2)
// _SafeStr_7598 = "_-3J1" (String#22240, DoABC#2)
// _SafeStr_7599 = "_-2Fo" (String#19635, DoABC#2)
// _SafeStr_7600 = "_-Y4" (String#23565, DoABC#2)


