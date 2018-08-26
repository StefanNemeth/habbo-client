
package com.sulake.habbo.communication.messages.outgoing.users
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class ApproveNameMessageComposer implements IMessageComposer 
    {

        private var _name:String;
        private var _type:int;

        public function ApproveNameMessageComposer(_arg_1:String, _arg_2:int)
        {
            this._name = _arg_1;
            this._type = _arg_2;
        }
        public function getMessageArray():Array
        {
            return ([this._name, this._type]);
        }
        public function dispose():void
        {
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.users

// ApproveNameMessageComposer = "_-2IA" (String#19733, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)


