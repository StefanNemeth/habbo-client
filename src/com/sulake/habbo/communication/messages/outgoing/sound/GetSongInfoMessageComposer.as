
package com.sulake.habbo.communication.messages.outgoing.sound
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;

    public class GetSongInfoMessageComposer implements IMessageComposer, IDisposable 
    {

        private var _SafeStr_3708:Array;

        public function GetSongInfoMessageComposer(_arg_1:Array)
        {
            var _local_2:int;
            this._SafeStr_3708 = new Array();
            super();
            this._SafeStr_3708.push(_arg_1.length);
            for each (_local_2 in _arg_1) {
                this._SafeStr_3708.push(_local_2);
            };
        }
        public function getMessageArray():Array
        {
            return (this._SafeStr_3708);
        }
        public function dispose():void
        {
            this._SafeStr_3708 = null;
        }
        public function get disposed():Boolean
        {
            return (false);
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.sound

// GetSongInfoMessageComposer = "_-2q3" (String#21083, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// _SafeStr_3708 = "_-2oC" (String#11, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)


