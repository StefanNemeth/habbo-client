
package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ActionDefinition extends Triggerable 
    {

        private var _type:int;
        private var _delayInPulses:int;
        private var _conflictingTriggers:Array;

        public function ActionDefinition(_arg_1:IMessageDataWrapper)
        {
            this._conflictingTriggers = new Array();
            super(_arg_1);
            this._type = _arg_1.readInteger();
            this._delayInPulses = _arg_1.readInteger();
            var _local_2:int = _arg_1.readInteger();
            var _local_3:int;
            while (_local_3 < _local_2) {
                this._conflictingTriggers.push(_arg_1.readInteger());
                _local_3++;
            };
        }
        public function get type():int
        {
            return (this._type);
        }
        override public function get code():int
        {
            return (this._type);
        }
        public function get delayInPulses():int
        {
            return (this._delayInPulses);
        }
        public function get conflictingTriggers():Array
        {
            return (this._conflictingTriggers);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// Triggerable = "_-2oD" (String#7043, DoABC#2)
// ActionDefinition = "_-1nw" (String#864, DoABC#2)
// code = "_-12Y" (String#4926, DoABC#2)
// _delayInPulses = "_-23S" (String#19152, DoABC#2)
// _conflictingTriggers = "_-1BY" (String#16921, DoABC#2)
// delayInPulses = "_-1IB" (String#17200, DoABC#2)
// conflictingTriggers = "_-2EX" (String#19587, DoABC#2)


