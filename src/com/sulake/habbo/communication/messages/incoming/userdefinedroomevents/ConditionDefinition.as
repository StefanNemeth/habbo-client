
package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ConditionDefinition extends Triggerable 
    {

        private var _type:int;

        public function ConditionDefinition(_arg_1:IMessageDataWrapper)
        {
            super(_arg_1);
            this._type = _arg_1.readInteger();
        }
        public function get type():int
        {
            return (this._type);
        }
        override public function get code():int
        {
            return (this._type);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// Triggerable = "_-2oD" (String#7043, DoABC#2)
// ConditionDefinition = "_-Lz" (String#8123, DoABC#2)
// code = "_-12Y" (String#4926, DoABC#2)


