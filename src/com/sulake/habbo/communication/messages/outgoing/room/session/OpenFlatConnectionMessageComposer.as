
package com.sulake.habbo.communication.messages.outgoing.room.session
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class OpenFlatConnectionMessageComposer implements IMessageComposer 
    {

        private var _message:Array;

        public function OpenFlatConnectionMessageComposer(_arg_1:int, _arg_2:String="", _arg_3:int=-1)
        {
            this._message = [_arg_1, _arg_2, _arg_3];
        }
        public function dispose():void
        {
            this._message = null;
        }
        public function getMessageArray():Array
        {
            return (this._message);
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.room.session

// OpenFlatConnectionMessageComposer = "_-0HY" (String#14739, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)


