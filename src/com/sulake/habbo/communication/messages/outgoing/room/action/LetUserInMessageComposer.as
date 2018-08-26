
package com.sulake.habbo.communication.messages.outgoing.room.action
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class LetUserInMessageComposer implements IMessageComposer 
    {

        private var _message:Array;

        public function LetUserInMessageComposer(_arg_1:String, _arg_2:Boolean, _arg_3:int=0, _arg_4:int=0)
        {
            this._message = [_arg_1, _arg_2];
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
}//package com.sulake.habbo.communication.messages.outgoing.room.action

// LetUserInMessageComposer = "_-2kS" (String#20862, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)


